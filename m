From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/12] ide-disk: merge LBA28 and LBA48 Host Protected Area
 support code
Date: Thu, 18 Oct 2007 16:59:19 +0400
Message-ID: <471758A7.90402@ru.mvista.com>
References: <200710082313.39894.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43019 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762954AbXJRM7I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 08:59:08 -0400
In-Reply-To: <200710082313.39894.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Merge idedisk_{read_native,set}_max_address_ext() into
>   idedisk_{read_native,set}_max_address().

> There should be no functionality changes caused by this patch.

    This is unfortunately not achieved...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    No cookie this time. :-)

> Index: b/drivers/ide/ide-disk.c
> ===================================================================
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
[...]
> @@ -350,31 +353,12 @@ static unsigned long idedisk_read_native
>  
>  	/* if OK, compute maximum address value */
>  	if ((tf->command & 0x01) == 0) {
> -		addr = ((tf->device & 0xf) << 24) |
> -		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
> -		addr++;	/* since the return value is (maxlba - 1), we add 1 */

    Actually, the return value is just maxlba (which is *not* the same as 
capacity).

> -	}
> -	return addr;
> -}
> -
> -static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
> -{
> -	ide_task_t args;
> -	struct ide_taskfile *tf = &args.tf;
> -	unsigned long long addr = 0;
> -
> -	/* Create IDE/ATA command request structure */
> -	memset(&args, 0, sizeof(ide_task_t));
> -	tf->device  = ATA_LBA;
> -	tf->command = WIN_READ_NATIVE_MAX_EXT;
> -	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
> -	args.handler				= &task_no_data_intr;
> -        /* submit command request */
> -        ide_raw_taskfile(drive, &args, NULL);
> -
> -	/* if OK, compute maximum address value */
> -	if ((tf->command & 0x01) == 0) {
>  		u32 high, low;

    No newline after declaration block.  Well, I see that it's been this way 
before the patch but it doesn't have to when this code has been already touched...

> +		if (lba48)
> +			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
> +				tf->hob_lbal;
> +		else
> +			high = tf->device & 0xf;
>  		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;

    Wait, you've just properly calculated 'high'!  And now LBA28 variant is 
borken. :-|

>  		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr = ((__u64)high << 24) | low;
> @@ -387,38 +371,11 @@ static unsigned long long idedisk_read_n

[...]

> @@ -438,7 +400,11 @@ static unsigned long long idedisk_set_ma
>  	/* if OK, compute maximum address value */
>  	if ((tf->command & 0x01) == 0) {
>  		u32 high, low;

   Again no newline after declaration...

> -		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> +		if (lba48)
> +			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
> +				tf->hob_lbal;
> +		else
> +			high = tf->device & 0xf;
>  		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr_set = ((__u64)high << 24) | low;
>  		addr_set++;

    BTW, haven't you noticed that LBA readback code is duplicate? It just asks 
to be put into a separate function, like:

static u64 ide_read_lba(struct ide_taskfile *tf)
{
	if (!(tf->command & 0x01)) {
		u32 high, low;

		if (lba48)
			high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) |
				tf->hob_lbal;
		else
			high = tf->device & 0xf;
		low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
		return (((__u64)high << 24) | low) + 1;
	} else
		return 0;
}

MBR, Sergei

