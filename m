From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] cdrom: longer timeout for "Read Track Info" command
Date: Tue, 2 Jan 2007 16:59:42 -0800
Message-ID: <20070103005942.GB25765@sgi.com>
References: <20070102023623.GA3108@sgi.com> <20070102102829.4117b230@localhost.localdomain> <20070102135052.GA2483@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:54769 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752532AbXACA7p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 19:59:45 -0500
Content-Disposition: inline
In-Reply-To: <20070102135052.GA2483@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org

On Tue, Jan 02, 2007 at 02:50:53PM +0100, Jens Axboe wrote:
> Yep, I suspect this patch is long overdue. Jeremy, is this enough to fix
> it for you?

Yes, the 7 second timeout is fine.  It actually takes about 6.7 seconds.
I guess if "another popular OS" has a 7 second timeout that we won't find
multimedia devices out there that take longer than that.  :-)

My 15 seconds assumed that the observed case wasn't the worst case, but
it probably is.

This patch looks good.

Thanks

jeremy

> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 66d028d..3105ddd 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -337,6 +337,12 @@ static const char *mrw_address_space[] = { "DMA", "GAA" };
>  /* used in the audio ioctls */
>  #define CHECKAUDIO if ((ret=check_for_audio_disc(cdi, cdo))) return ret
>  
> +/*
> + * Another popular OS uses 7 seconds as the hard timeout for default
> + * commands, so it is a good choice for us as well.
> + */
> +#define CDROM_DEF_TIMEOUT	(7 * HZ)
> +
>  /* Not-exported routines. */
>  static int open_for_data(struct cdrom_device_info * cdi);
>  static int check_for_audio_disc(struct cdrom_device_info * cdi,
> @@ -1528,7 +1534,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
>  	cgc->buffer = (char *) buf;
>  	cgc->buflen = len;
>  	cgc->data_direction = type;
> -	cgc->timeout = 5*HZ;
> +	cgc->timeout = CDROM_DEF_TIMEOUT;
>  }
>  
>  /* DVD handling */
