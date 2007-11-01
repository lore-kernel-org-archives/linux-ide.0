From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/15] ide: remove atapi_error_t
Date: Thu, 01 Nov 2007 21:47:12 +0300
Message-ID: <472A1F30.805@ru.mvista.com>
References: <200710310025.55983.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:52509 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753331AbXKASrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 14:47:08 -0400
In-Reply-To: <200710310025.55983.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Remove atapi_error_t.

> While at it:
> * replace 'HWIF(drive)' by 'drive->hwif'

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-floppy.c |    3 +--
>  drivers/ide/ide-lib.c    |   21 ++++++++++-----------
>  drivers/ide/ide-tape.c   |    3 +--
>  include/linux/ide.h      |   30 ------------------------------
>  4 files changed, 12 insertions(+), 45 deletions(-)

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
[...]
> @@ -576,19 +575,19 @@ static u8 ide_dump_atapi_status(ide_driv
>  	}
>  	printk("}\n");
>  	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
> -		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
> -		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
> -		if (error.b.ili)	printk("IllegalLengthIndication ");
> -		if (error.b.eom)	printk("EndOfMedia ");
> -		if (error.b.abrt)	printk("AbortedCommand ");
> -		if (error.b.mcr)	printk("MediaChangeRequested ");
> -		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
> -						error.b.sense_key);
> +		err = drive->hwif->INB(IDE_ERROR_REG);
> +		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
> +		if (err & MARK_ERR)	printk("IllegalLengthIndication ");
> +		if (err & TRK0_ERR)	printk("EndOfMedia ");
> +		if (err & ABRT_ERR)	printk("AbortedCommand ");
> +		if (err & MCR_ERR)	printk("MediaChangeRequested ");
> +		if (err & 0xf0)		printk("LastFailedSense=0x%02x ",
> +						(err & 0xf0) >> 4);

    I'd rather prefer that the ATAPI bit definitions be added to 
<linux/hdreg.h> -- the ATAPI sector count register fields definitions are 
already there...

MBR, Sergei
