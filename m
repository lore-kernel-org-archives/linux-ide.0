From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] pata_atp867x: fix it to not claim MWDMA support
Date: Wed, 7 Oct 2009 00:26:57 +0200
Message-ID: <200910070026.57226.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:61350 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933427AbZJFW1n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:27:43 -0400
Received: by fxm27 with SMTP id 27so4123475fxm.17
        for <linux-ide@vger.kernel.org>; Tue, 06 Oct 2009 15:27:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jung-Ik Lee (John)" <jilee@google.com>, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atp867x: fix it to not claim MWDMA support

MWDMA modes are not supported by this driver currently.

Acked-by: Jung-Ik (John) Lee <jilee@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atp867x.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

Index: b/drivers/ata/pata_atp867x.c
===================================================================
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -118,20 +118,13 @@ struct atp867x_priv {
 	int		pci66mhz;
 };
 
-static inline u8 atp867x_speed_to_mode(u8 speed)
-{
-	return speed - XFER_UDMA_0 + 1;
-}
-
 static void atp867x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	struct atp867x_priv *dp = ap->private_data;
 	u8 speed = adev->dma_mode;
 	u8 b;
-	u8 mode;
-
-	mode = atp867x_speed_to_mode(speed);
+	u8 mode = speed - XFER_UDMA_0 + 1;
 
 	/*
 	 * Doc 6.6.9: decrease the udma mode value by 1 for safer UDMA speed
@@ -471,7 +464,6 @@ static int atp867x_init_one(struct pci_d
 	static const struct ata_port_info info_867x = {
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask 	= ATA_UDMA6,
 		.port_ops	= &atp867x_ops,
 	};
