From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/18] ide: add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag
Date: Mon, 5 Nov 2007 00:31:10 +0100
Message-ID: <200711050031.10290.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbXKDX3q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:46 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag and use it to decide
  what to do with transfer modes < XFER_PIO_0 in ide_set_xfer_rate().

* Set IDE_HFLAG_ABUSE_SET_DMA_MODE in host drivers that need it
  (aec62xx, amd74xx, cs5520, cs5535, hpt34x, hpt366, pdc202xx_old,
  serverworks, tc86c001 and via82cxxx) and cleanup ->set_dma_mode
  methods in host drivers that don't (IDE core code guarantees that
  ->set_dma_mode will be called only for modes which are present
  in SWDMA/MWDMA/UDMA masks).

While at it:

* Add IDE_HFLAGS_HPT34X/HPT3XX/PDC202XX/SVWKS define in
  hpt34x/hpt366/pdc202xx_old/serverworks host driver.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c       |    2 -
 drivers/ide/cris/ide-cris.c    |    2 -
 drivers/ide/ide-lib.c          |    6 +++++
 drivers/ide/mips/au1xxx-ide.c  |    2 -
 drivers/ide/pci/aec62xx.c      |   13 +++++++++---
 drivers/ide/pci/alim15x3.c     |    3 --
 drivers/ide/pci/amd74xx.c      |    1 
 drivers/ide/pci/atiixp.c       |    3 --
 drivers/ide/pci/cmd64x.c       |    2 -
 drivers/ide/pci/cs5520.c       |    1 
 drivers/ide/pci/cs5530.c       |    2 -
 drivers/ide/pci/cs5535.c       |    2 -
 drivers/ide/pci/hpt34x.c       |   12 ++++++-----
 drivers/ide/pci/hpt366.c       |   19 ++++++++++--------
 drivers/ide/pci/it8213.c       |   21 +++-----------------
 drivers/ide/pci/pdc202xx_new.c |   38 +++++++++++--------------------------
 drivers/ide/pci/pdc202xx_old.c |   12 ++++++-----
 drivers/ide/pci/piix.c         |   17 +++-------------
 drivers/ide/pci/sc1200.c       |    2 -
 drivers/ide/pci/scc_pata.c     |   14 -------------
 drivers/ide/pci/serverworks.c  |   17 +++++++++-------
 drivers/ide/pci/siimage.c      |   29 +++++++---------------------
 drivers/ide/pci/sis5513.c      |   23 +++-------------------
 drivers/ide/pci/sl82c105.c     |   40 +++++++++++++++------------------------
 drivers/ide/pci/slc90e66.c     |   14 +------------
 drivers/ide/pci/tc86c001.c     |    3 +-
 drivers/ide/pci/triflex.c      |    2 -
 drivers/ide/pci/via82cxxx.c    |    1 
 drivers/ide/ppc/pmac.c         |   42 +++++++++++------------------------------
 include/linux/ide.h            |    1 
 30 files changed, 121 insertions(+), 225 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -272,8 +272,6 @@ static void icside_set_dma_mode(ide_driv
 	case XFER_SW_DMA_0:
 		cycle_time = 480;
 		break;
-	default:
-		return;
 	}
 
 	/*
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -747,8 +747,6 @@ static void cris_set_dma_mode(ide_drive_
 			strobe = ATA_DMA2_STROBE;
 			hold = ATA_DMA2_HOLD;
 			break;
-		default:
-			return;
 	}
 
 	if (speed >= XFER_UDMA_0)
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -438,6 +438,12 @@ int ide_set_xfer_rate(ide_drive_t *drive
 	 * case could happen iff the transfer mode has already been set on
 	 * the device by ide-proc.c::set_xfer_rate()).
 	 */
