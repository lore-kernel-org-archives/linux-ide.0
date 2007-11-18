From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/21] ide-cris: don't override ide_register_hw() result
Date: Sun, 18 Nov 2007 23:19:02 +0100
Message-ID: <200711182319.02460.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbXKRWgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>


* Don't override ide_register_hw() result and check if there is a hwif
  available to use.

* MAX_HWIFS is user configurable nowadays so replace it by hard-coded value.

* Remove the comment about ide_hwifs[].

Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -770,15 +770,16 @@ init_e100_ide (void)
 	/* the IDE control register is at ATA address 6, with CS1 active instead of CS0 */
 	ide_offsets[IDE_CONTROL_OFFSET] = cris_ide_reg_addr(6, 1, 0);
 
-	/* first fill in some stuff in the ide_hwifs fields */
+	for (h = 0; h < 4; h++) {
+		ide_hwif_t *hwif = NULL;
 
-	for(h = 0; h < MAX_HWIFS; h++) {
-		ide_hwif_t *hwif = &ide_hwifs[h];
 		ide_setup_ports(&hw, cris_ide_base_address(h),
 		                ide_offsets,
 		                0, 0, cris_ide_ack_intr,
 		                ide_default_irq(0));
 		ide_register_hw(&hw, NULL, 1, &hwif);
+		if (hwif == NULL)
+			continue;
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
 		hwif->set_pio_mode = &cris_set_pio_mode;
