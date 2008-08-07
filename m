From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [patch] cdrom: Handle TOC
Date: Thu, 7 Aug 2008 06:18:37 +0200
Message-ID: <20080807041837.GA2394@gollum.tnic>
References: <20080806210358.GA7386@shurick.s2s.msu.ru>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:44356 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYHGES3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 00:18:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so141548fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 21:18:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080806210358.GA7386@shurick.s2s.msu.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Inyukhin <shurick@sectorb.msk.ru>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, Aug 07, 2008 at 01:03:58AM +0400, Alexander Inyukhin wrote:
> Hi
> 
> This patch should fix TOC handling for cdroms that can not play audio.
> It extends commit af744e3294d09d706c4eae26cffaaa68a8d40337
> with a safety check and non-audio ioctls support.
> 
> Since CDC_PLAY_AUDIO flag was used not only to check ability
> to play audio but also to ensure that audio_ioctl was not NULL,
> all TOC-related operations had to use it.
> 
> As far as I understand, now audio_ioctl is never NULL,
> so a sanity check during device registration should be sufficient.
> 
> The patch is against 2.6.27-rc2. It was tested on Optiarc AD7203A
> device, that has no ability to play audio.

> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index d9d1b65..efc3aa0 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -394,6 +394,8 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  
>  	if (cdo->open == NULL || cdo->release == NULL)
>  		return -EINVAL;
> +	if (cdo->audio_ioctl == NULL)
> +		return -EINVAL;

How about putting all checks above together:
	if (!cdo->open || !cdo->release || !cdo->audio_ioctl)
		return -EINVAL;

?

>  	if (!banner_printed) {
>  		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
>  		banner_printed = 1;
> @@ -408,7 +410,6 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  	ENSURE(get_last_session, CDC_MULTI_SESSION);
>  	ENSURE(get_mcn, CDC_MCN);
>  	ENSURE(reset, CDC_RESET);
> -	ENSURE(audio_ioctl, CDC_PLAY_AUDIO);
>  	ENSURE(generic_packet, CDC_GENERIC_PACKET);
>  	cdi->mc_flags = 0;
>  	cdo->n_minors = 0;
> @@ -2506,8 +2507,6 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
>  
>  	/* cdinfo(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
>  
> -	if (!CDROM_CAN(CDC_PLAY_AUDIO))
> -		return -ENOSYS;
>  	if (copy_from_user(&q, argp, sizeof(q)))
>  		return -EFAULT;
>  
> @@ -2538,8 +2537,6 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
>  
>  	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
>  
> -	if (!CDROM_CAN(CDC_PLAY_AUDIO))
> -		return -ENOSYS;
>  	if (copy_from_user(&header, argp, sizeof(header)))
>  		return -EFAULT;
>  
> @@ -2562,8 +2559,6 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
>  
>  	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
>  
> -	if (!CDROM_CAN(CDC_PLAY_AUDIO))
> -		return -ENOSYS;
>  	if (copy_from_user(&entry, argp, sizeof(entry)))
>  		return -EFAULT;
>  


-- 
Regards/Gruss,
    Boris.
