From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Fix Promise UDMA33 IDE driver (pdc202xx_old)
Date: Tue, 05 Jan 2010 20:52:42 +0300
Message-ID: <4B437C6A.2040705@ru.mvista.com>
References: <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103223542.GA24920@flint.arm.linux.org.uk> <4B423E2F.9040808@ru.mvista.com> <20100104.222658.93634328.davem@davemloft.net> <20100105174915.GC30868@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:48406 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754979Ab0AERwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 12:52:51 -0500
In-Reply-To: <20100105174915.GC30868@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello.

Russell King wrote:

>>From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>Date: Mon, 04 Jan 2010 22:14:55 +0300

>>>   I suggest that we completely ignore the "FIFO empty"
>>>   bit. dma_test_irq() method which is called eventually when doing FMA
>>>   should yield the needed result WRT FIFO flushing, filtering out .

>>Can someone implement and test such a revised patch?

> Do we have any guarantee that the interrupt bit in this register will
> only be set when the DMA FIFOs on the card have emptied?

> Unlike the SFF status register's interrupt bit, which is defined by SFF
> to only be asserted when the drive signals an interrupt _and_ the FIFOs
> have emptied, there seems to be no such words in the PDC20246 data which
> suggests that the same is true of the interrupt bit in this alternative
> register.

    So what? The SFF status register will be read eventually.

> Therefore, I would suggest that using this alternative bit could be unsafe
> with shared interrupts without also qualifying it with the FIFO empty
> bit - we could end up disabling the DMA before the transfer has completed,
> thereby corrupting the last few words of a transfer from the drive.

    How so?

> What was the reason for checking this alternate promise-special register
> in the first place, rather than the SFF BM-DMA status register?

    It's not "rather then" -- we're checking both.

MBR, Sergei
