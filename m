From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] sata_sil24: rename PORT_IRQ_SDB_FIS to PORT_IRQ_SDB_NOTIFY
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978131973-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:64990 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWDGIQ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:16:59 -0400
Received: by wproxy.gmail.com with SMTP id 36so300023wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:16:58 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Rename PORT_IRQ_SDB_FIS to more proper PORT_IRQ_SDB_NOTIFY.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

0ce72002ee4f709f166a6e2433b8a1c3ecc240b2
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 76b6ffc..c581d9f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -143,7 +143,7 @@ enum {
 	PORT_IRQ_PHYRDY_CHG	= (1 << 4), /* PHY ready change */
 	PORT_IRQ_COMWAKE	= (1 << 5), /* COMWAKE received */
 	PORT_IRQ_UNK_FIS	= (1 << 6), /* Unknown FIS received */
-	PORT_IRQ_SDB_FIS	= (1 << 11), /* SDB FIS received */
+	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
@@ -975,8 +975,8 @@ static int sil24_init_one(struct pci_dev
 
 		/* Configure interrupts */
 		writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
-		writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR | PORT_IRQ_SDB_FIS,
-		       port + PORT_IRQ_ENABLE_SET);
+		writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
+		       PORT_IRQ_SDB_NOTIFY, port + PORT_IRQ_ENABLE_SET);
 
 		/* Clear interrupts */
 		writel(0x0fff0fff, port + PORT_IRQ_STAT);
-- 
1.2.4


