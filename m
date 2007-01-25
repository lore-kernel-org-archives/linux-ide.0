From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] ide: clear bmdma status in ide_intr() (revised)
Date: Thu, 25 Jan 2007 17:31:28 +0800
Message-ID: <45B878F0.7060707@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com> <45B6D5A7.6080700@tw.ibm.com> <45B7596F.6080504@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55611 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965736AbXAYJbo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 04:31:44 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0ONU5tF008887
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 18:30:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0P9VhsN467686
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 02:31:43 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0P9Vg2v023787
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 02:31:43 -0700
In-Reply-To: <45B7596F.6080504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 2/2 (revised):
- Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq such that LLDD can override it.
- Fix drive->waiting_for_dma to work with CDB-intr devices.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
hwif->dma is not reliable: ide_intr() races with dma_start(). Sometimes we got hwif->dma == 0
in ide_intr() even though it is actually a DMA interrupt. So, drive->waiting_for_dma is used instead.

Also revised per Sergei's comments and let ide_dma_clear_irq return "void".
The "if (hwif->dma_status)" check in __ide_dma_clear_irq() is kept as is since I think
it would be safer for the old ISA/VESA IDE devices that has no BMDMA registers.

For your review, thanks.


diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-cd.c 02_add_to_ide_intr/drivers/ide/ide-cd.c
--- 01_remove_from_ide_cd/drivers/ide/ide-cd.c	2007-01-24 11:00:03.000000000 +0800
+++ 02_add_to_ide_intr/drivers/ide/ide-cd.c	2007-01-25 16:52:20.000000000 +0800
@@ -923,6 +923,10 @@ static ide_startstop_t cdrom_start_packe
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
+		/* waiting for CDB interrupt, not DMA yet. */
+		if (info->dma)
+			drive->waiting_for_dma = 0;
+
 		/* packet command */
 		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
@@ -965,6 +969,10 @@ static ide_startstop_t cdrom_transfer_pa
 		/* Check for errors. */
 		if (cdrom_decode_status(drive, DRQ_STAT, NULL))
 			return ide_stopped;
+
+		/* Ok, next interrupt will be dma interrupt. */
+		if (info->dma)
+			drive->waiting_for_dma = 1;
 	} else {
 		/* Otherwise, we must wait for DRQ to get set. */
 		if (ide_wait_stat(&startstop, drive, DRQ_STAT,
diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-dma.c 02_add_to_ide_intr/drivers/ide/ide-dma.c
--- 01_remove_from_ide_cd/drivers/ide/ide-dma.c	2006-11-30 05:57:37.000000000 +0800
+++ 02_add_to_ide_intr/drivers/ide/ide-dma.c	2007-01-25 16:37:24.000000000 +0800
@@ -650,6 +650,19 @@ static int __ide_dma_test_irq(ide_drive_
 			drive->name, __FUNCTION__);
 	return 0;
 }
+
+static void __ide_dma_clear_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	u8 dma_stat;
+
+	/* clear the INTR & ERROR bits */
+	if (hwif->dma_status) {
+		dma_stat = hwif->INB(hwif->dma_status);
+		/* Should we force the bit as well ? */
+		hwif->OUTB(dma_stat, hwif->dma_status);
+	}
+}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
@@ -928,6 +941,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_end = &__ide_dma_end;
 	if (!hwif->ide_dma_test_irq)
 		hwif->ide_dma_test_irq = &__ide_dma_test_irq;
+	if (!hwif->ide_dma_clear_irq)
+		hwif->ide_dma_clear_irq = &__ide_dma_clear_irq;
 	if (!hwif->ide_dma_timeout)
 		hwif->ide_dma_timeout = &__ide_dma_timeout;
 	if (!hwif->ide_dma_lostirq)
diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-io.c 02_add_to_ide_intr/drivers/ide/ide-io.c
--- 01_remove_from_ide_cd/drivers/ide/ide-io.c	2006-11-30 05:57:37.000000000 +0800
+++ 02_add_to_ide_intr/drivers/ide/ide-io.c	2007-01-25 16:27:21.000000000 +0800
@@ -1644,6 +1644,18 @@ irqreturn_t ide_intr (int irq, void *dev
 	}
 	hwgroup->handler = NULL;
 	del_timer(&hwgroup->timer);
+
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
 	spin_unlock(&ide_lock);
 
 	if (drive->unmask)
diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide.c 02_add_to_ide_intr/drivers/ide/ide.c
--- 01_remove_from_ide_cd/drivers/ide/ide.c	2007-01-23 11:47:42.000000000 +0800
+++ 02_add_to_ide_intr/drivers/ide/ide.c	2007-01-24 11:00:48.000000000 +0800
@@ -503,6 +503,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
 	hwif->ide_dma_off_quietly	= tmp_hwif->ide_dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
+	hwif->ide_dma_clear_irq		= tmp_hwif->ide_dma_clear_irq;
 	hwif->ide_dma_host_on		= tmp_hwif->ide_dma_host_on;
 	hwif->ide_dma_host_off		= tmp_hwif->ide_dma_host_off;
 	hwif->ide_dma_lostirq		= tmp_hwif->ide_dma_lostirq;
diff -Nrup 01_remove_from_ide_cd/include/linux/ide.h 02_add_to_ide_intr/include/linux/ide.h
--- 01_remove_from_ide_cd/include/linux/ide.h	2007-01-24 11:00:03.000000000 +0800
+++ 02_add_to_ide_intr/include/linux/ide.h	2007-01-25 16:10:42.000000000 +0800
@@ -727,6 +727,7 @@ typedef struct hwif_s {
 	int (*ide_dma_on)(ide_drive_t *drive);
 	int (*ide_dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
+	void (*ide_dma_clear_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);


