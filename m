From: Anton Salnikov <asalnikov@ru.mvista.com>
Subject: [PATCH] Palmchip BK3710 IDE driver
Date: Mon, 21 Jan 2008 21:44:29 +0300
Message-ID: <200801212144.29511.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:38129 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751501AbYAUSoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 13:44:34 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com

This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
Supports interface to compact Flash (CF) configured in True-IDE mode.

Use ide_setup_dma() since BLK_DEV_PALMCHIP_BK3710 selects BLK_DEV_IDEDMA_PCI
So I deleted exports from ide-dma.c

Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>
---

 drivers/ide/Kconfig           |    8 
 drivers/ide/arm/Makefile      |    1 
 drivers/ide/arm/palm_bk3710.c |  434 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-proc.c        |    1 
 include/linux/ide.h           |    2 
 5 files changed, 445 insertions(+), 1 deletion(-)

Index: 2.6.24-rc8.ide/drivers/ide/Kconfig
===================================================================
--- 2.6.24-rc8.ide.orig/drivers/ide/Kconfig
+++ 2.6.24-rc8.ide/drivers/ide/Kconfig
@@ -1008,6 +1008,14 @@ config BLK_DEV_Q40IDE
 	  normally be on; disable it only if you are running a custom hard
 	  drive subsystem through an expansion card.
 
+config BLK_DEV_PALMCHIP_BK3710
+	bool "Palmchip bk3710 IDE controller support"
+	depends on ARCH_DAVINCI
+	select BLK_DEV_IDEDMA_PCI
+	help
+	  Say Y here if you want to support the onchip IDE controller on the
+	  TI DaVinci SoC
+
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
 	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && 
BLK_DEV_IDE=y && !PPC_MERGE
Index: 2.6.24-rc8.ide/drivers/ide/arm/Makefile
===================================================================
--- 2.6.24-rc8.ide.orig/drivers/ide/arm/Makefile
+++ 2.6.24-rc8.ide/drivers/ide/arm/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
 obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
