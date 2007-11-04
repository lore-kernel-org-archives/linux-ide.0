From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/18] ide: add ide_tf_read() helper
Date: Mon, 5 Nov 2007 00:21:50 +0100
Message-ID: <200711050021.50748.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbXKDX3j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:39 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Factor out code reading taskfile registers from ide_end_drive_cmd()
  to the new ide_tf_read() helper.

* Add IDE_TFLAG_IN_* taskfile flags to indicate the need to load
  particular IDE taskfile register in ide_tf_read().

* Update ide_end_drive_cmd() to set respective IDE_TFLAG_IN_* taksfile flags.

* Add ide_get_lba_addr() for getting LBA sector address from taskfile struct.

* Factor out code getting sector address from ide_dump_ata_status()
  to the new ide_dump_sector() function.

* Convert ide_dump_sector() to use ide_tf_read() and ide_get_lba_addr().

* Remove no longer needed ide_read_24().

The only change in functionality caused by this patch is that
ide_dump_ata_status() no longer prints "high"/"low" parts of LBA48
sector address (of course LBA48 sector address is still printed).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |   68 +++++++++++++++++++++++++++++++++---------------
 drivers/ide/ide-iops.c |    8 -----
 drivers/ide/ide-lib.c  |   69 ++++++++++++++++++++++++++-----------------------
 include/linux/ide.h    |   24 +++++++++++++++--
 4 files changed, 106 insertions(+), 63 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -297,6 +297,48 @@ static void ide_complete_pm_request (ide
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
+void ide_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_taskfile *tf = &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u16 data = hwif->INW(IDE_DATA_REG);
+
+		tf->data = data & 0xff;
+		tf->hob_data = (data >> 8) & 0xff;
+	}
+
+	/* be sure we're looking at the low order bits */
+	hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
+
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  = hwif->INB(IDE_NSECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   = hwif->INB(IDE_SECTOR_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   = hwif->INB(IDE_LCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   = hwif->INB(IDE_HCYL_REG);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device = hwif->INB(IDE_SELECT_REG);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		hwif->OUTB(drive->ctl | 0x80, IDE_CONTROL_REG);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature = hwif->INB(IDE_FEATURE_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   = hwif->INB(IDE_NSECTOR_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    = hwif->INB(IDE_SECTOR_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    = hwif->INB(IDE_LCYL_REG);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    = hwif->INB(IDE_HCYL_REG);
+	}
+}
+
 /**
  *	ide_end_drive_cmd	-	end an explicit drive command
  *	@drive: command 
@@ -339,30 +381,14 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		if (args) {
 			struct ide_taskfile *tf = &args->tf;
 
-			if (args->tf_flags & IDE_TFLAG_IN_DATA) {
-				u16 data = hwif->INW(IDE_DATA_REG);
-
-				tf->data = data & 0xff;
-				tf->hob_data = (data >> 8) & 0xff;
-			}
 			tf->error = err;
-			/* be sure we're looking at the low order bits */
-			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			tf->nsect  = hwif->INB(IDE_NSECTOR_REG);
-			tf->lbal   = hwif->INB(IDE_SECTOR_REG);
-			tf->lbam   = hwif->INB(IDE_LCYL_REG);
-			tf->lbah   = hwif->INB(IDE_HCYL_REG);
-			tf->device = hwif->INB(IDE_SELECT_REG);
 			tf->status = stat;
 
-			if (args->tf_flags & IDE_TFLAG_LBA48) {
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				tf->hob_feature = hwif->INB(IDE_FEATURE_REG);
-				tf->hob_nsect   = hwif->INB(IDE_NSECTOR_REG);
-				tf->hob_lbal    = hwif->INB(IDE_SECTOR_REG);
-				tf->hob_lbam    = hwif->INB(IDE_LCYL_REG);
-				tf->hob_lbah    = hwif->INB(IDE_HCYL_REG);
-			}
+			args->tf_flags |= (IDE_TFLAG_IN_TF|IDE_TFLAG_IN_DEVICE);
+			if (args->tf_flags & IDE_TFLAG_LBA48)
+				args->tf_flags |= IDE_TFLAG_IN_HOB;
+
+			ide_tf_read(drive, args);
 		}
 	} else if (blk_pm_request(rq)) {
 		struct request_pm_state *pm = rq->data;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -158,14 +158,6 @@ void default_hwif_mmiops (ide_hwif_t *hw
 
 EXPORT_SYMBOL(default_hwif_mmiops);
 
-u32 ide_read_24 (ide_drive_t *drive)
-{
-	u8 sect = HWIF(drive)->INB(IDE_SECTOR_REG);
-	u8 lcyl = HWIF(drive)->INB(IDE_LCYL_REG);
-	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
-	return (hcyl<<16)|(lcyl<<8)|sect;
-}
-
 void SELECT_DRIVE (ide_drive_t *drive)
 {
 	if (HWIF(drive)->selectproc)
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -476,6 +476,42 @@ static void ide_dump_opcode(ide_drive_t 
 		printk("0x%02x\n", opcode);
 }
 
+static u64 ide_get_lba_addr(struct ide_taskfile *tf, int lba48)
+{
+	u32 high, low;
+
+	if (lba48)
+		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
+			tf->hob_lbal;
+	else
+		high = tf->device & 0xf;
+	low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+
+	return ((u64)high << 24) | low;
+}
+
+static void ide_dump_sector(ide_drive_t *drive)
+{
+	ide_task_t task;
+	struct ide_taskfile *tf = &task.tf;
+	int lba48 = (drive->addressing == 1) ? 1 : 0;
+
+	memset(&task, 0, sizeof(task));
+	if (lba48)
+		task.tf_flags = IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_HOB_LBA |
+				IDE_TFLAG_LBA48;
+	else
+		task.tf_flags = IDE_TFLAG_IN_LBA | IDE_TFLAG_IN_DEVICE;
+
+	ide_tf_read(drive, &task);
+
+	if (lba48 || (tf->device & ATA_LBA))
+		printk(", LBAsect=%llu", ide_get_lba_addr(tf, lba48));
+	else
+		printk(", CHS=%d/%d/%d", (tf->lbah << 8) + tf->lbam,
+					 tf->device & 0xf, tf->lbal);
+}
+
 static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -509,38 +545,7 @@ static u8 ide_dump_ata_status(ide_drive_
 		printk("}");
 		if ((err & (BBD_ERR | ABRT_ERR)) == BBD_ERR ||
 		    (err & (ECC_ERR|ID_ERR|MARK_ERR))) {
-			if (drive->addressing == 1) {
-				__u64 sectors = 0;
-				u32 low = 0, high = 0;
-				hwif->OUTB(drive->ctl&~0x80, IDE_CONTROL_REG);
-				low = ide_read_24(drive);
-				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				high = ide_read_24(drive);
-				sectors = ((__u64)high << 24) | low;
-				printk(", LBAsect=%llu, high=%d, low=%d",
-				       (unsigned long long) sectors,
-				       high, low);
-			} else {
-				u8 sector, lcyl, hcyl, cur;
-
-				sector = hwif->INB(IDE_SECTOR_REG);
-				lcyl   = hwif->INB(IDE_LCYL_REG);
-				hcyl   = hwif->INB(IDE_HCYL_REG);
-				cur    = hwif->INB(IDE_SELECT_REG);
-
-				if (cur & 0x40) {	/* using LBA? */
-					printk(", LBAsect=%ld", (unsigned long)
-						((cur & 0xf) << 24) |
-						(hcyl << 16) |
-						(lcyl <<  8) |
-						sector);
-				} else {
-					printk(", CHS=%d/%d/%d",
-						(hcyl << 8) + lcyl,
-						cur & 0xf,
-						sector);
-				}
-			}
+			ide_dump_sector(drive);
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
 				printk(", sector=%llu",
 					(unsigned long long)HWGROUP(drive)->rq->sector);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -913,6 +913,27 @@ enum {
 	IDE_TFLAG_IN_DATA		= (1 << 17),
 	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 18),
 	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 19),
+	IDE_TFLAG_IN_HOB_FEATURE	= (1 << 20),
+	IDE_TFLAG_IN_HOB_NSECT		= (1 << 21),
+	IDE_TFLAG_IN_HOB_LBAL		= (1 << 22),
+	IDE_TFLAG_IN_HOB_LBAM		= (1 << 23),
+	IDE_TFLAG_IN_HOB_LBAH		= (1 << 24),
+	IDE_TFLAG_IN_HOB_LBA		= IDE_TFLAG_IN_HOB_LBAL |
+					  IDE_TFLAG_IN_HOB_LBAM |
+					  IDE_TFLAG_IN_HOB_LBAH,
+	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_FEATURE |
+					  IDE_TFLAG_IN_HOB_NSECT |
+					  IDE_TFLAG_IN_HOB_LBA,
+	IDE_TFLAG_IN_NSECT		= (1 << 25),
+	IDE_TFLAG_IN_LBAL		= (1 << 26),
+	IDE_TFLAG_IN_LBAM		= (1 << 27),
+	IDE_TFLAG_IN_LBAH		= (1 << 28),
+	IDE_TFLAG_IN_LBA		= IDE_TFLAG_IN_LBAL |
+					  IDE_TFLAG_IN_LBAM |
+					  IDE_TFLAG_IN_LBAH,
+	IDE_TFLAG_IN_TF			= IDE_TFLAG_IN_NSECT |
+					  IDE_TFLAG_IN_LBA,
+	IDE_TFLAG_IN_DEVICE		= (1 << 29),
 };
 
 struct ide_taskfile {
@@ -956,8 +977,7 @@ typedef struct ide_task_s {
 } ide_task_t;
 
 void ide_tf_load(ide_drive_t *, ide_task_t *);
-
-extern u32 ide_read_24(ide_drive_t *);
+void ide_tf_read(ide_drive_t *, ide_task_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
 extern void SELECT_MASK(ide_drive_t *, int);
