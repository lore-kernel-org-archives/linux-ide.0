From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/15] ide: remove hwif->intrproc
Date: Wed, 31 Oct 2007 00:55:13 +0100
Message-ID: <200710310055.13329.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbXJ3Xua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788146nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


Given that:

* hpt366.c::hpt3xx_intrproc() is the only user of hwif->intrproc

* hpt366.c::hpt3xx_quirkproc() sets drive->quirk_list to 1 for quirky drives
  which is a value unique to hpt366 host driver

we can remove hwif->intproc and just check for drive->quirk_list == 1
in ide_do_request().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Handling of quirky drives (problems with nIEN) by hpt366 and pdc202xx_*
looks suspicious...  are the problems really dependent on the host type
(thus hwif->quirkproc and ->quirk_list == 1/2)?  Shouldn't we just handle
quirky drives in the same way in the core IDE code regardless of the host
driver being used (of course using hwif->maskproc where needed)?

 drivers/ide/ide-io.c      |    9 +++++----
 drivers/ide/pci/hpt366.c  |   10 ----------
 drivers/ide/pci/sgiioc4.c |    1 -
 include/linux/ide.h       |    2 --
 4 files changed, 5 insertions(+), 17 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1198,10 +1198,11 @@ static void ide_do_request (ide_hwgroup_
 		if (hwgroup->hwif->sharing_irq &&
 		    hwif != hwgroup->hwif &&
 		    hwif->io_ports[IDE_CONTROL_OFFSET]) {
-			/* set nIEN for previous hwif */
-			if (hwif->intrproc)
-				hwif->intrproc(drive);
-			else
+			/*
+			 * set nIEN for previous hwif, drives in the
+			 * quirk_list may not like intr setups/cleanups
+			 */
+			if (drive->quirk_list != 1)
 				hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 		}
 		hwgroup->hwif = hwif;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -687,15 +687,6 @@ static int hpt3xx_quirkproc(ide_drive_t 
 	return 0;
 }
 
-static void hpt3xx_intrproc(ide_drive_t *drive)
-{
-	if (drive->quirk_list)
-		return;
-
-	/* drives in the quirk_list may not like intr setups/cleanups */
-	outb(drive->ctl | 2, IDE_CONTROL_REG);
-}
-
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -1253,7 +1244,6 @@ static void __devinit init_hwif_hpt366(i
 	hwif->set_pio_mode	= &hpt3xx_set_pio_mode;
 	hwif->set_dma_mode	= &hpt3xx_set_mode;
 	hwif->quirkproc		= &hpt3xx_quirkproc;
-	hwif->intrproc		= &hpt3xx_intrproc;
 	hwif->maskproc		= &hpt3xx_maskproc;
 	hwif->busproc		= &hpt3xx_busproc;
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -582,7 +582,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
 	hwif->resetproc = &sgiioc4_resetproc;/* Reset DMA engine,
 						clear interrupts */
-	hwif->intrproc = NULL;	/* Enable or Disable interrupt from drive */
 	hwif->maskproc = &sgiioc4_maskproc;	/* Mask on/off NIEN register */
 	hwif->quirkproc = NULL;
 	hwif->busproc = NULL;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -524,8 +524,6 @@ typedef struct hwif_s {
 	void	(*pre_reset)(ide_drive_t *);
 	/* routine to reset controller after a disk reset */
 	void	(*resetproc)(ide_drive_t *);
-	/* special interrupt handling for shared pci interrupts */
-	void	(*intrproc)(ide_drive_t *);
 	/* special host masking for drive selection */
 	void	(*maskproc)(ide_drive_t *, int);
 	/* check host's drive quirk list */
