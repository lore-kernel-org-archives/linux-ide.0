From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [BK PATCHES] ide-2.6 update
Date: Fri, 1 Oct 2004 20:43:30 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410012043.31097.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:17540 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S266879AbUJBASZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Oct 2004 20:18:25 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:36265 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S50919AbUJBASY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Oct 2004 02:18:24 +0200
Received: from [84.10.12.196] ([84.10.12.196]:63449 "EHLO [192.168.123.164]"
	ident: "TIMEDOUT" smtp-auth: "bzolnier" TLS-CIPHER: <none> TLS-PEER-CN1:
	<none>) by mion.elka.pw.edu.pl with ESMTP id S57596AbUJASl5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 1 Oct 2004 20:41:57 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/Kconfig        |    7 ++++
 drivers/ide/arm/Makefile   |    1 
 drivers/ide/arm/bast-ide.c |   71 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-probe.c    |    9 -----
 drivers/ide/ide-proc.c     |   25 +++------------
 drivers/ide/ide-taskfile.c |   33 --------------------
 drivers/ide/pci/aec62xx.c  |   47 +----------------------------
 drivers/ide/pci/aec62xx.h  |    7 ----
 drivers/ide/pci/cmd640.c   |    6 ++-
 drivers/ide/pci/piix.c     |   43 ++++++++++++---------------
 drivers/ide/pci/triflex.c  |   62 ---------------------------------------
 include/linux/ide.h        |    7 ----
 12 files changed, 110 insertions(+), 208 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/01 1.2031)
   [ide] Simtec BAST (EB2410ITX) / Thorcom VR1000 driver
   
   Patch to provide support for the following two boards:
   
   	- Simtec BAST (EB2410ITX)
   	- Thorcom VR1000
   
   Signed-off-by: Ben Dooks <ben@simtec.co.uk>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2030)
   [ide] piix: fix wrong DMA mode selected
   
   From: Carsten Haustein <chaus@cs.uni-potsdam.de>
   
   A bug in function piix_config_drive_xfer_rate() allows a call of
   hwif->ide_dma_on(drive) without prior call of piix_config_drive_for_dma().
   This results in harddisk configured for UDMA (default?) whereas the highest
   DMA mode supported by PIIX3 is MWORD2.
   
   This bug is supposed to be present in any 2.6.x kernel release and any
   2.4.x kernel release since 2.4.21.
   
   bart: this should also fix the same bug for PIIXa and PIIXb
   
   Fixes bugzilla bug #3473.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2029)
   [ide] aec62xx: remove dead DEBUG_AEC_REGS code
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2028)
   [ide] remove stale comment from ide-proc.c
   
   ide-default driver was added long time ago.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2027)
   [ide] remove dead debugging code from ide-taskfile.c
   
   - CONFIG_IDE_TASK_IOCTL_DEBUG cannot be defined
   - function declarations are used instead of calls
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2026)
   [ide] remove dead CMD640 debugging from ide-probe.c
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/01 1.2025)
   [ide] triflex: kill /proc/ide/triflex
   
   Fixes OOPS on two single channel controllers.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/Kconfig	2004-10-01 20:22:55 +02:00
@@ -830,6 +830,13 @@
 	  Say Y here if you want to support the Yellowstone RapIDE controller
 	  manufactured for use with Acorn computers.
 
