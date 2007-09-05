From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/10] ide: use I/O ops directly part #2
Date: Wed, 5 Sep 2007 22:43:03 +0200
Message-ID: <200709052243.03274.bzolnier@gmail.com>
References: <200708292318.23393.bzolnier@gmail.com> <46D993DC.40902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:21791 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923AbXIEUlh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 16:41:37 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1814038nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 13:41:37 -0700 (PDT)
In-Reply-To: <46D993DC.40902@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 01 September 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>     Strange I thought I've already replaced everything in hpt366.c ... 
> although we could switch to using MMIO there -- at least for HPT37x chips. B-)
> 
> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> 
>     Could you bump a version before committing?

[PATCH] ide: use I/O ops directly part #2 (take 2)

v2:
- bump host driver versions (as suggested by Sergei)
- use I/O ops directly in drivers/ide/setup-pci.c

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt366.c   |   45 +++++++++++++++++++++------------------------
 drivers/ide/pci/piix.c     |    6 +++---
 drivers/ide/pci/tc86c001.c |   14 +++++++-------
 drivers/ide/setup-pci.c    |    6 +++---
 4 files changed, 34 insertions(+), 37 deletions(-)

Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.13	Aug 20, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.14	Sep 5, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -658,12 +658,11 @@ static int hpt3xx_quirkproc(ide_drive_t 
 
 static void hpt3xx_intrproc(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-
 	if (drive->quirk_list)
 		return;
+
 	/* drives in the quirk_list may not like intr setups/cleanups */
-	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
+	outb(drive->ctl | 2, IDE_CONTROL_REG);
 }
 
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
@@ -691,8 +690,8 @@ static void hpt3xx_maskproc(ide_drive_t 
 				enable_irq (hwif->irq);
 		}
 	} else
-		hwif->OUTB(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
-			   IDE_CONTROL_REG);
+		outb(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
+		     IDE_CONTROL_REG);
 }
 
 /*
@@ -732,9 +731,9 @@ static void hpt370_irq_timeout(ide_drive
 	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo & 0x1ff);
 
 	/* get DMA command mode */
-	dma_cmd = hwif->INB(hwif->dma_command);
+	dma_cmd = inb(hwif->dma_command);
 	/* stop DMA */
-	hwif->OUTB(dma_cmd & ~0x1, hwif->dma_command);
+	outb(dma_cmd & ~0x1, hwif->dma_command);
 	hpt370_clear_engine(drive);
 }
 
