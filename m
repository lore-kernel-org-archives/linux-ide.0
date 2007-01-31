From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] ide: clear bmdma status in ide_intr() for ICHx controllers
 (revised #4)
Date: Wed, 31 Jan 2007 13:54:35 +0800
Message-ID: <45C02F1B.1000101@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com>	 <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com>	 <45B7596F.6080504@ru.mvista.com> <45B878F0.7060707@tw.ibm.com>	 <45B8CA02.4050701@ru.mvista.com> <45B8DD84.3090700@ru.mvista.com>	 <45BEB242.7070506@tw.ibm.com> <45BEB52B.4070307@tw.ibm.com> <58cb370e0701301117n316a9efax1e0b6299a8f8594a@mail.gmail.com> <45BFA8B6.9010902@gmail.com> <45C02DD1.7040907@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59098 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbXAaFyk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 00:54:40 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l0V5sZLQ022179
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 00:54:35 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0V5sZMp495322
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 22:54:35 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0V5sYwN021251
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 22:54:35 -0700
In-Reply-To: <45C02DD1.7040907@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 1/2 (revised):
- Fix drive->waiting_for_dma to work with CDB-intr devices.
- Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq for Intel ICHx controllers.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Revised per Alan, Sergei and Bart's advice.

Patch against 2.6.20-rc6. Tested ok on my ICH4 and pdc20275 adapters.
Please review/apply, thanks.

diff -Nrup 00_ide_dma/drivers/ide/ide-cd.c 01_add_to_ide_intr/drivers/ide/ide-cd.c
--- 00_ide_dma/drivers/ide/ide-cd.c	2007-01-29 17:19:48.000000000 +0800
+++ 01_add_to_ide_intr/drivers/ide/ide-cd.c	2007-01-31 11:01:03.000000000 +0800
@@ -930,6 +930,10 @@ static ide_startstop_t cdrom_start_packe
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
+		/* waiting for CDB interrupt, not DMA yet. */
+		if (info->dma)
+			drive->waiting_for_dma = 0;
+
 		/* packet command */
 		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
@@ -972,6 +976,10 @@ static ide_startstop_t cdrom_transfer_pa
 		/* Check for errors. */
 		if (cdrom_decode_status(drive, DRQ_STAT, NULL))
 			return ide_stopped;
+
+		/* Ok, next interrupt will be DMA interrupt. */
+		if (info->dma)
+			drive->waiting_for_dma = 1;
 	} else {
 		/* Otherwise, we must wait for DRQ to get set. */
 		if (ide_wait_stat(&startstop, drive, DRQ_STAT,
diff -Nrup 00_ide_dma/drivers/ide/ide-io.c 01_add_to_ide_intr/drivers/ide/ide-io.c
--- 00_ide_dma/drivers/ide/ide-io.c	2006-11-30 05:57:37.000000000 +0800
+++ 01_add_to_ide_intr/drivers/ide/ide-io.c	2007-01-31 12:19:09.000000000 +0800
@@ -1646,6 +1646,17 @@ irqreturn_t ide_intr (int irq, void *dev
 	del_timer(&hwgroup->timer);
 	spin_unlock(&ide_lock);
 
+	/* Some controllers might set DMA INTR no matter DMA or PIO;
+	 * bmdma status might need to be cleared even for
+	 * PIO interrupts to prevent spurious/lost irq.
+	 */
+	if (hwif->ide_dma_clear_irq && !(drive->waiting_for_dma))
+		/* ide_dma_end() needs bmdma status for error checking.
+		 * So, skip clearing bmdma status here and leave it
+		 * to ide_dma_end() if this is dma interrupt.
+		 */
+		hwif->ide_dma_clear_irq(drive);
+
 	if (drive->unmask)
 		local_irq_enable_in_hardirq();
 	/* service this interrupt, may set handler for next interrupt */
diff -Nrup 00_ide_dma/drivers/ide/ide.c 01_add_to_ide_intr/drivers/ide/ide.c
--- 00_ide_dma/drivers/ide/ide.c	2007-01-29 17:19:48.000000000 +0800
+++ 01_add_to_ide_intr/drivers/ide/ide.c	2007-01-31 11:01:03.000000000 +0800
@@ -503,6 +503,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
 	hwif->ide_dma_off_quietly	= tmp_hwif->ide_dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
+	hwif->ide_dma_clear_irq		= tmp_hwif->ide_dma_clear_irq;
 	hwif->ide_dma_host_on		= tmp_hwif->ide_dma_host_on;
 	hwif->ide_dma_host_off		= tmp_hwif->ide_dma_host_off;
 	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
diff -Nrup 00_ide_dma/drivers/ide/pci/piix.c 01_add_to_ide_intr/drivers/ide/pci/piix.c
--- 00_ide_dma/drivers/ide/pci/piix.c	2007-01-29 17:19:48.000000000 +0800
+++ 01_add_to_ide_intr/drivers/ide/pci/piix.c	2007-01-31 13:38:42.000000000 +0800
@@ -411,17 +411,14 @@ fast_ata_pio:
 }
 
 /**
- *	init_chipset_piix	-	set up the PIIX chipset
- *	@dev: PCI device to set up
- *	@name: Name of the device
+ *	piix_is_ichx	-	check if ICHx
+ *	@dev: PCI device to check
  *
- *	Initialize the PCI device as required. For the PIIX this turns
- *	out to be nice and simple
+ *	returns 1 if ICHx, 0 otherwise.
  */
- 
-static unsigned int __devinit init_chipset_piix (struct pci_dev *dev, const char *name)
+static int piix_is_ichx(struct pci_dev *dev)
 {
-        switch(dev->device) {
+        switch (dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801EB_1:
 		case PCI_DEVICE_ID_INTEL_82801AA_1:
 		case PCI_DEVICE_ID_INTEL_82801AB_1:
@@ -439,19 +436,51 @@ static unsigned int __devinit init_chips
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
 		case PCI_DEVICE_ID_INTEL_ICH8_6:
-		{
-			unsigned int extra = 0;
-			pci_read_config_dword(dev, 0x54, &extra);
-			pci_write_config_dword(dev, 0x54, extra|0x400);
-		}
-		default:
-			break;
+			return 1;
+	}
+	
+	return 0;
+}
+
+/**
+ *	init_chipset_piix	-	set up the PIIX chipset
+ *	@dev: PCI device to set up
+ *	@name: Name of the device
+ *
+ *	Initialize the PCI device as required. For the PIIX this turns
+ *	out to be nice and simple
+ */
+ 
+static unsigned int __devinit init_chipset_piix (struct pci_dev *dev, const char *name)
+{
+	if (piix_is_ichx(dev)) {
+		unsigned int extra = 0;
+		pci_read_config_dword(dev, 0x54, &extra);
+		pci_write_config_dword(dev, 0x54, extra|0x400);
 	}
 
 	return 0;
 }
 
 /**
+ *	piix_dma_clear_irq	-	clear BMDMA status
+ *	@drive: IDE drive to clear
+ *
+ *	Called from ide_intr() for PIO interrupts 
+ *	to clear BMDMA status as needed by ICHx
+ */
+static void piix_dma_clear_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	u8 dma_stat;
+
+	/* clear the INTR & ERROR bits */
+	dma_stat = hwif->INB(hwif->dma_status);
+	/* Should we force the bit as well ? */
+	hwif->OUTB(dma_stat, hwif->dma_status);
+}
+
+/**
  *	init_hwif_piix		-	fill in the hwif for the PIIX
  *	@hwif: IDE interface
  *
@@ -487,6 +516,10 @@ static void __devinit init_hwif_piix(ide
 	if (!hwif->dma_base)
 		return;
 
+	/* ICHx need to clear the bmdma status for all interrupts */
+	if (piix_is_ichx(hwif->pci_dev))
+		hwif->ide_dma_clear_irq = &piix_dma_clear_irq;
+
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x06;
diff -Nrup 00_ide_dma/include/linux/ide.h 01_add_to_ide_intr/include/linux/ide.h
--- 00_ide_dma/include/linux/ide.h	2007-01-29 17:19:53.000000000 +0800
+++ 01_add_to_ide_intr/include/linux/ide.h	2007-01-31 11:10:27.000000000 +0800
@@ -727,6 +727,7 @@ typedef struct hwif_s {
 	int (*ide_dma_on)(ide_drive_t *drive);
 	int (*ide_dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
+	void (*ide_dma_clear_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);