+config BLK_DEV_IDE_BAST
+	tristate "Simtec BAST / Thorcom VR1000 IDE support"
+	depends on ARM && (ARCH_BAST || MACH_VR100)
+	help
+	  Say Y here if you want to support the onboard IDE channels on the
+	  Simtec BAST or the Thorcom VR1000
+
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
diff -Nru a/drivers/ide/arm/Makefile b/drivers/ide/arm/Makefile
--- a/drivers/ide/arm/Makefile	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/arm/Makefile	2004-10-01 20:22:55 +02:00
@@ -1,5 +1,6 @@
 
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
+obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
diff -Nru a/drivers/ide/arm/bast-ide.c b/drivers/ide/arm/bast-ide.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/ide/arm/bast-ide.c	2004-10-01 20:22:55 +02:00
@@ -0,0 +1,71 @@
+/* linux/drivers/ide/arm/bast-ide.c
+ *
+ * Copyright (c) 2003-2004 Simtec Electronics
+ *  Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/mach-types.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/arch/map.h>
+#include <asm/arch/bast-map.h>
+#include <asm/arch/bast-irq.h>
+
+/* list of registered interfaces */
+static ide_hwif_t *ifs[2];
+
+static int __init
+bastide_register(unsigned int base, unsigned int aux, int irq,
+		 ide_hwif_t **hwif)
+{
+	hw_regs_t hw;
+	int i;
+
+	memset(&hw, 0, sizeof(hw));
+
+	base += BAST_IDE_CS;
+	aux  += BAST_IDE_CS;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		hw.io_ports[i] = (unsigned long)base;
+		base += 0x20;
+	}
+
+	hw.io_ports[IDE_CONTROL_OFFSET] = aux + (6 * 0x20);
+	hw.irq = irq;
+
+	ide_register_hw(&hw, hwif);
+
+	return 0;
+}
+
+static int __init bastide_init(void)
+{
+	/* we can treat the VR1000 and the BAST the same */
+
+	if (!(machine_is_bast() || machine_is_vr1000()))
+		return 0;
+
+	printk("BAST: IDE driver, (c) 2003-2004 Simtec Electronics\n");
+
+	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0, &ifs[0]);
+	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1, &ifs[1]);
+	return 0;
+}
+
+module_init(bastide_init);
+
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simtec BAST / Thorcom VR1000 IDE driver");
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/ide-probe.c	2004-10-01 20:22:55 +02:00
@@ -389,15 +389,6 @@
 				 */
 				printk("%s: IRQ probe failed (0x%lx)\n",
 					drive->name, cookie);
-#ifdef CONFIG_BLK_DEV_CMD640
-#ifdef CMD640_DUMP_REGS
-				if (hwif->chipset == ide_cmd640) {
-					printk("%s: Hmmm.. probably a driver "
-						"problem.\n", drive->name);
-					CMD640_DUMP_REGS;
-				}
-#endif /* CMD640_DUMP_REGS */
-#endif /* CONFIG_BLK_DEV_CMD640 */
 			}
 		}
 	}
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/ide-proc.c	2004-10-01 20:22:55 +02:00
@@ -360,27 +360,14 @@
 	int		err = 0;
 
 	len = sprintf(page, "\n");
