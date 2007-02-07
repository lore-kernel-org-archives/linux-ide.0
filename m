From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 17:09:34 +0300
Message-ID: <45C9DD9E.3070706@ru.mvista.com>
References: <45C9A23E.3030201@imc-berlin.de>	<20070207115826.2e3609e3@localhost.localdomain>	<45C9D34E.1060007@imc-berlin.de> <20070207135309.66942d25@localhost.localdomain> <45C9DAC7.10701@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34258 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161318AbXBGOJl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 09:09:41 -0500
In-Reply-To: <45C9DAC7.10701@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Steven Scholz wrote:

>>>So rqsize is only needed for DMA accesses?

>>PIO transfers are sector at a time, or multi-sector up to a usual limit
>>of about 16 sectors.

> So again: rqsize does not matter for PIO transfer?

> Looking at the lines

> 	if (hwif->no_lba48_dma && lba48 && dma) {
> 		if (block + rq->nr_sectors > 1ULL << 28)
> 			dma = 0;
> 		else
> 			lba48 = 0;
> 	}

> in drivers/ide/ide-disk.c. Does that mean that 48bit LBA adressing using the
> task_ioreg_t stuff is only used for sector numbers larger 1 << 28?

    If you're asking in general, no, that does not follow from that code.
    It only takes care of the no_lba48_dma case.

MBR, Sergei