+obj-$(CONFIG_BLK_DEV_PALMCHIP_BK3710)	+= palm_bk3710.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
Index: 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
===================================================================
--- /dev/null
+++ 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
@@ -0,0 +1,434 @@
+/*
+ * Palmchip bk3710 IDE controller
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ *
+ * ----------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * ----------------------------------------------------------------------------
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+/* Offset of the primary interface registers */
+#define IDE_PALM_ATA_PRI_REG_OFFSET 0x1F0
+
+/* Primary Control Offset */
+#define IDE_PALM_ATA_PRI_CTL_OFFSET 0x3F6
+
+/*
+ * PalmChip 3710 IDE Controller UDMA timing structure Definition
+ */
+struct palm_bk3710_udmatiming {
+	unsigned int rptime;	/* Ready to pause time  */
+	unsigned int cycletime;	/* Cycle Time           */
+};
+
+#define BK3710_BMICP		0x00
+#define BK3710_BMISP		0x02
+#define BK3710_BMIDTP		0x04
+#define BK3710_BMICS		0x08
+#define BK3710_BMISS		0x0A
+#define BK3710_BMIDTS		0x0C
+#define BK3710_IDETIMP		0x40
+#define BK3710_IDETIMS		0x42
+#define BK3710_SIDETIM		0x44
+#define BK3710_SLEWCTL		0x45
+#define BK3710_IDESTATUS	0x47
+#define BK3710_UDMACTL		0x48
+#define BK3710_UDMATIM		0x4A
+#define BK3710_MISCCTL		0x50
+#define BK3710_REGSTB		0x54
+#define BK3710_REGRCVR		0x58
+#define BK3710_DATSTB		0x5C
+#define BK3710_DATRCVR		0x60
+#define BK3710_DMASTB		0x64
+#define BK3710_DMARCVR		0x68
+#define BK3710_UDMASTB		0x6C
+#define BK3710_UDMATRP		0x70
+#define BK3710_UDMAENV		0x74
+#define BK3710_IORDYTMP		0x78
+#define BK3710_IORDYTMS		0x7C
+
+#include "../ide-timing.h"
+
+static long ide_palm_clk;
+static u32 base;
+
+static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
+	{160, 240},		/* UDMA Mode 0 */
+	{125, 160},		/* UDMA Mode 1 */
+	{100, 120},		/* UDMA Mode 2 */
+	{100, 90},		/* UDMA Mode 3 */
+	{85,  60},		/* UDMA Mode 4 */
+};
+
+static struct clk *ideclkp;
+
+static inline u32 ioread(u32 reg)
+{
+	return ioread32(base + reg);
+}
+
+static inline void iowrite(u32 val, u32 reg)
+{
+	iowrite32(val, base + reg);
+}
+
+static void palm_bk3710_setudmamode(unsigned int dev, unsigned int mode)
+{
+	u8 tenv, trp, t0;
+	u32 val;
+
+	/* DMA Data Setup */
+	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
+			/ ide_palm_clk - 1;
+	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
+	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
+			/ ide_palm_clk - 1;
+
+	/* udmatim Register */
+	val = ioread(BK3710_UDMATIM) & ((!dev) ? 0xFFF0 : 0xFF0F);
+	iowrite(val, BK3710_UDMATIM);
+	val = ioread(BK3710_UDMATIM) | (mode << ((!dev) ? 0 : 4));
+	iowrite(val, BK3710_UDMATIM);
+
+	/* udmastb Ultra DMA Access Strobe Width */
+	val = ioread(BK3710_UDMASTB) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_UDMASTB);
+	val = ioread(BK3710_UDMASTB) | (t0 << (dev << 4));
+	iowrite(val, BK3710_UDMASTB);
+
+	/* udmatrp Ultra DMA Ready to Pause Time */
+	val = ioread(BK3710_UDMATRP) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_UDMATRP);
+	val = ioread(BK3710_UDMATRP) | (trp << (dev << 4));
+	iowrite(val, BK3710_UDMATRP);
+
+	/* udmaenv Ultra DMA envelop Time */
+	val = ioread(BK3710_UDMAENV) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_UDMAENV);
+	val = ioread(BK3710_UDMAENV) | (tenv << (dev << 4));
+	iowrite(val, BK3710_UDMAENV);
+
+	/* Enable UDMA for Device */
+	val = ioread(BK3710_UDMACTL) | (1 << dev);
+	iowrite(val, BK3710_UDMACTL);
+}
+
+static void palm_bk3710_setdmamode(unsigned int dev, unsigned int cycletime,
+				  unsigned int mode)
+{
+	u8 td, tkw, t0;
+	u32 val;
+
+	if (cycletime < ide_timing[mode].cycle)
+		cycletime = ide_timing[mode].cycle;
+
+	/* DMA Data Setup */
+	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
+	td = (ide_timing_find_mode(mode)->active + ide_palm_clk - 1)
+			/ ide_palm_clk;
+	tkw = t0 - td - 1;
+	td -= 1;
+
+	val = ioread(BK3710_DMASTB) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_DMASTB);
+	val = ioread(BK3710_DMASTB) | (td << (dev << 4));
+	iowrite(val, BK3710_DMASTB);
+
+	val = ioread(BK3710_DMARCVR) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_DMARCVR);
+	val = ioread(BK3710_DMARCVR) | (tkw << (dev << 4));
+	iowrite(val, BK3710_DMARCVR);
+
+	/* Disable UDMA for Device */
+	val = ioread(BK3710_UDMACTL) & (0xFF00 | (1 << (!dev)));
+	iowrite(val, BK3710_UDMACTL);
+}
+
+static void palm_bk3710_setpiomode(ide_drive_t *mate, unsigned int dev,
+				  unsigned int cycletime, unsigned int mode)
+{
+	u8 t2, t2i, t0;
+	u32 val;
+	struct ide_timing *t;
+
+	/* PIO Data Setup */
+	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
+	t2 = (ide_timing_find_mode(XFER_PIO_0 + mode)->active + ide_palm_clk - 1)
+			/ ide_palm_clk;
+
+	t2i = t0 - t2 - 1;
+	t2 -= 1;
+
+	val = ioread(BK3710_DATSTB) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_DATSTB);
+	val = ioread(BK3710_DATSTB) | (t2 << (dev << 4));
+	iowrite(val, BK3710_DATSTB);
+
+	val = ioread(BK3710_DATRCVR) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_DATRCVR);
+	val = ioread(BK3710_DATRCVR) | (t2i << (dev << 4));
+	iowrite(val, BK3710_DATRCVR);
+
+	if (mate && mate->present) {
+		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);
+
+		if (mode2 < mode)
+			mode = mode2;
+	}
+
+	/* TASKFILE Setup */
+	t = ide_timing_find_mode(XFER_PIO_0 + mode);
+	t0 = (t->cyc8b + ide_palm_clk - 1)
+			/ ide_palm_clk;
+	t2 = (t->act8b + ide_palm_clk - 1)
+			/ ide_palm_clk;
+
+	t2i = t0 - t2 - 1;
+	t2 -= 1;
+
+	val = ioread(BK3710_REGSTB) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_REGSTB);
+	val = ioread(BK3710_REGSTB) | (t2 << (dev << 4));
+	iowrite(val, BK3710_REGSTB);
+
+	val = ioread(BK3710_REGRCVR) & (0xFF << ((!dev) << 4));
+	iowrite(val, BK3710_REGRCVR);
+	val = ioread(BK3710_REGRCVR) | (t2i << (dev << 4));
+	iowrite(val, BK3710_REGRCVR);
+}
+
+static void palm_bk3710_set_dma_mode(ide_drive_t *drive, u8 xferspeed)
+{
+	int is_slave = drive->dn & 1;
+
+	if (xferspeed >= XFER_UDMA_0) {
+		palm_bk3710_setudmamode(is_slave, xferspeed - XFER_UDMA_0);
+	} else {
+		int nspeed = 10 - xferspeed + XFER_MW_DMA_0;
+		unsigned ide_cycle = max_t(int, ide_timing[nspeed].cycle,
+					   drive->id->eide_dma_min);
+
+		palm_bk3710_setdmamode(is_slave, ide_cycle, nspeed);
+	}
+}
+
+static void palm_bk3710_set_pio_mode(ide_drive_t *drive, u8 pio)
+{
+	unsigned int cycle_time;
+	int is_slave = drive->dn & 1;
+	ide_drive_t *mate;
+
+	/*
+	 * Obtain the drive PIO data for tuning the Palm Chip registers
+	 */
+	cycle_time = ide_pio_cycle_time(drive, pio);
+	mate = ide_get_paired_drive(drive);
+	palm_bk3710_setpiomode(mate, is_slave, cycle_time, pio);
+}
+
+static void __devinit palm_bk3710_chipinit(void)
+{
+	/*
+	 * enable the reset_en of ATA controller so that when ata signals
+	 * are brought out, by writing into device config. at that
+	 * time por_n signal should not be 'Z' and have a stable value.
+	 */
+	iowrite(0x0300, BK3710_MISCCTL);
+
+	/* wait for some time and deassert the reset of ATA Device. */
+	mdelay(100);
+
+	/* Deassert the Reset */
+	iowrite(0x0200, BK3710_MISCCTL);
+
+	/*
+	 * Program the IDETIMP Register Value based on the following assumptions
+	 *
+	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
+	 * (ATA_IDETIMP_SLVTIMEN	, DISABLE) |
+	 * (ATA_IDETIMP_RDYSMPL		, 70NS)    |
+	 * (ATA_IDETIMP_RDYRCVRY	, 50NS)    |
+	 * (ATA_IDETIMP_DMAFTIM1	, PIOCOMP) |
+	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
+	 * (ATA_IDETIMP_RDYSEN1		, DISABLE) |
+	 * (ATA_IDETIMP_PIOFTIM1	, DISABLE) |
+	 * (ATA_IDETIMP_DMAFTIM0	, PIOCOMP) |
+	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
+	 * (ATA_IDETIMP_RDYSEN0		, DISABLE) |
+	 * (ATA_IDETIMP_PIOFTIM0	, DISABLE)
+	 */
+	iowrite(0xB388, BK3710_IDETIMP);
+
+	/*
+	 * Configure  SIDETIM  Register
+	 * (ATA_SIDETIM_RDYSMPS1	,120NS ) |
+	 * (ATA_SIDETIM_RDYRCYS1	,120NS )
+	 */
+	iowrite(0, BK3710_SIDETIM);
+
+	/*
+	 * UDMACTL Ultra-ATA DMA Control
+	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
+	 * (ATA_UDMACTL_UDMAP0	, 0 )
+	 *
+	 */
+	iowrite(0, BK3710_UDMACTL);
+
+	/*
+	 * MISCCTL Miscellaneous Conrol Register
+	 * (ATA_MISCCTL_RSTMODEP	, 1) |
+	 * (ATA_MISCCTL_RESETP		, 0) |
+	 * (ATA_MISCCTL_TIMORIDE	, 1)
+	 */
+	iowrite(0x201, BK3710_MISCCTL);
+
+	/*
+	 * IORDYTMP IORDY Timer for Primary Register
+	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
+	 */
+	iowrite(0xFFFF, BK3710_IORDYTMP);
+
+	/*
+	 * Configure BMISP Register
+	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
+	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
+	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
+	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
+	 * (ATA_BMISP_DMAERROR	, CLEAR)
+	 */
+	iowrite(0, BK3710_BMISP);
+
+	palm_bk3710_setpiomode(NULL, 0, 600, 0);
+	palm_bk3710_setpiomode(NULL, 1, 600, 0);
+}
+
+static int __devinit palm_bk3710_probe(struct platform_device *pdev)
+{
+	hw_regs_t ide_ctlr_info;
+	int index = 0;
+	int pribase;
+	struct clk *clkp;
+	struct resource *mem, *irq;
+	ide_hwif_t *hwif;
+
+	clkp = clk_get(NULL, "IDECLK");
+	if (IS_ERR(clkp))
+		return -ENODEV;
+
+	ideclkp = clkp;
+	clk_enable(ideclkp);
+	ide_palm_clk = clk_get_rate(ideclkp)/100000;
+	ide_palm_clk = (10000/ide_palm_clk) + 1;
+	/* Register the IDE interface with Linux ATA Interface */
+	memset(&ide_ctlr_info, 0, sizeof(ide_ctlr_info));
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem == NULL) {
+		printk(KERN_INFO "failed to get memory region resource\n");
+		return -ENODEV;
+	}
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (irq == NULL) {
+		printk(KERN_INFO "failed to get IRQ resource\n");
+		return -ENODEV;
+	}
+
+	base = mem->start;
+	/* Configure the Palm Chip controller */
+	palm_bk3710_chipinit();
+
+	pribase = mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
+	for (index = 0; index < IDE_NR_PORTS - 2; index++)
+		ide_ctlr_info.io_ports[index] = pribase + index;
+	ide_ctlr_info.io_ports[IDE_CONTROL_OFFSET] = mem->start +
+			IDE_PALM_ATA_PRI_CTL_OFFSET;
+	ide_ctlr_info.irq = irq->start;
+	ide_ctlr_info.chipset = ide_palm3710;
+
+	if (!request_region(mem->start, 8, "palm_bk3710")) {
+		printk(KERN_ERR "Error, ports in use.\n");
+		return -EBUSY;
+	}
+
+	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &hwif) < 0) {
+		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
+		return -ENODEV;
+	}
+
+	hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
+	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
+	hwif->mmio = 1;
+	hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
+						(input clk 99MHz) */
+	hwif->mwdma_mask = 0x7;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+
+	hwif->dmatable_cpu = dma_alloc_coherent(
+				NULL,
+				PRD_ENTRIES * PRD_BYTES,
+				&hwif->dmatable_dma,
+				GFP_ATOMIC);
+
+	if (!hwif->dmatable_cpu) {
+		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
+		hwif->ultra_mask = 0;
+		hwif->mwdma_mask = 0;
+		return 0;
+	}
+
+	hwif->dma_base = mem->start;
+
+	hwif->dma_master = mem->start;
+
+	hwif->dma_command = mem->start;
+	hwif->dma_status = mem->start + 2;
+	hwif->dma_prdtable = mem->start + 4;
+	ide_setup_dma(hwif, mem->start, 8);
+
+	return 0;
+}
+
+static struct platform_driver platform_bk_driver = {
+	.driver = {
+		.name = "palm_bk3710",
+	},
+	.probe = palm_bk3710_probe,
+	.remove = NULL,
+};
+
+static int __init palm_bk3710_init(void)
+{
+	return platform_driver_register(&platform_bk_driver);
+}
+
+module_init(palm_bk3710_init);
+MODULE_LICENSE("GPL");
+
Index: 2.6.24-rc8.ide/drivers/ide/ide-proc.c
===================================================================
--- 2.6.24-rc8.ide.orig/drivers/ide/ide-proc.c
+++ 2.6.24-rc8.ide/drivers/ide/ide-proc.c
@@ -67,6 +67,7 @@ static int proc_ide_read_imodel
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
 		case ide_au1xxx:	name = "au1xxx";	break;
+		case ide_palm3710:      name = "palm3710";      break;
 		case ide_etrax100:	name = "etrax100";	break;
 		case ide_acorn:		name = "acorn";		break;
 		default:		name = "(unknown)";	break;
Index: 2.6.24-rc8.ide/include/linux/ide.h
===================================================================
--- 2.6.24-rc8.ide.orig/include/linux/ide.h
+++ 2.6.24-rc8.ide/include/linux/ide.h
@@ -202,7 +202,7 @@ enum {		ide_unknown,	ide_generic,	ide_pc
 		ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_au1xxx, ide_forced
+		ide_au1xxx,	ide_palm3710,	ide_forced
 };
 
 typedef u8 hwif_chipset_t;
