From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] libata-pmp-prep: separate out sata_link_hardreset()
Date: Sat, 8 Jul 2006 14:51:18 +0900
Message-ID: <1152337878787-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:10098 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964781AbWGHFu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484429wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:25 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sata_link_hardreset() from sata_std_hardreset().  This
will be used by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   57 ++++++++++++++++++++++++++++++++++----------
 drivers/scsi/libata.h      |    2 ++
 2 files changed, 46 insertions(+), 13 deletions(-)

9a955b32a2ec11df498d7e2dc3005a29a554a6e7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bb12e16..4d09167 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2719,11 +2719,11 @@ int ata_std_softreset(struct ata_link *l
 }
 
 /**
- *	sata_std_hardreset - reset host port via SATA phy reset
+ *	sata_link_hardreset - reset link via SATA phy reset
  *	@link: link to reset
- *	@class: resulting class of attached device
+ *	@timing: timing parameters { interval, duratinon, timeout } in msec
  *
- *	SATA phy-reset host port using DET bits of SControl register.
+ *	SATA phy-reset @link using DET bits of SControl register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2731,12 +2731,10 @@ int ata_std_softreset(struct ata_link *l
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_link *link, unsigned int *class)
+int sata_link_hardreset(struct ata_link *link, const unsigned long *timing)
 {
-	struct ata_port *ap = link->ap;
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	u32 scontrol;
-	int rc;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -2747,24 +2745,24 @@ int sata_std_hardreset(struct ata_link *
 		 * and Sil3124.
 		 */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-			return rc;
+			goto out;
 
 		scontrol = (scontrol & 0x0f0) | 0x302;
 
 		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-			return rc;
+			goto out;
 
 		sata_set_spd(link);
 	}
 
 	/* issue phy wake/reset */
 	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		return rc;
+		goto out;
 
 	scontrol = (scontrol & 0x0f0) | 0x301;
 
 	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
-		return rc;
+		goto out;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
@@ -2772,9 +2770,42 @@ int sata_std_hardreset(struct ata_link *
 	msleep(1);
 
 	/* bring phy back */
-	sata_link_resume(link, timing);
+	rc = sata_link_resume(link, timing);
+ out:
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	sata_std_hardreset - reset host port via SATA phy reset
+ *	@link: link to reset
+ *	@class: resulting class of attached device
+ *
+ *	SATA phy-reset host port using DET bits of SControl register,
+ *	wait for !BSY and classify the attached device.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_std_hardreset(struct ata_link *link, unsigned int *class)
+{
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	struct ata_port *ap = link->ap;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link, timing);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
 
-	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_link_offline(link)) {
 		*class = ATA_DEV_NONE;
 		DPRINTK("EXIT, link offline\n");
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e610894..7017b9d 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -55,6 +55,8 @@ extern int ata_dev_read_id(struct ata_de
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern void sata_print_link_status(struct ata_link *link);
+extern int sata_link_hardreset(struct ata_link *link,
+			       const unsigned long *timing);
 extern int sata_down_spd_limit(struct ata_link *link);
 extern int sata_set_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-- 
1.3.2


