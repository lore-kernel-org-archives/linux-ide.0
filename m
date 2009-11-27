From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_rdc: MWDMA0 is unsupported
Date: Fri, 27 Nov 2009 19:53:41 +0100
Message-ID: <200911271953.41860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62522 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZK0S6L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Nov 2009 13:58:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

MWDMA0 timings cannot be met with the PIIX based controller
programming interface.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_rdc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_rdc.c
===================================================================
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -244,7 +244,7 @@ static struct ata_port_info rdc_port_inf
 
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= ATA_PIO4,
-	.mwdma_mask	= ATA_MWDMA2,
+	.mwdma_mask	= ATA_MWDMA12_ONLY,
 	.udma_mask	= ATA_UDMA5,
 	.port_ops	= &rdc_pata_ops,
 };
