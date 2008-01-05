From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 06/10] ide-floppy: report DMA handling in idefloppy_pc_intr() properly
Date: Sat, 5 Jan 2008 16:46:05 +0100
Message-ID: <200801051646.05131.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-6-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:46361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbYAEPfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 10:35:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2918535ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 07:35:10 -0800 (PST)
In-Reply-To: <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Thursday 03 January 2008, Borislav Petkov wrote:
> while at it:
> -cleanup small issues raised by scripts/checkpatch.pl
> -remove redundant and shorten some comments

Could you split the above coding style fixes into a separate patch?

> There should be no functionality change resulting from this patch

The patch fixes the DMA error reporting so this is not true. :)

> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |  195 ++++++++++++++++++++--------------------------
>  1 files changed, 83 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 7823447..5d0fd1f 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -5,9 +5,7 @@
>   * Copyright (C) 2000 - 2002 Paul Bristow <paul@paulbristow.net>
>   *
>   * The driver currently doesn't have any fancy features, just the bare
> - * minimum read/write support.

this comment should be removed as it is not true anymore
(SG_IO and IDEFLOPPY_IOCTL_FORMAT_* ioctls are supported)

[...]

> @@ -208,11 +204,11 @@ static void idefloppy_update_buffers (ide_drive_t *drive, idefloppy_pc_t *pc)
>  }
>  
>  /*
> - *	idefloppy_queue_pc_head generates a new packet command request in front
> - *	of the request queue, before the current request, so that it will be
> - *	processed immediately, on the next pass through the driver.
> + * Generates a new packet command request in front

a lot of space left in the above line

> + * of the request queue, before the current request, so that it will be
> + * processed immediately, on the next pass through the driver.
>   */
> -static void idefloppy_queue_pc_head (ide_drive_t *drive,idefloppy_pc_t *pc,
> +static void idefloppy_queue_pc_head(ide_drive_t *drive, idefloppy_pc_t *pc,
>  		struct request *rq)
>  {
>  	struct ide_floppy_obj *floppy = drive->driver_data;

[...]

> @@ -554,11 +545,7 @@ static ide_startstop_t idefloppy_transfer_pc1 (ide_drive_t *drive)
>  	return ide_started;
>  }
>  
> -/**
> - * idefloppy_should_report_error()
> - *
> - * Supresses error messages resulting from Medium not present
> - */
> +/* Supresses error messages resulting from Medium not present */

missing '.'

> @@ -792,7 +774,8 @@ static void idefloppy_create_rw_cmd (idefloppy_t *floppy, idefloppy_pc_t *pc,
>  }
>  
>  static void
> -idefloppy_blockpc_cmd(idefloppy_t *floppy, idefloppy_pc_t *pc, struct request *rq)
> +idefloppy_blockpc_cmd(idefloppy_t *floppy, idefloppy_pc_t *pc,
> +		struct request *rq)

might as well be converted to match the coding style:

static void idefloppy_blockpc_cmd...

[...]

> @@ -1437,7 +1408,7 @@ static void idefloppy_setup (ide_drive_t *drive, idefloppy_t *floppy)
>  	idefloppy_add_settings(drive);
>  }
>  
> -static void ide_floppy_remove(ide_drive_t *drive)
> +static void idefloppy_remove(ide_drive_t *drive)

Hmm, no.  The driver is called ide-floppy (ide_floppy) and it is more
readable this way.

>  {
>  	idefloppy_t *floppy = drive->driver_data;
>  	struct gendisk *g = floppy->disk;
> @@ -1479,7 +1450,7 @@ static ide_proc_entry_t idefloppy_proc[] = {
>  };
>  #endif	/* CONFIG_IDE_PROC_FS */
>  
> -static int ide_floppy_probe(ide_drive_t *);
> +static int idefloppy_probe(ide_drive_t *);

ditto
 
[...]

> @@ -1733,7 +1704,7 @@ static struct block_device_operations idefloppy_ops = {
>  	.revalidate_disk= idefloppy_revalidate_disk
>  };
>  
> -static int ide_floppy_probe(ide_drive_t *drive)
> +static int idefloppy_probe(ide_drive_t *drive)

ditto

otherwise looks good
