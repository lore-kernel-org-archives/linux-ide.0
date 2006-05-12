From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide_dma_speed() fixes
Date: Fri, 12 May 2006 06:36:56 +0400
Message-ID: <4463F4C8.9080608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020309060805090308040407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:38110 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750867AbWELCh7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 22:37:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020309060805090308040407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    ide_dma_speed() fails to actually honor the IDE drivers' mode support 
masks) because of the bogus checks -- thus, selecting the DMA transfer mode 
that the driver explicitly refuses to support is possible. Additionally, there 
is no check for validity of the UltraDMA mode data in the drive ID, and the 
function is misdocumented.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------020309060805090308040407
Content-Type: text/plain;
 name="ide_dma_speed-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_dma_speed-fix.patch"

Index: linus/drivers/ide/ide-lib.c
===================================================================
--- linus.orig/drivers/ide/ide-lib.c
+++ linus/drivers/ide/ide-lib.c
@@ -72,66 +72,65 @@ EXPORT_SYMBOL(ide_xfer_verbose);
 /**
  *	ide_dma_speed	-	compute DMA speed
  *	@drive: drive
- *	@mode; intended mode
+ *	@mode:	modes available
  *
  *	Checks the drive capabilities and returns the speed to use
- *	for the transfer. Returns -1 if the requested mode is unknown
- *	(eg PIO)
+ *	for the DMA transfer.  Returns 0 if the drive is incapable
+ *	of DMA transfers.
  */
  
 u8 ide_dma_speed(ide_drive_t *drive, u8 mode)
 {
 	struct hd_driveid *id   = drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
+	u8 ultra_mask, mwdma_mask, swdma_mask;
 	u8 speed = 0;
 
 	if (drive->media != ide_disk && hwif->atapi_dma == 0)
 		return 0;
 
-	switch(mode) {
-		case 0x04:
-			if ((id->dma_ultra & 0x0040) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+	/* Capable of UltraDMA modes? */
+	if (id->field_valid & 4)
+		ultra_mask = id->dma_ultra & hwif->ultra_mask;
+	else
+		mode = 0;	/* fallback to MW/SW DMA if no UltraDMA */
+
+	switch (mode) {
+		case 4:
+			if (ultra_mask & 0x40)
 				{ speed = XFER_UDMA_6; break; }
-		case 0x03:
-			if ((id->dma_ultra & 0x0020) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+		case 3:
+			if (ultra_mask & 0x20)
 				{ speed = XFER_UDMA_5; break; }
-		case 0x02:
-			if ((id->dma_ultra & 0x0010) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+		case 2:
+			if (ultra_mask & 0x10)
 				{ speed = XFER_UDMA_4; break; }
-			if ((id->dma_ultra & 0x0008) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+			if (ultra_mask & 0x08)
 				{ speed = XFER_UDMA_3; break; }
-		case 0x01:
-			if ((id->dma_ultra & 0x0004) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+		case 1:
+			if (ultra_mask & 0x04)
 				{ speed = XFER_UDMA_2; break; }
-			if ((id->dma_ultra & 0x0002) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+			if (ultra_mask & 0x02)
 				{ speed = XFER_UDMA_1; break; }
-			if ((id->dma_ultra & 0x0001) &&
-			    (id->dma_ultra & hwif->ultra_mask))
+			if (ultra_mask & 0x01)
 				{ speed = XFER_UDMA_0; break; }
-		case 0x00:
-			if ((id->dma_mword & 0x0004) &&
-			    (id->dma_mword & hwif->mwdma_mask))
+		case 0:
+			mwdma_mask = id->dma_mword & hwif->mwdma_mask;
+
+			if (mwdma_mask & 0x04)
 				{ speed = XFER_MW_DMA_2; break; }
-			if ((id->dma_mword & 0x0002) &&
-			    (id->dma_mword & hwif->mwdma_mask))
+			if (mwdma_mask & 0x02)
 				{ speed = XFER_MW_DMA_1; break; }
-			if ((id->dma_mword & 0x0001) &&
-			    (id->dma_mword & hwif->mwdma_mask))
+			if (mwdma_mask & 0x01)
 				{ speed = XFER_MW_DMA_0; break; }
-			if ((id->dma_1word & 0x0004) &&
-			    (id->dma_1word & hwif->swdma_mask))
+
+			swdma_mask = id->dma_1word & hwif->swdma_mask;
+
+			if (swdma_mask & 0x04)
 				{ speed = XFER_SW_DMA_2; break; }
-			if ((id->dma_1word & 0x0002) &&
-			    (id->dma_1word & hwif->swdma_mask))
+			if (swdma_mask & 0x02)
 				{ speed = XFER_SW_DMA_1; break; }
-			if ((id->dma_1word & 0x0001) &&
-			    (id->dma_1word & hwif->swdma_mask))
+			if (swdma_mask & 0x01)
 				{ speed = XFER_SW_DMA_0; break; }
 	}
 

--------------020309060805090308040407--
