From: Anton Salnikov <asalnikov@ru.mvista.com>
Subject: [PATCH] Palmchip BK3710 IDE driver
Date: Thu, 17 Jan 2008 21:50:56 +0300
Message-ID: <200801172150.57059.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:26963 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751882AbYAQSvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 13:51:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com

This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
Supports interface to compact Flash (CF) configured in True-IDE mode.

I had to export two functions (ide_dma_exec_cmd and __ide_dma_test_irq) from 
driver/ide/ide-dma.c to get rid of copying them.

Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>
---

 drivers/ide/Kconfig           |    8 
 drivers/ide/arm/Makefile      |    1 
 drivers/ide/arm/palm_bk3710.c |  486 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-dma.c         |    6 
 drivers/ide/ide-proc.c        |    1 
 include/linux/ide.h           |    4 
 6 files changed, 503 insertions(+), 3 deletions(-)

Index: 2.6.24-rc7.ide/drivers/ide/Kconfig
===================================================================
--- 2.6.24-rc7.ide.orig/drivers/ide/Kconfig
+++ 2.6.24-rc7.ide/drivers/ide/Kconfig
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
Index: 2.6.24-rc7.ide/drivers/ide/arm/Makefile
===================================================================
--- 2.6.24-rc7.ide.orig/drivers/ide/arm/Makefile
+++ 2.6.24-rc7.ide/drivers/ide/arm/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
 obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
