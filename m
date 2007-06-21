From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 19/19] ide: use PIO/MMIO operations directly where possible
Date: Thu, 21 Jun 2007 21:16:03 +0400
Message-ID: <467AB253.8010902@ru.mvista.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain> <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64327 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754737AbXFUROW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 13:14:22 -0400
In-Reply-To: <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: use PIO/MMIO operations directly where possible

> This results in smaller/faster/simpler code and allows future optimizations.
> Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: a/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a.orig/drivers/ide/pci/hpt366.c
> +++ a/drivers/ide/pci/hpt366.c
> @@ -836,7 +836,7 @@ static int hpt374_ide_dma_test_irq(ide_d
>  		return 0;
>  	}
>  
> -	dma_stat = hwif->INB(hwif->dma_status);
> +	dma_stat = inb(hwif->dma_status);
>  	/* return 1 if INTR asserted */
>  	if (dma_stat & 4)
>  		return 1;

    Hmm... this driver *still* has a lot more indirect I/O accessors -- I 
wonder why only this one had been converted then?

MBR, Sergei

