From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/12] ide: add struct ide_taskfile
Date: Wed, 17 Oct 2007 21:38:28 +0400
Message-ID: <47164894.9080007@ru.mvista.com>
References: <200710082311.10925.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33557 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932456AbXJQRiR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 13:38:17 -0400
In-Reply-To: <200710082311.10925.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:

> * Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hobRegister[7]
>   in idedisk_set_max_address_ext().

> * Add struct ide_taskfile and use it in ide_task_t instead of tfRegister[]
>   and hobRegister[].

> * Remove no longer needed IDE_CONTROL_OFFSET_HOB define.

> * Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_struct_t.

> While at it:

> * Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Nearly-acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-disk.c
> ===================================================================
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c

[...]

> +	if ((tf->command & 0x01) == 0) {
> +		u32 high, low;

    Isn't newline needed after declarations?

> +		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> +		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr = ((__u64)high << 24) | low;
>  		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}

[...]

> @@ -422,33 +417,29 @@ static unsigned long idedisk_set_max_add
[...]
>  	/* if OK, compute maximum address value */
> -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
> -		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
> -			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
> -			    args.hobRegister[IDE_SECTOR_OFFSET];
> -		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
> -			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
> -			    (args.tfRegister[IDE_SECTOR_OFFSET]);
> +	if ((tf->command & 0x01) == 0) {
> +		u32 high, low;

    Again missing newline...

> +		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> +		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr_set = ((__u64)high << 24) | low;
>  		addr_set++;
>  	}
> @@ -582,12 +573,13 @@ static sector_t idedisk_capacity (ide_dr
>  static int smart_enable(ide_drive_t *drive)
>  {
>  	ide_task_t args;
> +	struct ide_taskfile *tf = &args.tf;
>  
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_ENABLE;
> -	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
> -	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
> +	tf->feature = SMART_ENABLE;
> +	tf->lbam    = SMART_LCYL_PASS;
> +	tf->lbah    = SMART_HCYL_PASS;
> +	tf->command = WIN_SMART;
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	return ide_raw_taskfile(drive, &args, NULL);
> @@ -596,13 +588,14 @@ static int smart_enable(ide_drive_t *dri
>  static int get_smart_data(ide_drive_t *drive, u8 *buf, u8 sub_cmd)
>  {
>  	ide_task_t args;
> +	struct ide_taskfile *tf = &args.tf;
>  
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= sub_cmd;
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
> -	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
> -	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
> +	tf->feature = sub_cmd;
> +	tf->nsect   = 0x01;
> +	tf->lbam    = SMART_LCYL_PASS;
> +	tf->lbah    = SMART_HCYL_PASS;
> +	tf->command = WIN_SMART;

    I guess the code above and below were menat to have the same = indentation...

>  	args.command_type			= IDE_DRIVE_TASK_IN;
>  	args.data_phase				= TASKFILE_IN;
>  	args.handler				= &task_in_intr;

> @@ -808,9 +801,9 @@ static int write_cache(ide_drive_t *driv
>  
>  	if (ide_id_has_flush_cache(drive->id)) {
>  		memset(&args, 0, sizeof(ide_task_t));
> -		args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
> +		args.tf.feature = arg ?
>  			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
> +		args.tf.command = WIN_SETFEATURES;

    Same here...

>  		args.command_type		= IDE_DRIVE_TASK_NO_DATA;
>  		args.handler			= &task_no_data_intr;
>  		err = ide_raw_taskfile(drive, &args, NULL);
> @@ -829,9 +822,9 @@ static int do_idedisk_flushcache (ide_dr
>  
>  	memset(&args, 0, sizeof(ide_task_t));
>  	if (ide_id_has_flush_cache_ext(drive->id))
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
> +		args.tf.command = WIN_FLUSH_CACHE_EXT;
>  	else
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
> +		args.tf.command = WIN_FLUSH_CACHE;

    ... and here...

>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	return ide_raw_taskfile(drive, &args, NULL);
> @@ -845,10 +838,9 @@ static int set_acoustic (ide_drive_t *dr
>  		return -EINVAL;
>  
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ? SETFEATURES_EN_AAM :
> -							  SETFEATURES_DIS_AAM;
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
> +	args.tf.feature = arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
> +	args.tf.nsect   = arg;
> +	args.tf.command = WIN_SETFEATURES;

    ... and here...

>  	args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  	args.handler	  = &task_no_data_intr;
>  	ide_raw_taskfile(drive, &args, NULL);
> @@ -1115,7 +1107,7 @@ static int idedisk_open(struct inode *in
>  	if (drive->removable && idkp->openers == 1) {
>  		ide_task_t args;
>  		memset(&args, 0, sizeof(ide_task_t));
> -		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
> +		args.tf.command = WIN_DOORLOCK;

    ... and here...

>  		args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args.handler	  = &task_no_data_intr;
>  		check_disk_change(inode->i_bdev);
> @@ -1142,7 +1134,7 @@ static int idedisk_release(struct inode 
>  	if (drive->removable && idkp->openers == 1) {
>  		ide_task_t args;
>  		memset(&args, 0, sizeof(ide_task_t));
> -		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
> +		args.tf.command = WIN_DOORUNLOCK;

    ... and here...

>  		args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args.handler	  = &task_no_data_intr;
>  		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -189,15 +189,15 @@ static ide_startstop_t ide_start_power_s
>  			return ide_stopped;
>  		}
>  		if (ide_id_has_flush_cache_ext(drive->id))
> -			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
> +			args->tf.command = WIN_FLUSH_CACHE_EXT;
>  		else
> -			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
> +			args->tf.command = WIN_FLUSH_CACHE;
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler	   = &task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
>  
>  	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
> -		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
> +		args->tf.command = WIN_STANDBYNOW1;

    ... and here...

>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler	   = &task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
[...]
> @@ -387,28 +387,30 @@ void ide_end_drive_cmd (ide_drive_t *dri
>  			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
>  			
>  		if (args) {
> +			struct ide_taskfile *tf = &args->tf;
> +
>  			if (args->tf_in_flags.b.data) {
> -				u16 data				= hwif->INW(IDE_DATA_REG);
> -				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
> -				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
> +				u16 data = hwif->INW(IDE_DATA_REG);

    Again, no newline after declaration block.

[...]

> @@ -707,28 +709,28 @@ static ide_startstop_t drive_cmd_intr (i
>  
>  static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
>  {
> -	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
> -	task->tfRegister[IDE_SECTOR_OFFSET]  = drive->sect;
> -	task->tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
> -	task->tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
> -	task->tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
> -	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
> +	task->tf.nsect   = drive->sect;
> +	task->tf.lbal    = drive->sect;
> +	task->tf.lbam    = drive->cyl;
> +	task->tf.lbah    = drive->cyl >> 8;
> +	task->tf.device  = ((drive->head - 1) | drive->select.all) & 0xBF;

    Well, if you started using ATA_LBA, s/0xBF/~ATA_LBA.

> +	task->tf.command = WIN_SPECIFY;

[...]

> Index: b/drivers/ide/ide-taskfile.c
> ===================================================================
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
[...]
>  	/* (ks) send hob registers first */
>  	if (task->tf_out_flags.b.nsector_hob)
> -		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
> +		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
>  	if (task->tf_out_flags.b.sector_hob)
> -		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
> +		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
>  	if (task->tf_out_flags.b.lcyl_hob)
> -		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
> +		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
>  	if (task->tf_out_flags.b.hcyl_hob)
> -		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
> +		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
>  
>  	/* (ks) Send now the standard registers */
>  	if (task->tf_out_flags.b.error_feature)
> -		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
> +		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
>  	/* refers to number of sectors to transfer */
>  	if (task->tf_out_flags.b.nsector)
> -		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
> +		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
>  	/* refers to sector offset or start sector */
>  	if (task->tf_out_flags.b.sector)
> -		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
> +		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
>  	if (task->tf_out_flags.b.lcyl)
> -		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
> +		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
>  	if (task->tf_out_flags.b.hcyl)
> -		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
> +		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
>  
>          /*
>  	 * (ks) In the flagged taskfile approch, we will use all specified

    Well, maybe it time to fix typo in approAch? :-)

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -103,8 +103,6 @@ typedef unsigned char	byte;	/* used ever
>  #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
>  #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
>  
> -#define IDE_CONTROL_OFFSET_HOB	(7)
> -
>  #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
>  #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
>  #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
> @@ -1072,15 +1070,33 @@ extern void ide_end_drive_cmd(ide_drive_
>   */
>  extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
>  
> +struct ide_taskfile {
> +	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
> +
> +	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
> +	u8	hob_nsect;
> +	u8	hob_lbal;
> +	u8	hob_lbam;
> +	u8	hob_lbah;
> +
> +	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */

    I wonder who needs to read/write the data reg. (even with HOB)? :-O

MBR, Sergei
