From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/12] ide-disk: use struct ide_taskfile in __ide_do_rw_disk()
Date: Mon, 8 Oct 2007 23:15:49 +0200
Message-ID: <200710082315.49176.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:60050 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbXJHVjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:55 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370238nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


Based on the earlier work by Tejun Heo.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   87 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -166,6 +166,7 @@ static ide_startstop_t __ide_do_rw_disk(
 	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
 	u8 command		= WIN_NOP;
 	ata_nsector_t		nsectors;
+	struct ide_taskfile ltf, *tf = &ltf;
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
@@ -186,53 +187,36 @@ static ide_startstop_t __ide_do_rw_disk(
 
 	/* FIXME: SELECT_MASK(drive, 0) ? */
 
+	memset(tf, 0, sizeof(*tf));
+
 	if (drive->select.b.lba) {
 		if (lba48) {
-			u8 tasklets[10];
-
 			pr_debug("%s: LBA=0x%012llx\n", drive->name,
 					(unsigned long long)block);
 
-			tasklets[0] = 0;
-			tasklets[1] = 0;
-			tasklets[2] = nsectors.b.low;
-			tasklets[3] = nsectors.b.high;
-			tasklets[4] = (u8) block;
-			tasklets[5] = (u8)(block >>  8);
-			tasklets[6] = (u8)(block >> 16);
-			tasklets[7] = (u8)(block >> 24);
-			if (sizeof(block) == 4) {
-				tasklets[8] = 0;
-				tasklets[9] = 0;
-			} else {
-				tasklets[8] = (u8)((u64)block >> 32);
-				tasklets[9] = (u8)((u64)block >> 40);
+			tf->hob_nsect = nsectors.b.high;
+			tf->hob_lbal  = (u8)(block >> 24);
+			if (sizeof(block) != 4) {
+				tf->hob_lbam = (u8)((u64)block >> 32);
+				tf->hob_lbah = (u8)((u64)block >> 40);
 			}
+
+			tf->nsect  = nsectors.b.low;
+			tf->lbal   = (u8) block;
+			tf->lbam   = (u8)(block >>  8);
+			tf->lbah   = (u8)(block >> 16);
 #ifdef DEBUG
 			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tasklets[3], tasklets[2],
-				tasklets[9], tasklets[8], tasklets[7],
-				tasklets[6], tasklets[5], tasklets[4]);
+				drive->name, tf->hob_nsect, tf->nsect,
+				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
+				tf->lbah, tf->lbam, tf->lbal);
 #endif
-			hwif->OUTB(tasklets[1], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[3], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[7], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[8], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[9], IDE_HCYL_REG);
-
-			hwif->OUTB(tasklets[0], IDE_FEATURE_REG);
-			hwif->OUTB(tasklets[2], IDE_NSECTOR_REG);
-			hwif->OUTB(tasklets[4], IDE_SECTOR_REG);
-			hwif->OUTB(tasklets[5], IDE_LCYL_REG);
-			hwif->OUTB(tasklets[6], IDE_HCYL_REG);
-			hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
 		} else {
-			hwif->OUTB(0x00, IDE_FEATURE_REG);
-			hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-			hwif->OUTB(block, IDE_SECTOR_REG);
-			hwif->OUTB(block>>=8, IDE_LCYL_REG);
-			hwif->OUTB(block>>=8, IDE_HCYL_REG);
-			hwif->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
+			tf->nsect  = nsectors.b.low;
+			tf->lbal   = block;
+			tf->lbam   = block >>= 8;
+			tf->lbah   = block >>= 8;
+			tf->device = (block >> 8) & 0xf;
 		}
 	} else {
 		unsigned int sect,head,cyl,track;
@@ -243,13 +227,28 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
 
-		hwif->OUTB(0x00, IDE_FEATURE_REG);
-		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
-		hwif->OUTB(sect, IDE_SECTOR_REG);
-		hwif->OUTB(cyl, IDE_LCYL_REG);
-		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
-		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
-	}
+		tf->nsect  = nsectors.b.low;
+		tf->lbal   = sect;
+		tf->lbam   = cyl;
+		tf->lbah   = cyl >> 8;
+		tf->device = head;
+	}
+
+	if (drive->select.b.lba && lba48) {
+		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
+	}
+
+	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
+
+	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
 
 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
