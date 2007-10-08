From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/12] ide: add struct ide_taskfile
Date: Mon, 8 Oct 2007 23:11:10 +0200
Message-ID: <200710082311.10925.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbXJHVjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:52 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370193nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


* Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hobRegister[7]
  in idedisk_set_max_address_ext().

* Add struct ide_taskfile and use it in ide_task_t instead of tfRegister[]
  and hobRegister[].

* Remove no longer needed IDE_CONTROL_OFFSET_HOB define.

* Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_struct_t.

While at it:

* Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.

There should be no functionality changes caused by this patch.

Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |  156 ++++++++++++++++++++++++---------------------
 drivers/ide/ide-io.c       |   80 +++++++++++++----------
 drivers/ide/ide-iops.c     |   12 +--
 drivers/ide/ide-lib.c      |    3
 drivers/ide/ide-acpi.c     |    8 ---
 drivers/ide/ide-disk.c     |  118 ++++++++++++++++++++-------------------------
 drivers/ide/ide-io.c       |   60 +++++++++++-----------
 drivers/ide/ide-iops.c     |   12 ++--
 drivers/ide/ide-lib.c      |    3 -
 drivers/ide/ide-taskfile.c |   99 +++++++++++++++++--------------------
 include/linux/hdreg.h      |    4 +
 include/linux/ide.h        |   36 +++++++++----
 8 files changed, 169 insertions(+), 171 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -354,13 +354,7 @@ static int taskfile_load_raw(ide_drive_t
 	args.handler      = &task_no_data_intr;
 
 	/* convert gtf to IDE Taskfile */
-	args.tfRegister[1] = gtf->tfa[0];	/* 0x1f1 */
-	args.tfRegister[2] = gtf->tfa[1];	/* 0x1f2 */
-	args.tfRegister[3] = gtf->tfa[2];	/* 0x1f3 */
-	args.tfRegister[4] = gtf->tfa[3];	/* 0x1f4 */
-	args.tfRegister[5] = gtf->tfa[4];	/* 0x1f5 */
-	args.tfRegister[6] = gtf->tfa[5];	/* 0x1f6 */
-	args.tfRegister[7] = gtf->tfa[6];	/* 0x1f7 */
+	memcpy(&args.tf_array[7], &gtf->tfa, 7);
 
 	if (ide_noacpitfs) {
 		DEBPRINT("_GTF execution disabled\n");
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -336,23 +336,22 @@ static ide_startstop_t ide_do_rw_disk (i
 static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 	unsigned long addr = 0;
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
+	tf->device  = ATA_LBA;
+	tf->command = WIN_READ_NATIVE_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		addr = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((tf->command & 0x01) == 0) {
+		addr = ((tf->device & 0xf) << 24) |
+		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
 	return addr;
@@ -361,26 +360,23 @@ static unsigned long idedisk_read_native
 static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 	unsigned long long addr = 0;
 
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-
-	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
+	tf->device  = ATA_LBA;
+	tf->command = WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((tf->command & 0x01) == 0) {
+		u32 high, low;
+		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr = ((__u64)high << 24) | low;
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
@@ -394,26 +390,25 @@ static unsigned long long idedisk_read_n
 static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 	unsigned long addr_set = 0;
 	
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>  8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >> 16) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
+	tf->lbal    =  (addr_req >>  0) & 0xff;
+	tf->lbam    =  (addr_req >>  8) & 0xff;
+	tf->lbah    =  (addr_req >> 16) & 0xff;
+	tf->device  = ((addr_req >> 24) & 0x0f) | ATA_LBA;
+	tf->command = WIN_SET_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		addr_set = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
-			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
-			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
-			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+	if ((tf->command & 0x01) == 0) {
+		addr_set = ((tf->device & 0xf) << 24) |
+		           (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr_set++;
 	}
 	return addr_set;
@@ -422,33 +417,29 @@ static unsigned long idedisk_set_max_add
 static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 	unsigned long long addr_set = 0;
 
 	addr_req--;
 	/* Create IDE/ATA command request structure */
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
-	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
-	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
-	args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX_EXT;
-	args.hobRegister[IDE_SECTOR_OFFSET]	= (addr_req >>= 8) & 0xff;
-	args.hobRegister[IDE_LCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
-	args.hobRegister[IDE_HCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
-	args.hobRegister[IDE_SELECT_OFFSET]	= 0x40;
-	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
+	tf->lbal     = (addr_req >>  0) & 0xff;
+	tf->lbam     = (addr_req >>= 8) & 0xff;
+	tf->lbah     = (addr_req >>= 8) & 0xff;
+	tf->device   = ATA_LBA;
+	tf->command  = WIN_SET_MAX_EXT;
+	tf->hob_lbal = (addr_req >>= 8) & 0xff;
+	tf->hob_lbam = (addr_req >>= 8) & 0xff;
+	tf->hob_lbah = (addr_req >>= 8) & 0xff;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
-	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
-		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
-			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
-			    args.hobRegister[IDE_SECTOR_OFFSET];
-		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
-			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
-			    (args.tfRegister[IDE_SECTOR_OFFSET]);
+	if ((tf->command & 0x01) == 0) {
+		u32 high, low;
+		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
 		addr_set = ((__u64)high << 24) | low;
 		addr_set++;
 	}
@@ -582,12 +573,13 @@ static sector_t idedisk_capacity (ide_dr
 static int smart_enable(ide_drive_t *drive)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_ENABLE;
-	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
+	tf->feature = SMART_ENABLE;
+	tf->lbam    = SMART_LCYL_PASS;
+	tf->lbah    = SMART_HCYL_PASS;
+	tf->command = WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -596,13 +588,14 @@ static int smart_enable(ide_drive_t *dri
 static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
 {
 	ide_task_t args;
+	struct ide_taskfile *tf = &args.tf;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= sub_cmd;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
-	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
-	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
+	tf->feature = sub_cmd;
+	tf->nsect   = 0x01;
+	tf->lbam    = SMART_LCYL_PASS;
+	tf->lbah    = SMART_HCYL_PASS;
+	tf->command = WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
 	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
@@ -808,9 +801,9 @@ static int write_cache(ide_drive_t *driv
 
 	if (ide_id_has_flush_cache(drive->id)) {
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
+		args.tf.feature = arg ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+		args.tf.command = WIN_SETFEATURES;
 		args.command_type		= IDE_DRIVE_TASK_NO_DATA;
 		args.handler			= &task_no_data_intr;
 		err = ide_raw_taskfile(drive, &args, NULL);
@@ -829,9 +822,9 @@ static int do_idedisk_flushcache (ide_dr
 
 	memset(&args, 0, sizeof(ide_task_t));
 	if (ide_id_has_flush_cache_ext(drive->id))
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
+		args.tf.command = WIN_FLUSH_CACHE_EXT;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
+		args.tf.command = WIN_FLUSH_CACHE;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
@@ -845,10 +838,9 @@ static int set_acoustic (ide_drive_t *dr
 		return -EINVAL;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ? SETFEATURES_EN_AAM :
-							  SETFEATURES_DIS_AAM;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.tf.feature = arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
+	args.tf.nsect   = arg;
+	args.tf.command = WIN_SETFEATURES;
 	args.command_type = IDE_DRIVE_TASK_NO_DATA;
 	args.handler	  = &task_no_data_intr;
 	ide_raw_taskfile(drive, &args, NULL);
@@ -1115,7 +1107,7 @@ static int idedisk_open(struct inode *in
 	if (drive->removable && idkp->openers == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
+		args.tf.command = WIN_DOORLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
@@ -1142,7 +1134,7 @@ static int idedisk_release(struct inode 
 	if (drive->removable && idkp->openers == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
-		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
+		args.tf.command = WIN_DOORUNLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -189,15 +189,15 @@ static ide_startstop_t ide_start_power_s
 			return ide_stopped;
 		}
 		if (ide_id_has_flush_cache_ext(drive->id))
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
+			args->tf.command = WIN_FLUSH_CACHE_EXT;
 		else
-			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
+			args->tf.command = WIN_FLUSH_CACHE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
+		args->tf.command = WIN_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
@@ -214,7 +214,7 @@ static ide_startstop_t ide_start_power_s
 		return ide_stopped;
 
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
-		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
+		args->tf.command = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
 		args->handler = task_no_data_intr;
 		return do_rw_taskfile(drive, args);
@@ -387,28 +387,30 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
 			
 		if (args) {
+			struct ide_taskfile *tf = &args->tf;
+
 			if (args->tf_in_flags.b.data) {
-				u16 data				= hwif->INW(IDE_DATA_REG);
-				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
-				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
+				u16 data = hwif->INW(IDE_DATA_REG);
+				tf->data = data & 0xff;
+				tf->hob_data = (data >> 8) & 0xff;
 			}
-			args->tfRegister[IDE_ERROR_OFFSET]   = err;
+			tf->feature = err;
 			/* be sure we're looking at the low order bits */
 			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
-			args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
-			args->tfRegister[IDE_SECTOR_OFFSET]  = hwif->INB(IDE_SECTOR_REG);
-			args->tfRegister[IDE_LCYL_OFFSET]    = hwif->INB(IDE_LCYL_REG);
-			args->tfRegister[IDE_HCYL_OFFSET]    = hwif->INB(IDE_HCYL_REG);
-			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
-			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
+			tf->nsect   = hwif->INB(IDE_NSECTOR_REG);
+			tf->lbal    = hwif->INB(IDE_SECTOR_REG);
+			tf->lbam    = hwif->INB(IDE_LCYL_REG);
+			tf->lbah    = hwif->INB(IDE_HCYL_REG);
+			tf->device  = hwif->INB(IDE_SELECT_REG);
+			tf->command = stat;
 
 			if (drive->addressing == 1) {
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
-				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
-				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
-				args->hobRegister[IDE_SECTOR_OFFSET]	= hwif->INB(IDE_SECTOR_REG);
-				args->hobRegister[IDE_LCYL_OFFSET]	= hwif->INB(IDE_LCYL_REG);
-				args->hobRegister[IDE_HCYL_OFFSET]	= hwif->INB(IDE_HCYL_REG);
+				tf->hob_feature = hwif->INB(IDE_FEATURE_REG);
+				tf->hob_nsect   = hwif->INB(IDE_NSECTOR_REG);
+				tf->hob_lbal    = hwif->INB(IDE_SECTOR_REG);
+				tf->hob_lbam    = hwif->INB(IDE_LCYL_REG);
+				tf->hob_lbah    = hwif->INB(IDE_HCYL_REG);
 			}
 		}
 	} else if (blk_pm_request(rq)) {
@@ -707,28 +709,28 @@ static ide_startstop_t drive_cmd_intr (i
 
 static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
-	task->tfRegister[IDE_SECTOR_OFFSET]  = drive->sect;
-	task->tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
-	task->tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
-	task->tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
-	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
+	task->tf.nsect   = drive->sect;
+	task->tf.lbal    = drive->sect;
+	task->tf.lbam    = drive->cyl;
+	task->tf.lbah    = drive->cyl >> 8;
+	task->tf.device  = ((drive->head - 1) | drive->select.all) & 0xBF;
+	task->tf.command = WIN_SPECIFY;
 
 	task->handler = &set_geometry_intr;
 }
 
 static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
-	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
+	task->tf.nsect   = drive->sect;
+	task->tf.command = WIN_RESTORE;
 
 	task->handler = &recal_intr;
 }
 
 static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
 {
-	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
-	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
+	task->tf.nsect   = drive->mult_req;
+	task->tf.command = WIN_SETMULT;
 
 	task->handler = &set_multmode_intr;
 }
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -635,9 +635,9 @@ no_80w:
 
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
+	if (args->tf.command == WIN_SETFEATURES &&
+	    args->tf.lbal > XFER_UDMA_2 &&
+	    args->tf.feature == SETFEATURES_XFER) {
 		if (eighty_ninty_three(drive) == 0) {
 			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
 					    "be set\n", drive->name);
@@ -655,9 +655,9 @@ int ide_ata66_check (ide_drive_t *drive,
  */
 int set_transfer (ide_drive_t *drive, ide_task_t *args)
 {
-	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
-	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
-	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
+	if (args->tf.command == WIN_SETFEATURES &&
+	    args->tf.lbal >= XFER_SW_DMA_0 &&
+	    args->tf.feature == SETFEATURES_XFER &&
 	    (drive->id->dma_ultra ||
 	     drive->id->dma_mword ||
 	     drive->id->dma_1word))
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -465,8 +465,7 @@ static void ide_dump_opcode(ide_drive_t 
 	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args = rq->special;
 		if (args) {
-			task_struct_t *tf = (task_struct_t *) args->tfRegister;
-			opcode = tf->command;
+			opcode = args->tf.command;
 			found = 1;
 		}
 	}
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -65,12 +65,13 @@ static void taskfile_output_data(ide_dri
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
+
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
+	args.tf.nsect = 0x01;
 	if (drive->media == ide_disk)
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_IDENTIFY;
+		args.tf.command = WIN_IDENTIFY;
 	else
-		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_PIDENTIFY;
+		args.tf.command = WIN_PIDENTIFY;
 	args.command_type = IDE_DRIVE_TASK_IN;
 	args.data_phase   = TASKFILE_IN;
 	args.handler	  = &task_in_intr;
@@ -80,8 +81,7 @@ int taskfile_lib_get_identify (ide_drive
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
+	struct ide_taskfile *tf = &task->tf;
 	u8 HIHI			= (drive->addressing == 1) ? 0xE0 : 0xEF;
 
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
@@ -92,35 +92,35 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	SELECT_MASK(drive, 0);
 
 	if (drive->addressing == 1) {
-		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
 	}
 
-	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
-	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
-	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
-	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
-	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
+	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
+	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
+	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
+	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
 
-	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
 
 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
-			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+			hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 			ndelay(400);	/* FIXME */
 			return task->prehandler(drive, task->rq);
 		}
-		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
+		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
 		return ide_started;
 	}
 
 	if (!drive->using_dma)
 		return ide_stopped;
 
-	switch (taskfile->command) {
+	switch (tf->command) {
 		case WIN_WRITEDMA_ONCE:
 		case WIN_WRITEDMA:
 		case WIN_WRITEDMA_EXT:
@@ -129,7 +129,7 @@ ide_startstop_t do_rw_taskfile (ide_driv
 		case WIN_READDMA_EXT:
 		case WIN_IDENTIFY_DMA:
 			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_exec_cmd(drive, tf->command);
 				hwif->dma_start(drive);
 				return ide_started;
 			}
@@ -472,7 +472,7 @@ static int ide_diag_taskfile(ide_drive_t
 	 */
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
-			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
+			rq.nr_sectors = (args->tf.hob_nsect << 8) | args->tf.nsect;
 		else
 			rq.nr_sectors = data_size / SECTOR_SIZE;
 
@@ -507,8 +507,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	ide_task_t		args;
 	u8 *outbuf		= NULL;
 	u8 *inbuf		= NULL;
-	u8 *argsptr		= args.tfRegister;
-	u8 *hobsptr		= args.hobRegister;
 	int err			= 0;
 	int tasksize		= sizeof(struct ide_task_request_s);
 	unsigned int taskin	= 0;
@@ -560,9 +558,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	}
 
 	memset(&args, 0, sizeof(ide_task_t));
-	memcpy(argsptr, req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
-	memcpy(hobsptr, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE);
 
+	memcpy(&args.tf_array[0], req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE - 2);
+	memcpy(&args.tf_array[6], req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
 	args.tf_in_flags  = req_task->in_flags;
 	args.tf_out_flags = req_task->out_flags;
 	args.data_phase   = req_task->data_phase;
@@ -616,8 +614,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 			goto abort;
 	}
 
-	memcpy(req_task->io_ports, &(args.tfRegister), HDIO_DRIVE_TASK_HDR_SIZE);
-	memcpy(req_task->hob_ports, &(args.hobRegister), HDIO_DRIVE_HOB_HDR_SIZE);
+	memcpy(req_task->hob_ports, &args.tf_array[0], HDIO_DRIVE_HOB_HDR_SIZE - 2);
+	memcpy(req_task->io_ports, &args.tf_array[6], HDIO_DRIVE_TASK_HDR_SIZE);
 	req_task->in_flags  = args.tf_in_flags;
 	req_task->out_flags = args.tf_out_flags;
 
@@ -675,6 +673,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	u8 xfer_rate = 0;
 	int argsize = 4;
 	ide_task_t tfargs;
+	struct ide_taskfile *tf = &tfargs.tf;
 
 	if (NULL == (void *) arg) {
 		struct request rq;
@@ -686,13 +685,10 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 		return -EFAULT;
 
 	memset(&tfargs, 0, sizeof(ide_task_t));
-	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
-	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];
-	tfargs.tfRegister[IDE_SECTOR_OFFSET]  = args[1];
-	tfargs.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
-	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
-	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];
+	tf->feature = args[2];
+	tf->nsect   = args[3];
+	tf->lbal    = args[1];
+	tf->command = args[0];
 
 	if (args[3]) {
 		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
@@ -754,8 +750,7 @@ int ide_task_ioctl (ide_drive_t *drive, 
 ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
-	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
+	struct ide_taskfile *tf = &task->tf;
 
 	if (task->data_phase == TASKFILE_MULTI_IN ||
 	    task->data_phase == TASKFILE_MULTI_OUT) {
@@ -785,34 +780,32 @@ ide_startstop_t flagged_taskfile (ide_dr
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	SELECT_MASK(drive, 0);
 
-	if (task->tf_out_flags.b.data) {
-		u16 data =  taskfile->data + (hobfile->data << 8);
-		hwif->OUTW(data, IDE_DATA_REG);
-	}
+	if (task->tf_out_flags.b.data)
+		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);
 
 	/* (ks) send hob registers first */
 	if (task->tf_out_flags.b.nsector_hob)
-		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
 	if (task->tf_out_flags.b.sector_hob)
-		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
+		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
 	if (task->tf_out_flags.b.lcyl_hob)
-		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
+		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
 	if (task->tf_out_flags.b.hcyl_hob)
-		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
 
 	/* (ks) Send now the standard registers */
 	if (task->tf_out_flags.b.error_feature)
-		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
 	/* refers to number of sectors to transfer */
 	if (task->tf_out_flags.b.nsector)
-		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
 	/* refers to sector offset or start sector */
 	if (task->tf_out_flags.b.sector)
-		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
+		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
 	if (task->tf_out_flags.b.lcyl)
-		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
+		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
 	if (task->tf_out_flags.b.hcyl)
-		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
+		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
 
         /*
 	 * (ks) In the flagged taskfile approch, we will use all specified
@@ -820,7 +813,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
@@ -831,7 +824,7 @@ ide_startstop_t flagged_taskfile (ide_dr
 				break;
 
 			if (!hwif->dma_setup(drive)) {
-				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_exec_cmd(drive, tf->command);
 				hwif->dma_start(drive);
 				return ide_started;
 			}
@@ -843,11 +836,11 @@ ide_startstop_t flagged_taskfile (ide_dr
 
 			/* Issue the command */
 			if (task->prehandler) {
-				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
+				hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
 				ndelay(400);	/* FIXME */
 				return task->prehandler(drive, task->rq);
 			}
-			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
+			ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
 			return ide_started;
 	}
 
Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -117,7 +117,7 @@ typedef union ide_reg_valid_s {
 
 typedef struct ide_task_request_s {
 	__u8		io_ports[8];
-	__u8		hob_ports[8];
+	__u8		hob_ports[8]; /* bytes 6 and 7 are unused */
 	ide_reg_valid_t	out_flags;
 	ide_reg_valid_t	in_flags;
 	int		data_phase;
@@ -139,6 +139,7 @@ struct hd_drive_cmd_hdr {
 	__u8 sector_count;
 };
 
+#ifndef __KERNEL__
 typedef struct hd_drive_task_hdr {
 	__u8 data;
 	__u8 feature;
@@ -160,6 +161,7 @@ typedef struct hd_drive_hob_hdr {
 	__u8 device_head;
 	__u8 control;
 } hob_struct_t;
+#endif
 
 #define TASKFILE_INVALID		0x7fff
 #define TASKFILE_48			0x8000
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -103,8 +103,6 @@ typedef unsigned char	byte;	/* used ever
 #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
 #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
 
-#define IDE_CONTROL_OFFSET_HOB	(7)
-
 #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
 #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
 #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
@@ -1072,15 +1070,33 @@ extern void ide_end_drive_cmd(ide_drive_
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
 
+struct ide_taskfile {
+	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
+
+	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
+	u8	hob_nsect;
+	u8	hob_lbal;
+	u8	hob_lbam;
+	u8	hob_lbah;
+
+	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
+
+	u8	feature;	/*  7: feature */
+	u8	nsect;		/*  8: number of sectors */
+	u8	lbal;		/*  9: LBA low */
+	u8	lbam;		/* 10: LBA mid */
+	u8	lbah;		/* 11: LBA high */
+
+	u8	device;		/* 12: device select */
+
+	u8	command;	/* 13: command */
+};
+
 typedef struct ide_task_s {
-/*
- *	struct hd_drive_task_hdr	tf;
- *	task_struct_t		tf;
- *	struct hd_drive_hob_hdr		hobf;
- *	hob_struct_t		hobf;
- */
-	u8			tfRegister[8];
-	u8			hobRegister[8];
+	union {
+		struct ide_taskfile	tf;
+		u8			tf_array[14];
+	};
 	ide_reg_valid_t		tf_out_flags;
 	ide_reg_valid_t		tf_in_flags;
 	int			data_phase;
