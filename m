From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/15] ide: remove atapi_error_t
Date: Sun, 04 Nov 2007 16:05:05 +0300
Message-ID: <472DC381.2010307@ru.mvista.com>
References: <200710310025.55983.bzolnier@gmail.com> <472A1F30.805@ru.mvista.com> <200711022104.16206.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10664 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755718AbXKDNE5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 08:04:57 -0500
In-Reply-To: <200711022104.16206.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>Index: b/drivers/ide/ide-lib.c
>>>===================================================================
>>>--- a/drivers/ide/ide-lib.c
>>>+++ b/drivers/ide/ide-lib.c

>>[...]

>>>@@ -576,19 +575,19 @@ static u8 ide_dump_atapi_status(ide_driv
>>> 	}
>>> 	printk("}\n");
>>> 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
>>>-		error.all = HWIF(drive)->INB(IDE_ERROR_REG);
>>>-		printk("%s: %s: error=0x%02x { ", drive->name, msg, error.all);
>>>-		if (error.b.ili)	printk("IllegalLengthIndication ");
>>>-		if (error.b.eom)	printk("EndOfMedia ");
>>>-		if (error.b.abrt)	printk("AbortedCommand ");
>>>-		if (error.b.mcr)	printk("MediaChangeRequested ");
>>>-		if (error.b.sense_key)	printk("LastFailedSense=0x%02x ",
>>>-						error.b.sense_key);
>>>+		err = drive->hwif->INB(IDE_ERROR_REG);
>>>+		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
>>>+		if (err & MARK_ERR)	printk("IllegalLengthIndication ");
>>>+		if (err & TRK0_ERR)	printk("EndOfMedia ");
>>>+		if (err & ABRT_ERR)	printk("AbortedCommand ");
>>>+		if (err & MCR_ERR)	printk("MediaChangeRequested ");
>>>+		if (err & 0xf0)		printk("LastFailedSense=0x%02x ",
>>>+						(err & 0xf0) >> 4);

>>    I'd rather prefer that the ATAPI bit definitions be added to 
>><linux/hdreg.h> -- the ATAPI sector count register fields definitions are 
>>already there...

> Yeah, that should do it:

> [PATCH] ide: remove atapi_error_t (take 2)

> Remove atapi_error_t.

> While at it:
> * replace 'HWIF(drive)' by 'drive->hwif'

> v2:
> * Add {ILI,EOM,LFS}_ERR defines to <linux/hdreg.h>.

> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

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
> +		if (err & ILI_ERR)	printk("IllegalLengthIndication ");
> +		if (err & EOM_ERR)	printk("EndOfMedia ");
> +		if (err & ABRT_ERR)	printk("AbortedCommand ");
> +		if (err & MCR_ERR)	printk("MediaChangeRequested ");

    Well, actually MCR bit is not defined for ATAPI (this condition should be 
reported via REQUEST SENSE I guess).

> +		if (err & LFS_ERR)	printk("LastFailedSense=0x%02x ",
> +						(err & LFS_ERR) >> 4);
> ===================================================================
> --- a/include/linux/hdreg.h
> +++ b/include/linux/hdreg.h
[...]
> @@ -52,6 +54,7 @@
>  #define ECC_ERR			0x40	/* Uncorrectable ECC error */
>  #define BBD_ERR			0x80	/* pre-EIDE meaning:  block marked bad */
>  #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
> +#define LFS_ERR			0xf0	/* Last Failed Sense (ATAPI) */

    Well, the field name is actually just "sense key"...

MBR, Sergei
