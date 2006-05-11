From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/7] libata-pm-prep: separate out sata_link_hardreset()
Date: Fri, 12 May 2006 01:37:50 +0900
Message-ID: <1147365470753-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:53728 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030331AbWEKQh4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:37:56 -0400
Received: by py-out-1112.google.com with SMTP id f28so306433pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:37:56 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sata_link_hardreset() from sata_std_hardreset().  This
will be used by PM.

---

 drivers/scsi/libata-core.c |   54 ++++++++++++++++++++++++++++++++++----------
 drivers/scsi/libata.h      |    1 +
 2 files changed, 43 insertions(+), 12 deletions(-)

618a80782b3044ecbfff23f978aa0066942332d0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d4e3b37..53b5ed0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2620,11 +2620,10 @@ int ata_std_softreset(struct ata_link *l
 }
 
 /**
- *	sata_std_hardreset - reset host port via SATA phy reset
+ *	sata_link_hardreset - reset link via SATA phy reset
  *	@link: link to reset
- *	@class: resulting class of attached device
  *
- *	SATA phy-reset host port using DET bits of SControl register.
+ *	SATA phy-reset @link using DET bits of SControl register.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2632,11 +2631,10 @@ int ata_std_softreset(struct ata_link *l
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_link *link, unsigned int *class)
+int sata_link_hardreset(struct ata_link *link)
 {
-	struct ata_port *ap = link->ap;
 	u32 scontrol;
-	int rc;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -2647,24 +2645,24 @@ int sata_std_hardreset(struct ata_link *
 		 * and Sil3124.
 		 */
 		if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
-			return rc;
+			goto out;
 
 		scontrol = (scontrol & 0x0f0) | 0x302;
 
 		if ((rc = ata_scr_write(link, SCR_CONTROL, scontrol)))
-			return rc;
+			goto out;
 
 		ata_set_sata_spd(link);
 	}
 
 	/* issue phy wake/reset */
 	if ((rc = ata_scr_read(link, SCR_CONTROL, &scontrol)))
-		return rc;
+		goto out;
 
 	scontrol = (scontrol & 0x0f0) | 0x301;
 
 	if ((rc = ata_scr_write_flush(link, SCR_CONTROL, scontrol)))
-		return rc;
+		goto out;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
@@ -2672,9 +2670,41 @@ int sata_std_hardreset(struct ata_link *
 	msleep(1);
 
 	/* bring phy back */
-	sata_link_resume(link, 0);
+	rc = sata_link_resume(link, 0);
+ out:
+	if (rc)
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
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
+	struct ata_port *ap = link->ap;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link);
+	if (rc)
+		return rc;
 
-	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_link_offline(link)) {
 		*class = ATA_DEV_NONE;
 		DPRINTK("EXIT, link offline\n");
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e4d21aa..0f3cefe 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -54,6 +54,7 @@ extern int ata_dev_read_id(struct ata_de
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
 extern void sata_print_link_status(struct ata_link *link);
+extern int sata_link_hardreset(struct ata_link *link);
 extern int ata_down_sata_spd_limit(struct ata_link *link);
 extern int ata_set_sata_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
-- 
1.2.4


