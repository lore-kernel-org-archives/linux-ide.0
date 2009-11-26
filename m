From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 17:28:36 +0100
Message-ID: <200911261728.36433.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:52387 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZKZQat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 11:30:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


MWDMA0 timings cannot be met with the PIIX based controller
programming interface.

This change should be safe as this is how we have been doing
things in IDE it8213 host driver for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Verified with the documentation (similar case as with pata_efar).

On top of patches from yesterday.

 drivers/ata/pata_it8213.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -227,7 +227,7 @@ static int it8213_init_one (struct pci_d
 	static const struct ata_port_info info = {
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= ATA_PIO4,
-		.mwdma_mask	= ATA_MWDMA2,
+		.mwdma_mask	= ATA_MWDMA12_ONLY,
 		.udma_mask 	= ATA_UDMA6,
 		.port_ops	= &it8213_ops,
 	};
