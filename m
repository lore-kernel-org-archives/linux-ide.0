From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 38/86] pata_it8213: fix PIO2 underclocking
Date: Wed, 25 Nov 2009 18:06:50 +0100
Message-ID: <20091125170650.5446.8246.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57397 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbZKYRH3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:07:29 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: fix PIO2 underclocking

[ port of Sergei's fixes for pata_efar from commit 5f33b3b ]

Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
fast timing bank starting with PIO2, just like the PIIX/ICH drivers do.
Also, fix/rephrase some comments while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -92,18 +92,17 @@ static void it8213_set_piomode (struct a
 			    { 2, 1 },
 			    { 2, 3 }, };
 
-	if (pio > 2)
-		control |= 1;	/* TIME1 enable */
+	if (pio > 1)
+		control |= 1;	/* TIME */
 	if (ata_pio_need_iordy(adev))	/* PIO 3/4 require IORDY */
-		control |= 2;	/* IORDY enable */
+		control |= 2;	/* IE */
 	/* Bit 2 is set for ATAPI on the IT8213 - reverse of ICH/PIIX */
 	if (adev->class != ATA_DEV_ATA)
-		control |= 4;
+		control |= 4;	/* PPE */
 
 	pci_read_config_word(dev, idetm_port, &idetm_data);
 
-	/* Enable PPE, IE and TIME as appropriate */
-
+	/* Set PPE, IE, and TIME as appropriate */
 	if (adev->devno == 0) {
 		idetm_data &= 0xCCF0;
 		idetm_data |= control;
@@ -122,7 +121,7 @@ static void it8213_set_piomode (struct a
 		pci_write_config_byte(dev, 0x44, slave_data);
 	}
 
-	idetm_data |= 0x4000;	/* Ensure SITRE is enabled */
+	idetm_data |= 0x4000;	/* Ensure SITRE is set */
 	pci_write_config_word(dev, idetm_port, idetm_data);
 }
 
