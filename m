From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] trm290: add IDE_HFLAG_TRM290 host flag
Date: Tue, 04 Nov 2008 20:36:30 +0300
Message-ID: <4910881E.3020609@ru.mvista.com>
References: <20081103200244.5098.29817.sendpatchset@localhost.localdomain> <20081103200313.5098.63642.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:47009 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754004AbYKDRgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 12:36:36 -0500
In-Reply-To: <20081103200313.5098.63642.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] trm290: add IDE_HFLAG_TRM290 host flag

> * Add IDE_HFLAG_TRM290 host flag and use it in ide_build_dmatable().

    Actually, I've considered removing TRM290 hacks from that function and 
re-implemeting the whole thing in the driver but that wouldn't sever this 
driver's ties with CONFIG_BLK_DEV_IDEDMA_SFF since the latter gets selected by 
CONFIG_BLK_DEV_IDEDMA_PCI...

> * Remove no longer needed ide_trm290 chipset type.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-dma-sff.c
> ===================================================================
> --- a/drivers/ide/ide-dma-sff.c
> +++ b/drivers/ide/ide-dma-sff.c
> @@ -98,10 +98,10 @@ int ide_build_dmatable(ide_drive_t *driv
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	__le32 *table = (__le32 *)hwif->dmatable_cpu;
> -	unsigned int is_trm290	= (hwif->chipset == ide_trm290) ? 1 : 0;
>  	unsigned int count = 0;
>  	int i;
>  	struct scatterlist *sg;
> +	u8 is_trm290 = !!(hwif->host_flags & IDE_HFLAG_TRM290);

    I'd keep all the initilaized variables together...

MBR, Sergei
