From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [BK PATCHES] ide-2.6 update
Date: Sun, 10 Oct 2004 18:10:44 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410101810.44678.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35291 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268329AbUJJQLO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Oct 2004 12:11:14 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:50817 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S50052AbUJJQLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Oct 2004 18:11:13 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:64663 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S73080AbUJJQIV (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sun, 10 Oct 2004 18:08:21 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/ide-dma.c          |    8 ++--
 drivers/ide/ide-taskfile.c     |   13 -------
 drivers/ide/pci/cmd64x.c       |   17 ---------
 drivers/ide/pci/cmd64x.h       |    4 --
 drivers/ide/pci/pdc202xx_old.c |   11 ------
 drivers/ide/pci/pdc202xx_old.h |   71 -----------------------------------------
 6 files changed, 4 insertions(+), 120 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/10 1.2159)
   [ide] pdc202xx_old: kill PDC202XX_DECODE_REGISTER_INFO
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/10 1.2158)
   [ide] kill dead TASKFILE_IN_OUT code
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/10 1.2157)
   [ide] cmd64x: kill dead DEBUG_CMD_REGS code
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/10 1.2156)
   [ide] ide-dma blacklist behaviour broken
   
   From: Jens Axboe <axboe@suse.de>
   
   The blacklist stuff is broken. When set_using_dma() calls into
   ->ide_dma_check(), it returns __ide_dma_off() for a blacklisted drive.
   This of course succeeds, returning success to the caller of ->ide_dma_check().
   Not so good... It then uncondtionally calls ->ide_dma_on(), which turns on
   DMA for the drive.
   
   This moves the check to __ide_dma_on() so we also catch the buggy
   ->ide_dma_check() defined by various chipset drivers.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-10 18:02:09 +02:00
@@ -407,10 +407,6 @@
 	ide_hwif_t *hwif = HWIF(drive);
 
 	if ((id->capability & 1) && hwif->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			return __ide_dma_off(drive);
-
 		/*
 		 * Enable DMA on any drive that has
 		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
@@ -564,6 +560,10 @@
  
 int __ide_dma_on (ide_drive_t *drive)
 {
+	/* consult the list of known "bad" drives */
+	if (__ide_dma_bad_drive(drive))
+		return 1;
+
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-10 18:02:09 +02:00
@@ -611,19 +611,6 @@
 		case TASKFILE_IN_DMA:
 			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
 			break;
-		case TASKFILE_IN_OUT:
-#if 0
-			args.prehandler = &pre_task_out_intr;
-			args.handler = &task_out_intr;
-			err = ide_diag_taskfile(drive, &args, taskout, outbuf);
-			args.prehandler = NULL;
-			args.handler = &task_in_intr;
-			err = ide_diag_taskfile(drive, &args, taskin, inbuf);
-			break;
-#else
-			err = -EFAULT;
-			goto abort;
-#endif
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
diff -Nru a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/pci/cmd64x.c	2004-10-10 18:02:09 +02:00
@@ -38,8 +38,6 @@
 static struct pci_dev *cmd_devs[CMD_MAX_DEVS];
 static int n_cmd_devs;
 
-#undef DEBUG_CMD_REGS
-
 static char * print_cmd64x_get_info (char *buf, struct pci_dev *dev, int index)
 {
 	char *p = buf;
@@ -49,9 +47,6 @@
 	u8 reg72 = 0, reg73 = 0;			/* primary */
 	u8 reg7a = 0, reg7b = 0;			/* secondary */
 	u8 reg50 = 0, reg71 = 0;			/* extra */
-#ifdef DEBUG_CMD_REGS
-	u8 hi_byte = 0, lo_byte = 0;
-#endif /* DEBUG_CMD_REGS */
 
 	p += sprintf(p, "\nController: %d\n", index);
 	p += sprintf(p, "CMD%x Chipset.\n", dev->device);
@@ -126,18 +121,6 @@
 	p += sprintf(p, "                %s                          %s\n",
 		(reg71 & MRDMODE_BLK_CH0) ? "blocked" : "enabled",
 		(reg71 & MRDMODE_BLK_CH1) ? "blocked" : "enabled");
-
-#ifdef DEBUG_CMD_REGS
-	SPLIT_BYTE(reg50, hi_byte, lo_byte);
-	p += sprintf(p, "CFR       = 0x%02x, HI = 0x%02x, "
-			"LOW = 0x%02x\n", reg50, hi_byte, lo_byte);
-	SPLIT_BYTE(reg57, hi_byte, lo_byte);
-	p += sprintf(p, "ARTTIM23  = 0x%02x, HI = 0x%02x, "
-			"LOW = 0x%02x\n", reg57, hi_byte, lo_byte);
-	SPLIT_BYTE(reg71, hi_byte, lo_byte);
-	p += sprintf(p, "MRDMODE   = 0x%02x, HI = 0x%02x, "
-			"LOW = 0x%02x\n", reg71, hi_byte, lo_byte);
-#endif /* DEBUG_CMD_REGS */
 
 	return (char *)p;
 }
diff -Nru a/drivers/ide/pci/cmd64x.h b/drivers/ide/pci/cmd64x.h
--- a/drivers/ide/pci/cmd64x.h	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/pci/cmd64x.h	2004-10-10 18:02:09 +02:00
@@ -15,10 +15,6 @@
 #define cmdprintk(x...)
 #endif
 
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
 /*
  * CMD64x specific registers definition.
  */
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.c	2004-10-10 18:02:09 +02:00
@@ -314,17 +314,6 @@
 		pci_write_config_byte(dev, (drive_pci)|0x02, CP|TC);
 	}
 
