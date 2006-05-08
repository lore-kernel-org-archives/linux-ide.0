From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pdc202xx_old: remove the obsolete busproc
Date: Mon, 08 May 2006 21:36:20 +0400
Message-ID: <445F8194.7000100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030509030207050509010007"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:14541 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932500AbWEHRh0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 May 2006 13:37:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509030207050509010007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Remove the busproc from pdc202xx_old.c because:

1) it handles the obsolete HDIO_TRISTATE_HWIF ioctl instead of the modern 
HDIO_SET_BUSSTATE, so treats its argument wrong;
2) I don't think that tristating both channels is good idea (probably can't be 
done otherwise since there seems to be only single bit controlling this).

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------030509030207050509010007
Content-Type: text/plain;
 name="pdc202xx_old-remove-busproc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc202xx_old-remove-busproc.patch"

Index: linus/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linus.orig/drivers/ide/pci/pdc202xx_old.c
+++ linus/drivers/ide/pci/pdc202xx_old.c
@@ -550,31 +550,6 @@ static void pdc202xx_reset (ide_drive_t 
 #endif
 }
 
-/*
- * Since SUN Cobalt is attempting to do this operation, I should disclose
- * this has been a long time ago Thu Jul 27 16:40:57 2000 was the patch date
- * HOTSWAP ATA Infrastructure.
- */
-static int pdc202xx_tristate (ide_drive_t * drive, int state)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
-	unsigned long high_16	= hwif->dma_master;
-	u8 sc1f			= hwif->INB(high_16|0x001f);
-
-	if (!hwif)
-		return -EINVAL;
-
-//	hwif->bus_state = state;
-
-	if (state) {
-		hwif->OUTB(sc1f | 0x08, (high_16|0x001f));
-	} else {
-		hwif->OUTB(sc1f & ~0x08, (high_16|0x001f));
-	}
-	return 0;
-}
-
 static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev, const char *name)
 {
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
@@ -624,10 +599,8 @@ static void __devinit init_hwif_pdc202xx
 	hwif->tuneproc  = &config_chipset_for_pio;
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
-	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
-		hwif->busproc   = &pdc202xx_tristate;
+	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc = &pdc202xx_reset;
-	}
 
 	hwif->speedproc = &pdc202xx_tune_chipset;
 

--------------030509030207050509010007--
