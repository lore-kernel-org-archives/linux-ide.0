From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 08/18] ide-floppy: use drive->capacity64 for caching
	current capacity
Date: Wed, 10 Sep 2008 13:20:06 +0200
Message-ID: <20080910112006.GA10263@gollum.tnic>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain> <20080907221519.24285.44318.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:33804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYIJLVN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 07:21:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2106232fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 10 Sep 2008 04:21:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080907221519.24285.44318.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 08, 2008 at 12:15:19AM +0200, Bartlomiej Zolnierkiewicz wrote:
> * Use drive->capacity64 for caching current capacity.
> 
> * Switch ide_floppy_capacity() to use drive->capacity64.
> 
> * Call set_capacity() in idefloppy_open() and ide_floppy_probe()
>   instead of ide_floppy_get_capacity().
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-floppy.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> Index: b/drivers/ide/ide-floppy.c
> ===================================================================
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -445,7 +445,9 @@ static int ide_floppy_get_flexible_disk_
>  			drive->name, lba_capacity, capacity);
>  		floppy->blocks = floppy->block_size ?
>  			capacity / floppy->block_size : 0;
> +		drive->capacity64 = floppy->blocks * floppy->bs_factor;

why do we do the assignment only in the capacity < lba_capacity case?
drive->capacity64 is the total number of sectors, shouldn't we do

drive->capacity64 = floppy->blocks;

in the floppy->bs_factor == 1 case? Otherwise you have the case of calling

idefloppy_setup()
|-> ide_floppy_get_capacity()
    |-> ide_floppy_get_flexible_disk_page()

and having drive->capacity64 == 0 in the (capacity >= lba_capacity) case which
assigns a capacity of 0 to disk->capacity in the set_capacity() call later ...

or am I missing something?

>  	}
> +
>  	return 0;
>  }
>  
> @@ -466,7 +468,7 @@ static int ide_floppy_get_capacity(ide_d
>  	drive->bios_head = drive->bios_sect = 0;
>  	floppy->blocks = 0;
>  	floppy->bs_factor = 1;
> -	set_capacity(floppy->disk, 0);
> +	drive->capacity64 = 0;
>  
>  	ide_floppy_create_read_capacity_cmd(&pc);
>  	if (ide_queue_pc_tail(drive, disk, &pc)) {
> @@ -523,6 +525,8 @@ static int ide_floppy_get_capacity(ide_d
>  					       "non 512 bytes block size not "
>  					       "fully supported\n",
>  					       drive->name);
> +				drive->capacity64 =
> +					floppy->blocks * floppy->bs_factor;
>  				rc = 0;
>  			}
>  			break;
> @@ -547,17 +551,12 @@ static int ide_floppy_get_capacity(ide_d
>  	if (!(drive->atapi_flags & IDE_AFLAG_CLIK_DRIVE))
>  		(void) ide_floppy_get_flexible_disk_page(drive);
>  
> -	set_capacity(disk, floppy->blocks * floppy->bs_factor);
> -
>  	return rc;
>  }
>  
>  sector_t ide_floppy_capacity(ide_drive_t *drive)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> -	unsigned long capacity = floppy->blocks * floppy->bs_factor;
> -
> -	return capacity;
> +	return drive->capacity64;

you can simplify this one even further by killing ide_floppy_capacity() and
doing

	set_capacity(disk, floppy->drive->capacity64);

in idefloppy_revalidate_disk().
>  }
>  
>  static void idefloppy_setup(ide_drive_t *drive)
> @@ -671,14 +670,16 @@ static int idefloppy_open(struct inode *
>  		if (ide_do_test_unit_ready(drive, disk))
>  			ide_do_start_stop(drive, disk, 1);
>  
> -		if (ide_floppy_get_capacity(drive)
> -		   && (filp->f_flags & O_NDELAY) == 0
> +		ret = ide_floppy_get_capacity(drive);
> +
> +		set_capacity(disk, ide_floppy_capacity(drive));

ditto.

> +
> +		if (ret && (filp->f_flags & O_NDELAY) == 0) {
>  		    /*
>  		     * Allow O_NDELAY to open a drive without a disk, or with an
>  		     * unreadable disk, so that we can get the format capacity
>  		     * of the drive or begin the format - Sam
>  		     */
> -		    ) {
>  			ret = -EIO;
>  			goto out_put_floppy;
>  		}
> @@ -811,6 +812,8 @@ static int ide_floppy_probe(ide_drive_t 
>  
>  	idefloppy_setup(drive);
>  
> +	set_capacity(g, ide_floppy_capacity(drive));

ditto.

> +
>  	g->minors = 1 << PARTN_BITS;
>  	g->driverfs_dev = &drive->gendev;
>  	if (drive->dev_flags & IDE_DFLAG_REMOVABLE)

-- 
Regards/Gruss,
    Boris.