-	
-	if (drive)
-	{
+
+	if (drive) {
 		unsigned short *val = (unsigned short *) page;
-		
-		/*
-		 *	The current code can't handle a driverless
-		 *	identify query taskfile. Now the right fix is
-		 *	to add a 'default' driver but that is a bit
-		 *	more work. 
-		 *
-		 *	FIXME: this has to be fixed for hotswap devices
-		 */
-		 
-		if(DRIVER(drive))
-			err = taskfile_lib_get_identify(drive, page);
-		else	/* This relies on the ID changes */
-			val = (unsigned short *)drive->id;
 
-		if(!err)
-		{						
+		BUG_ON(!drive->driver);
+
+		err = taskfile_lib_get_identify(drive, page);
+		if (!err) {
 			char *out = ((char *)page) + (SECTOR_WORDS * 4);
 			page = out;
 			do {
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-01 20:22:55 +02:00
@@ -103,30 +103,6 @@
 
 EXPORT_SYMBOL(taskfile_lib_get_identify);
 
-#ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
-void debug_taskfile (ide_drive_t *drive, ide_task_t *args)
-{
-	printk(KERN_INFO "%s: ", drive->name);
-//	printk("TF.0=x%02x ", args->tfRegister[IDE_DATA_OFFSET]);
-	printk("TF.1=x%02x ", args->tfRegister[IDE_FEATURE_OFFSET]);
-	printk("TF.2=x%02x ", args->tfRegister[IDE_NSECTOR_OFFSET]);
-	printk("TF.3=x%02x ", args->tfRegister[IDE_SECTOR_OFFSET]);
-	printk("TF.4=x%02x ", args->tfRegister[IDE_LCYL_OFFSET]);
-	printk("TF.5=x%02x ", args->tfRegister[IDE_HCYL_OFFSET]);
-	printk("TF.6=x%02x ", args->tfRegister[IDE_SELECT_OFFSET]);
-	printk("TF.7=x%02x\n", args->tfRegister[IDE_COMMAND_OFFSET]);
-	printk(KERN_INFO "%s: ", drive->name);
-//	printk("HTF.0=x%02x ", args->hobRegister[IDE_DATA_OFFSET]);
-	printk("HTF.1=x%02x ", args->hobRegister[IDE_FEATURE_OFFSET]);
-	printk("HTF.2=x%02x ", args->hobRegister[IDE_NSECTOR_OFFSET]);
-	printk("HTF.3=x%02x ", args->hobRegister[IDE_SECTOR_OFFSET]);
-	printk("HTF.4=x%02x ", args->hobRegister[IDE_LCYL_OFFSET]);
-	printk("HTF.5=x%02x ", args->hobRegister[IDE_HCYL_OFFSET]);
-	printk("HTF.6=x%02x ", args->hobRegister[IDE_SELECT_OFFSET]);
-	printk("HTF.7=x%02x\n", args->hobRegister[IDE_CONTROL_OFFSET_HOB]);
-}
-#endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
-
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -134,10 +110,6 @@
 	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
 	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
-#ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
-	void debug_taskfile(drive, task);
-#endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
-
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
 		/* clear nIEN */
@@ -852,11 +824,6 @@
 #if DEBUG_TASKFILE
 	u8 status;
 #endif
-
-
-#ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
-	void debug_taskfile(drive, task);
-#endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
 
 	if (task->data_phase == TASKFILE_MULTI_IN ||
 	    task->data_phase == TASKFILE_MULTI_OUT) {
diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/pci/aec62xx.c	2004-10-01 20:22:55 +02:00
@@ -29,8 +29,6 @@
 static struct pci_dev *aec_devs[AEC_MAX_DEVS];
 static int n_aec_devs;
 
-#undef DEBUG_AEC_REGS
-
 static int aec62xx_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
@@ -44,9 +42,6 @@
 		struct pci_dev *dev	= aec_devs[i];
 		unsigned long iobase = pci_resource_start(dev, 4);
 		u8 c0 = 0, c1 = 0, art	= 0;
-#ifdef DEBUG_AEC_REGS
-		u8 uart			= 0;
-#endif /* DEBUG_AEC_REGS */
 
 		c0 = inb(iobase + 0x02);
 		c1 = inb(iobase + 0x0a);
@@ -83,24 +78,6 @@
 			p += sprintf(p, "           %s(%s)\n",
 				(c1&0x40)?((art&0xc0)?"UDMA":" DMA"):" PIO",
 				(art&0x80)?"2":(art&0x40)?"1":"0");
-#ifdef DEBUG_AEC_REGS
-			(void) pci_read_config_byte(dev, 0x40, &art);
-			p += sprintf(p, "Active:         0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x42, &art);
-			p += sprintf(p, "             0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x44, &art);
-			p += sprintf(p, "            0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x46, &art);
-			p += sprintf(p, "              0x%02x\n", art);
-			(void) pci_read_config_byte(dev, 0x41, &art);
-			p += sprintf(p, "Recovery:       0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x43, &art);
-			p += sprintf(p, "             0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x45, &art);
-			p += sprintf(p, "            0x%02x", art);
-			(void) pci_read_config_byte(dev, 0x47, &art);
-			p += sprintf(p, "              0x%02x\n", art);
-#endif /* DEBUG_AEC_REGS */
 		} else {
 			/*
 			 * case PCI_DEVICE_ID_ARTOP_ATP860:
@@ -146,28 +123,6 @@
 				((art&0x30)==0x30)?"2":
 				((art&0x20)==0x20)?"1":
 				((art&0x10)==0x10)?"0":"?");
-#ifdef DEBUG_AEC_REGS
-			(void) pci_read_config_byte(dev, 0x40, &art);
-			p += sprintf(p, "Active:         0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", HIGH_4(art));
-			(void) pci_read_config_byte(dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", HIGH_4(art));
-			(void) pci_read_config_byte(dev, 0x40, &art);
-			p += sprintf(p, "Recovery:       0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(dev, 0x41, &art);
-			p += sprintf(p, "             0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(dev, 0x42, &art);
-			p += sprintf(p, "            0x%02x", LOW_4(art));
-			(void) pci_read_config_byte(dev, 0x43, &art);
-			p += sprintf(p, "              0x%02x\n", LOW_4(art));
-			(void) pci_read_config_byte(dev, 0x49, &uart);
-			p += sprintf(p, "reg49h = 0x%02x ", uart);
-			(void) pci_read_config_byte(dev, 0x4a, &uart);
-			p += sprintf(p, "reg4ah = 0x%02x\n", uart);
-#endif /* DEBUG_AEC_REGS */
 		}
 	}
 	/* p - buffer must be less than 4k! */
@@ -240,6 +195,7 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
+	/* 0x40|(2*drive->dn): Active, 0x41|(2*drive->dn): Recovery */
 	pci_read_config_word(dev, 0x40|(2*drive->dn), &d_conf);
 	tmp0 = pci_bus_clock_list(speed, BUSCLOCK(dev));
 	SPLIT_BYTE(tmp0,tmp1,tmp2);
@@ -268,6 +224,7 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
+	/* high 4-bits: Active, low 4-bits: Recovery */
 	pci_read_config_byte(dev, 0x40|drive->dn, &drive_conf);
 	drive_conf = pci_bus_clock_list(speed, BUSCLOCK(dev));
 	pci_write_config_byte(dev, 0x40|drive->dn, drive_conf);
diff -Nru a/drivers/ide/pci/aec62xx.h b/drivers/ide/pci/aec62xx.h
--- a/drivers/ide/pci/aec62xx.h	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/pci/aec62xx.h	2004-10-01 20:22:55 +02:00
@@ -53,13 +53,6 @@
 	{	0,		0x00,	0x00	}
 };
 
-
-#ifndef HIGH_4
-#define HIGH_4(H)		((H)=(H>>4))
-#endif
-#ifndef LOW_4
-#define LOW_4(L)		((L)=(L-((L>>4)<<4)))
-#endif
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
 #endif
diff -Nru a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
--- a/drivers/ide/pci/cmd640.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/pci/cmd640.c	2004-10-01 20:22:55 +02:00
@@ -101,6 +101,8 @@
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 #define CMD640_PREFETCH_MASKS 1
 
+//#define CMD640_DUMP_REGS
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -748,7 +750,7 @@
 	put_cmd640_reg(0x5b, 0);
 
 #ifdef CMD640_DUMP_REGS
-	CMD640_DUMP_REGS;
+	cmd640_dump_regs();
 #endif
 
 	/*
@@ -870,7 +872,7 @@
 	}
 
 #ifdef CMD640_DUMP_REGS
-	CMD640_DUMP_REGS;
+	cmd640_dump_regs();
 #endif
 	return 1;
 }
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/pci/piix.c	2004-10-01 20:22:55 +02:00
@@ -561,36 +561,31 @@
 	drive->init_speed = 0;
 
 	if ((id->capability & 1) && drive->autodma) {
+
 		/* Consult the list of known "bad" drives */
 		if (__ide_dma_bad_drive(drive))
 			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				if ((id->field_valid & 2) &&
-				    (!piix_config_drive_for_dma(drive)))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!piix_config_drive_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!piix_config_drive_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		/**
+		 * Try to turn DMA on if:
+		 *  - UDMA or EIDE modes are supported or
+		 *  - drive is a known "good" drive
+		 *
+		 * Checks for best mode supported are down later by
+		 * piix_config_drive_for_dma() -> ide_dma_speed()
+		 */
+		if ((id->field_valid & (4 | 2)) ||
+		    (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)) {
+			if (piix_config_drive_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		/* For some reason DMA wasn't turned on, so try PIO. */
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
+		/* Find best PIO mode. */
 		hwif->tuneproc(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
--- a/drivers/ide/pci/triflex.c	2004-10-01 20:22:55 +02:00
+++ b/drivers/ide/pci/triflex.c	2004-10-01 20:22:55 +02:00
@@ -41,57 +41,6 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
-static struct pci_dev *triflex_dev;
-
-#ifdef CONFIG_PROC_FS
-static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
-{
-	char *p = buf;
-	int len;
-
-	struct pci_dev *dev	= triflex_dev;
-	unsigned long bibma = pci_resource_start(dev, 4);
-	u8  c0 = 0, c1 = 0;
-	u32 pri_timing, sec_timing;
-
-	p += sprintf(p, "\n                                Compaq Triflex Chipset\n");
-	
-	pci_read_config_dword(dev, 0x70, &pri_timing);
-	pci_read_config_dword(dev, 0x74, &sec_timing);
-
-	/*
-	 * at that point bibma+0x2 et bibma+0xa are byte registers
-	 * to investigate:
-	 */
-	c0 = inb((unsigned short)bibma + 0x02);
-	c1 = inb((unsigned short)bibma + 0x0a);
-
-	p += sprintf(p, "--------------- Primary Channel "
-			"---------------- Secondary Channel "
-			"-------------\n");
-	p += sprintf(p, "                %sabled "
-			"                        %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 "
-			"-------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s "
-			"            %s               %s\n",
-			(c0&0x20) ? "yes" : "no ",
-			(c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ",
-			(c1&0x40) ? "yes" : "no " );
-
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
-
-	len = (p - buf) - offset;
-	*addr = buf + offset;
-	
-	return len > count ? count : len;
-}
-#endif
-
 static int triflex_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -206,18 +155,8 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static unsigned int __init init_chipset_triflex(struct pci_dev *dev, 
-		const char *name) 
-{
-#ifdef CONFIG_PROC_FS
-	ide_pci_create_host_proc("triflex", triflex_get_info);
-#endif
-	return 0;	
-}
-
 static ide_pci_device_t triflex_device __devinitdata = {
 	.name		= "TRIFLEX",
-	.init_chipset	= init_chipset_triflex,
 	.init_hwif	= init_hwif_triflex,
 	.channels	= 2,
 	.autodma	= AUTODMA,
@@ -229,7 +168,6 @@
 		const struct pci_device_id *id)
 {
 	ide_setup_pci_device(dev, &triflex_device);
-	triflex_dev = dev;
 
 	return 0;
 }
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-01 20:22:55 +02:00
+++ b/include/linux/ide.h	2004-10-01 20:22:55 +02:00
@@ -52,13 +52,6 @@
 #define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface */
 #endif
 
-#ifdef CONFIG_BLK_DEV_CMD640
-#if 0	/* change to 1 when debugging cmd640 problems */
-void cmd640_dump_regs (void);
-#define CMD640_DUMP_REGS cmd640_dump_regs() /* for debugging cmd640 chipset */
-#endif
-#endif  /* CONFIG_BLK_DEV_CMD640 */
-
 #ifndef DISABLE_IRQ_NOSYNC
 #define DISABLE_IRQ_NOSYNC	0
 #endif
