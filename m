From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] libata: kill spurious NCQ completion
 detection
Date: Fri, 07 Dec 2007 18:24:11 -0500
Message-ID: <4759D61B.8010802@rtr.ca>
References: <4758C20F.8020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2575 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbXLGXYO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 18:24:14 -0500
In-Reply-To: <4758C20F.8020005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, albertl@mail.com, diego torres <dtorres@coral.dnsalias.org>, Michael Tokarev <mjt@tls.msk.ru>

Tejun Heo wrote:
> Spurious NCQ completion detection implemented in ahci was incorrect.
> On AHCI receving and processing FISes and raising interrupts are not
> interlocked and spurious interrupts are expected.
> 
> For example, if an interrupt occurs while interrupt handler is running
> and the running interrupt handler handles the event the new IRQ
> indicated, after IRQ handler finishes, it will be executed again
> because IRQ pending bit is set by the new interrupt but there won't be
> anything to process.
...

Great job tracking that one down, Tejun!

Cheers
