From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/18] ide: add ide_tf_read() helper
Date: Fri, 09 Nov 2007 13:29:27 +0300
Message-ID: <47343687.1030309@ru.mvista.com>
References: <200711050021.50748.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:64185 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbXKIK3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 05:29:14 -0500
In-Reply-To: <200711050021.50748.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Factor out code reading taskfile registers from ide_end_drive_cmd()
>   to the new ide_tf_read() helper.

> * Add IDE_TFLAG_IN_* taskfile flags to indicate the need to load
>   particular IDE taskfile register in ide_tf_read().

> * Update ide_end_drive_cmd() to set respective IDE_TFLAG_IN_* taksfile flags.

> * Add ide_get_lba_addr() for getting LBA sector address from taskfile struct.

> * Factor out code getting sector address from ide_dump_ata_status()
>   to the new ide_dump_sector() function.

> * Convert ide_dump_sector() to use ide_tf_read() and ide_get_lba_addr().

> * Remove no longer needed ide_read_24().

> The only change in functionality caused by this patch is that
> ide_dump_ata_status() no longer prints "high"/"low" parts of LBA48
> sector address (of course LBA48 sector address is still printed).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -913,6 +913,27 @@ enum {
>  	IDE_TFLAG_IN_DATA		= (1 << 17),
>  	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 18),
>  	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 19),
> +	IDE_TFLAG_IN_HOB_FEATURE	= (1 << 20),
> +	IDE_TFLAG_IN_HOB_NSECT		= (1 << 21),
> +	IDE_TFLAG_IN_HOB_LBAL		= (1 << 22),
> +	IDE_TFLAG_IN_HOB_LBAM		= (1 << 23),
> +	IDE_TFLAG_IN_HOB_LBAH		= (1 << 24),
> +	IDE_TFLAG_IN_HOB_LBA		= IDE_TFLAG_IN_HOB_LBAL |
> +					  IDE_TFLAG_IN_HOB_LBAM |
> +					  IDE_TFLAG_IN_HOB_LBAH,
> +	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_FEATURE |
> +					  IDE_TFLAG_IN_HOB_NSECT |
> +					  IDE_TFLAG_IN_HOB_LBA,
> +	IDE_TFLAG_IN_NSECT		= (1 << 25),
> +	IDE_TFLAG_IN_LBAL		= (1 << 26),
> +	IDE_TFLAG_IN_LBAM		= (1 << 27),
> +	IDE_TFLAG_IN_LBAH		= (1 << 28),
> +	IDE_TFLAG_IN_LBA		= IDE_TFLAG_IN_LBAL |
> +					  IDE_TFLAG_IN_LBAM |
> +					  IDE_TFLAG_IN_LBAH,
> +	IDE_TFLAG_IN_TF			= IDE_TFLAG_IN_NSECT |
> +					  IDE_TFLAG_IN_LBA,
> +	IDE_TFLAG_IN_DEVICE		= (1 << 29),

    Hm, yet the device/head is a part of the LBA in 24-bit mode...

>  };
>  
>  struct ide_taskfile {

MBR, Sergei
