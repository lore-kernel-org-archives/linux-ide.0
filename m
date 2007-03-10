From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/13] cs5530/sc1200: DMA support cleanup
Date: Sat, 10 Mar 2007 22:09:02 +0100
Message-ID: <200703102209.02467.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbXCJVJN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749117uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] cs5530/sc1200: DMA support cleanup

sc1200.c:

* remove open-coded variant of ide_dma_host_off() (== ->dma_host_off),
  it is not needed because ->dma_off_quietly calls ->dma_host_off

* use ->dma_host_on (== ide_dma_host_on() for this driver) instead of
  open-coded variant, call it from the users of sc1200_config_dma2()

  [ there is no need to call ->dma_host_on in sc1200_config_dma() because
    core code takes care of calling ->ide_dma_on on successful execution
    of ->ide_dma_check ]

* add comment about ->tuneproc interface abuse

cs5530.c/sc1200.c:

* core code takes care of calling ->dma_off_quietly before calling
  ->ide_dma_check so there is no need to call it in ->ide_dma_check methods

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/cs5530.c |    7 +------
 drivers/ide/pci/sc1200.c |   27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 21 deletions(-)

Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.71	Mar 10 2007
+ * linux/drivers/ide/pci/cs5530.c		Version 0.72	Mar 10 2007
  *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
@@ -141,11 +141,6 @@ static int cs5530_config_dma(ide_drive_t
 	unsigned long basereg;
 	u8 unit = drive->dn & 1, mode = 0;
 
-	/*
-	 * Default to DMA-off in case we run into trouble here.
-	 */
-	hwif->dma_off_quietly(drive);
-
 	if (ide_use_dma(drive))
 		mode = ide_max_dma_mode(drive);
 
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.92	Mar 10 2007
+ * linux/drivers/ide/pci/sc1200.c		Version 0.93	Mar 10 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
@@ -137,12 +137,6 @@ static int sc1200_config_dma2 (ide_drive
 	unsigned int		basereg = hwif->channel ? 0x50 : 0x40;
 
 	/*
-	 * Default to DMA-off in case we run into trouble here.
-	 */
-	hwif->dma_off_quietly(drive);	/* turn off DMA while we fiddle */
-	outb(inb(hwif->dma_base+2)&~(unit?0x40:0x20), hwif->dma_base+2); /* clear DMA_capable bit */
-
-	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
 	if (!mode || sc1200_set_xfer_mode(drive, mode)) {
@@ -217,8 +211,6 @@ static int sc1200_config_dma2 (ide_drive
 		pci_write_config_dword(hwif->pci_dev, basereg+12, timings);
 	}
 
-	outb(inb(hwif->dma_base+2)|(unit?0x40:0x20), hwif->dma_base+2);	/* set DMA_capable bit */
-
 	return 0;	/* success */
 }
 
@@ -277,6 +269,9 @@ static void sc1200_tuneproc (ide_drive_t
 	static byte	modes[5] = {XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3, XFER_PIO_4};
 	int		mode = -1;
 
+	/*
+	 * bad abuse of ->tuneproc interface
+	 */
 	switch (pio) {
 		case 200: mode = XFER_UDMA_0;	break;
 		case 201: mode = XFER_UDMA_1;	break;
@@ -287,7 +282,9 @@ static void sc1200_tuneproc (ide_drive_t
 	}
 	if (mode != -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
-		(void)sc1200_config_dma2(drive, mode);
+		hwif->dma_off_quietly(drive);
+		if (sc1200_config_dma2(drive, mode) == 0)
+			hwif->dma_host_on(drive);
 		return;
 	}
 
@@ -421,12 +418,12 @@ static int sc1200_resume (struct pci_dev
 		for (d = 0; d < MAX_DRIVES; ++d) {
 			ide_drive_t *drive = &(hwif->drives[d]);
 			if (drive->present && !__ide_dma_bad_drive(drive)) {
-				int was_using_dma = drive->using_dma;
+				int enable_dma = drive->using_dma;
 				hwif->dma_off_quietly(drive);
-				sc1200_config_dma(drive);
-				if (!was_using_dma && drive->using_dma) {
-					hwif->dma_off_quietly(drive);
-				}
+				if (sc1200_config_dma(drive))
+					enable_dma = 0;
+				if (enable_dma)
+					hwif->dma_host_on(drive);
 			}
 		}
 	}
