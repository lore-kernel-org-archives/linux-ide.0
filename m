From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/8] ide: add IDE_HFLAG_NO_LBA48 and IDE_HFLAG_NO_LBA48_DMA
 host flags
Date: Thu, 04 Oct 2007 18:53:39 +0400
Message-ID: <4704FE73.5010602@ru.mvista.com>
References: <200708271934.18313.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:47259 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756380AbXJDOx7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 10:53:59 -0400
In-Reply-To: <200708271934.18313.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Add IDE_HFLAG_NO_LBA48[_DMA] host flags, use it instead of hwif->no_lba48[_dma]
> and then remove no longer needed hwif->no_lba48[_dma].  As a side-effect
> this change fixes hwif->no_lba48_dma not being restored by ide_hwif_restore().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-probe.c
> ===================================================================
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -951,7 +951,8 @@ static int ide_init_queue(ide_drive_t *d
>  	blk_queue_segment_boundary(q, 0xffff);
>  
>  	if (!hwif->rqsize) {
> -		if (hwif->no_lba48 || hwif->no_lba48_dma)
> +		if ((hwif->host_flags & IDE_HFLAG_NO_LBA48) ||
> +		    (hwif->host_flags & IDE_HFLAG_NO_LBA48_DMA))

    Could have been:

		if (hwif->host_flags &
		   (IDE_HFLAG_NO_LBA48_DMA | IDE_HFLAG_NO_LBA48_DMA))

MBR, Sergei
