From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] sata_sil24: use sata_phy_debounce() in sil24_hardreset()
Date: Fri, 12 May 2006 00:14:58 +0900
Message-ID: <11473604983253-git-send-email-htejun@gmail.com>
References: <11473604983883-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:23982 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030249AbWEKPPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:15:08 -0400
Received: by nz-out-0102.google.com with SMTP id 13so225605nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:15:08 -0700 (PDT)
In-Reply-To: <11473604983883-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Do phy debouncing instead of unconditional wait after DEV_RST.

---

 drivers/scsi/sata_sil24.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

b8c4776dbd446dd2087689d23c1a6ca153abd293
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 629679e..72219fa 100644
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
@@ -605,10 +605,15 @@ static int sil24_hardreset(struct ata_po
 	tmp = ata_wait_register(port + PORT_CTRL_STAT,
 				PORT_CS_DEV_RST, PORT_CS_DEV_RST, 10, tout_msec);
 
-	/* SStatus oscillates between zero and valid status for short
-	 * duration after DEV_RST, give it time to settle.
+	/* SStatus oscillates between zero and valid status after
+	 * DEV_RST, debounce it.
 	 */
-	msleep(100);
+	rc = sata_phy_debounce(ap, ATA_DEBOUNCE_INTERVAL,
+			       ATA_DEBOUNCE_DURATION, ATA_DEBOUNCE_TIMEOUT);
+	if (rc) {
+		reason = "PHY debouncing failed";
+		goto err;
+	}
 
 	if (tmp & PORT_CS_DEV_RST) {
 		if (ata_port_offline(ap))
-- 
1.2.4


