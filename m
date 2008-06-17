From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cdrom: don't check CDC_PLAY_AUDIO in cdrom_count_tracks()
Date: Tue, 17 Jun 2008 11:43:53 +0200
Message-ID: <200806171143.53883.bzolnier@gmail.com>
References: <48574994.9090503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:51340 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYFQJm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 05:42:27 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3321752wri.5
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2008 02:42:22 -0700 (PDT)
In-Reply-To: <48574994.9090503@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Borislav Petkov <petkovbb@googlemail.com>

On Tuesday 17 June 2008, Tejun Heo wrote:
> According to MMC-3 (or any later versions) READ TOCs are mandatory
> commands and have nothing to do with CDC_PLAY_AUDIO.  I have no idea
> why the check was put there in the first place but it now only breaks
> automatic actions on certain drives.
> 
> Note that this test was only effective when ide-cdrom was being used

cc:ing Borislav

> as sr didn't mask CDC_PLAY_AUDIO according to the capabilities.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/cdrom/cdrom.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 69f26eb..11574c5 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1491,10 +1491,6 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype* tracks)
>  	tracks->xa=0;
>  	tracks->error=0;
>  	cdinfo(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n"); 
> -        if (!CDROM_CAN(CDC_PLAY_AUDIO)) { 
> -                tracks->error=CDS_NO_INFO;
> -                return;
> -        }        
>  	/* Grab the TOC header so we can see how many tracks there are */
>  	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header))) {
>  		if (ret == -ENOMEDIUM)
