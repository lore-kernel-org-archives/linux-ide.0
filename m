From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: ide-cd.c blocklen is a big-endian value
Date: Thu, 24 Jul 2008 20:48:19 +0200
Message-ID: <200807242048.20087.bzolnier@gmail.com>
References: <1216852296.30386.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:10957 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYGXTOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:14:30 -0400
Received: by ug-out-1314.google.com with SMTP id h2so627387ugf.16
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:14:29 -0700 (PDT)
In-Reply-To: <1216852296.30386.21.camel@brick>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-next <linux-next@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Buesch <mb@bu3sch.de>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <petkovbb@googlemail.com>

On Thursday 24 July 2008, Harvey Harrison wrote:
> Noticed by sparse between next-20080722 and next-20080723
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Thanks for noticing/fixing this.

I integrated it into the guilty patch
("ide-cd: fix oops when using growisofs").

> ---
>  drivers/ide/ide-cd.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 3a6fef5..a384500 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1318,17 +1318,17 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
>  	 * Sanity check the given block size
>  	 */
>  	switch (capbuf.blocklen) {
> -	case 512:
> -	case 1024:
> -	case 2048:
> -	case 4096:
> +	case __constant_cpu_to_be32(512):
> +	case __constant_cpu_to_be32(1024):
> +	case __constant_cpu_to_be32(2048):
> +	case __constant_cpu_to_be32(4096):
>  		break;
>  	default:
>  		printk(KERN_ERR "%s: weird block size %u\n",
>  			drive->name, capbuf.blocklen);
>  		printk(KERN_ERR "%s: default to 2kb block size\n",
>  			drive->name);
> -		capbuf.blocklen = 2048;
> +		capbuf.blocklen = __constant_cpu_to_be32(2048);
>  		break;
>  	}
>  
> -- 
> 1.5.6.4.570.g052e
