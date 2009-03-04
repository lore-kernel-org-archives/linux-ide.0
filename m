From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: unsigned len subtracted below 0?
Date: Wed, 4 Mar 2009 08:20:44 +0100
Message-ID: <20090304072044.GA3273@liondog.tnic>
References: <49ADB9AA.106@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:56513 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZCDHUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 02:20:51 -0500
Received: by fxm24 with SMTP id 24so2749105fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 03 Mar 2009 23:20:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <49ADB9AA.106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, Mar 04, 2009 at 12:13:46AM +0100, Roel Kluin wrote:
> len is unsigned, so take care not to subtract below 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index ddfbea4..23447a0 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -916,7 +916,10 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  		xferfunc(drive, NULL, ptr, blen);
>  
>  		thislen -= blen;
> -		len -= blen;
> +		if (blen > len)
> +			len -= blen;
> +		else
> +			len = 0;

Hi,

can you please look at the code and try to understand what it does.
Especially the part where thislen is being initialized:

        thislen = blk_fs_request(rq) ? len : cmd->nleft;
        if (thislen > len)
                thislen = len;

now look at the loop where len is being decremented. Question: can len
really wrap?

>  
>  		if (blk_fs_request(rq)) {
>  			rq->buffer += blen;
