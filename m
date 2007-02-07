From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 14:57:27 +0100
Message-ID: <45C9DAC7.10701@imc-berlin.de>
References: <45C9A23E.3030201@imc-berlin.de>	<20070207115826.2e3609e3@localhost.localdomain>	<45C9D34E.1060007@imc-berlin.de> <20070207135309.66942d25@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:35378 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161305AbXBGN53 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 08:57:29 -0500
In-Reply-To: <20070207135309.66942d25@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan,

>>> Only relevant for DMA really
>> So rqsize is only needed for DMA accesses?
> 
> PIO transfers are sector at a time, or multi-sector up to a usual limit
> of about 16 sectors.

So again: rqsize does not matter for PIO transfer?

Looking at the lines

	if (hwif->no_lba48_dma && lba48 && dma) {
		if (block + rq->nr_sectors > 1ULL << 28)
			dma = 0;
		else
			lba48 = 0;
	}

in drivers/ide/ide-disk.c. Does that mean that 48bit LBA adressing using the
task_ioreg_t stuff is only used for sector numbers larger 1 << 28?
Thus for small HDDs only LBA28 ist used by

			hwif->OUTB(block, IDE_SECTOR_REG);
			hwif->OUTB(block>>=8, IDE_LCYL_REG);
			hwif->OUTB(block>>=8, IDE_HCYL_REG);

???

Thanks a million!!!!

Steven
