From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix Promise UDMA33 IDE driver (pdc202xx_old)
Date: Tue, 5 Jan 2010 17:49:15 +0000
Message-ID: <20100105174915.GC30868@flint.arm.linux.org.uk>
References: <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103223542.GA24920@flint.arm.linux.org.uk> <4B423E2F.9040808@ru.mvista.com> <20100104.222658.93634328.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42092 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0AERtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 12:49:42 -0500
Content-Disposition: inline
In-Reply-To: <20100104.222658.93634328.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 10:26:58PM -0800, David Miller wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Mon, 04 Jan 2010 22:14:55 +0300
> 
> >    I suggest that we completely ignore the "FIFO empty"
> >    bit. dma_test_irq() method which is called eventually when doing FMA
> >    should yield the needed result WRT FIFO flushing, filtering out .
> 
> Can someone implement and test such a revised patch?

Do we have any guarantee that the interrupt bit in this register will
only be set when the DMA FIFOs on the card have emptied?

Unlike the SFF status register's interrupt bit, which is defined by SFF
to only be asserted when the drive signals an interrupt _and_ the FIFOs
have emptied, there seems to be no such words in the PDC20246 data which
suggests that the same is true of the interrupt bit in this alternative
register.

Therefore, I would suggest that using this alternative bit could be unsafe
with shared interrupts without also qualifying it with the FIFO empty
bit - we could end up disabling the DMA before the transfer has completed,
thereby corrupting the last few words of a transfer from the drive.

What was the reason for checking this alternate promise-special register
in the first place, rather than the SFF BM-DMA status register?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
