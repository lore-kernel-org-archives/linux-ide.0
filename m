From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 09:00:44 -0500
Message-ID: <456C410C.9060604@pobox.com>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <20061128102534.5a42c9b2@localhost.localdomain> <456C0F11.30301@gmail.com> <20061128104659.4ec91296@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:22226 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S934629AbWK1OA5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 09:00:57 -0500
In-Reply-To: <20061128104659.4ec91296@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Alan wrote:
>>> The IRQ delivery is async to the I/O so this makes a lot of sense for all
>>> cases.
>> I don't think that's true unless the controller is doing something funky 
>> as in SET XFERMODE.  Can you enlighten me?

I'm with Tejun on this one.  The posted patch simply adds extra bus transactions
to poll for a late BUSY bit.  Yes, some devices are late posting the BUSY bit,
but the vast majority are not.

For other cases where this is needed, I'm not so sure.
Alan, I confess that I really don't understand this example (below).
Can you try again, with something concrete enough for a rusty old
IDE hacker to understand?

Thanks

> This leads to suprising sequences like
> 
> 
> 	device raises IRQ
> 				kernel blocks device IRQ at chip
> 				kernel reads to post the block
> 				kernel does other stuff
> 	IRQ message finally arrives
> 				IRQ taken


-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
