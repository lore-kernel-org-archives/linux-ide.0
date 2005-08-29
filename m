From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [RFH][PATCH] CS5535 driver
Date: Mon, 29 Aug 2005 17:48:26 +0200
Message-ID: <58cb370e0508290848457748dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11312_32452010.1125330506432"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:1614 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751236AbVH2Ps2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 11:48:28 -0400
Received: by nproxy.gmail.com with SMTP id x37so315327nfc
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2005 08:48:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Altmann <jens.altmann@amd.com>, Wolfgang Zuleger <wolfgang.zuleger@gmx.de>, Alexander Kiausch <alex.kiausch@t-online.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

------=_Part_11312_32452010.1125330506432
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Alan Cox has sent me this driver recently.  It needs a little bit of
work to become
acceptable into mainline kernel and as I don't have neither the hardware no=
r the
time to work on it now, I'm posting it to you and linux-ide ML with a remai=
ning
TODO list (original patch attached to the mail). :-)

I hope that somebody will work on it so that it can be merged soon.

* cs5535_tuneproc() needs to be fixed to not abuse ->tuneproc interface
  (which is exported to user-space), all DMA tuning should be done through
  ->speedproc interface only
* cs5535_set_drive() needs to use ide_rate_filter() to limit values passed
  from the user-space
* cs5535_set_drive() needs to set drive's speed unconditionally otherwise
  drive may not be setup correctly after resume
* cs5535_set_drive() shouldn't change drive->current_speed
* cable detection needs to be in separate function (for hotplug - later)
* driver lacks device side cable detection [ see eighty_ninty_three() ]
* driver needs to check for blacklisted DMA devices [ see ide_use_dma() ]
* init_hwif_cs5535() should be marked __devinit not __init
* cs5535_ide_init() lacks __init tag
* .name in driver struct should be "CS5535_IDE" (w/o space)
* what taking ide_lock in init_chipset_cs5535() is supposed to protect?
* it would be simpler to always set ->autotune and tune PIO instead of
  checking for BIOS settings

minor things:

* use 'drive->hwif' instead of 'HWIF' macro
* use 'u8' instead of 'byte' type
* remove unneeded includes
* proper coding style:

        if (foo) {
        } else {
        }

       if (foo)
               bar;

Thanks,
Bartlomiej

------=_Part_11312_32452010.1125330506432
Content-Type: application/octet-stream; name=cs5535.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cs5535.patch"

diff -aur --unidirectional-new-file linux-2.6.11.4-21.7/drivers/ide/Kconfig linux-cs5535/drivers/ide/Kconfig
--- linux-2.6.11.4-21.7/drivers/ide/Kconfig	2005-03-02 08:38:08.000000000 +0100
+++ linux-cs5535/drivers/ide/Kconfig	2005-06-11 00:52:34.000000000 +0200
@@ -540,6 +540,14 @@
 
 	  It is safe to say Y to this question.
 
+config BLK_DEV_CS5535
+	tristate "AMD CS5535 MediaGX chipset support"
+	help
+	  Include support for UDMA on the Cyrix MediaGX 5535 chipset. This
+	  will automatically be detected and configured if found.
+
+	  It is safe to say Y to this question.
+
 config BLK_DEV_HPT34X
 	tristate "HPT34X chipset support"
 	help