-#if PDC202XX_DECODE_REGISTER_INFO
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-	pci_read_config_byte(dev, (drive_pci)|0x03, &DP);
-
-	decode_registers(REG_A, AP);
-	decode_registers(REG_B, BP);
-	decode_registers(REG_C, CP);
-	decode_registers(REG_D, DP);
-#endif /* PDC202XX_DECODE_REGISTER_INFO */
 #if PDC202XX_DEBUG_DRIVE_INFO
 	printk(KERN_DEBUG "%s: %s drive%d 0x%08x ",
 		drive->name, ide_xfer_verbose(speed),
diff -Nru a/drivers/ide/pci/pdc202xx_old.h b/drivers/ide/pci/pdc202xx_old.h
--- a/drivers/ide/pci/pdc202xx_old.h	2004-10-10 18:02:09 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.h	2004-10-10 18:02:09 +02:00
@@ -10,7 +10,6 @@
 #endif
 
 #define PDC202XX_DEBUG_DRIVE_INFO		0
-#define PDC202XX_DECODE_REGISTER_INFO		0
 
 static const char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
@@ -98,76 +97,6 @@
 #define	MC2		0x04	/* DMA"C" timing */
 #define	MC1		0x02	/* DMA"C" timing */
 #define	MC0		0x01	/* DMA"C" timing */
-
-#if PDC202XX_DECODE_REGISTER_INFO
-
-#define REG_A		0x01
-#define REG_B		0x02
-#define REG_C		0x04
-#define REG_D		0x08
-
-static void decode_registers (u8 registers, u8 value)
-{
-	u8	bit = 0, bit1 = 0, bit2 = 0;
-
-	switch(registers) {
-		case REG_A:
-			bit2 = 0;
-			printk("A Register ");
-			if (value & 0x80) printk("SYNC_IN ");
-			if (value & 0x40) printk("ERRDY_EN ");
-			if (value & 0x20) printk("IORDY_EN ");
-			if (value & 0x10) printk("PREFETCH_EN ");
-			if (value & 0x08) { printk("PA3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PA2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PA1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PA0 ");bit2 |= 0x01; }
-			printk("PIO(A) = %d ", bit2);
-			break;
-		case REG_B:
-			bit1 = 0;bit2 = 0;
-			printk("B Register ");
-			if (value & 0x80) { printk("MB2 ");bit1 |= 0x80; }
-			if (value & 0x40) { printk("MB1 ");bit1 |= 0x40; }
-			if (value & 0x20) { printk("MB0 ");bit1 |= 0x20; }
-			printk("DMA(B) = %d ", bit1 >> 5);
-			if (value & 0x10) printk("PIO_FORCED/PB4 ");
-			if (value & 0x08) { printk("PB3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PB2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PB1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PB0 ");bit2 |= 0x01; }
-			printk("PIO(B) = %d ", bit2);
-			break;
-		case REG_C:
-			bit2 = 0;
-			printk("C Register ");
-			if (value & 0x80) printk("DMARQp ");
-			if (value & 0x40) printk("IORDYp ");
-			if (value & 0x20) printk("DMAR_EN ");
-			if (value & 0x10) printk("DMAW_EN ");
-
-			if (value & 0x08) { printk("MC3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("MC2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("MC1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("MC0 ");bit2 |= 0x01; }
-			printk("DMA(C) = %d ", bit2);
-			break;
-		case REG_D:
-			printk("D Register ");
-			break;
-		default:
-			return;
-	}
-	printk("\n        %s ", (registers & REG_D) ? "DP" :
-				(registers & REG_C) ? "CP" :
-				(registers & REG_B) ? "BP" :
-				(registers & REG_A) ? "AP" : "ERROR");
-	for (bit=128;bit>0;bit/=2)
-		printk("%s", (value & bit) ? "1" : "0");
-	printk("\n");
-}
-
-#endif /* PDC202XX_DECODE_REGISTER_INFO */
 
 #define DISPLAY_PDC202XX_TIMINGS
 
