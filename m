From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 41/63] ide-cd: move lba_to_msf() and msf_to_lba() to
	<linux/cdrom.h>
Date: Thu, 20 Dec 2007 09:27:10 +0100
Message-ID: <20071220082710.GJ13958@kernel.dk>
References: <200712200224.16183.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:13331 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbXLTIbw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2007 03:31:52 -0500
Content-Disposition: inline
In-Reply-To: <200712200224.16183.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 20 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> * Move lba_to_msf() and msf_to_lba() to <linux/cdrom.h>
>   (use 'u8' type instead of 'byte' while at it).
> 
> * Remove msf_to_lba() copy from drivers/cdrom/cdrom.c.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Jens Axboe <jens.axboe@oracle.com>

> ---
>  drivers/cdrom/cdrom.c |    6 ------
>  drivers/ide/ide-cd.c  |   18 ------------------
>  include/linux/cdrom.h |   14 ++++++++++++++
>  3 files changed, 14 insertions(+), 24 deletions(-)
> 
> Index: b/drivers/cdrom/cdrom.c
> ===================================================================
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -2787,12 +2787,6 @@ int cdrom_ioctl(struct file * file, stru
>  	return -ENOSYS;
>  }
>  
> -static inline
> -int msf_to_lba(char m, char s, char f)
> -{
> -	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
> -}
> -
>  /*
>   * Required when we need to use READ_10 to issue other than 2048 block
>   * reads
> Index: b/drivers/ide/ide-cd.c
> ===================================================================
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1643,24 +1643,6 @@ void msf_from_bcd (struct atapi_msf *msf
>  	msf->frame  = BCD2BIN(msf->frame);
>  }
>  
> -static inline
> -void lba_to_msf (int lba, byte *m, byte *s, byte *f)
> -{
> -	lba += CD_MSF_OFFSET;
> -	lba &= 0xffffff;  /* negative lbas use only 24 bits */
> -	*m = lba / (CD_SECS * CD_FRAMES);
> -	lba %= (CD_SECS * CD_FRAMES);
> -	*s = lba / CD_FRAMES;
> -	*f = lba % CD_FRAMES;
> -}
> -
> -
> -static inline
> -int msf_to_lba (byte m, byte s, byte f)
> -{
> -	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
> -}
> -
>  static int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
>  {
>  	struct request req;
> Index: b/include/linux/cdrom.h
> ===================================================================
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -1184,6 +1184,20 @@ struct media_event_desc {
>  
>  extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct media_event_desc *med);
>  
> +static inline void lba_to_msf(int lba, u8 *m, u8 *s, u8 *f)
> +{
> +	lba += CD_MSF_OFFSET;
> +	lba &= 0xffffff;  /* negative lbas use only 24 bits */
> +	*m = lba / (CD_SECS * CD_FRAMES);
> +	lba %= (CD_SECS * CD_FRAMES);
> +	*s = lba / CD_FRAMES;
> +	*f = lba % CD_FRAMES;
> +}
> +
> +static inline int msf_to_lba(u8 m, u8 s, u8 f)
> +{
> +	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
> +}
>  #endif  /* End of kernel only stuff */ 
>  
>  #endif  /* _LINUX_CDROM_H */

-- 
Jens Axboe

