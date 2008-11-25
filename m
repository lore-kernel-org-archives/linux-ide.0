From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Tue, 25 Nov 2008 12:07:58 -0500
Message-ID: <492C30EE.9080600@garzik.org>
References: <49263552.8090602@kernel.org> <20081121102504.63007bf6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56410 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbYKYRIG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 12:08:06 -0500
In-Reply-To: <20081121102504.63007bf6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Fri, 21 Nov 2008 13:13:06 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
>> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
>> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
>> clear them.  This protects ata_piix against nobody-cared which gets
>> reported not so rarely.
> 
> Various controllers have the ability to report the IRQ more reliably in
> similar fashion, should this not be part of ata_sff_interrupt with an
> optional ops->irq_pending call ?

Though I'm in general agreement with this sub-thread of opinions, I do 
note that, in the past, I have purposefully avoided an ->irq_pending.

I always felt the alternative -- writing a small irq handler function 
specifically for that controller -- was a much more flexible and 
powerful method of producing the desired result.

A separate interrupt function can, for example, perform an MMIO read to 
check irq-pending, outside of a spinlock.  ->irq_pending callback is a 
bit more constraining.

In terms of implementation, we could probably collapse all the 
non-controller-specific behavior into a single function call or macro, 
performed inside the custom interrupt handling routine.

	Jeff



