From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: move ide_map_sg() call out of ->dma_setup method (take 2)
Date: Wed, 11 Mar 2009 21:23:43 +0400
Message-ID: <200903112023.43307.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5245 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754170AbZCKRXF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 13:23:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Move ide_map_sg() call from ->dma_setup implementations and
ide_destroy_dmatable() one from *_build_dmatable() to ide_dma_prepare().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Removed 'use_pio_instead' labels and replaced 'goto' with 'return 0' --
that required no changes to the follow-up patches...

 drivers/ide/au1xxx-ide.c  |    9 ++-------
 drivers/ide/ide-dma-sff.c |    2 --
 drivers/ide/ide-dma.c     |    8 ++++++--
 drivers/ide/pmac.c        |   11 +++--------
 drivers/ide/scc_pata.c    |    4 +---
 drivers/ide/sgiioc4.c     |    9 ++-------
 drivers/ide/trm290.c      |    5 ++---
 drivers/ide/tx4939ide.c   |    6 +-----
 8 files changed, 17 insertions(+), 37 deletions(-)

Index: linux-2.6/drivers/ide/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/au1xxx-ide.c
+++ linux-2.6/drivers/ide/au1xxx-ide.c
@@ -236,7 +236,7 @@ static int auide_build_dmatable(ide_driv
 			if (++count >= PRD_ENTRIES) {
 				printk(KERN_WARNING "%s: DMA table too small\n",
 				       drive->name);
-				goto use_pio_instead;
+				return 0;
 			}
 
 			/* Lets enable intr for the last descriptor only */
@@ -272,9 +272,6 @@ static int auide_build_dmatable(ide_driv
 	if (count)
 		return 1;
 
- use_pio_instead:
-	ide_destroy_dmatable(drive);
-
 	return 0; /* revert to PIO for this request */
 }
 
@@ -290,10 +287,8 @@ static void auide_dma_start(ide_drive_t 
 
 static int auide_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
 {
-	if (auide_build_dmatable(drive, cmd) == 0) {
-		ide_map_sg(drive, cmd);
+	if (auide_build_dmatable(drive, cmd) == 0)
 		return 1;
-	}
 
 	drive->waiting_for_dma = 1;
 	return 0;
Index: linux-2.6/drivers/ide/ide-dma-sff.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma-sff.c
+++ linux-2.6/drivers/ide/ide-dma-sff.c
@@ -165,8 +165,6 @@ use_pio_instead:
 	printk(KERN_ERR "%s: %s\n", drive->name,
 		count ? "DMA table too small" : "empty DMA table?");
 
-	ide_destroy_dmatable(drive);
-
 	return 0; /* revert to PIO for this request */
 }
 EXPORT_SYMBOL_GPL(ide_build_dmatable);
Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -566,8 +566,12 @@ int ide_dma_prepare(ide_drive_t *drive, 
 
 	if ((drive->dev_flags & IDE_DFLAG_USING_DMA) == 0 ||
 	    (dma_ops->dma_check && dma_ops->dma_check(drive, cmd)) ||
-	    ide_build_sglist(drive, cmd) == 0 ||
-	    dma_ops->dma_setup(drive, cmd))
+	    ide_build_sglist(drive, cmd) == 0)
 		return 1;
+	if (dma_ops->dma_setup(drive, cmd)) {
+		ide_destroy_dmatable(drive);
+		ide_map_sg(drive, cmd);
+		return 1;
+	}
 	return 0;
 }
Index: linux-2.6/drivers/ide/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/pmac.c
+++ linux-2.6/drivers/ide/pmac.c
@@ -1455,7 +1455,7 @@ static int pmac_ide_build_dmatable(ide_d
 				       "switching to PIO on Ohare chipset\n", drive->name);
 				pmif->broken_dma_warn = 1;
 			}
