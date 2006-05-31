From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] sata_sil24: update sil24_hardreset()
Date: Wed, 31 May 2006 20:11:28 +0900
Message-ID: <1149073888639-git-send-email-htejun@gmail.com>
References: <11490738873808-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:27942 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964983AbWEaLLj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:11:39 -0400
Received: by wx-out-0102.google.com with SMTP id h27so3993wxd
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:11:38 -0700 (PDT)
In-Reply-To: <11490738873808-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use phy debouncing instead of unconditional wait after DEV_RST and
make sil24_hardreset() to request followup SRST as that's the only way
to wait for !BSY.  Note that the original implementation never worked
- if the cached status was !BSY, ata_busy_sleep() finished
immediately; otherwise, it timed out regardless of the actual device
status.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

e8e008e7b5ed8c65675cc9b3e778b8bb909f65ab
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a39e8d0..4a83090 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -591,7 +591,7 @@ static int sil24_hardreset(struct ata_po
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	const char *reason;
-	int tout_msec;
+	int tout_msec, rc;
 	u32 tmp;
 
 	/* sil24 does the right thing(tm) without any protection */
@@ -605,10 +605,14 @@ static int sil24_hardreset(struct ata_po
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_DEV_RST, PORT_CS_DEV_RST, 10, tout_msec);
 
-	/* SStatus oscillates between zero and valid status for short
-	 * duration after DEV_RST, give it time to settle.
+	/* SStatus oscillates between zero and valid status after
+	 * DEV_RST, debounce it.
 	 */
-	msleep(100);
+	rc = sata_phy_debounce(ap, sata_deb_timing_before_fsrst);
+	if (rc) {
+		reason = "PHY debouncing failed";
+		goto err;
+	}
 
 	if (tmp & PORT_CS_DEV_RST) {
 		if (ata_port_offline(ap))
@@ -617,15 +621,13 @@ static int sil24_hardreset(struct ata_po
 		goto err;
 	}
 
-	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		reason = "device not ready";
-		goto err;
-	}
-
-	/* sil24 doesn't report device class code after hardreset,
-	 * leave *class alone.
+	/* Sil24 doesn't store signature FIS after hardreset, so we
+	 * can't wait for BSY to clear.  Some devices take a long time
+	 * to get ready and those devices will choke if we don't wait
+	 * for BSY clearance here.  Tell libata to perform follow-up
+	 * softreset.
 	 */
-	return 0;
+	return -EAGAIN;
 
  err:
 	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
-- 
1.3.2


