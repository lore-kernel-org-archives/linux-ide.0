From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 31/32] ide-tape: remove idetape_config_t typedef
Date: Sun, 27 Jan 2008 19:30:53 +0100
Message-ID: <200801271930.53933.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-26-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:9274 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbYA0TcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:21 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431368fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:20 -0800 (PST)
In-Reply-To: <1201427300-3954-26-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Since this is used only in idetape_blkdev_ioctl(), remove the typedef and make
> the struct function-local.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied

> ---
>  drivers/ide/ide-tape.c |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index c22d7f6..424879d 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -540,15 +540,6 @@ struct idetape_id_gcw {
>  #define	IDETAPE_CAPABILITIES_PAGE	0x2a
>  
>  /*
> - *	Run time configurable parameters.
> - */
> -typedef struct {
> -	int	dsc_rw_frequency;
> -	int	dsc_media_access_frequency;
> -	int	nr_stages;
> -} idetape_config_t;
> -
> -/*
>   *	The variables below are used for the character device interface.
>   *	Additional state variables are defined in our ide_drive_t structure.
>   */
> @@ -2742,14 +2733,21 @@ static int idetape_rewind_tape (ide_drive_t *drive)
>  static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
> -	idetape_config_t config;
> +
> +	struct idetape_config {
> +		int dsc_rw_frequency;
> +		int dsc_media_access_frequency;
> +		int nr_stages;
> +	} config;
> +
>  	void __user *argp = (void __user *)arg;
>  
>  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
>  
>  	switch (cmd) {
>  		case 0x0340:
> -			if (copy_from_user(&config, argp, sizeof (idetape_config_t)))
> +			if (copy_from_user(&config, argp,
> +						sizeof(struct idetape_config)))

s/sizeof(struct idetape_config)/sizeof(config)/ so it fits nicely in one line

>  				return -EFAULT;
>  			tape->best_dsc_rw_freq = config.dsc_rw_frequency;
>  			tape->max_stages = config.nr_stages;
> @@ -2757,7 +2755,8 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned l
>  		case 0x0350:
>  			config.dsc_rw_frequency = (int) tape->best_dsc_rw_freq;
>  			config.nr_stages = tape->max_stages; 
> -			if (copy_to_user(argp, &config, sizeof (idetape_config_t)))
> +			if (copy_to_user(argp, &config,
> +						sizeof(struct idetape_config)))

ditto
