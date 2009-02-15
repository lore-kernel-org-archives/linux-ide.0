From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 06/10] ide-disk: use flags query macros
Date: Sun, 15 Feb 2009 13:08:08 +0100
Message-ID: <1234699692-9452-7-git-send-email-petkovbb@gmail.com>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:29313 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbZBOMIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 07:08:20 -0500
In-Reply-To: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-disk.c      |   28 ++++++++++++++--------------
 drivers/ide/ide-disk_proc.c |    2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index ca934c8..011cdb3 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -99,7 +99,7 @@ static ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
 
-	if (drive->dev_flags & IDE_DFLAG_LBA) {
+	if (ide_drv_does_lba(drive)) {
 		if (lba48) {
 			pr_debug("%s: LBA=0x%012llx\n", drive->name,
 					(unsigned long long)block);
@@ -180,7 +180,7 @@ static ide_startstop_t ide_do_rw_disk(ide_drive_t *drive, struct request *rq,
 {
 	ide_hwif_t *hwif = drive->hwif;
 
-	BUG_ON(drive->dev_flags & IDE_DFLAG_BLOCKED);
+	BUG_ON(ide_drv_blocked(drive));
 
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "ide_do_rw_disk - bad command");
@@ -359,7 +359,7 @@ static int ide_disk_get_capacity(ide_drive_t *drive)
 	}
 
 	/* limit drive capacity to 137GB if LBA48 cannot be used */
-	if ((drive->dev_flags & IDE_DFLAG_LBA48) == 0 &&
+	if (!ide_drv_lba48(drive) &&
 	    drive->capacity64 > 1ULL << 28) {
 		printk(KERN_WARNING "%s: cannot use LBA48 - full capacity "
 		       "%llu sectors (%llu MB)\n",
@@ -369,7 +369,7 @@ static int ide_disk_get_capacity(ide_drive_t *drive)
 	}
 
 	if ((drive->hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA) &&
-	    (drive->dev_flags & IDE_DFLAG_LBA48)) {
+	    ide_drv_lba48(drive)) {
 		if (drive->capacity64 > 1ULL << 28) {
 			printk(KERN_INFO "%s: cannot use LBA48 DMA - PIO mode"
 					 " will be used for accessing sectors "
@@ -468,7 +468,7 @@ static void update_ordered(ide_drive_t *drive)
 	unsigned ordered = QUEUE_ORDERED_NONE;
 	prepare_flush_fn *prep_fn = NULL;
 
-	if (drive->dev_flags & IDE_DFLAG_WCACHE) {
+	if (ide_drv_wcache_enabled(drive)) {
 		unsigned long long capacity;
 		int barrier;
 		/*
@@ -481,8 +481,8 @@ static void update_ordered(ide_drive_t *drive)
 		 */
 		capacity = ide_gd_capacity(drive);
 		barrier = ata_id_flush_enabled(id) &&
-			(drive->dev_flags & IDE_DFLAG_NOFLUSH) == 0 &&
-			((drive->dev_flags & IDE_DFLAG_LBA48) == 0 ||
+			!ide_drv_noflush(drive) &&
+			(!ide_drv_lba48(drive) ||
 			 capacity <= (1ULL << 28) ||
 			 ata_id_flush_ext_enabled(id));
 
@@ -604,10 +604,10 @@ static void ide_disk_setup(ide_drive_t *drive)
 
 	ide_proc_register_driver(drive, idkp->driver);
 
-	if ((drive->dev_flags & IDE_DFLAG_ID_READ) == 0)
+	if (!ide_drv_id_read(drive))
 		return;
 
-	if (drive->dev_flags & IDE_DFLAG_REMOVABLE) {
+	if (ide_drv_removable(drive)) {
 		/*
 		 * Removable disks (eg. SYQUEST); ignore 'WD' drives
 		 */
@@ -617,7 +617,7 @@ static void ide_disk_setup(ide_drive_t *drive)
 
 	(void)set_addressing(drive, 1);
 
-	if (drive->dev_flags & IDE_DFLAG_LBA48) {
+	if (ide_drv_lba48(drive)) {
 		int max_s = 2048;
 
 		if (max_s > hwif->rqsize)
@@ -641,7 +641,7 @@ static void ide_disk_setup(ide_drive_t *drive)
 	 */
 	capacity = ide_gd_capacity(drive);
 
-	if ((drive->dev_flags & IDE_DFLAG_FORCED_GEOM) == 0) {
+	if (!ide_drv_forced_geom(drive)) {
 		if (ata_id_lba48_enabled(drive->id)) {
 			/* compatibility */
 			drive->bios_sect = 63;
@@ -680,7 +680,7 @@ static void ide_disk_setup(ide_drive_t *drive)
 
 	set_wcache(drive, 1);
 
-	if ((drive->dev_flags & IDE_DFLAG_LBA) == 0 &&
+	if (!ide_drv_does_lba(drive) &&
 	    (drive->head == 0 || drive->head > 16)) {
 		printk(KERN_ERR "%s: invalid geometry: %d physical heads?\n",
 			drive->name, drive->head);
@@ -692,7 +692,7 @@ static void ide_disk_setup(ide_drive_t *drive)
 static void ide_disk_flush(ide_drive_t *drive)
 {
 	if (ata_id_flush_enabled(drive->id) == 0 ||
-	    (drive->dev_flags & IDE_DFLAG_WCACHE) == 0)
+	    !ide_drv_wcache_enabled(drive))
 		return;
 
 	if (do_idedisk_flushcache(drive))
@@ -710,7 +710,7 @@ static int ide_disk_set_doorlock(ide_drive_t *drive, struct gendisk *disk,
 	struct ide_cmd cmd;
 	int ret;
 
-	if ((drive->dev_flags & IDE_DFLAG_DOORLOCKING) == 0)
+	if (!ide_drv_doorlocking(drive))
 		return 0;
 
 	memset(&cmd, 0, sizeof(cmd));
diff --git a/drivers/ide/ide-disk_proc.c b/drivers/ide/ide-disk_proc.c
index 3f2a078..bfe8cc1 100644
--- a/drivers/ide/ide-disk_proc.c
+++ b/drivers/ide/ide-disk_proc.c
@@ -42,7 +42,7 @@ static int proc_idedisk_read_cache
 	char		*out = page;
 	int		len;
 
-	if (drive->dev_flags & IDE_DFLAG_ID_READ)
+	if (ide_drv_id_read(drive))
 		len = sprintf(out, "%i\n", drive->id[ATA_ID_BUF_SIZE] / 2);
 	else
 		len = sprintf(out, "(none)\n");
-- 
1.6.0.4

