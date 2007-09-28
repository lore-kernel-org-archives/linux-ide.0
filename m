From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/8] ata: add ATA_MWDMA* and ATA_SWDMA* defines
Date: Fri, 28 Sep 2007 16:10:56 +0400
Message-ID: <46FCEF50.4060200@ru.mvista.com>
References: <200708271935.22751.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44704 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754015AbXI1MLN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 08:11:13 -0400
In-Reply-To: <200708271935.22751.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/include/linux/ata.h
> ===================================================================
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -73,6 +73,19 @@ enum {
>  	ATA_PIO5		= ATA_PIO4 | (1 << 5),
>  	ATA_PIO6		= ATA_PIO5 | (1 << 6),
>  
> +	ATA_SWDMA0		= (1 << 0),
> +	ATA_SWDMA1		= ATA_SWDMA0 | (1 << 1),
> +	ATA_SWDMA2		= ATA_SWDMA1 | (1 << 2),
> +
> +	ATA_SWDMA2_ONLY		= (1 << 2),

    Hm, specially for PIIX/ICH? :-)

> +	ATA_MWDMA0		= (1 << 0),
> +	ATA_MWDMA1		= ATA_MWDMA0 | (1 << 1),
> +	ATA_MWDMA2		= ATA_MWDMA1 | (1 << 2),
> +
> +	ATA_MWDMA12_ONLY	= (1 << 1) | (1 << 2),

    For PIIX/ICH, I see...

> +	ATA_MWDMA2_ONLY		= (1 << 2),

    We still have such? Ah, must be sgiioc4...

MBR, Sergei
