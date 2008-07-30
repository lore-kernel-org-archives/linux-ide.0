From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ide-cd: fix endianity for the error message in
 cdrom_read_capacity
Date: Wed, 30 Jul 2008 01:18:32 -0700
Message-ID: <20080730011832.0ee55d47.akpm@linux-foundation.org>
References: <1217405406.11834.11.camel@elijah.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbYG3ISt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 04:18:49 -0400
In-Reply-To: <1217405406.11834.11.camel@elijah.suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Jan Kara <jack@suse.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 30 Jul 2008 10:10:06 +0200 Petr Tesarik <ptesarik@suse.cz> wrote:

> Resent because of a typo in the LKML address. :(

Thanks.

> 
> Aesthetic regards aside, commit e8e7b9eb11c34ee18bde8b7011af41938d1ad667
> still leaves a bug in the error message, because it uses the unconverted
> big-endian value for printk.
> 
> Fix this by using a local variable in machine byte order. The result is
> correct, more readable, and also produces slightly shorter code on i386.
> 
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

Bart owns this patch now.  It got lost for a month and it has already
been fixed twice and it is also on the route to 2.6.25.x and 2.6.26.x,
so it'll get complicated.  Not a happy little patch.

> 
>  ide-cd.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1305,6 +1305,7 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
>  	int stat;
>  	unsigned char cmd[BLK_MAX_CDB];
>  	unsigned len = sizeof(capbuf);
> +	__u32 blocklen;
>  
>  	memset(cmd, 0, BLK_MAX_CDB);
>  	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
> @@ -1317,23 +1318,24 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
>  	/*
>  	 * Sanity check the given block size
>  	 */
> -	switch (capbuf.blocklen) {
> -	case __constant_cpu_to_be32(512):
> -	case __constant_cpu_to_be32(1024):
> -	case __constant_cpu_to_be32(2048):
> -	case __constant_cpu_to_be32(4096):
> +	blocklen = be32_to_cpu(capbuf.blocklen);
> +	switch (blocklen) {
> +	case 512:
> +	case 1024:
> +	case 2048:
> +	case 4096:
>  		break;
>  	default:
>  		printk(KERN_ERR "%s: weird block size %u\n",
> -			drive->name, capbuf.blocklen);
> +			drive->name, blocklen);
>  		printk(KERN_ERR "%s: default to 2kb block size\n",
>  			drive->name);
> -		capbuf.blocklen = __constant_cpu_to_be32(2048);
> +		blocklen = 2048;
>  		break;
>  	}
>  
>  	*capacity = 1 + be32_to_cpu(capbuf.lba);
> -	*sectors_per_frame = be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
> +	*sectors_per_frame = blocklen >> SECTOR_BITS;
>  	return 0;
>  }
>  
> 
