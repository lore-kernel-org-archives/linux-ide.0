From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] libata-pmp-prep: implement sata_async_notification()
Date: Sun, 23 Sep 2007 13:14:13 +0900
Message-ID: <11905208533403-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbXIWEOb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545849wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:30 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

AN serves multiple purposes.  For ATAPI, it's used for media change
notification.  For PMP, for downstream PHY status change notification.
Implement sata_async_notification() which demultiplexes AN.

To avoid unnecessary port events, ATAPI AN is not enabled if PMP is
attached but SNTF is not available.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Kriten Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/ata/ahci.c        |   24 ++++----------
 drivers/ata/libata-core.c |   13 +++++--
 drivers/ata/libata-eh.c   |   73 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c |    1 -
 drivers/ata/libata.h      |    1 +
 drivers/ata/sata_sil24.c  |    5 +--
 include/linux/libata.h    |    4 +-
 7 files changed, 93 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cf34044..9f3c591 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1356,27 +1356,17 @@ static void ahci_port_intr(struct ata_port *ap)
 	}
 
 	if (status & PORT_IRQ_SDB_FIS) {
-		/*
-		 * if this is an ATAPI device with AN turned on,
-		 * then we should interrogate the device to
-		 * determine the cause of the interrupt
-		 *
-		 * for AN - this we should check the SDB FIS
-		 * and find the I and N bits set
+		/* If the 'N' bit in word 0 of the FIS is set, we just
+		 * received asynchronous notification.  Tell libata
+		 * about it.  Note that as the SDB FIS itself is
+		 * accessible, SNotification can be emulated by the
+		 * driver but don't bother for the time being.
 		 */
 		const __le32 *f = pp->rx_fis + RX_FIS_SDB;
 		u32 f0 = le32_to_cpu(f[0]);
 
-		/* check the 'N' bit in word 0 of the FIS */
-		if (f0 & (1 << 15)) {
-			int port_addr = ((f0 & 0x00000f00) >> 8);
-			struct ata_device *adev;
-			if (port_addr < ATA_MAX_DEVICES) {
-				adev = &ap->link.device[port_addr];
-				if (adev->flags & ATA_DFLAG_AN)
-					ata_scsi_media_change_notify(adev);
-			}
-		}
+		if (f0 & (1 << 15))
+			sata_async_notification(ap);
 	}
 
 	if (ap->link.sactive)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 86ef06e..e650fb9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2018,6 +2018,7 @@ int ata_dev_configure(struct ata_device *dev)
 	else if (dev->class == ATA_DEV_ATAPI) {
 		const char *cdb_intr_string = "";
 		const char *atapi_an_string = "";
+		u32 sntf;
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
@@ -2029,11 +2030,14 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 		dev->cdb_len = (unsigned int) rc;
 
-		/*
-		 * check to see if this ATAPI device supports
-		 * Asynchronous Notification
+		/* Enable ATAPI AN if both the host and device have
+		 * the support.  If PMP is attached, SNTF is required
+		 * to enable ATAPI AN to discern between PHY status
+		 * changed notifications and ATAPI ANs.
 		 */
-		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id)) {
+		if ((ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id) &&
+		    (!ap->nr_pmp_links ||
+		     sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf) == 0)) {
 			unsigned int err_mask;
 
 			/* issue SET feature command to turn this on */
@@ -7250,6 +7254,7 @@ EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_link_abort);
 EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_port_freeze);
