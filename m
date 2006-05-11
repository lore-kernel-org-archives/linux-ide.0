From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] libata-hp-prep: implement sata_phy_debounce()
Date: Fri, 12 May 2006 00:02:35 +0900
Message-ID: <11473597551662-git-send-email-htejun@gmail.com>
References: <11473597542442-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:65058 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751830AbWEKPCq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:02:46 -0400
Received: by wr-out-0506.google.com with SMTP id i12so385619wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:02:45 -0700 (PDT)
In-Reply-To: <11473597542442-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With hotplug, PHY always needs to be debounced before a reset as any
reset might find new devices.  Extract PHY waiting code from
sata_phy_resume() and extend it to include SStatus debouncing.  Note
that sata_phy_debounce() is superset of what used to be done inside
sata_phy_resume().

Two sets of debounce timings are defined and an argument is added to
sata_phy_resume() to select between the two.

---

 drivers/scsi/libata-core.c |  103 ++++++++++++++++++++++++++++++++++++++------
 include/linux/libata.h     |   13 ++++++
 2 files changed, 101 insertions(+), 15 deletions(-)

31e0810e495194fb383ea61ddd059f22449352b0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1861373..636f044 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2417,10 +2417,83 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
-static int sata_phy_resume(struct ata_port *ap)
+/**
+ *	sata_phy_debounce - debounce SATA phy status
+ *	@ap: ATA port to debounce SATA phy status for
+ *	@interval_msec: polling interval in millisecs
+ *	@duration_msec: debounce duration in millisecs
+ *	@timeout_msec: timeout in millisecs
+ *
+ *	Make sure SStatus of @ap reaches stable state, determined by
+ *	holding the same value where DET is not 1 for @duration_msec
+ *	polled every @interval_msec, before @timeout_msec.  Timeout
+ *	constraints the beginning of the stable state.  Because, after
+ *	hot unplugging, DET gets stuck at 1 on some controllers, this
+ *	functions waits until timeout then returns 0 if DET is stable
+ *	at 1.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_phy_debounce(struct ata_port *ap, unsigned long interval_msec,
+		      unsigned long duration_msec, unsigned long timeout_msec)
+{
+	unsigned long duration = duration_msec * HZ / 1000;
+	unsigned long timeout = jiffies + timeout_msec * HZ / 1000;
+	unsigned long last_jiffies;
+	u32 last, cur;
+	int rc;
+
+	if ((rc = ata_scr_read(ap, SCR_STATUS, &cur)))
+		return rc;
+	cur &= 0xf;
+
+	last = cur;
+	last_jiffies = jiffies;
+
+	while (1) {
+		msleep(interval_msec);
+		if ((rc = ata_scr_read(ap, SCR_STATUS, &cur)))
+			return rc;
+		cur &= 0xf;
+
+		/* DET stable? */
+		if (cur == last) {
+			if (cur == 1 && time_before(jiffies, timeout))
+				continue;
+			if (time_after(jiffies, last_jiffies + duration))
+				return 0;
+			continue;
+		}
+
+		/* unstable, start over */
+		last = cur;
+		last_jiffies = jiffies;
+
+		/* check timeout */
+		if (time_after(jiffies, timeout))
+			return -EBUSY;
+	}
+}
+
+/**
+ *	sata_phy_resume - resume SATA phy
+ *	@ap: ATA port to resume SATA phy for
+ *
+ *	Resume SATA phy of @ap and debounce it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_phy_resume(struct ata_port *ap, int quick)
 {
-	unsigned long timeout = jiffies + (HZ * 5);
-	u32 scontrol, sstatus;
+	u32 scontrol;
 	int rc;
 
 	if ((rc = ata_scr_read(ap, SCR_CONTROL, &scontrol)))
@@ -2431,16 +2504,14 @@ static int sata_phy_resume(struct ata_po
 	if ((rc = ata_scr_write(ap, SCR_CONTROL, scontrol)))
 		return rc;
 
-	/* Wait for phy to become ready, if necessary. */
-	do {
-		msleep(200);
-		if ((rc = ata_scr_read(ap, SCR_STATUS, &sstatus)))
-			return rc;
-		if ((sstatus & 0xf) != 1)
-			return 0;
-	} while (time_before(jiffies, timeout));
-
-	return -EBUSY;
+	if (quick)
+		return sata_phy_debounce(ap, ATA_DEBOUNCE_QUICK_INTERVAL,
+					 ATA_DEBOUNCE_QUICK_DURATION,
+					 ATA_DEBOUNCE_QUICK_TIMEOUT);
+	else
+		return sata_phy_debounce(ap, ATA_DEBOUNCE_INTERVAL,
+					 ATA_DEBOUNCE_DURATION,
+					 ATA_DEBOUNCE_TIMEOUT);
 }
 
 /**
@@ -2459,7 +2530,7 @@ static int sata_phy_resume(struct ata_po
 void ata_std_probeinit(struct ata_port *ap)
 {
 	/* resume link */
-	sata_phy_resume(ap);
+	sata_phy_resume(ap, 1);
 
 	/* wait for device */
 	if (ata_port_online(ap))
@@ -2575,7 +2646,7 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap);
+	sata_phy_resume(ap, 0);
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -5722,6 +5793,8 @@ EXPORT_SYMBOL_GPL(ata_set_sata_spd);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(sata_phy_debounce);
+EXPORT_SYMBOL_GPL(sata_phy_resume);
 EXPORT_SYMBOL_GPL(ata_std_probeinit);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4a544e..5c843a8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -255,6 +255,15 @@ enum {
 	ATA_PROBE_MAX_TRIES	= 3,
 	ATA_EH_RESET_TRIES	= 3,
 	ATA_EH_DEV_TRIES	= 3,
+
+	/* timing constants in millisecs */
+	ATA_DEBOUNCE_QUICK_INTERVAL	= 5,
+	ATA_DEBOUNCE_QUICK_DURATION	= 100,
+	ATA_DEBOUNCE_QUICK_TIMEOUT	= 5000,
+
+	ATA_DEBOUNCE_INTERVAL	= 10,
+	ATA_DEBOUNCE_DURATION	= 500,
+	ATA_DEBOUNCE_TIMEOUT	= 10000,
 };
 
 enum hsm_task_states {
@@ -600,6 +609,10 @@ extern void __sata_phy_reset(struct ata_
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern int ata_set_sata_spd(struct ata_port *ap);
+extern int sata_phy_debounce(struct ata_port *ap, unsigned long interval_msec,
+			     unsigned long duration_msec,
+			     unsigned long timeout_msec);
+extern int sata_phy_resume(struct ata_port *ap, int quick);
 extern int ata_drive_probe_reset(struct ata_port *ap,
 			ata_probeinit_fn_t probeinit,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
1.2.4


