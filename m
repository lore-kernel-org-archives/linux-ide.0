From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 02/10] ide-floppy: move ide-floppy struct and macro defs into its own header. While at it
Date: Fri, 4 Jan 2008 23:49:09 +0100
Message-ID: <200801042349.09964.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-2-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-3-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:8617 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbYADWje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 17:39:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2842044ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 14:39:29 -0800 (PST)
In-Reply-To: <1199366409-26016-3-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

Hmm, contrary to ide-cd.c case there doesn't seem to be a need currently for
moving code out of ide-floppy.c (and this patch series doesn't change that).

Besides it would be better to just remove some structs like it has been done
with i.e. struct atapi_capabilities_page in ide-cd.c case [1] because:

* it is easier to audit/debug the code if you don't have to look at typedefs
  all the time just to see which bytes/bits the code is really accessing

* not using typedefs will make the source code significantly smaller

* documentation is publically available

* these structs are not memory mapped

[1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg242747.html

On Thursday 03 January 2008, Borislav Petkov wrote:
> - do a white-space cleanup
> - remove old crufty code untouched since at least 2005

Please try to not mix things like moving code around and doing actual
changes because it makes patch review difficult (i.e. it took me quite a
while to find "old crufty code" that has been removed)...

Sometimes having more "trivial" patches is better...

> - shorten lines longer than 80ish columns
> - shorten some LAAARGE typenames.

typedefs are evil (exceptions are rare) and should die :)

> There should be no functional changes resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |  763 ++++++++++++----------------------------------
>  drivers/ide/ide-floppy.h |  382 +++++++++++++++++++++++
>  2 files changed, 581 insertions(+), 564 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 785fbde..52d09c1 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c

[...]

> -} idefloppy_capabilities_page_t;

[...]

> -} idefloppy_flexible_disk_page_t;

[...]

> -} idefloppy_capacity_descriptor_t;

as mentioned earlier it would be best to just remove these structs/typedefs

[ respective structures are described in SFF-8070i spec, it is useful to audit
  the final code against the spec to catch potential coding mistakes early ]

[...]

> -#if 0
> -/*
> - *	Special requests for our block device strategy routine.
> - */
> -#define	IDEFLOPPY_FIRST_RQ	90
> -
> -/*
> - * 	IDEFLOPPY_PC_RQ is used to queue a packet command in the request queue.
> - */
> -#define	IDEFLOPPY_PC_RQ		90
> -
> -#define IDEFLOPPY_LAST_RQ	90
> -
> -/*
> - *	A macro which can be used to check if a given request command
> - *	originated in the driver or in the buffer cache layer.
> - */
> -#define IDEFLOPPY_RQ_CMD(cmd) 	((cmd >= IDEFLOPPY_FIRST_RQ) && (cmd <= IDEFLOPPY_LAST_RQ))
> -
> -#endif

Well, it was already removed, the patch is in IDE tree (and thus in -mm).

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc6/2.6.24-rc6-mm1/broken-out/ide-mm-ide-floppy-remove-dead-code.patch

If possible please base your patches against IDE tree or the latest -mm patch.

[...]

> -} idefloppy_inquiry_result_t;

[...]

> -} idefloppy_request_sense_result_t;

[...]

> -} idefloppy_mode_parameter_header_t;

more structs/typedefs heading for /dev/null

[...]

> @@ -1689,9 +1304,12 @@ static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
>  	printk(KERN_INFO "Write buffer size(?): %d bytes\n",id->buf_size*512);
>  	printk(KERN_INFO "DMA: %s",id->capability & 0x01 ? "Yes\n":"No\n");
>  	printk(KERN_INFO "LBA: %s",id->capability & 0x02 ? "Yes\n":"No\n");
> -	printk(KERN_INFO "IORDY can be disabled: %s",id->capability & 0x04 ? "Yes\n":"No\n");
> -	printk(KERN_INFO "IORDY supported: %s",id->capability & 0x08 ? "Yes\n":"Unknown\n");
> -	printk(KERN_INFO "ATAPI overlap supported: %s",id->capability & 0x20 ? "Yes\n":"No\n");
> +	printk(KERN_INFO "IORDY can be disabled: %s",
> +			id->capability & 0x04 ? "Yes\n":"No\n");
> +	printk(KERN_INFO "IORDY supported: %s",
> +			id->capability & 0x08 ? "Yes\n":"Unknown\n");
> +	printk(KERN_INFO "ATAPI overlap supported: %s",
> +			id->capability & 0x20 ? "Yes\n":"No\n");
>  	printk(KERN_INFO "PIO Cycle Timing Category: %d\n",id->tPIO);
>  	printk(KERN_INFO "DMA Cycle Timing Category: %d\n",id->tDMA);
>  	printk(KERN_INFO "Single Word DMA supported modes:\n");
> @@ -1713,12 +1331,16 @@ static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
>  			sprintf(buffer, "Not supported");
>  		else
>  			sprintf(buffer, "%d ns",id->eide_dma_min);
> -		printk(KERN_INFO "Minimum Multi-word DMA cycle per word: %s\n", buffer);
> +		printk(KERN_INFO "Minimum Multi-word DMA cycle per word: %s\n",
> +				buffer);
> +
>  		if (id->eide_dma_time == 0)
>  			sprintf(buffer, "Not supported");
>  		else
>  			sprintf(buffer, "%d ns",id->eide_dma_time);
> -		printk(KERN_INFO "Manufacturer\'s Recommended Multi-word cycle: %s\n", buffer);
> +		printk(KERN_INFO "Manufacturer\'s Recommended Multi-word"
> +				" cycle: %s\n", buffer);
> +
>  		if (id->eide_pio == 0)
>  			sprintf(buffer, "Not supported");
>  		else
> @@ -1731,7 +1353,8 @@ static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
>  			sprintf(buffer, "%d ns",id->eide_pio_iordy);
>  		printk(KERN_INFO "Minimum PIO cycle with IORDY: %s\n", buffer);
>  	} else
> -		printk(KERN_INFO "According to the device, fields 64-70 are not valid.\n");
> +		printk(KERN_INFO "According to the device, fields 64-70 are not"
> +				" valid.\n");
>  #endif /* IDEFLOPPY_DEBUG_INFO */
>  
>  	if (gcw.protocol != 2)

identify dumping has been removed by:

http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-floppy-tape-remove-debug-code-for-dumping-identify-data.patch

[ not in -mm yet ]

Please rework/resubmit this patch (preferably splitted on few smaller ones).

Thanks,
Bart

PS please also check your patches with scripts/checkpatch.pl before posting