+	if (rate < XFER_PIO_0) {
+		if (hwif->host_flags & IDE_HFLAG_ABUSE_SET_DMA_MODE)
+			return ide_set_dma_mode(drive, rate);
+		else
+			return ide_config_drive_speed(drive, rate);
+	}
 
 	return ide_set_dma_mode(drive, rate);
 }
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -198,8 +198,6 @@ static void auide_set_dma_mode(ide_drive
 
 		break;
 #endif
-	default:
-		return;
 	}
 
 	au_writel(mem_sttime,MEM_STTIME2);
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -202,6 +202,7 @@ static const struct ide_port_info aec62x
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	= IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -211,6 +212,7 @@ static const struct ide_port_info aec62x
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_NO_AUTODMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
@@ -220,7 +222,8 @@ static const struct ide_port_info aec62x
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA,
+		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA4,
@@ -228,7 +231,9 @@ static const struct ide_port_info aec62x
 		.name		= "AEC6280",
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -237,7 +242,9 @@ static const struct ide_port_info aec62x
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -402,9 +402,6 @@ static void ali_set_dma_mode(ide_drive_t
 	u8 tmpbyte		= 0x00;
 	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
 
-	if (speed < XFER_PIO_0)
-		return;
-
 	if (speed == XFER_UDMA_6)
 		speed1 = 0x47;
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -266,6 +266,7 @@ static void __devinit init_hwif_amd74xx(
 #define IDE_HFLAGS_AMD \
 	(IDE_HFLAG_PIO_NO_BLACKLIST | \
 	 IDE_HFLAG_PIO_NO_DOWNGRADE | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
 	 IDE_HFLAG_POST_SET_MODE | \
 	 IDE_HFLAG_IO_32BIT | \
 	 IDE_HFLAG_UNMASK_IRQS | \
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -133,9 +133,6 @@ static void atiixp_set_dma_mode(ide_driv
 	u32 tmp32;
 	u16 tmp16;
 
-	if (speed < XFER_MW_DMA_0)
-		return;
-
 	spin_lock_irqsave(&atiixp_lock, flags);
 
 	save_mdma_mode[drive->dn] = 0;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -322,8 +322,6 @@ static void cmd64x_set_dma_mode(ide_driv
 	case XFER_MW_DMA_0:
 		program_cycle_times(drive, 480, 215);
 		break;
-	default:
-		return;
 	}
 
 	if (speed >= XFER_SW_DMA_0)
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -137,6 +137,7 @@ static void __devinit init_hwif_cs5520(i
 				  IDE_HFLAG_CS5520 |		\
 				  IDE_HFLAG_VDMA |		\
 				  IDE_HFLAG_NO_ATAPI_DMA |	\
+				  IDE_HFLAG_ABUSE_SET_DMA_MODE |\
 				  IDE_HFLAG_BOOTABLE,		\
 		.pio_mask	= ATA_PIO4,			\
 	}
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -116,8 +116,6 @@ static void cs5530_set_dma_mode(ide_driv
 		case XFER_MW_DMA_0:	timings = 0x00077771; break;
 		case XFER_MW_DMA_1:	timings = 0x00012121; break;
 		case XFER_MW_DMA_2:	timings = 0x00002020; break;
-		default:
-			return;
 	}
 	basereg = CS5530_BASEREG(drive->hwif);
 	reg = inl(basereg + 4);			/* get drive0 config register */
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -190,7 +190,7 @@ static const struct ide_port_info cs5535
 	.name		= "CS5535",
 	.init_hwif	= init_hwif_cs5535,
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
-			  IDE_HFLAG_BOOTABLE,
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE | IDE_HFLAG_BOOTABLE,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA4,
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -129,14 +129,18 @@ static void __devinit init_hwif_hpt34x(i
 	hwif->set_dma_mode = &hpt34x_set_mode;
 }
 
+#define IDE_HFLAGS_HPT34X \
+	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_NO_AUTODMA)
+
 static const struct ide_port_info hpt34x_chipsets[] __devinitdata = {
 	{ /* 0 */
 		.name		= "HPT343",
 		.init_chipset	= init_chipset_hpt34x,
 		.init_hwif	= init_hwif_hpt34x,
 		.extra		= 16,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_NO_AUTODMA,
+		.host_flags	= IDE_HFLAGS_HPT34X,
 		.pio_mask	= ATA_PIO5,
 	},
 	{ /* 1 */
@@ -144,9 +148,7 @@ static const struct ide_port_info hpt34x
 		.init_chipset	= init_chipset_hpt34x,
 		.init_hwif	= init_hwif_hpt34x,
 		.extra		= 16,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_NO_AUTODMA |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT34X | IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO5,
 #ifdef CONFIG_HPT34X_AUTODMA
 		.swdma_mask	= ATA_SWDMA2,
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1416,6 +1416,11 @@ static int __devinit hpt36x_init(struct 
 	return 0;
 }
 
+#define IDE_HFLAGS_HPT3XX \
+	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_OFF_BOARD)
+
 static const struct ide_port_info hpt366_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "HPT36x",
@@ -1430,9 +1435,7 @@ static const struct ide_port_info hpt366
 		 */
 		.enablebits	= {{0x50,0x10,0x10}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_NO_ATAPI_DMA |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX | IDE_HFLAG_SINGLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 1 */
@@ -1442,7 +1445,7 @@ static const struct ide_port_info hpt366
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 2 */
@@ -1452,7 +1455,7 @@ static const struct ide_port_info hpt366
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 3 */
@@ -1462,7 +1465,7 @@ static const struct ide_port_info hpt366
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 4 */
@@ -1473,7 +1476,7 @@ static const struct ide_port_info hpt366
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= ATA_UDMA5,
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	},{	/* 5 */
@@ -1483,7 +1486,7 @@ static const struct ide_port_info hpt366
 		.init_dma	= init_dma_hpt366,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.extra		= 240,
-		.host_flags	= IDE_HFLAG_NO_ATAPI_DMA | IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_HPT3XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 	}
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -101,24 +101,11 @@ static void it8213_set_dma_mode(ide_driv
 	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
 
-	switch(speed) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_4:
-		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
-		case XFER_UDMA_5:
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	u_speed = 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:
-			break;
-		default:
-			return;
-	}
-
 	if (speed >= XFER_UDMA_0) {
+		u8 udma = speed - XFER_UDMA_0;
+
+		u_speed = min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed >= XFER_UDMA_5) {
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -162,32 +162,18 @@ static void pdcnew_set_dma_mode(ide_driv
 	if (max_dma_rate(hwif->pci_dev) == 4) {
 		u8 mode = speed & 0x07;
 
-		switch (speed) {
-			case XFER_UDMA_6:
-			case XFER_UDMA_5:
-			case XFER_UDMA_4:
-			case XFER_UDMA_3:
-			case XFER_UDMA_2:
-			case XFER_UDMA_1:
-			case XFER_UDMA_0:
-				set_indexed_reg(hwif, 0x10 + adj,
-						udma_timings[mode].reg10);
-				set_indexed_reg(hwif, 0x11 + adj,
-						udma_timings[mode].reg11);
-				set_indexed_reg(hwif, 0x12 + adj,
-						udma_timings[mode].reg12);
-				break;
-			case XFER_MW_DMA_2:
-			case XFER_MW_DMA_1:
-			case XFER_MW_DMA_0:
-				set_indexed_reg(hwif, 0x0e + adj,
-						mwdma_timings[mode].reg0e);
-				set_indexed_reg(hwif, 0x0f + adj,
-						mwdma_timings[mode].reg0f);
-				break;
-			default:
-				printk(KERN_ERR "pdc202xx_new: "
-				       "Unknown speed %d ignored\n", speed);
+		if (speed >= XFER_UDMA_0) {
+			set_indexed_reg(hwif, 0x10 + adj,
+					udma_timings[mode].reg10);
+			set_indexed_reg(hwif, 0x11 + adj,
+					udma_timings[mode].reg11);
+			set_indexed_reg(hwif, 0x12 + adj,
+					udma_timings[mode].reg12);
+		} else {
+			set_indexed_reg(hwif, 0x0e + adj,
+					mwdma_timings[mode].reg0e);
+			set_indexed_reg(hwif, 0x0f + adj,
+					mwdma_timings[mode].reg0f);
 		}
 	} else if (speed == XFER_UDMA_2) {
 		/* Set tHOLD bit to 0 if using UDMA mode 2 */
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -375,6 +375,11 @@ static void __devinit pdc202ata4_fixup_i
 	}
 }
 
+#define IDE_HFLAGS_PDC202XX \
+	(IDE_HFLAG_ERROR_STOPS_FIFO | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_OFF_BOARD)
+
 #define DECLARE_PDC2026X_DEV(name_str, udma, extra_flags) \
 	{ \
 		.name		= name_str, \
@@ -382,9 +387,7 @@ static void __devinit pdc202ata4_fixup_i
 		.init_hwif	= init_hwif_pdc202xx, \
 		.init_dma	= init_dma_pdc202xx, \
 		.extra		= 48, \
-		.host_flags	= IDE_HFLAG_ERROR_STOPS_FIFO | \
-				  extra_flags | \
-				  IDE_HFLAG_OFF_BOARD, \
+		.host_flags	= IDE_HFLAGS_PDC202XX | extra_flags, \
 		.pio_mask	= ATA_PIO4, \
 		.mwdma_mask	= ATA_MWDMA2, \
 		.udma_mask	= udma, \
@@ -397,8 +400,7 @@ static const struct ide_port_info pdc202
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.extra		= 16,
-		.host_flags	= IDE_HFLAG_ERROR_STOPS_FIFO |
-				  IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAGS_PDC202XX,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -203,20 +203,11 @@ static void piix_set_dma_mode(ide_drive_
 	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
 
-	switch(speed) {
-		case XFER_UDMA_4:
-		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
-		case XFER_UDMA_5:
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	u_speed = 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:	break;
-		default:		return;
-	}
-
 	if (speed >= XFER_UDMA_0) {
+		u8 udma = speed - XFER_UDMA_0;
+
+		u_speed = min_t(u8, 2 - (udma & 1), udma) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed == XFER_UDMA_5) {
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -185,8 +185,6 @@ static void sc1200_set_dma_mode(ide_driv
 				case PCI_CLK_66:	timings = 0x00015151;	break;
 			}
 			break;
-		default:
-			return;
 	}
 
 	if (unit == 0) {			/* are we configuring drive0? */
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -254,19 +254,7 @@ static void scc_set_dma_mode(ide_drive_t
 		offset = 0; /* 100MHz */
 	}
 
-	switch (speed) {
-	case XFER_UDMA_6:
-	case XFER_UDMA_5:
-	case XFER_UDMA_4:
-	case XFER_UDMA_3:
-	case XFER_UDMA_2:
-	case XFER_UDMA_1:
-	case XFER_UDMA_0:
-		idx = speed - XFER_UDMA_0;
-		break;
-	default:
-		return;
-	}
+	idx = speed - XFER_UDMA_0;
 
 	jcactsel = JCACTSELtbl[offset][idx];
 	if (is_slave) {
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -366,12 +366,17 @@ static void __devinit init_hwif_svwks (i
 	}
 }
 
+#define IDE_HFLAGS_SVWKS \
+	(IDE_HFLAG_LEGACY_IRQS | \
+	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
+	 IDE_HFLAG_BOOTABLE)
+
 static const struct ide_port_info serverworks_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "SvrWks OSB4",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_SVWKS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= 0x00, /* UDMA is problematic on OSB4 */
@@ -379,7 +384,7 @@ static const struct ide_port_info server
 		.name		= "SvrWks CSB5",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_SVWKS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -387,7 +392,7 @@ static const struct ide_port_info server
 		.name		= "SvrWks CSB6",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_SVWKS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -395,8 +400,7 @@ static const struct ide_port_info server
 		.name		= "SvrWks CSB6",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_SVWKS | IDE_HFLAG_SINGLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
@@ -404,8 +408,7 @@ static const struct ide_port_info server
 		.name		= "SvrWks HT1000",
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.host_flags	= IDE_HFLAG_LEGACY_IRQS | IDE_HFLAG_SINGLE |
-				  IDE_HFLAG_BOOTABLE,
+		.host_flags	= IDE_HFLAGS_SVWKS | IDE_HFLAG_SINGLE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA5,
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -278,27 +278,14 @@ static void sil_set_dma_mode(ide_drive_t
 
 	scsc = is_sata(hwif) ? 1 : scsc;
 
-	switch(speed) {
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			multi = dma[speed - XFER_MW_DMA_0];
-			mode |= ((unit) ? 0x20 : 0x02);
-			break;
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			multi = dma[2];
-			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
-					   (ultra5[speed - XFER_UDMA_0]));
-			mode |= ((unit) ? 0x30 : 0x03);
-			break;
-		default:
-			return;
+	if (speed >= XFER_UDMA_0) {
+		multi = dma[2];
+		ultra |= (scsc ? ultra6[speed - XFER_UDMA_0] :
+				 ultra5[speed - XFER_UDMA_0]);
+		mode |= (unit ? 0x30 : 0x03);
+	} else {
+		multi = dma[speed - XFER_MW_DMA_0];
+		mode |= (unit ? 0x20 : 0x02);
 	}
 
 	if (hwif->mmio) {
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -351,25 +351,10 @@ static void sis_program_udma_timings(ide
 
 static void sis_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-	/* Config chip for mode */
-	switch(speed) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			sis_program_udma_timings(drive, speed);
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			sis_program_timings(drive, speed);
-			break;
-		default:
-			break;
-	}
+	if (speed >= XFER_UDMA_0)
+		sis_program_udma_timings(drive, speed);
+	else
+		sis_program_timings(drive, speed);
 }
 
 static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -115,32 +115,24 @@ static void sl82c105_set_dma_mode(ide_dr
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
 	     drive->name, ide_xfer_verbose(speed)));
 
-	switch (speed) {
-	case XFER_MW_DMA_2:
-	case XFER_MW_DMA_1:
-	case XFER_MW_DMA_0:
-		drv_ctrl = mwdma_timings[speed - XFER_MW_DMA_0];
+	drv_ctrl = mwdma_timings[speed - XFER_MW_DMA_0];
 
-		/*
-		 * Store the DMA timings so that we can actually program
-		 * them when DMA will be turned on...
-		 */
-		drive->drive_data &= 0x0000ffff;
-		drive->drive_data |= (unsigned long)drv_ctrl << 16;
+	/*
+	 * Store the DMA timings so that we can actually program
+	 * them when DMA will be turned on...
+	 */
+	drive->drive_data &= 0x0000ffff;
+	drive->drive_data |= (unsigned long)drv_ctrl << 16;
 
-		/*
-		 * If we are already using DMA, we just reprogram
-		 * the drive control register.
-		 */
-		if (drive->using_dma) {
-			struct pci_dev *dev	= HWIF(drive)->pci_dev;
-			int reg 		= 0x44 + drive->dn * 4;
-
-			pci_write_config_word(dev, reg, drv_ctrl);
-		}
-		break;
-	default:
-		return;
+	/*
+	 * If we are already using DMA, we just reprogram
+	 * the drive control register.
+	 */
+	if (drive->using_dma) {
+		struct pci_dev *dev	= HWIF(drive)->pci_dev;
+		int reg 		= 0x44 + drive->dn * 4;
+
+		pci_write_config_word(dev, reg, drv_ctrl);
 	}
 }
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -91,19 +91,9 @@ static void slc90e66_set_dma_mode(ide_dr
 	pci_read_config_word(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
 
-	switch(speed) {
-		case XFER_UDMA_4:	u_speed = 4 << (drive->dn * 4); break;
-		case XFER_UDMA_3:	u_speed = 3 << (drive->dn * 4); break;
-		case XFER_UDMA_2:	u_speed = 2 << (drive->dn * 4); break;
-		case XFER_UDMA_1:	u_speed = 1 << (drive->dn * 4); break;
-		case XFER_UDMA_0:	u_speed = 0 << (drive->dn * 4); break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_SW_DMA_2:	break;
-		default:		return;
-	}
-
 	if (speed >= XFER_UDMA_0) {
+		u_speed = (speed - XFER_UDMA_0) << (drive->dn * 4);
+
 		if (!(reg48 & u_flag))
 			pci_write_config_word(dev, 0x48, reg48|u_flag);
 		/* FIXME: (reg4a & a_speed) ? */
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -222,7 +222,8 @@ static const struct ide_port_info tc86c0
 	.name		= "TC86C001",
 	.init_chipset	= init_chipset_tc86c001,
 	.init_hwif	= init_hwif_tc86c001,
-	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_OFF_BOARD,
+	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_OFF_BOARD |
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE,
 	.pio_mask	= ATA_PIO4,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA4,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -81,8 +81,6 @@ static void triflex_set_mode(ide_drive_t
 		case XFER_PIO_0:
 			timing = 0x0808;
 			break;
-		default:
-			return;
 	}
 
 	triflex_timings &= ~(0xFFFF << (16 * unit));
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -439,6 +439,7 @@ static const struct ide_port_info via82c
 	.enablebits	= { { 0x40, 0x02, 0x02 }, { 0x40, 0x01, 0x01 } },
 	.host_flags	= IDE_HFLAG_PIO_NO_BLACKLIST |
 			  IDE_HFLAG_PIO_NO_DOWNGRADE |
+			  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 			  IDE_HFLAG_POST_SET_MODE |
 			  IDE_HFLAG_IO_32BIT |
 			  IDE_HFLAG_BOOTABLE,
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -828,38 +828,20 @@ static void pmac_ide_set_dma_mode(ide_dr
 	tl[0] = *timings;
 	tl[1] = *timings2;
 
-	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			if (pmif->kind == controller_kl_ata4)
-				ret = set_timings_udma_ata4(&tl[0], speed);
-			else if (pmif->kind == controller_un_ata6
-				 || pmif->kind == controller_k2_ata6)
-				ret = set_timings_udma_ata6(&tl[0], &tl[1], speed);
-			else if (pmif->kind == controller_sh_ata6)
-				ret = set_timings_udma_shasta(&tl[0], &tl[1], speed);
-			else
-				ret = 1;
-			break;
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed);
-			break;
-		case XFER_SW_DMA_2:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-			return;
+	if (speed >= XFER_UDMA_0) {
+		if (pmif->kind == controller_kl_ata4)
+			ret = set_timings_udma_ata4(&tl[0], speed);
+		else if (pmif->kind == controller_un_ata6
+			 || pmif->kind == controller_k2_ata6)
+			ret = set_timings_udma_ata6(&tl[0], &tl[1], speed);
+		else if (pmif->kind == controller_sh_ata6)
+			ret = set_timings_udma_shasta(&tl[0], &tl[1], speed);
+		else
+			ret = -1;
+	} else
+		set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
-		default:
-			ret = 1;
-	}
 	if (ret)
 		return;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1094,6 +1094,7 @@ enum {
 	IDE_HFLAG_IO_32BIT		= (1 << 24),
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
+	IDE_HFLAG_ABUSE_SET_DMA_MODE	= (1 << 26),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
