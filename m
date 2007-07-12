From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported
 modes
Date: Thu, 12 Jul 2007 23:23:20 +0400
Message-ID: <46967FA8.4090406@ru.mvista.com>
References: <200707110200.37607.bzolnier@gmail.com> <46952A87.6010005@ru.mvista.com> <20070711195641.GA2301@flint.arm.linux.org.uk> <200707112321.41597.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:37105 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752248AbXGLTVU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 15:21:20 -0400
In-Reply-To: <200707112321.41597.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Moreover, I think the patch is quite broken.  If an invalid DMA mode
>>is passed, currently the driver sets the cycle time to 480ns (stored
>>in drive_data) since both cycle_time and use_dma_info will be zero.
>>Moreover, 'on' will be zero, causing icside_set_speed() to return zero
>>which means the DMA setting was not successful (iow, use PIO).

> Thanks for spotting this.  The patch in the current form is indeed broken
> as I haven't noticed that icside_set_speed() returns zero on failure.

    You're not the only one.

> However all other implementations of ->speedproc return zero on success
> and non-zero on failure.  Currently it doesn't matter for icside host
> driver and isn't a bug per se since:

> - ide_set_xfer_rate() return value is ignored by all IDE core users

    Indeed. So my accusation of breaking the usermode interface (and UltraDMA
downgrade) was too rash. :-<

> - icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

    Yeah, that was rash too. :-<

> but sooner or later we will need to fix anyway - so lets do it now.

> It also seems to cleanup icside_dma_check() a bit since return value
> invertion is no longer needed.


> [PATCH] icside: fix ->speedproc to return on unsupported modes (take 2)

> * All other implementations of ->speedproc return zero on success
>   and non-zero on failure.  Currently it doesn't matter for icside host
>   driver and isn't a bug per se since:

>   - ide_set_xfer_rate() return value is ignored by all IDE core users

>   - icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

>   but sooner or later we will need to fix anyway - so lets do it now.

> * icside_set_speed() happily accepts unsupported transfer modes which
>   results in drive->drive_data being set to the maximum value (480)
>   and drive->current_speed being set to the unsupported transfer mode.

    I don't understand why it needs to bother setting drive->current_speed at 
all to begin with.

>   Fix it.

> v2:
> - The initial version of the patch was broken because it didn't take into
>   the account (the different from usual) return values of icside_set_speed().
>   (Noticed by Russell).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Looks like the patch still needs more polishing:

> Index: b/drivers/ide/arm/icside.c
> ===================================================================
> --- a/drivers/ide/arm/icside.c
> +++ b/drivers/ide/arm/icside.c
> @@ -250,7 +250,7 @@ static void icside_build_sglist(ide_driv
>   */
>  static int icside_set_speed(ide_drive_t *drive, const u8 xfer_mode)
>  {
> -	int on = 0, cycle_time = 0, use_dma_info = 0;
> +	int on = -1, cycle_time = 0, use_dma_info = 0;

    We don't need to pre-initialize cycle_time anymore.

>  	switch (xfer_mode) {
>  	case XFER_MW_DMA_2:
> @@ -272,6 +272,8 @@ static int icside_set_speed(ide_drive_t 
>  	case XFER_SW_DMA_0:
>  		cycle_time = 480;
>  		break;
> +	default:
> +		return 1;
>  	}
>  
>  	/*
> @@ -284,7 +286,7 @@ static int icside_set_speed(ide_drive_t 
>  	drive->drive_data = cycle_time;
>  
>  	if (cycle_time && ide_config_drive_speed(drive, xfer_mode) == 0)

    Now cycle_time can't be 0 here, so the first condition may be dropped.

> -		on = 1;
> +		on = 0;
>  	else
>  		drive->drive_data = 480;

    I'm not sure that this really makes sense now.

MBR, Sergei

