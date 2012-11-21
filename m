From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 05/10] libata: check zero power ready status for ZPODD
Date: Wed, 21 Nov 2012 19:50:34 +0800
Message-ID: <1353498639-27631-6-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33823 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362Ab2KULuh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2012 06:50:37 -0500
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Per the Mount Fuji spec, the ODD is considered zero power ready when:
  - For slot type ODD, no media inside;
  - For tray type ODD, no media inside and tray closed.

The information can be retrieved by either the returned information of
command GET_EVENT_STATUS_NOTIFICATION(the command is used to poll for
media event) or sense code.

The information provided by the media status byte is not accurate, it
is possible that after a new disc is just inserted, the status byte
still returns media not present. So this information can not be used as
the deciding factor, we use sense code to decide if zpready status is
true.

When we first sensed the ODD in the zero power ready state, the
timestamp will be recoreded. And after ODD stayed in this state for
some pre-defined period, the ODD is considered as power off ready and
the zp_ready flag will be set. The zp_ready flag serves as the deciding
factor other code will use to see if power off is OK for the ODD.

The Mount Fuji spec suggests a delay should be used here, to avoid the
case user ejects the ODD and then instantly inserts a new one again, so
that we can avoid a power transition. And some ODDs may be slow to place
its head to the home position after disc is ejected, so a delay here is
generally a good idea.

The zero power ready status check is performed in the ata port's runtime
suspend code path, when port is not frozen yet, as we need to issue some
IOs to the ODD.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-eh.c    | 10 +++++--
 drivers/ata/libata-zpodd.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h       |  5 ++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e60437c..b928892 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1591,7 +1591,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure.
  */
-static unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
+unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
 {
 	u8 cdb[ATAPI_CDB_LEN] = { TEST_UNIT_READY, 0, 0, 0, 0, 0 };
 	struct ata_taskfile tf;
@@ -1624,7 +1624,7 @@ static unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure
  */
-static unsigned int atapi_eh_request_sense(struct ata_device *dev,
+unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   u8 *sense_buf, u8 dfl_sense_key)
 {
 	u8 cdb[ATAPI_CDB_LEN] =
@@ -4021,6 +4021,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 {
 	unsigned long flags;
 	int rc = 0;
+	struct ata_device *dev;
 
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -4033,6 +4034,11 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		if (zpodd_dev_enabled(dev))
+			zpodd_on_suspend(dev);
+	}
+
 	/* tell ACPI we're suspending */
 	rc = ata_acpi_on_suspend(ap);
 	if (rc)
diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 3669eb4..719b814 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -5,12 +5,17 @@
 
 #include "libata.h"
 
+#define POWEROFF_DELAY	(30 * 1000) /* 30 seconds for power off delay */
+
 struct zpodd {
 	bool slot:1;
 	bool drawer:1;
 
 	/* The following bits are synchronized by PM core */
 	bool from_notify:1; /* resumed as a result of acpi notification */
+	bool zp_ready:1;	/* zero power ready state */
+
+	unsigned long last_ready; /* last zero power ready timestamp */
 
 	struct ata_device *dev;
 };
@@ -95,6 +100,67 @@ static bool device_can_poweroff(struct ata_device *ata_dev)
 		return false;
 }
 
+/* Test if ODD is zero power ready by sense code */
+static bool zpready(struct ata_device *dev)
+{
+	u8 sense_key, *sense_buf;
+	unsigned int ret, asc, ascq, add_len;
+	struct zpodd *zpodd = dev->zpodd;
+
+	ret = atapi_eh_tur(dev, &sense_key);
+
+	if (!ret || sense_key != NOT_READY)
+		return false;
+
+	sense_buf = dev->link->ap->sector_buf;
+	ret = atapi_eh_request_sense(dev, sense_buf, sense_key);
+	if (ret)
+		return false;
+
+	/* sense valid */
+	if ((sense_buf[0] & 0x7f) != 0x70)
+		return false;
+
+	add_len = sense_buf[7];
+	/* has asc and ascq */
+	if (add_len < 6)
+		return false;
+
+	asc = sense_buf[12];
+	ascq = sense_buf[13];
+
+	if (zpodd->slot)
+		/* no media inside */
+		return asc == 0x3a;
+	else
+		/* no media inside and door closed */
+		return asc == 0x3a && ascq == 0x01;
+}
+
+/* Check zero power ready status */
+void zpodd_on_suspend(struct ata_device *dev)
+{
+	struct zpodd *zpodd = dev->zpodd;
+	unsigned long expires;
+
+	if (!zpready(dev)) {
+		zpodd->zp_ready = false;
+		zpodd->last_ready = 0;
+		return;
+	}
+
+	if (!zpodd->last_ready) {
+		zpodd->last_ready = jiffies;
+		return;
+	}
+
+	expires = zpodd->last_ready + msecs_to_jiffies(POWEROFF_DELAY);
+	if (time_before(jiffies, expires))
+		return;
+
+	zpodd->zp_ready = true;
+}
+
 static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
 {
 	struct ata_device *ata_dev = context;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8cb4372..f9235dc 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -182,6 +182,9 @@ extern void ata_eh_finish(struct ata_port *ap);
 extern int ata_ering_map(struct ata_ering *ering,
 			 int (*map_fn)(struct ata_ering_entry *, void *),
 		  	 void *arg);
+extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
+extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
+					   u8 *sense_buf, u8 dfl_sense_key);
 
 /* libata-pmp.c */
 #ifdef CONFIG_SATA_PMP
@@ -238,10 +241,12 @@ static inline bool zpodd_dev_enabled(struct ata_device *dev)
 {
 	return dev->zpodd ? true : false;
 }
+void zpodd_on_suspend(struct ata_device *dev);
 #else /* CONFIG_SATA_ZPODD */
 static inline void zpodd_init(struct ata_device *dev) {}
 static inline void zpodd_exit(struct ata_device *dev) {}
 static inline bool zpodd_dev_enabled(struct ata_device *dev) { return false; }
+static inline void zpodd_on_suspend(struct ata_device *dev) {}
 #endif /* CONFIG_SATA_ZPODD */
 
 #endif /* __LIBATA_H__ */
-- 
1.7.12.4

