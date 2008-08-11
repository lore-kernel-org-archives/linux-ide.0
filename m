From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 11/22] ide: add ide_set_media_lock() helper
Date: Mon, 11 Aug 2008 08:02:32 +0200
Message-ID: <20080811060232.GA15436@gollum.tnic>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <20080810153645.16255.80542.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:28351 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYHKGCi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 02:02:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so944570fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 23:02:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080810153645.16255.80542.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 10, 2008 at 05:36:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Set IDE_AFLAG_NO_DOORLOCK in idetape_get_mode_sense_result(), check it
>   in ide_tape_set_media_lock() and cleanup idetape_create_prevent_cmd().
> 
> * Set IDE_AFLAG_NO_DOORLOCK in ide_floppy_create_read_capacity_cmd() and
>   check it instead of IDE_AFLAG_CLIK_DRIVE in ide_floppy_set_media_lock().
> 
> * Add ide_set_media_lock() helper and convert ide-{floppy,tape}.c to use it.
> 
> * Remove no longer used ide*_create_prevent_cmd()/ide*_set_media_lock().
> 
> * Update comment in <linux/ide.h> accordingly.
> 
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-atapi.c  |   15 +++++++++++++++
>  drivers/ide/ide-floppy.c |   32 +++++++-------------------------
>  drivers/ide/ide-tape.c   |   41 ++++++++++-------------------------------
>  include/linux/ide.h      |    6 ++++--
>  4 files changed, 36 insertions(+), 58 deletions(-)
> 
> Index: b/drivers/ide/ide-atapi.c
> ===================================================================
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -162,6 +162,21 @@ int ide_queue_pc_tail(ide_drive_t *drive
>  }
>  EXPORT_SYMBOL_GPL(ide_queue_pc_tail);
>  
> +int ide_set_media_lock(ide_drive_t *drive, struct gendisk *disk, int on)
> +{
> +	struct ide_atapi_pc pc;
> +
> +	if (drive->atapi_flags & IDE_AFLAG_NO_DOORLOCK)
> +		return 0;
> +
> +	ide_init_pc(&pc);
> +	pc.c[0] = ALLOW_MEDIUM_REMOVAL;

Are we switching to SCSI opcodes? What about the generic packet commands in
<include/linux/cdrom.h>?

> +	pc.c[4] = on;
> +
> +	return ide_queue_pc_tail(drive, disk, &pc);
> +}
> +EXPORT_SYMBOL_GPL(ide_set_media_lock);
> +
>  /* TODO: unify the code thus making some arguments go away */
>  ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
>  	ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry,
> Index: b/drivers/ide/ide-floppy.c
> ===================================================================
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -324,15 +324,6 @@ static ide_startstop_t idefloppy_issue_p
>  			    IDEFLOPPY_WAIT_CMD, NULL);
>  }
>  
> -static void idefloppy_create_prevent_cmd(struct ide_atapi_pc *pc, int prevent)
> -{
> -	debug_log("creating prevent removal command, prevent = %d\n", prevent);
> -
> -	ide_init_pc(pc);
> -	pc->c[0] = GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
> -	pc->c[4] = prevent;
> -}
> -
>  void ide_floppy_create_read_capacity_cmd(struct ide_atapi_pc *pc)
>  {
>  	ide_init_pc(pc);
> @@ -711,6 +702,8 @@ static void idefloppy_setup(ide_drive_t 
>  	if (strncmp((char *)&id[ATA_ID_PROD], "IOMEGA Clik!", 11) == 0) {
>  		blk_queue_max_sectors(drive->queue, 64);
>  		drive->atapi_flags |= IDE_AFLAG_CLIK_DRIVE;
> +		/* IOMEGA Clik! drives do not support lock/unlock commands */
> +		drive->atapi_flags |= IDE_AFLAG_NO_DOORLOCK;
>  	}
>  
>  	(void) ide_floppy_get_capacity(drive);
> @@ -781,18 +774,6 @@ static ide_driver_t idefloppy_driver = {
>  #endif
>  };
>  
> -static void ide_floppy_set_media_lock(ide_drive_t *drive, int on)
> -{
> -	struct ide_floppy_obj *floppy = drive->driver_data;
> -	struct ide_atapi_pc pc;
> -
> -	/* IOMEGA Clik! drives do not support lock/unlock commands */
> -	if ((drive->atapi_flags & IDE_AFLAG_CLIK_DRIVE) == 0) {
> -		idefloppy_create_prevent_cmd(&pc, on);
> -		(void)ide_queue_pc_tail(drive, floppy->disk, &pc);
> -	}
> -}
> -
>  static int idefloppy_open(struct inode *inode, struct file *filp)
>  {
>  	struct gendisk *disk = inode->i_bdev->bd_disk;
> @@ -841,7 +822,7 @@ static int idefloppy_open(struct inode *
>  		}
>  
>  		drive->atapi_flags |= IDE_AFLAG_MEDIA_CHANGED;
> -		ide_floppy_set_media_lock(drive, 1);
> +		ide_set_media_lock(drive, disk, 1);
>  		check_disk_change(inode->i_bdev);
>  	} else if (drive->atapi_flags & IDE_AFLAG_FORMAT_IN_PROGRESS) {
>  		ret = -EBUSY;
> @@ -864,7 +845,7 @@ static int idefloppy_release(struct inod
>  	debug_log("Reached %s\n", __func__);
>  
>  	if (floppy->openers == 1) {
> -		ide_floppy_set_media_lock(drive, 0);
> +		ide_set_media_lock(drive, disk, 0);
>  		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
>  	}
>  
> @@ -890,16 +871,17 @@ static int ide_floppy_lockdoor(ide_drive
>  			       unsigned long arg, unsigned int cmd)
>  {
>  	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct gendisk *disk = floppy->disk;
>  	int prevent = (arg && cmd != CDROMEJECT) ? 1 : 0;
>  
>  	if (floppy->openers > 1)
>  		return -EBUSY;
>  
> -	ide_floppy_set_media_lock(drive, prevent);
> +	ide_set_media_lock(drive, disk, prevent);
>  
>  	if (cmd == CDROMEJECT) {
>  		idefloppy_create_start_stop_cmd(pc, 2);
> -		(void)ide_queue_pc_tail(drive, floppy->disk, pc);
> +		(void)ide_queue_pc_tail(drive, disk, pc);
>  	}
>  
>  	return 0;
> Index: b/drivers/ide/ide-tape.c
> ===================================================================
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -1213,32 +1213,6 @@ static void idetape_create_locate_cmd(id
>  	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
>  }
>  
> -static int idetape_create_prevent_cmd(ide_drive_t *drive,
> -		struct ide_atapi_pc *pc, int prevent)
> -{
> -	idetape_tape_t *tape = drive->driver_data;
> -
> -	/* device supports locking according to capabilities page */
> -	if (!(tape->caps[6] & 0x01))
> -		return 0;
> -
> -	ide_init_pc(pc);
> -	pc->c[0] = ALLOW_MEDIUM_REMOVAL;
> -	pc->c[4] = prevent;
> -	return 1;
> -}
> -
> -static int ide_tape_set_media_lock(ide_drive_t *drive, int on)
> -{
> -	struct ide_tape_obj *tape = drive->driver_data;
> -	struct ide_atapi_pc pc;
> -
> -	if (!idetape_create_prevent_cmd(drive, &pc, on))
> -		return 0;
> -
> -	return ide_queue_pc_tail(drive, tape->disk, &pc);
> -}
> -
>  static void __ide_tape_discard_merge_buffer(ide_drive_t *drive)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
> @@ -1871,7 +1845,7 @@ static int idetape_mtioctop(ide_drive_t 
>  		 * attempting to eject.
>  		 */
>  		if (tape->door_locked) {
> -			if (!ide_tape_set_media_lock(drive, 0))
> +			if (!ide_set_media_lock(drive, disk, 0))
>  				tape->door_locked = DOOR_UNLOCKED;
>  		}
>  		ide_tape_discard_merge_buffer(drive, 0);
> @@ -1916,13 +1890,13 @@ static int idetape_mtioctop(ide_drive_t 
>  	case MTFSR:
>  	case MTBSR:
>  	case MTLOCK:
> -		retval = ide_tape_set_media_lock(drive, 1);
> +		retval = ide_set_media_lock(drive, disk, 1);
>  		if (retval)
>  			return retval;
>  		tape->door_locked = DOOR_EXPLICITLY_LOCKED;
>  		return 0;
>  	case MTUNLOCK:
> -		retval = ide_tape_set_media_lock(drive, 0);
> +		retval = ide_set_media_lock(drive, disk, 0);
>  		if (retval)
>  			return retval;
>  		tape->door_locked = DOOR_UNLOCKED;
> @@ -2086,7 +2060,7 @@ static int idetape_chrdev_open(struct in
>  
>  	/* Lock the tape drive door so user can't eject. */
>  	if (tape->chrdev_dir == IDETAPE_DIR_NONE) {
> -		if (!ide_tape_set_media_lock(drive, 1)) {
> +		if (!ide_set_media_lock(drive, tape->disk, 1)) {
>  			if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
>  				tape->door_locked = DOOR_LOCKED;
>  		}
> @@ -2139,7 +2113,7 @@ static int idetape_chrdev_release(struct
>  		(void) idetape_rewind_tape(drive);
>  	if (tape->chrdev_dir == IDETAPE_DIR_NONE) {
>  		if (tape->door_locked == DOOR_LOCKED) {
> -			if (!ide_tape_set_media_lock(drive, 0))
> +			if (!ide_set_media_lock(drive, tape->disk, 0))
>  				tape->door_locked = DOOR_UNLOCKED;
>  		}
>  	}
> @@ -2217,6 +2191,11 @@ static void idetape_get_mode_sense_resul
>  	}
>  
>  	memcpy(&tape->caps, caps, 20);
> +
> +	/* device lacks locking support according to capabilities page */
> +	if ((caps[6] & 1) == 0)
> +		drive->atapi_flags |= IDE_AFLAG_NO_DOORLOCK;
> +
>  	if (caps[7] & 0x02)
>  		tape->blk_size = 512;
>  	else if (caps[7] & 0x04)
> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -317,10 +317,10 @@ struct ide_acpi_hwif_link;
>  enum {
>  	IDE_AFLAG_DRQ_INTERRUPT		= (1 << 0),
>  	IDE_AFLAG_MEDIA_CHANGED		= (1 << 1),
> -
> -	/* ide-cd */
>  	/* Drive cannot lock the door. */
>  	IDE_AFLAG_NO_DOORLOCK		= (1 << 2),
> +
> +	/* ide-cd */
>  	/* Drive cannot eject the disc. */
>  	IDE_AFLAG_NO_EJECT		= (1 << 3),
>  	/* Drive is a pre ATAPI 1.2 drive. */
> @@ -1140,6 +1140,8 @@ void ide_queue_pc_head(ide_drive_t *, st
>  		       struct request *);
>  int ide_queue_pc_tail(ide_drive_t *, struct gendisk *, struct ide_atapi_pc *);
>  
> +int ide_set_media_lock(ide_drive_t *, struct gendisk *, int);
> +
>  ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
>  	ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry,
>  	void (*update_buffers)(ide_drive_t *, struct ide_atapi_pc *),

-- 
Regards/Gruss,
    Boris.