diff -aur --unidirectional-new-file linux-2.6.11.4-21.7/drivers/ide/pci/Makefile linux-cs5535/drivers/ide/pci/Makefile
--- linux-2.6.11.4-21.7/drivers/ide/pci/Makefile	2005-03-02 08:37:49.000000000 +0100
+++ linux-cs5535/drivers/ide/pci/Makefile	2005-06-11 00:52:34.000000000 +0200
@@ -6,6 +6,7 @@
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
+obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT34X)		+= hpt34x.o
diff -aur --unidirectional-new-file linux-2.6.11.4-21.7/drivers/ide/pci/cs5535.c linux-cs5535/drivers/ide/pci/cs5535.c
--- linux-2.6.11.4-21.7/drivers/ide/pci/cs5535.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-cs5535/drivers/ide/pci/cs5535.c	2005-06-25 19:32:21.000000000 +0200
@@ -0,0 +1,381 @@
+/*
+ * linux/drivers/ide/pci/cs5535.c       Version 0.1 Dec 10, 2003
+ *
+ * Copyright (C) 2003           Jens Altmann <jens.altmann@amd.com>
+ *
+ * Ported to Kernel 2.6.11 on June 26, 2005 by
+ *   Wolfgang Zuleger <wolfgang.zuleger@gmx.de>
+ *   Alexander Kiausch <alex.kiausch@t-online.de>
+ *
+ *
+ * Development of this chipset driver was funded
+ * by the nice folks at National Semiconductor.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Documentation:
+ *  CS5535 documentation available from National Semiconductor.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/msr.h>
+
+#include "ide-timing.h"
+
+#define MSR_ATAC_BASE    0x51300000
+#define ATAC_GLD_MSR_CAP (MSR_ATAC_BASE+0)
+#define ATAC_GLD_MSR_CONFIG    (MSR_ATAC_BASE+0x01)
+#define ATAC_GLD_MSR_SMI       (MSR_ATAC_BASE+0x02)
+#define ATAC_GLD_MSR_ERROR     (MSR_ATAC_BASE+0x03)
+#define ATAC_GLD_MSR_PM        (MSR_ATAC_BASE+0x04)
+#define ATAC_GLD_MSR_DIAG      (MSR_ATAC_BASE+0x05)
+#define ATAC_IO_BAR            (MSR_ATAC_BASE+0x08)
+#define ATAC_RESET             (MSR_ATAC_BASE+0x10)
+#define ATAC_CH0D0_PIO         (MSR_ATAC_BASE+0x20)
+#define ATAC_CH0D0_DMA         (MSR_ATAC_BASE+0x21)
+#define ATAC_CH0D1_PIO         (MSR_ATAC_BASE+0x22)
+#define ATAC_CH0D1_DMA         (MSR_ATAC_BASE+0x23) 
+#define ATAC_PCI_ABRTERR       (MSR_ATAC_BASE+0x24)
+#define ATAC_BM0_CMD_PRIM      0x00
+#define ATAC_BM0_STS_PRIM      0x02
+#define ATAC_BM0_PRD           0x04
+
+#define CS5535_CABLE_DETECT    0x48
+
+//#define DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(fmt,args...) printk("cs5535-ide: " fmt, ##args)
+#else
+#define DPRINTK(fmt,args...)
+#endif
+
+/* Format I PIO settings. We seperate out cmd and data for safer timings */
+
+static unsigned int cs5535_pio_cmd_timings[5] = 
+{ 0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131 };
+static unsigned int cs5535_pio_dta_timings[5] = 
+{ 0xF7F4, 0xF173, 0x8141, 0x5131, 0x1131 };
+
+static unsigned int cs5535_mwdma_timings[3] = 
+{ 0x7F0FFFF3, 0x7F035352, 0x7f024241 };
+
+static unsigned int cs5535_udma_timings[5] = 
+{ 0x7F7436A1, 0x7F733481, 0x7F723261, 0x7F713161, 0x7F703061 };
+
+/* Macros to check if the register is the reset value -  reset value is an
+   invalid timing and indicates the register has not been set previously */
+
+#define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL)==0x00009172 )
+#define CS5535_BAD_DMA(timings) ( (timings & 0x000FFFFF) == 0x00077771 )
+  
+/**
+ *	cs5535_set_speed         -     Configure the chipset to the new speed
+ *	@drive: Drive to set up
+ *	@speed: desired speed
+ *
+ *	cs5535_set_drive() configures the chipset to a new speed.
+ */
+
+static void cs5535_set_speed(ide_drive_t *drive, u8 speed) {
+	
+	u32 reg = 0, dummy;
+	int unit = drive->select.b.unit;
+
+	DPRINTK("cs5535_set_speed speed %x\n", speed);
+
+	/* Set the PIO timings */
+	
+	if ((speed & XFER_MODE) == XFER_PIO) {
+		u8 pioa = speed - XFER_PIO_0;
+		u8 piob = ide_get_best_pio_mode(&(HWIF(drive)->drives[!unit]), 255, 4, NULL);
+		u8 cmd = pioa < piob ? pioa : piob;
+		
+		/* Write the speed of the current drive */
+		
+		reg = (cs5535_pio_cmd_timings[cmd] << 16) | cs5535_pio_dta_timings[pioa];	
+		wrmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
+		
+		/* And if nessesary - change the speed of the other drive */
+		rdmsr(unit ?  ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, dummy);    
+		
+		if (((reg >> 16) & cs5535_pio_cmd_timings[cmd]) != cs5535_pio_cmd_timings[cmd]) {
+			reg &= 0x0000FFFF;
+			reg |= cs5535_pio_cmd_timings[cmd] << 16;
+			wrmsr(unit ? ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, 0);
+		}
+
+		/* Set bit 31 of the DMA register for PIO format 1 timings */
+		rdmsr(unit ?  ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);    
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg | 0x80000000UL, 0);
+		
+	}
+	else {
+
+		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
+		
+		reg &= 0x80000000UL;  /* Preserve the PIO format bit */
+
+		if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_7) 
+			reg |= cs5535_udma_timings[speed - XFER_UDMA_0];
+		else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2) 
+			reg |= cs5535_mwdma_timings[speed - XFER_MW_DMA_0];
+		else 
+			return;
+		
+		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, 0);
+	}
+}
+
+/**
+ *	cs5535_set_drive         -     Configure the drive to the new speed
+ *	@drive: Drive to set up
+ *	@speed: desired speed
+ *
+ *	cs5535_set_drive() configures the drive and the chipset to a
+ *	new speed. It also can be called by upper layers.
+ */
+
+static int cs5535_set_drive(ide_drive_t *drive, u8 speed) {
+	
+	DPRINTK("cs5535_set_drive speed %x\n", speed);
+
+	if (speed != drive->current_speed)
+		ide_config_drive_speed(drive, speed);
+	
+	cs5535_set_speed(drive, speed);	
+
+	drive->current_speed = speed;
+	return 0;
+}
+
+/**
+ *	cs5535_tuneproc    -       PIO setup
+ *	@drive: drive to set up
+ *	@pio: mode to use (255 for 'best possible')
+ *
+ *	A callback from the upper layers for PIO-only tuning.
+ */
+
+static void cs5535_tuneproc (ide_drive_t *drive, u8 pio) 
+{ 	
+	u8 speed = 0;
+
+	DPRINTK("cs5535_tuneproc(%d) pio %x\n", drive->select.b.unit, pio);
+
+ 	if (pio == 255)
+		speed = ide_find_best_mode(drive, XFER_PIO | XFER_EPIO);
+	else if (pio < 100) 
+		speed = XFER_PIO_0 + min_t(byte, pio, 5);
+	else if (pio < 200)
+		speed = XFER_MW_DMA_0 + min_t(byte, (pio - 100), 2);
+	else 
+		speed = XFER_UDMA_0 + min_t(byte, (pio - 200), 7);
+			
+	cs5535_set_drive(drive, speed);
+}
+
+#if defined(DEBUG)
+/**
+ *      init_chipset_cs5535  -       initialization handler
+ *      @dev: PCI device
+ *      @name: Name of interface
+ *
+ *      The initialization callback. We do not need it for this chipset.
+ *      It is only used for debugging purposes.
+ */
+
+static unsigned int __init init_chipset_cs5535 (struct pci_dev *dev, const char *name)
+{
+	unsigned long flags;
+	u32 val1, val2;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	/* all CPUs (there should only be one CPU with this chipset) */
+
+	rdmsr(ATAC_GLD_MSR_CAP,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_CAP=0x%x\n",val1);
+	rdmsr(ATAC_GLD_MSR_CONFIG,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_CONFIG=0x%x\n",val1);
+	rdmsr(ATAC_GLD_MSR_SMI   ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_SMI=0x%x\n",val1);
+	rdmsr(ATAC_GLD_MSR_ERROR ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_ERROR=0x%x\n",val1);
+	rdmsr(ATAC_GLD_MSR_PM    ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_PM=0x%x\n",val1);
+	rdmsr(ATAC_GLD_MSR_DIAG  ,val1,val2);
+	DPRINTK("ATAC_GLD_MSR_DIAG=0x%x\n",val1);
+	rdmsr(ATAC_IO_BAR        ,val1,val2);
+	DPRINTK("ATAC_IO_BAR=0x%x.%x\n",val2,val1);
+	rdmsr(ATAC_RESET         ,val1,val2);
+	DPRINTK("ATAC_RESET=0x%x\n",val1);
+	rdmsr(ATAC_CH0D0_PIO     ,val1,val2);
+	DPRINTK("ATAC_CH0D0_PIO=0x%x\n",val1);
+	rdmsr(ATAC_CH0D0_DMA     ,val1,val2);
+	DPRINTK("ATAC_CH0D0_DMA=0x%x\n",val1);
+	rdmsr(ATAC_CH0D1_PIO     ,val1,val2);
+	DPRINTK("ATAC_CH0D1_PIO=0x%x\n",val1);
+	rdmsr(ATAC_CH0D1_DMA     ,val1,val2);
+	DPRINTK("ATAC_CH0D1_DMA=0x%x\n",val1);
+	rdmsr(ATAC_PCI_ABRTERR   ,val1,val2);
+	DPRINTK("ATAC_PCI_ABRTERR=0x%x\n",val1);
+
+	spin_unlock_irqrestore(&ide_lock, flags);
+
+	return 0;
+}
+#endif
+
+/**
+ *	cs5535_config_dma         -       Set up for DMA if possible
+ *	@drive: IDE drive to set up
+ *
+ *	Set up the drive for the highest supported speed considering the
+ *	driver, controller and cable
+ */
+
+static int cs5535_config_dma(ide_drive_t *drive) {
+
+	u8 speed = 0;
+	unsigned long map = XFER_MWDMA | XFER_UDMA;
+
+        /* if we have a 80 wire cable */
+	if (HWIF(drive)->udma_four) map |= XFER_UDMA_66;
+
+	/* Get the best mode for this drive */
+	speed = ide_find_best_mode(drive, map);
+		
+	if ((speed & XFER_MODE) != XFER_PIO) {
+		cs5535_set_drive(drive, speed);
+		
+		if (drive->autodma)
+			return HWIF(drive)->ide_dma_on(drive);
+	}
+	
+	return 
+		HWIF(drive)->ide_dma_off_quietly(drive);
+}
+	
+
+/**
+ * 	init_hwif_cs5535        -       Initialize one ide cannel
+ *	@hwif: Channel descriptor
+ *
+ *	This gets invoked by the IDE driver once for each channel. It
+ *	performs channel-specific pre-initialization before drive probing.
+ *
+ */
+
+static void __init init_hwif_cs5535 (ide_hwif_t *hwif)
+{
+	u32 timings, dummy;
+	u8 bit;
+	hwif->autodma = 0;
+	u32 dfltpio = (cs5535_pio_cmd_timings[0] << 16) | 
+			cs5535_pio_dta_timings[0];
+
+	if (hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
+
+	hwif->tuneproc = &cs5535_tuneproc;
+	hwif->speedproc = &cs5535_set_drive;
+	hwif->ide_dma_check = &cs5535_config_dma;
+
+	/* Check the registers, and set up the PIO registers if nessesary */
+	/* Note that this will default to whatever the BIOS set them to be */
+
+	/* Drive 0 */
+
+ 	rdmsr(ATAC_CH0D0_PIO,timings,dummy);
+	if (CS5535_BAD_PIO(timings)) 
+	{
+	 	/* PIO timings not initialized? */
+		wrmsr(ATAC_CH0D0_PIO, dfltpio, 0);
+
+		if(!hwif->drives[0].autotune)
+			hwif->drives[0].autotune = 1;
+	}
+
+	/* Drive 1 */
+
+	rdmsr(ATAC_CH0D1_PIO,timings,dummy);
+	if (CS5535_BAD_PIO(timings)) 
+	{
+		/* PIO timings not initialized? */
+		wrmsr(ATAC_CH0D1_PIO,dfltpio,0);
+		if(!hwif->drives[1].autotune)
+			hwif->drives[1].autotune = 1;
+
+	}
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x1F;
+	hwif->mwdma_mask = 0x07;
+
+	/* if a 80 wire cable was detected */
+	pci_read_config_byte(hwif->pci_dev, CS5535_CABLE_DETECT, &bit);
+	hwif->udma_four = bit & 1;
+
+	if (!noautodma) hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+static ide_pci_device_t cs5535_chipset __devinitdata = {
+	.name		= "CS5535",
+#if defined(DEBUG)
+	.init_chipset   = init_chipset_cs5535,
+#endif
+	.init_hwif	= init_hwif_cs5535,
+	.channels	= 1,
+	.autodma	= AUTODMA,
+	.bootable	= ON_BOARD,
+};
+
+static int __devinit cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	return ide_setup_pci_device(dev, &cs5535_chipset);
+}
+
+static struct pci_device_id cs5535_pci_tbl[] = 
+{
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, cs5535_pci_tbl);
+
+static struct pci_driver driver = {
+	.name       = "CS5535 IDE",
+	.id_table   = cs5535_pci_tbl,
+	.probe      = cs5535_init_one,
+};
+
+static int cs5535_ide_init(void)
+{
+	DPRINTK("cs5535_ide_init\n"); 
+	return ide_pci_register_driver(&driver);
+}
+
+module_init(cs5535_ide_init);
+
+MODULE_AUTHOR("Jens Altmann");
+MODULE_DESCRIPTION("PCI driver module for AMD/NS 5535 IDE");
+MODULE_LICENSE("GPL");
diff -aur --unidirectional-new-file linux-2.6.11.4-21.7/include/linux/pci_ids.h linux-cs5535/include/linux/pci_ids.h
--- linux-2.6.11.4-21.7/include/linux/pci_ids.h	2005-06-02 16:57:05.000000000 +0200
+++ linux-cs5535/include/linux/pci_ids.h	2005-06-11 00:52:34.000000000 +0200
@@ -387,6 +387,7 @@
 #define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_SC1100_BRIDGE	0x0510
 #define PCI_DEVICE_ID_NS_87410		0xd001
+#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202






------=_Part_11312_32452010.1125330506432--
