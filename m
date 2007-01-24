From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] ide: clear bmdma status in ide_intr()
Date: Wed, 24 Jan 2007 11:42:31 +0800
Message-ID: <45B6D5A7.6080700@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com>	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>	 <45B479C2.7090300@tw.ibm.com> <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com> <45B6D386.3030104@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:38277 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965260AbXAXDme (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 22:42:34 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0O3gXhN018654
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 22:42:33 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0O3gXLg403020
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:42:33 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0O3gWcw003745
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 20:42:33 -0700
In-Reply-To: <45B6D386.3030104@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>

patch 2/2:
  Do the dma status clearing in ide_intr() and add a new hwif->ide_dma_clear_irq such that LLDD could override it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Tested ok on ICH4 and pdc20275. Not sure if this would have bad effect for other adapters.

Patch against 2.6.20-rc5, for your review, thanks.

diff -Nrup 01_remove_from_ide_cd/drivers/ide/ide-dma.c 02_add_to_ide_intr/drivers/ide/ide-dma.c
--- 01_remove_from_ide_cd/drivers/ide/ide-dma.c	2006-11-30 05:57:37.000000000 +0800
+++ 02_add_to_ide_intr/drivers/ide/ide-dma.c	2007-01-24 11:07:58.000000000 +0800
@@ -650,6 +650,22 @@ static int __ide_dma_test_irq(ide_drive_
 			drive->name, __FUNCTION__);
 	return 0;
 }
+
+/* returns 1 on error, 0 otherwise */
+int __ide_dma_clear_irq(ide_drive_t *drive)
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
+
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
@@ -928,6 +944,8 @@ void ide_setup_dma (ide_hwif_t *hwif, un
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
+++ 02_add_to_ide_intr/drivers/ide/ide-io.c	2007-01-24 11:21:41.000000000 +0800
@@ -1644,6 +1644,18 @@ irqreturn_t ide_intr (int irq, void *dev
 	}
 	hwgroup->handler = NULL;
 	del_timer(&hwgroup->timer);
+
+	/* Some controllers might set DMA INTR no matter DMA or PIO;
+	 * bmdma status might need to be cleared even for
+	 * PIO interrupts to prevent spurious irq or irq lost.
+	 */
+	if (hwif->ide_dma_clear_irq && !(hwif->dma))
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
+++ 02_add_to_ide_intr/include/linux/ide.h	2007-01-24 11:00:48.000000000 +0800
@@ -727,6 +727,7 @@ typedef struct hwif_s {
 	int (*ide_dma_on)(ide_drive_t *drive);
 	int (*ide_dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
+	int (*ide_dma_clear_irq)(ide_drive_t *drive);
 	int (*ide_dma_host_on)(ide_drive_t *drive);
 	int (*ide_dma_host_off)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);


