From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/18] sis5513: factor out UDMA programming code
Date: Mon, 5 Nov 2007 00:26:49 +0100
Message-ID: <200711050026.49990.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbXKDX3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:44 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Factor out UDMA programming code from sis_set_dma_mode() to per
  chipset family helpers: sis_{ata33,ata133}_program_udma_timings().

* Add sis_program_udma_timings() helper.

* Remove unneeded casts to 'unsigned long'.

* Minor cleanups.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   78 ++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -305,11 +305,52 @@ static void sis_set_pio_mode(ide_drive_t
 	sis_program_timings(drive, XFER_PIO_0 + pio);
 }
 
-static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
+static void sis_ata133_program_udma_timings(ide_drive_t *drive, const u8 mode)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u32 regdw = 0;
+	u8 drive_pci = sis_ata133_get_base(drive), clk, idx;
+
+	pci_read_config_dword(dev, drive_pci, &regdw);
+
+	regdw |= 0x04;
+	regdw &= 0xfffff00f;
+	/* check if ATA133 enable */
+	clk = (regdw & 0x08) ? ATA_133 : ATA_100;
+	idx = mode - XFER_UDMA_0;
+	regdw |= cycle_time_value[clk][idx] << 4;
+	regdw |= cvs_time_value[clk][idx] << 8;
+
+	pci_write_config_dword(dev, drive_pci, regdw);
+}
+
+static void sis_ata33_program_udma_timings(ide_drive_t *drive, const u8 mode)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	u8 drive_pci = 0x40 + drive->dn * 2, reg = 0, i = chipset_family;
+
+	pci_read_config_byte(dev, drive_pci + 1, &reg);
 
+	/* force the UDMA bit on if we want to use UDMA */
+	reg |= 0x80;
+	/* clean reg cycle time bits */
+	reg &= ~((0xff >> (8 - cycle_time_range[i])) << cycle_time_offset[i]);
+	/* set reg cycle time bits */
+	reg |= cycle_time_value[i][mode - XFER_UDMA_0] << cycle_time_offset[i];
+
+	pci_write_config_byte(dev, drive_pci + 1, reg);
+}
+
+static void sis_program_udma_timings(ide_drive_t *drive, const u8 mode)
+{
+	if (chipset_family >= ATA_133)	/* ATA_133 */
+		sis_ata133_program_udma_timings(drive, mode);
+	else				/* ATA_33/66/100a/100/133a */
+		sis_ata33_program_udma_timings(drive, mode);
+}
+
+static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
+{
 	/* Config chip for mode */
 	switch(speed) {
 		case XFER_UDMA_6:
@@ -319,36 +360,7 @@ static void sis_set_dma_mode(ide_drive_t
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
-			if (chipset_family >= ATA_133) {
-				u32 regdw = 0;
-				u8 drive_pci = sis_ata133_get_base(drive);
-
-				pci_read_config_dword(dev, drive_pci, &regdw);
-				regdw |= 0x04;
-				regdw &= 0xfffff00f;
-				/* check if ATA133 enable */
-				if (regdw & 0x08) {
-					regdw |= (unsigned long)cycle_time_value[ATA_133][speed-XFER_UDMA_0] << 4;
-					regdw |= (unsigned long)cvs_time_value[ATA_133][speed-XFER_UDMA_0] << 8;
-				} else {
-					regdw |= (unsigned long)cycle_time_value[ATA_100][speed-XFER_UDMA_0] << 4;
-					regdw |= (unsigned long)cvs_time_value[ATA_100][speed-XFER_UDMA_0] << 8;
-				}
-				pci_write_config_dword(dev, (unsigned long)drive_pci, regdw);
-			} else {
-				u8 drive_pci = 0x40 + drive->dn * 2, reg = 0;
-
-				pci_read_config_byte(dev, drive_pci+1, &reg);
-				/* Force the UDMA bit on if we want to use UDMA */
-				reg |= 0x80;
-				/* clean reg cycle time bits */
-				reg &= ~((0xFF >> (8 - cycle_time_range[chipset_family]))
-					 << cycle_time_offset[chipset_family]);
-				/* set reg cycle time bits */
-				reg |= cycle_time_value[chipset_family][speed-XFER_UDMA_0]
-					<< cycle_time_offset[chipset_family];
-				pci_write_config_byte(dev, drive_pci+1, reg);
-			}
+			sis_program_udma_timings(drive, speed);
 			break;
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
