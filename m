From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] sata_sil24: use sata_phy_debounce() in sil24_hardreset()
Date: Sat, 20 May 2006 00:38:10 +0900
Message-ID: <11480530901495-git-send-email-htejun@gmail.com>
References: <11480530901755-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:14230 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932350AbWESPiV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:38:21 -0400
Received: by wx-out-0102.google.com with SMTP id s6so531883wxc
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:38:21 -0700 (PDT)
In-Reply-To: <11480530901755-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Do phy debouncing instead of unconditional wait after DEV_RST.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

1f6218924d908e924488ea1ce855bc1ba62f6396
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a39e8d0..89d5d70 100644
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
+	rc = sata_phy_debounce(ap, sata_deb_timing_eh);
+	if (rc) {
+		reason = "PHY debouncing failed";
+		goto err;
+	}
 
 	if (tmp & PORT_CS_DEV_RST) {
 		if (ata_port_offline(ap))
-- 
1.3.2


