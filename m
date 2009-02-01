From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Mon, 02 Feb 2009 09:49:12 +1100
Message-ID: <1233528552.18767.62.camel@pasglop>
References: <1233294371.18767.23.camel@pasglop>
	 <1233313678.18767.25.camel@pasglop> <200902011744.07794.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55749 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbZBAW4E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Feb 2009 17:56:04 -0500
In-Reply-To: <200902011744.07794.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>


> Yeah my bad, though thanks to Andreas Schwab it is fixed in -rc3.

Hrm... I was using rc3 here and had the bug. I'll dig to check it's
really that or something else and send a patch if needed.

> Would be great as I have completely no idea about this stuff.

No worries.

> While you are at DMA support and will be fixing/testing it anyway
> you may try to remove long standing duplication/obfuscation:
> 
> 	/* Those fields are duplicating what is in hwif. We currently
> 	 * can't use the hwif ones because of some assumptions that are
> 	 * beeing done by the generic code about the kind of dma controller
> 	 * and format of the dma table. This will have to be fixed though.
> 	 */
> 	volatile struct dbdma_regs __iomem *	dma_regs;
> 	struct dbdma_cmd*		dma_table_cpu;
> 
> What needs to be done is more-or-less:
> 
> - teaching pmac_ide_init_dma() about hwif->prd_max_{nents,size}
>   and then converting it to use ide_allocate_dma_engine()
> 
> - pmif->dma_regs -> hwif->dma_base
> 
> - pmif->dma_table_cpu -> hwif->dmatable_cpu
> 
> - sticking ide_release_dma_engine() somewhere (it seems that
>   pmac driver never frees DMA memory allocated currently)

I'll have a look. Can't promise I'll get it all done this week tho. I
have several other urgent things on my plate.

> Of course while the above would be a nice cleanup+fixup, making
> the driver work comes first..

Heh, we'll see... ide-pmac was never quite intended as a module and
definitely not a module you can remove. I don't know if it's worth
fixing to be honest.

Cheers,
Ben.

> Thanks,
> Bart