-			goto use_pio_instead;
+			return 0;
 		}
 		while (cur_len) {
 			unsigned int tc = (cur_len < 0xfe00)? cur_len: 0xfe00;
@@ -1463,7 +1463,7 @@ static int pmac_ide_build_dmatable(ide_d
 			if (count++ >= MAX_DCMDS) {
 				printk(KERN_WARNING "%s: DMA table too small\n",
 				       drive->name);
-				goto use_pio_instead;
+				return 0;
 			}
 			st_le16(&table->command, wr? OUTPUT_MORE: INPUT_MORE);
 			st_le16(&table->req_count, tc);
@@ -1492,9 +1492,6 @@ static int pmac_ide_build_dmatable(ide_d
 
 	printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
 
-use_pio_instead:
-	ide_destroy_dmatable(drive);
-
 	return 0; /* revert to PIO for this request */
 }
 
@@ -1510,10 +1507,8 @@ static int pmac_ide_dma_setup(ide_drive_
 	u8 unit = drive->dn & 1, ata4 = (pmif->kind == controller_kl_ata4);
 	u8 write = !!(cmd->tf_flags & IDE_TFLAG_WRITE);
 
-	if (pmac_ide_build_dmatable(drive, cmd) == 0) {
-		ide_map_sg(drive, cmd);
+	if (pmac_ide_build_dmatable(drive, cmd) == 0)
 		return 1;
-	}
 
 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -321,10 +321,8 @@ static int scc_dma_setup(ide_drive_t *dr
 	u8 dma_stat;
 
 	/* fall back to pio! */
-	if (ide_build_dmatable(drive, cmd) == 0) {
-		ide_map_sg(drive, cmd);
+	if (ide_build_dmatable(drive, cmd) == 0)
 		return 1;
-	}
 
 	/* PRD table */
 	out_be32((void __iomem *)(hwif->dma_base + 8), hwif->dmatable_dma);
Index: linux-2.6/drivers/ide/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/sgiioc4.c
+++ linux-2.6/drivers/ide/sgiioc4.c
@@ -442,7 +442,7 @@ static int sgiioc4_build_dmatable(ide_dr
 				printk(KERN_WARNING
 				       "%s: DMA table too small\n",
 				       drive->name);
-				goto use_pio_instead;
+				return 0;
 			} else {
 				u32 bcount =
 				    0x10000 - (cur_addr & 0xffff);
@@ -477,9 +477,6 @@ static int sgiioc4_build_dmatable(ide_dr
 		return count;
 	}
 
-use_pio_instead:
-	ide_destroy_dmatable(drive);
-
 	return 0;		/* revert to PIO for this request */
 }
 
@@ -488,11 +485,9 @@ static int sgiioc4_dma_setup(ide_drive_t
 	int ddir;
 	u8 write = !!(cmd->tf_flags & IDE_TFLAG_WRITE);
 
-	if (sgiioc4_build_dmatable(drive, cmd) == 0) {
+	if (sgiioc4_build_dmatable(drive, cmd) == 0)
 		/* try PIO instead of DMA */
-		ide_map_sg(drive, cmd);
 		return 1;
-	}
 
 	if (write)
 		/* Writes TO the IOC4 FROM Main Memory */
Index: linux-2.6/drivers/ide/trm290.c
===================================================================
--- linux-2.6.orig/drivers/ide/trm290.c
+++ linux-2.6/drivers/ide/trm290.c
@@ -193,11 +193,10 @@ static int trm290_dma_setup(ide_drive_t 
 	unsigned int count, rw = (cmd->tf_flags & IDE_TFLAG_WRITE) ? 1 : 2;
 
 	count = ide_build_dmatable(drive, cmd);
-	if (count == 0) {
-		ide_map_sg(drive, cmd);
+	if (count == 0)
 		/* try PIO instead of DMA */
 		return 1;
-	}
+
 	outl(hwif->dmatable_dma | rw, hwif->dma_base);
 	drive->waiting_for_dma = 1;
 	/* start DMA */
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -279,8 +279,6 @@ use_pio_instead:
 	printk(KERN_ERR "%s: %s\n", drive->name,
 		count ? "DMA table too small" : "empty DMA table?");
 
-	ide_destroy_dmatable(drive);
-
 	return 0; /* revert to PIO for this request */
 }
 #else
@@ -294,10 +292,8 @@ static int tx4939ide_dma_setup(ide_drive
 	u8 rw = (cmd->tf_flags & IDE_TFLAG_WRITE) ? 0 : ATA_DMA_WR;
 
 	/* fall back to PIO! */
-	if (tx4939ide_build_dmatable(drive, cmd) == 0) {
-		ide_map_sg(drive, cmd);
+	if (tx4939ide_build_dmatable(drive, cmd) == 0)
 		return 1;
-	}
 
 	/* PRD table */
 	tx4939ide_writel(hwif->dmatable_dma, base, TX4939IDE_PRD_Ptr);

