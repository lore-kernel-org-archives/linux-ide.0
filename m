From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/86] ata_piix: fix MWDMA handling on PIIX3
Date: Wed, 25 Nov 2009 18:02:25 +0100
Message-ID: <20091125170225.5446.50868.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52887 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbZKYRDD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:03:03 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ata_piix: fix MWDMA handling on PIIX3

Fix erroneous check for ap->udma_mask in do_pata_set_dmamode()
resulting in controller not being programmed properly for MWDMA.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/ata_piix.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ata/ata_piix.c
===================================================================
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -869,10 +869,10 @@ static void do_pata_set_dmamode(struct a
 				(timings[pio][1] << 8);
 		}
 
-		if (ap->udma_mask) {
+		if (ap->udma_mask)
 			udma_enable &= ~(1 << devid);
-			pci_write_config_word(dev, master_port, master_data);
-		}
+
+		pci_write_config_word(dev, master_port, master_data);
 	}
 	/* Don't scribble on 0x48 if the controller does not support UDMA */
 	if (ap->udma_mask)
