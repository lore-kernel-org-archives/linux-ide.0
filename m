From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] ide: remove clearing bmdma status from cdrom_decode_status()
Date: Wed, 24 Jan 2007 11:36:44 +0800
Message-ID: <45B6D44C.40406@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:52155 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965156AbXAXDgr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 22:36:47 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0O3ak4R018977
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 22:36:47 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0O3akvx519106
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:36:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0O3akb1026526
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:36:46 -0700
In-Reply-To: <45B6D386.3030104@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 1/2:
  Remove clearing bmdma status from cdrom_decode_status() since ATA devices might need it as well.
  (http://lkml.org/lkml/2006/12/4/201 and http://lkml.org/lkml/2006/11/15/94)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
diff -Nrup 00_ide_dma/drivers/ide/ide-cd.c 01_remove_from_ide_cd/drivers/ide/ide-cd.c
--- 00_ide_dma/drivers/ide/ide-cd.c	2007-01-23 11:47:42.000000000 +0800
+++ 01_remove_from_ide_cd/drivers/ide/ide-cd.c	2007-01-24 11:00:03.000000000 +0800
@@ -687,15 +687,8 @@ static void ide_dump_status_no_sense(ide
 static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	ide_hwif_t *hwif = HWIF(drive);
 	int stat, err, sense_key;
 	
-	/* We may have bogus DMA interrupts in PIO state here */
-	if (HWIF(drive)->dma_status && hwif->atapi_irq_bogon) {
-		stat = hwif->INB(hwif->dma_status);
-		/* Should we force the bit as well ? */
-		hwif->OUTB(stat, hwif->dma_status);
-	}
 	/* Check for errors. */
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (stat_ret)
diff -Nrup 00_ide_dma/drivers/ide/pci/piix.c 01_remove_from_ide_cd/drivers/ide/pci/piix.c
--- 00_ide_dma/drivers/ide/pci/piix.c	2007-01-23 11:47:42.000000000 +0800
+++ 01_remove_from_ide_cd/drivers/ide/pci/piix.c	2007-01-24 11:00:03.000000000 +0800
@@ -473,10 +473,6 @@ static void __devinit init_hwif_piix(ide
 		/* This is a painful system best to let it self tune for now */
 		return;
 	}
-	/* ESB2 appears to generate spurious DMA interrupts in PIO mode
-	   when in native mode */
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_INTEL_ESB2_18)
-		hwif->atapi_irq_bogon = 1;
 
 	hwif->autodma = 0;
 	hwif->tuneproc = &piix_tune_drive;
diff -Nrup 00_ide_dma/include/linux/ide.h 01_remove_from_ide_cd/include/linux/ide.h
--- 00_ide_dma/include/linux/ide.h	2007-01-23 11:47:48.000000000 +0800
+++ 01_remove_from_ide_cd/include/linux/ide.h	2007-01-24 11:00:03.000000000 +0800
@@ -796,7 +796,6 @@ typedef struct hwif_s {
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
 	unsigned	err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
-	unsigned	atapi_irq_bogon : 1; /* Generates spurious DMA interrupts in PIO mode */
 
 	struct device	gendev;
 	struct completion gendev_rel_comp; /* To deal with device release() */