+obj-$(CONFIG_BLK_DEV_PALMCHIP_BK3710)	+= palm_bk3710.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
Index: 2.6.24-rc7.ide/drivers/ide/arm/palm_bk3710.c
===================================================================
--- /dev/null
+++ 2.6.24-rc7.ide/drivers/ide/arm/palm_bk3710.c
@@ -0,0 +1,486 @@
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
+ Modifications:
+ ver. 1.0: Oct 2005, Swaminathan S
+ -
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
+/*
+ * Register Layout Structure for DmaEngine
+ */
+struct palm_bk3710_dmaengineregs {
+	unsigned short bmicp;
+	unsigned short bmisp;
+	unsigned int bmidtp;
+	unsigned short bmics;
+	unsigned short bmiss;
+	unsigned int bmidts;
+};
+
+/*
+ * Register Layout Structure for Config
+ */
+struct palm_bk3710_ideconfigregs {
+	unsigned short idetimp __attribute__((packed));
+	unsigned short idetims __attribute__((packed));
+	unsigned char sidetim;
+	unsigned short slewctl __attribute__((packed));
+	unsigned char idestatus;
+	unsigned short udmactl __attribute__((packed));
+	unsigned short udmatim __attribute__((packed));
+	unsigned char rsvd0[4];
+	unsigned int miscctl __attribute__((packed));
+	unsigned int regstb __attribute__((packed));
+	unsigned int regrcvr __attribute__((packed));
+	unsigned int datstb __attribute__((packed));
+	unsigned int datrcvr __attribute__((packed));
+	unsigned int dmastb __attribute__((packed));
+	unsigned int dmarcvr __attribute__((packed));
+	unsigned int udmastb __attribute__((packed));
+	unsigned int udmatrp __attribute__((packed));
+	unsigned int udmaenv __attribute__((packed));
+	unsigned int iordytmp __attribute__((packed));
+	unsigned int iordytms __attribute__((packed));
+};
+
+/*
+ * Register Layout Structure
+ */
+struct palm_bk3710_ideregs {
+	struct palm_bk3710_dmaengineregs dmaengine;
+	unsigned char rsvd0[48];
+	struct palm_bk3710_ideconfigregs config;
+};
+
+#include "../ide-timing.h"
+
+static ide_hwif_t *palm_bk3710_hwif;
+static struct palm_bk3710_ideregs __iomem *palm_bk3710_base;
+static long ide_palm_clk;
+
+static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
+	{160, 240},		/* UDMA Mode 0 */
+	{125, 160},		/* UDMA Mode 1 */
+	{100, 120},		/* UDMA Mode 2 */
+	{100, 90},		/* UDMA Mode 3 */
+	{85,  60},		/* UDMA Mode 4 */
+	{85,  40}		/* UDMA Mode 5 */
+};
+
+static struct clk *ideclkp;
+
+static void palm_bk3710_setudmamode(unsigned int dev, unsigned int level)
+{
+	char ide_tenv, ide_trp, ide_t0;
+
+	/* DMA Data Setup */
+	ide_t0 = (palm_bk3710_udmatimings[level].cycletime + ide_palm_clk - 1)
+			/ ide_palm_clk - 1;
+	ide_tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
+	ide_trp = (palm_bk3710_udmatimings[level].rptime + ide_palm_clk - 1)
+			/ ide_palm_clk - 1;
+
+
+	if (!dev) {
+		/* setup master device parameters */
+
+		/* udmatim Register */
+		palm_bk3710_base->config.udmatim &= 0xFFF0;
+		palm_bk3710_base->config.udmatim |= level;
+		/* udmastb Ultra DMA Access Strobe Width */
+		palm_bk3710_base->config.udmastb &= 0xFF00;
+		palm_bk3710_base->config.udmastb |= ide_t0;
+		/* udmatrp Ultra DMA Ready to Pause Time */
+		palm_bk3710_base->config.udmatrp &= 0xFF00;
+		palm_bk3710_base->config.udmatrp |= ide_trp;
+		/* udmaenv Ultra DMA envelop Time */
+		palm_bk3710_base->config.udmaenv &= 0xFF00;
+		palm_bk3710_base->config.udmaenv |= ide_tenv;
+		/* Enable UDMA for Device 0 */
+		palm_bk3710_base->config.udmactl |= 1;
+	} else {
+		/* setup slave device parameters */
+
+		/* udmatim Register */
+		palm_bk3710_base->config.udmatim &= 0xFF0F;
+		palm_bk3710_base->config.udmatim |= (level << 4);
+		/* udmastb Ultra DMA Access Strobe Width */
+		palm_bk3710_base->config.udmastb &= 0xFF;
+		palm_bk3710_base->config.udmastb |= (ide_t0 << 8);
+		/* udmatrp Ultra DMA Ready to Pause Time */
+		palm_bk3710_base->config.udmatrp &= 0xFF;
+		palm_bk3710_base->config.udmatrp |= (ide_trp << 8);
+		/* udmaenv Ultra DMA envelop Time */
+		palm_bk3710_base->config.udmaenv &= 0xFF;
+		palm_bk3710_base->config.udmaenv |= (ide_tenv << 8);
+		/* Enable UDMA for Device 1 */
+		palm_bk3710_base->config.udmactl |= (1 << 1);
+	}
+}
+
+static void palm_bk3710_setdmamode(unsigned int dev, unsigned int cycletime,
+				  unsigned int mode)
+{
+	char ide_td, ide_tkw, ide_t0;
+
+	if (cycletime < ide_timing[mode].cycle)
+		cycletime = ide_timing[mode].cycle;
+
+	/* DMA Data Setup */
+	ide_t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
+	ide_td = (ide_timing[mode].active + ide_palm_clk - 1) / ide_palm_clk;
+	ide_tkw = ide_t0 - ide_td - 1;
+	ide_td -= 1;
+
+	if (!dev) {
+		/* setup master device parameters */
+		palm_bk3710_base->config.dmastb &= 0xFF00;
+		palm_bk3710_base->config.dmastb |= ide_td;
+		palm_bk3710_base->config.dmarcvr &= 0xFF00;
+		palm_bk3710_base->config.dmarcvr |= ide_tkw;
+		/* Disable UDMA for Device 0 */
+		palm_bk3710_base->config.udmactl &= 0xFF02;
+	} else {
+		/* setup slave device parameters */
+		palm_bk3710_base->config.dmastb &= 0xFF;
+		palm_bk3710_base->config.dmastb |= (ide_td << 8);
+		palm_bk3710_base->config.dmarcvr &= 0xFF;
+		palm_bk3710_base->config.dmarcvr |= (ide_tkw << 8);
+		/* Disable UDMA for Device 1 */
+		palm_bk3710_base->config.udmactl &= 0xFF01;
+	}
+}
+
+static void palm_bk3710_setpiomode(ide_drive_t *mate, unsigned int dev,
+				  unsigned int cycletime, unsigned int mode)
+{
+	char ide_t2, ide_t2i, ide_t0;
+
+	/* PIO Data Setup */
+	ide_t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
+	ide_t2 = (ide_timing[19 - mode].active + ide_palm_clk - 1)
+			/ ide_palm_clk;
+
+	ide_t2i = ide_t0 - ide_t2 - 1;
+	ide_t2 -= 1;
+
+	if (!dev) {
+		/* setup master device parameters */
+		palm_bk3710_base->config.datstb &= 0xFF00;
+		palm_bk3710_base->config.datstb |= ide_t2;
+		palm_bk3710_base->config.datrcvr &= 0xFF00;
+		palm_bk3710_base->config.datrcvr |= ide_t2i;
+	} else {
+		/* setup slave device parameters */
+		palm_bk3710_base->config.datstb &= 0xFF;
+		palm_bk3710_base->config.datstb |= (ide_t2 << 8);
+		palm_bk3710_base->config.datrcvr &= 0xFF;
+		palm_bk3710_base->config.datrcvr |= (ide_t2i << 8);
+	}
+
+	if (mate && mate->present) {
+		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);
+
+		if (mode2 < mode)
+			mode = mode2;
+	}
+
+	/* TASKFILE Setup */
+	ide_t0 = (ide_timing[19 - mode].cyc8b + ide_palm_clk - 1)
+			/ ide_palm_clk;
+	ide_t2 = (ide_timing[19 - mode].act8b + ide_palm_clk - 1)
+			/ ide_palm_clk;
+	ide_t2i = ide_t0 - ide_t2 - 1;
+	ide_t2 -= 1;
+
+	if (!dev) {
+		/* setup master device parameters */
+		palm_bk3710_base->config.regstb &= 0xFF00;
+		palm_bk3710_base->config.regstb |= ide_t2;
+		palm_bk3710_base->config.regrcvr &= 0xFF00;
+		palm_bk3710_base->config.regrcvr |= ide_t2i;
+	} else {
+		/* setup slave device parameters */
+		palm_bk3710_base->config.regstb &= 0xFF;
+		palm_bk3710_base->config.regstb |= (ide_t2 << 8);
+		palm_bk3710_base->config.regrcvr &= 0xFF;
+		palm_bk3710_base->config.regrcvr |= (ide_t2i << 8);
+	}
+}
+
+static void palm_bk3710_set_dma_mode(ide_drive_t *drive, u8 xferspeed)
+{
+	int is_slave = drive->dn & 1;
+
+	switch (xferspeed) {
+	case XFER_UDMA_4:
+	case XFER_UDMA_3:
+	case XFER_UDMA_2:
+	case XFER_UDMA_1:
+	case XFER_UDMA_0:
+		palm_bk3710_setudmamode(is_slave, xferspeed - XFER_UDMA_0);
+		break;
+	case XFER_MW_DMA_2:
+	case XFER_MW_DMA_1:
+	case XFER_MW_DMA_0:
+		{
+			int nspeed = 10 - xferspeed + XFER_MW_DMA_0;
+			unsigned ide_cycle = max(ide_timing[nspeed].cycle,
+					     drive->id->eide_dma_min);
+
+			palm_bk3710_setdmamode(is_slave, ide_cycle, nspeed);
+		}
+		break;
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
+	 * Get the best PIO Mode supported by the drive
+	 * Obtain the drive PIO data for tuning the Palm Chip registers
+	 */
+	cycle_time = ide_pio_cycle_time(drive, pio);
+	mate = ide_get_paired_drive(drive);
+	palm_bk3710_setpiomode(mate, is_slave, cycle_time, pio);
+}
+
+static void palm_bk3710_chipinit(void)
+{
+	/*
+	 * enable the reset_en of ATA controller so that when ata signals
+	 * are brought out, by writing into device config. at that
+	 * time por_n signal should not be 'Z' and have a stable value.
+	 */
+	palm_bk3710_base->config.miscctl = 0x0300;
+
+	/* wait for some time and deassert the reset of ATA Device. */
+	mdelay(100);
+
+	/* Deassert the Reset */
+	palm_bk3710_base->config.miscctl = 0x0200;
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
+
+	palm_bk3710_base->config.idetimp = 0xb388;
+
+	/*
+	 * Configure  SIDETIM  Register
+	 * (ATA_SIDETIM_RDYSMPS1	,120NS ) |
+	 * (ATA_SIDETIM_RDYRCYS1	,120NS )
+	 */
+	palm_bk3710_base->config.sidetim = 0;
+
+	/*
+	 * UDMACTL Ultra-ATA DMA Control
+	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
+	 * (ATA_UDMACTL_UDMAP0	, 0 )
+	 *
+	 */
+	palm_bk3710_base->config.udmactl = 0;
+
+	/*
+	 * MISCCTL Miscellaneous Conrol Register
+	 * (ATA_MISCCTL_RSTMODEP	, 1) |
+	 * (ATA_MISCCTL_RESETP		, 0) |
+	 * (ATA_MISCCTL_TIMORIDE	, 1)
+	 */
+	palm_bk3710_base->config.miscctl = 0x201;
+
+	/*
+	 * IORDYTMP IORDY Timer for Primary Register
+	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
+	 */
+
+	palm_bk3710_base->config.iordytmp = 0xffff;
+
+	/*
+	 * Configure BMISP Register
+	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
+	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
+	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
+	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
+	 * (ATA_BMISP_DMAERROR	, CLEAR)
+	 */
+
+	palm_bk3710_base->dmaengine.bmisp = 0;
+
+	palm_bk3710_setpiomode(NULL, 0, 0, 0);
+	palm_bk3710_setpiomode(NULL, 1, 0, 0);
+}
+
+int palm_bk3710_probe(struct platform_device *pdev)
+{
+	hw_regs_t ide_ctlr_info;
+	int index = 0;
+	int pribase;
+	struct clk *clkp;
+	struct resource *mem, *irq;
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
+	palm_bk3710_base = (struct palm_bk3710_ideregs __iomem *)mem->start;
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
+	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &palm_bk3710_hwif) < 0) {
+		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
+		return -ENODEV;
+	}
+
+	palm_bk3710_hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
+	palm_bk3710_hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
+
+	palm_bk3710_hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
+						(input clk 99MHz) */
+	palm_bk3710_hwif->mwdma_mask = 0x7;
+	palm_bk3710_hwif->drives[0].autotune = 1;
+	palm_bk3710_hwif->drives[1].autotune = 1;
+
+	if (!request_region(mem->start, 8, palm_bk3710_hwif->name)) {
+		printk(KERN_ERR "Error, ports in use.\n");
+		return -EBUSY;
+	}
+
+	palm_bk3710_hwif->dmatable_cpu = dma_alloc_coherent(
+				NULL,
+				PRD_ENTRIES * PRD_BYTES,
+				&palm_bk3710_hwif->dmatable_dma,
+				GFP_ATOMIC);
+
+	if (!palm_bk3710_hwif->dmatable_cpu) {
+		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
+		return -ENOMEM;
+	}
+
+	palm_bk3710_hwif->dma_base = mem->start;
+
+	palm_bk3710_hwif->dma_master = mem->start;
+
+	palm_bk3710_hwif->dma_command = mem->start;
+	palm_bk3710_hwif->dma_status = mem->start + 2;
+	palm_bk3710_hwif->dma_prdtable = mem->start + 4;
+
+	palm_bk3710_hwif->dma_off_quietly = &ide_dma_off_quietly;
+	palm_bk3710_hwif->ide_dma_on = &__ide_dma_on;
+	palm_bk3710_hwif->dma_host_off = &ide_dma_host_off;
+	palm_bk3710_hwif->dma_host_on = &ide_dma_host_on;
+	palm_bk3710_hwif->dma_setup = &ide_dma_setup;
+	palm_bk3710_hwif->dma_exec_cmd = &ide_dma_exec_cmd;
+	palm_bk3710_hwif->dma_start = &ide_dma_start;
+	palm_bk3710_hwif->ide_dma_end = &__ide_dma_end;
+	palm_bk3710_hwif->ide_dma_test_irq = &__ide_dma_test_irq;
+	palm_bk3710_hwif->dma_timeout = &ide_dma_timeout;
+	palm_bk3710_hwif->dma_lost_irq = &ide_dma_lost_irq;
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
+int palm_bk3710_init(void)
+{
+	return platform_driver_register(&platform_bk_driver);
+}
+
+module_init(palm_bk3710_init);
+MODULE_LICENSE("GPL");
+
Index: 2.6.24-rc7.ide/drivers/ide/ide-dma.c
===================================================================
--- 2.6.24-rc7.ide.orig/drivers/ide/ide-dma.c
+++ 2.6.24-rc7.ide/drivers/ide/ide-dma.c
@@ -556,11 +556,12 @@ int ide_dma_setup(ide_drive_t *drive)
 
 EXPORT_SYMBOL_GPL(ide_dma_setup);
 
