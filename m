From: Pavel Troller <patrol@sinus.cz>
Subject: Re: ide-cd in 2.6.10/11: BIG problem with burning audio CDs
Date: Thu, 3 Feb 2005 12:55:07 +0100
Message-ID: <20050203115506.GA6949@tangens.sinus.cz>
References: <20050203085452.GA22995@tangens.sinus.cz> <20050203110547.GU5710@suse.de>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from tangens.sinus.cz ([195.39.17.8]:59044 "HELO tangens.sinus.cz")
	by vger.kernel.org with SMTP id S263452AbVBCLzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 06:55:23 -0500
Content-Disposition: inline
In-Reply-To: <20050203110547.GU5710@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, silk@sinus.cz

> On Thu, Feb 03 2005, Pavel Troller wrote:
> >   The problem is that on 2.6.10 and 2.6.11-rc[1-3], burning audio CDs
> >   consumes so much CPU cycles, that my dual Athlon 1800+ system cannot
> >   serve the process and cd burner dies of repeated buffer underruns or
> >   totally crashes, requiring physical reset to revive (no ide bus
> >   reset is enough).
> 
> Try this patch.
> 
> ===== drivers/ide/ide-cd.c 1.105 vs edited =====
> --- 1.105/drivers/ide/ide-cd.c	2005-01-08 06:43:53 +01:00
> +++ edited/drivers/ide/ide-cd.c	2005-01-09 16:31:53 +01:00
> @@ -1915,7 +1915,7 @@
>  		/*
>  		 * check if dma is safe
>  		 */
> -		if ((rq->data_len & mask) || (addr & mask))
> +		if ((rq->data_len & 3) || (addr & mask))
>  			info->dma = 0;
>  	}
>  
Hi Jens,
  many thanks, that's exactly what fixes the problem :-)! Now I can burn on
the 40x speed as well as with 2.6.7... Great work!
  So it REALLY was a DMA issue... 
                             With regards, Pavel Troller
