From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] hpt366: MWDMA filter for SATA cards (take 2)
Date: Sun, 30 Sep 2007 00:04:42 +0400
Message-ID: <200709300004.43335.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758156AbXI2UFT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The Marvell bridge chips used on HighPoint SATA cards do not seem to support
the MWDMA modes (at least that caould be seen in their so-called drivers :-),
so the driver needs to account for this -- to achieve this:

- add mdma_filter() method from the original patch by Bartlomiej Zolnierkewicz
  with his consent, also adding the method callout to ide_rate_filter();

- install the method for all chips to only return empty mask if a SATA drive
  is detected on HPT372{AN]/374 chips...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the current Linus' tree.
It has not been tested on a real SATA card...

 drivers/ide/ide-dma.c    |    9 +++++++--
 drivers/ide/ide.c        |    1 +
 drivers/ide/pci/hpt366.c |   23 +++++++++++++++++++++--
 include/linux/ide.h      |    1 +
 4 files changed, 30 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -674,8 +674,13 @@ static unsigned int ide_get_mode_mask(id
 			mask &= 0x07;
 		break;
 	case XFER_MW_DMA_0:
-		if (id->field_valid & 2)
-			mask = id->dma_mword & hwif->mwdma_mask;
+		if ((id->field_valid & 2) == 0)
+			break;
+		if (hwif->mdma_filter)
+			mask = hwif->mdma_filter(drive);
+		else
+			mask = hwif->mwdma_mask;
+		mask &= id->dma_mword;
 		break;
 	case XFER_SW_DMA_0:
 		if (id->field_valid & 2) {
Index: linux-2.6/drivers/ide/ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide.c
+++ linux-2.6/drivers/ide/ide.c
@@ -398,6 +398,7 @@ static void ide_hwif_restore(ide_hwif_t 
 
 	hwif->tuneproc			= tmp_hwif->tuneproc;
 	hwif->speedproc			= tmp_hwif->speedproc;
+	hwif->mdma_filter		= tmp_hwif->mdma_filter;
 	hwif->udma_filter		= tmp_hwif->udma_filter;
 	hwif->selectproc		= tmp_hwif->selectproc;
 	hwif->reset_poll		= tmp_hwif->reset_poll;
Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.12	Aug 19, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.13	Sep 29, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -114,7 +114,7 @@
  *   unify HPT36x/37x timing setup code and the speedproc handlers by joining
  *   the register setting lists into the table indexed by the clock selected
  * - set the correct hwif->ultra_mask for each individual chip
- * - add UltraDMA mode filtering for the HPT37[24] based SATA cards
+ * - add Ultra and MW DMA mode filtering for the HPT37[24] based SATA cards
  *	Sergei Shtylyov, <sshtylyov@ru.mvista.com> or <source@mvista.com>
  */
 
@@ -562,6 +562,24 @@ static u8 hpt3xx_udma_filter(ide_drive_t
 	return check_in_drive_list(drive, bad_ata33) ? 0x00 : mask;
 }
 
+static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct hpt_info *info	= pci_get_drvdata(hwif->pci_dev);
+
+	switch (info->chip_type) {
+	case HPT372 :
+	case HPT372A:
+	case HPT372N:
+	case HPT374 :
+		if (ide_dev_is_sata(drive->id))
+			return 0x00;
+		/* Fall thru */
+	default:
+		return 0x07;
+	}
+}
+
 static u32 get_speed_setting(u8 speed, struct hpt_info *info)
 {
 	int i;
@@ -1257,6 +1275,7 @@ static void __devinit init_hwif_hpt366(i
 	hwif->busproc		= &hpt3xx_busproc;
 
 	hwif->udma_filter	= &hpt3xx_udma_filter;
+	hwif->mdma_filter	= &hpt3xx_mdma_filter;
 
 	/*
 	 * HPT3xxN chips have some complications:
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -723,6 +723,7 @@ typedef struct hwif_s {
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
 #endif
+	u8 (*mdma_filter)(ide_drive_t *);
 	u8 (*udma_filter)(ide_drive_t *);
 
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