-static void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+void ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	/* issue cmd to drive */
 	ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, 
dma_timer_expiry);
 }
+EXPORT_SYMBOL(ide_dma_exec_cmd);
 
 void ide_dma_start(ide_drive_t *drive)
 {
@@ -606,7 +607,7 @@ int __ide_dma_end (ide_drive_t *drive)
 EXPORT_SYMBOL(__ide_dma_end);
 
 /* returns 1 if dma irq issued, 0 otherwise */
-static int __ide_dma_test_irq(ide_drive_t *drive)
+int __ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
@@ -619,6 +620,7 @@ static int __ide_dma_test_irq(ide_drive_
 			drive->name, __FUNCTION__);
 	return 0;
 }
+EXPORT_SYMBOL(__ide_dma_test_irq);
 #else
 static inline int config_drive_for_dma(ide_drive_t *drive) { return 0; }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
Index: 2.6.24-rc7.ide/drivers/ide/ide-proc.c
===================================================================
--- 2.6.24-rc7.ide.orig/drivers/ide/ide-proc.c
+++ 2.6.24-rc7.ide/drivers/ide/ide-proc.c
@@ -67,6 +67,7 @@ static int proc_ide_read_imodel
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
 		case ide_au1xxx:	name = "au1xxx";	break;
+		case ide_palm3710:      name = "palm3710";      break;
 		case ide_etrax100:	name = "etrax100";	break;
 		case ide_acorn:		name = "acorn";		break;
 		default:		name = "(unknown)";	break;
Index: 2.6.24-rc7.ide/include/linux/ide.h
===================================================================
--- 2.6.24-rc7.ide.orig/include/linux/ide.h
+++ 2.6.24-rc7.ide/include/linux/ide.h
@@ -202,7 +202,7 @@ enum {		ide_unknown,	ide_generic,	ide_pc
 		ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_au1xxx, ide_forced
+		ide_au1xxx,	ide_palm3710,	ide_forced
 };
 
 typedef u8 hwif_chipset_t;
@@ -1280,8 +1280,10 @@ void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
 extern int ide_dma_setup(ide_drive_t *);
+extern void ide_dma_exec_cmd(ide_drive_t *drive, u8 command);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
+extern int __ide_dma_test_irq(ide_drive_t *drive);
 extern void ide_dma_lost_irq(ide_drive_t *);
 extern void ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
