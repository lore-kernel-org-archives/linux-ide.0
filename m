From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Fri, 21 Nov 2008 22:07:17 +0900
Message-ID: <4926B285.1030702@kernel.org>
References: <49263552.8090602@kernel.org> <20081121102504.63007bf6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58963 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbYKUNHd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 08:07:33 -0500
In-Reply-To: <20081121102504.63007bf6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

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

There are?  That's a good news.  Sure, if it's a common thing, we can
definitely make it a callback.  It actually goes together with
->sff_irq_clear pretty well.

Thanks.

-- 
tejun
