From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ide: endian annotations in ide-floppy.c
Date: Thu, 19 Jun 2008 00:34:37 +0100
Message-ID: <20080618233437.GO28946@ZenIV.linux.org.uk>
References: <1213829856.2125.26.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46756 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbYFRXei (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 19:34:38 -0400
Content-Disposition: inline
In-Reply-To: <1213829856.2125.26.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

On Wed, Jun 18, 2008 at 03:57:35PM -0700, Harvey Harrison wrote:
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/ide/ide-floppy.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index f05fbc2..cba39fa 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -921,10 +921,10 @@ static int ide_floppy_get_flexible_disk_page(ide_drive_t *drive)
>  	set_disk_ro(floppy->disk, floppy->wp);
>  	page = &pc.buf[8];
>  
> -	transfer_rate = be16_to_cpu(*(u16 *)&pc.buf[8 + 2]);
> -	sector_size   = be16_to_cpu(*(u16 *)&pc.buf[8 + 6]);
> -	cyls          = be16_to_cpu(*(u16 *)&pc.buf[8 + 8]);
> -	rpm           = be16_to_cpu(*(u16 *)&pc.buf[8 + 28]);
> +	transfer_rate = be16_to_cpup((__be16 *)&pc.buf[8 + 2]);
> +	sector_size   = be16_to_cpup((__be16 *)&pc.buf[8 + 6]);
> +	cyls          = be16_to_cpup((__be16 *)&pc.buf[8 + 8]);
> +	rpm           = be16_to_cpup((__be16 *)&pc.buf[8 + 28]);

Pointless, IMO - just s/u16/__be16/ in the above.

> -		blocks = be32_to_cpu(*(u32 *)&pc.buf[desc_start]);
> -		length = be16_to_cpu(*(u16 *)&pc.buf[desc_start + 6]);
> +		blocks = be32_to_cpup((__be32 *)&pc.buf[desc_start]);
> +		length = be16_to_cpup((__be16 *)&pc.buf[desc_start + 6]);

Similar.

>  
>  		debug_log("Descriptor %d: %dkB, %d blocks, %d sector size\n",
>  				i, blocks * length / 1024, blocks, length);
> @@ -1121,8 +1121,8 @@ static int ide_floppy_get_format_capacities(ide_drive_t *drive, int __user *arg)
>  		if (u_index >= u_array_size)
>  			break;	/* User-supplied buffer too small */
>  
> -		blocks = be32_to_cpu(*(u32 *)&pc.buf[desc_start]);
> -		length = be16_to_cpu(*(u16 *)&pc.buf[desc_start + 6]);
> +		blocks = be32_to_cpup((__be32 *)&pc.buf[desc_start]);
> +		length = be16_to_cpup((__be16 *)&pc.buf[desc_start + 6]);

Ditto.