@@ -749,12 +748,12 @@ static void hpt370_ide_dma_start(ide_dri
 static int hpt370_ide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8  dma_stat		= hwif->INB(hwif->dma_status);
+	u8  dma_stat		= inb(hwif->dma_status);
 
 	if (dma_stat & 0x01) {
 		/* wait a little */
 		udelay(20);
-		dma_stat = hwif->INB(hwif->dma_status);
+		dma_stat = inb(hwif->dma_status);
 		if (dma_stat & 0x01)
 			hpt370_irq_timeout(drive);
 	}
@@ -815,34 +814,32 @@ static int hpt374_ide_dma_end(ide_drive_
 
 static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
 {
-	u8 scr2 = hwif->INB(hwif->dma_master + 0x7b);
+	u8 scr2 = inb(hwif->dma_master + 0x7b);
 
 	if ((scr2 & 0x7f) == mode)
 		return;
 
 	/* Tristate the bus */
-	hwif->OUTB(0x80, hwif->dma_master + 0x73);
-	hwif->OUTB(0x80, hwif->dma_master + 0x77);
+	outb(0x80, hwif->dma_master + 0x73);
+	outb(0x80, hwif->dma_master + 0x77);
 
 	/* Switch clock and reset channels */
-	hwif->OUTB(mode, hwif->dma_master + 0x7b);
-	hwif->OUTB(0xc0, hwif->dma_master + 0x79);
+	outb(mode, hwif->dma_master + 0x7b);
+	outb(0xc0, hwif->dma_master + 0x79);
 
 	/*
 	 * Reset the state machines.
 	 * NOTE: avoid accidentally enabling the disabled channels.
 	 */
-	hwif->OUTB(hwif->INB(hwif->dma_master + 0x70) | 0x32,
-		   hwif->dma_master + 0x70);
-	hwif->OUTB(hwif->INB(hwif->dma_master + 0x74) | 0x32,
-		   hwif->dma_master + 0x74);
+	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
+	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
 
 	/* Complete reset */
-	hwif->OUTB(0x00, hwif->dma_master + 0x79);
+	outb(0x00, hwif->dma_master + 0x79);
 
 	/* Reconnect channels to bus */
-	hwif->OUTB(0x00, hwif->dma_master + 0x73);
-	hwif->OUTB(0x00, hwif->dma_master + 0x77);
+	outb(0x00, hwif->dma_master + 0x73);
+	outb(0x00, hwif->dma_master + 0x77);
 }
 
 /**
@@ -1332,7 +1329,7 @@ static void __devinit init_dma_hpt366(id
 	u8 dma_new	= 0, dma_old	= 0;
 	unsigned long flags;
 
-	dma_old = hwif->INB(dmabase + 2);
+	dma_old = inb(dmabase + 2);
 
 	local_irq_save(flags);
 
@@ -1343,7 +1340,7 @@ static void __devinit init_dma_hpt366(id
 	if (masterdma & 0x30)	dma_new |= 0x20;
 	if ( slavedma & 0x30)	dma_new |= 0x40;
 	if (dma_new != dma_old)
-		hwif->OUTB(dma_new, dmabase + 2);
+		outb(dma_new, dmabase + 2);
 
 	local_irq_restore(flags);
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.53	Aug 9, 2007
+ *  linux/drivers/ide/pci/piix.c	Version 0.54	Sep 5, 2007
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -318,9 +318,9 @@ static void piix_dma_clear_irq(ide_drive
 	u8 dma_stat;
 
 	/* clear the INTR & ERROR bits */
-	dma_stat = hwif->INB(hwif->dma_status);
+	dma_stat = inb(hwif->dma_status);
 	/* Should we force the bit as well ? */
-	hwif->OUTB(dma_stat, hwif->dma_status);
+	outb(dma_stat, hwif->dma_status);
 }
 
 struct ich_laptop {
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -1,5 +1,5 @@
 /*
- * drivers/ide/pci/tc86c001.c	Version 1.00	Dec 12, 2006
+ * drivers/ide/pci/tc86c001.c	Version 1.01	Sep 5, 2007
  *
  * Copyright (C) 2002 Toshiba Corporation
  * Copyright (C) 2005-2006 MontaVista Software, Inc. <source@mvista.com>
@@ -17,7 +17,7 @@ static void tc86c001_set_mode(ide_drive_
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long scr_port	= hwif->config_data + (drive->dn ? 0x02 : 0x00);
-	u16 mode, scr		= hwif->INW(scr_port);
+	u16 mode, scr		= inw(scr_port);
 
 	switch (speed) {
 		case XFER_UDMA_4:	mode = 0x00c0; break;
@@ -65,7 +65,7 @@ static int tc86c001_timer_expiry(ide_dri
 	ide_hwif_t *hwif	= HWIF(drive);
 	ide_expiry_t *expiry	= ide_get_hwifdata(hwif);
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
-	u8 dma_stat		= hwif->INB(hwif->dma_status);
+	u8 dma_stat		= inb(hwif->dma_status);
 
 	/* Restore a higher level driver's expiry handler first. */
 	hwgroup->expiry	= expiry;
@@ -73,7 +73,7 @@ static int tc86c001_timer_expiry(ide_dri
 	if ((dma_stat & 5) == 1) {	/* DMA active and no interrupt */
 		unsigned long sc_base	= hwif->config_data;
 		unsigned long twcr_port	= sc_base + (drive->dn ? 0x06 : 0x04);
-		u8 dma_cmd		= hwif->INB(hwif->dma_command);
+		u8 dma_cmd		= inb(hwif->dma_command);
 
 		printk(KERN_WARNING "%s: DMA interrupt possibly stuck, "
 		       "attempting recovery...\n", drive->name);
@@ -135,7 +135,7 @@ static int tc86c001_busproc(ide_drive_t 
 	u16 scr1;
 
 	/* System Control 1 Register bit 11 (ATA Hard Reset) read */
-	scr1 = hwif->INW(sc_base + 0x00);
+	scr1 = inw(sc_base + 0x00);
 
 	switch (state) {
 		case BUSSTATE_ON:
@@ -165,7 +165,7 @@ static int tc86c001_busproc(ide_drive_t 
 static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
 {
 	unsigned long sc_base	= pci_resource_start(hwif->pci_dev, 5);
-	u16 scr1		= hwif->INW(sc_base + 0x00);;
+	u16 scr1		= inw(sc_base + 0x00);
 
 	/* System Control 1 Register bit 15 (Soft Reset) set */
 	outw(scr1 |  0x8000, sc_base + 0x00);
@@ -205,7 +205,7 @@ static void __devinit init_hwif_tc86c001
 		 * System Control  1 Register bit 13 (PDIAGN):
 		 * 0=80-pin cable, 1=40-pin cable
 		 */
-		scr1 = hwif->INW(sc_base + 0x00);
+		scr1 = inw(sc_base + 0x00);
 		hwif->cbl = (scr1 & 0x2000) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 	}
 }
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -185,9 +185,9 @@ static unsigned long ide_get_or_set_dma_
 			case PCI_DEVICE_ID_CMD_643:
 			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
 			case PCI_DEVICE_ID_REVOLUTION:
-				simplex_stat = hwif->INB(dma_base + 2);
-				hwif->OUTB((simplex_stat&0x60),(dma_base + 2));
-				simplex_stat = hwif->INB(dma_base + 2);
+				simplex_stat = inb(dma_base + 2);
+				outb(simplex_stat & 0x60, dma_base + 2);
+				simplex_stat = inb(dma_base + 2);
 				if (simplex_stat & 0x80) {
 					printk(KERN_INFO "%s: simplex device: "
 							 "DMA forced\n",
