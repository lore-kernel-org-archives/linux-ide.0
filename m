From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/19] au1xxx-ide: remove dead code
Date: Fri, 12 Jan 2007 05:26:52 +0100
Message-ID: <20070112042652.28794.54747.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030479AbXALEXa@vger.kernel.org>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[PATCH] au1xxx-ide: remove dead code

'speed' is always equal to 'mode' when ide_config_drive_speed() is called

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/mips/au1xxx-ide.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

Index: a/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a.orig/drivers/ide/mips/au1xxx-ide.c
+++ a/drivers/ide/mips/au1xxx-ide.c
@@ -181,12 +181,6 @@ static int auide_tune_chipset (ide_drive
 {
 	int mem_sttime;
 	int mem_stcfg;
-	unsigned long mode;
-
-#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-	if (ide_use_dma(drive))
-		mode = ide_dma_speed(drive, 0);
-#endif
 
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
@@ -195,7 +189,7 @@ static int auide_tune_chipset (ide_drive
 		auide_tune_drive(drive, speed - XFER_PIO_0);
 		return 0;
 	}
-	      
+
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	case XFER_MW_DMA_2:
@@ -207,7 +201,6 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA2_TCSOE | SBC_IDE_MDMA2_TOECS;
 
-		mode = XFER_MW_DMA_2;
 		break;
 	case XFER_MW_DMA_1:
 		mem_sttime = SBC_IDE_TIMING(MDMA1);
@@ -218,7 +211,6 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA1_TCSOE | SBC_IDE_MDMA1_TOECS;
 
-		mode = XFER_MW_DMA_1;
 		break;
 	case XFER_MW_DMA_0:
 		mem_sttime = SBC_IDE_TIMING(MDMA0);
@@ -229,14 +221,13 @@ static int auide_tune_chipset (ide_drive
 		mem_stcfg &= ~TOECS_MASK;
 		mem_stcfg |= SBC_IDE_MDMA0_TCSOE | SBC_IDE_MDMA0_TOECS;
 
-		mode = XFER_MW_DMA_0;
 		break;
 #endif
 	default:
 		return 1;
 	}
-	
-	if (ide_config_drive_speed(drive, mode))
+
+	if (ide_config_drive_speed(drive, speed))
 		return 1;
 
 	au_writel(mem_sttime,MEM_STTIME2);
