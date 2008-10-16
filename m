From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-floppy: remove idefloppy_floppy_t typedef
Date: Thu, 16 Oct 2008 07:29:54 +0200
Message-ID: <20081016052953.GA32756@gollum.tnic>
References: <200810152136.48019.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:32959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYJPFaA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 01:30:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2266997fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 22:29:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810152136.48019.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 15, 2008 at 09:36:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> There should be no functional changes caused by this patch.
> 
> Cc: Borislav Petkov <petkovbb@googlemail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

> ---
> against pata tree
> 
>  drivers/ide/ide-floppy.c       |   18 +++++++++---------
>  drivers/ide/ide-floppy.h       |    2 --
>  drivers/ide/ide-floppy_ioctl.c |    8 ++++----
>  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> Index: b/drivers/ide/ide-floppy.c
> ===================================================================
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -70,7 +70,7 @@
>   */
>  static int ide_floppy_end_request(ide_drive_t *drive, int uptodate, int nsecs)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct request *rq = HWGROUP(drive)->rq;
>  	int error;
>  
> @@ -117,7 +117,7 @@ static void idefloppy_update_buffers(ide
>  
>  static void ide_floppy_callback(ide_drive_t *drive, int dsc)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct ide_atapi_pc *pc = drive->pc;
>  	int uptodate = pc->error ? 0 : 1;
>  
> @@ -154,7 +154,7 @@ static void ide_floppy_callback(ide_driv
>  	ide_floppy_end_request(drive, uptodate, 0);
>  }
>  
> -static void ide_floppy_report_error(idefloppy_floppy_t *floppy,
> +static void ide_floppy_report_error(struct ide_disk_obj *floppy,
>  				    struct ide_atapi_pc *pc)
>  {
>  	/* supress error messages resulting from Medium not present */
> @@ -173,7 +173,7 @@ static void ide_floppy_report_error(idef
>  static ide_startstop_t idefloppy_issue_pc(ide_drive_t *drive,
>  		struct ide_atapi_pc *pc)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  
>  	if (floppy->failed_pc == NULL &&
>  	    pc->c[0] != GPCMD_REQUEST_SENSE)
> @@ -237,7 +237,7 @@ static void idefloppy_create_rw_cmd(ide_
>  				    struct ide_atapi_pc *pc, struct request *rq,
>  				    unsigned long sector)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	int block = sector / floppy->bs_factor;
>  	int blocks = rq->nr_sectors / floppy->bs_factor;
>  	int cmd = rq_data_dir(rq);
> @@ -261,7 +261,7 @@ static void idefloppy_create_rw_cmd(ide_
>  	pc->flags |= PC_FLAG_DMA_OK;
>  }
>  
> -static void idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy,
> +static void idefloppy_blockpc_cmd(struct ide_disk_obj *floppy,
>  		struct ide_atapi_pc *pc, struct request *rq)
>  {
>  	ide_init_pc(pc);
> @@ -283,7 +283,7 @@ static void idefloppy_blockpc_cmd(ideflo
>  static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
>  					     struct request *rq, sector_t block)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct ide_atapi_pc *pc;
>  
> @@ -344,7 +344,7 @@ static ide_startstop_t ide_floppy_do_req
>   */
>  static int ide_floppy_get_flexible_disk_page(ide_drive_t *drive)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct gendisk *disk = floppy->disk;
>  	struct ide_atapi_pc pc;
>  	u8 *page;
> @@ -407,7 +407,7 @@ static int ide_floppy_get_flexible_disk_
>   */
>  static int ide_floppy_get_capacity(ide_drive_t *drive)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct gendisk *disk = floppy->disk;
>  	struct ide_atapi_pc pc;
>  	u8 *cap_desc;
> Index: b/drivers/ide/ide-floppy.h
> ===================================================================
> --- a/drivers/ide/ide-floppy.h
> +++ b/drivers/ide/ide-floppy.h
> @@ -4,8 +4,6 @@
>  #include "ide-gd.h"
>  
>  #ifdef CONFIG_IDE_GD_ATAPI
> -typedef struct ide_disk_obj idefloppy_floppy_t;
> -
>  /*
>   * Pages of the SELECT SENSE / MODE SENSE packet commands.
>   * See SFF-8070i spec.
> Index: b/drivers/ide/ide-floppy_ioctl.c
> ===================================================================
> --- a/drivers/ide/ide-floppy_ioctl.c
> +++ b/drivers/ide/ide-floppy_ioctl.c
> @@ -113,7 +113,7 @@ static void ide_floppy_create_format_uni
>  
>  static int ide_floppy_get_sfrp_bit(ide_drive_t *drive)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct ide_atapi_pc pc;
>  
>  	drive->atapi_flags &= ~IDE_AFLAG_SRFP;
> @@ -132,7 +132,7 @@ static int ide_floppy_get_sfrp_bit(ide_d
>  
>  static int ide_floppy_format_unit(ide_drive_t *drive, int __user *arg)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct ide_atapi_pc pc;
>  	int blocks, length, flags, err = 0;
>  
> @@ -190,7 +190,7 @@ out:
>  
>  static int ide_floppy_get_format_progress(ide_drive_t *drive, int __user *arg)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct ide_atapi_pc pc;
>  	int progress_indication = 0x10000;
>  
> @@ -226,7 +226,7 @@ static int ide_floppy_get_format_progres
>  static int ide_floppy_lockdoor(ide_drive_t *drive, struct ide_atapi_pc *pc,
>  			       unsigned long arg, unsigned int cmd)
>  {
> -	idefloppy_floppy_t *floppy = drive->driver_data;
> +	struct ide_disk_obj *floppy = drive->driver_data;
>  	struct gendisk *disk = floppy->disk;
>  	int prevent = (arg && cmd != CDROMEJECT) ? 1 : 0;
>  

-- 
Regards/Gruss,
    Boris.