+EXPORT_SYMBOL_GPL(sata_async_notification);
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3c31e10..60186f8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -905,6 +905,79 @@ int ata_port_freeze(struct ata_port *ap)
 }
 
 /**
+ *	sata_async_notification - SATA async notification handler
+ *	@ap: ATA port where async notification is received
+ *
+ *	Handler to be called when async notification via SDB FIS is
+ *	received.  This function schedules EH if necessary.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	1 if EH is scheduled, 0 otherwise.
+ */
+int sata_async_notification(struct ata_port *ap)
+{
+	u32 sntf;
+	int rc;
+
+	if (!(ap->flags & ATA_FLAG_AN))
+		return 0;
+
+	rc = sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf);
+	if (rc == 0)
+		sata_scr_write(&ap->link, SCR_NOTIFICATION, sntf);
+
+	if (!ap->nr_pmp_links || rc) {
+		/* PMP is not attached or SNTF is not available */
+		if (!ap->nr_pmp_links) {
+			/* PMP is not attached.  Check whether ATAPI
+			 * AN is configured.  If so, notify media
+			 * change.
+			 */
+			struct ata_device *dev = ap->link.device;
+
+			if ((dev->class == ATA_DEV_ATAPI) &&
+			    (dev->flags & ATA_DFLAG_AN))
+				ata_scsi_media_change_notify(dev);
+			return 0;
+		} else {
+			/* PMP is attached but SNTF is not available.
+			 * ATAPI async media change notification is
+			 * not used.  The PMP must be reporting PHY
+			 * status change, schedule EH.
+			 */
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+	} else {
+		/* PMP is attached and SNTF is available */
+		struct ata_link *link;
+
+		/* check and notify ATAPI AN */
+		ata_port_for_each_link(link, ap) {
+			if (!(sntf & (1 << link->pmp)))
+				continue;
+
+			if ((link->device->class == ATA_DEV_ATAPI) &&
+			    (link->device->flags & ATA_DFLAG_AN))
+				ata_scsi_media_change_notify(link->device);
+		}
+
+		/* If PMP is reporting that PHY status of some
+		 * downstream ports has changed, schedule EH.
+		 */
+		if (sntf & (1 << SATA_PMP_CTRL_PORT)) {
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+
+		return 0;
+	}
+}
+
+/**
  *	ata_eh_freeze_port - EH helper to freeze port
  *	@ap: ATA port to freeze
  *
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a651bdd..116d875 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3167,7 +3167,6 @@ void ata_scsi_media_change_notify(struct ata_device *dev)
 		scsi_device_event_notify(dev->sdev, SDEV_MEDIA_CHANGE);
 #endif
 }
-EXPORT_SYMBOL_GPL(ata_scsi_media_change_notify);
 
 /**
  *	ata_scsi_hotplug - SCSI part of hotplug
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e380423..fc8a786 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -118,6 +118,7 @@ extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 9acfce4..b4f81eb 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -821,11 +821,8 @@ static void sil24_error_intr(struct ata_port *ap)
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
 	if (irq_stat & PORT_IRQ_SDB_NOTIFY) {
-		struct ata_device *dev = ap->link.device;
-
 		ata_ehi_push_desc(ehi, "SDB notify");
-		if (dev->flags & ATA_DFLAG_AN)
-			ata_scsi_media_change_notify(dev);
+		sata_async_notification(ap);
 	}
 
 	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 56b2187..cd9c2a2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -139,7 +139,7 @@ enum {
 	ATA_DFLAG_FLUSH_EXT	= (1 << 4), /* do FLUSH_EXT instead of FLUSH */
 	ATA_DFLAG_ACPI_PENDING	= (1 << 5), /* ACPI resume action pending */
 	ATA_DFLAG_ACPI_FAILED	= (1 << 6), /* ACPI on devcfg has failed */
-	ATA_DFLAG_AN		= (1 << 7), /* device supports AN */
+	ATA_DFLAG_AN		= (1 << 7), /* AN configured */
 	ATA_DFLAG_CFG_MASK	= (1 << 12) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 12), /* device limited to PIO mode */
@@ -787,7 +787,6 @@ extern void ata_host_init(struct ata_host *, struct device *,
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern void ata_scsi_media_change_notify(struct ata_device *atadev);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);
@@ -953,6 +952,7 @@ extern void ata_port_schedule_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
1.5.0.3


