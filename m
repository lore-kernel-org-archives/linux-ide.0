From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 09:16:25 -0500
Message-ID: <456C44B9.2050300@rtr.ca>
References: <200611180759.34622.t.powa@gmx.de>	<20061118002357.564dbb9d.akpm@osdl.org>	<455F790C.2030509@garzik.org>	<456BDCAC.4060609@tw.ibm.com>	<20061128102534.5a42c9b2@localhost.localdomain>	<456C0F11.30301@gmail.com>	<20061128104659.4ec91296@localhost.localdomain>	<456C410C.9060604@pobox.com> <20061128141200.104facf3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:7686 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S935219AbWK1OQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 09:16:27 -0500
In-Reply-To: <20061128141200.104facf3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Alan wrote:
> On Tue, 28 Nov 2006 09:00:44 -0500
> Mark Lord <mlord@pobox.com> wrote:
> 
>> Alan, I confess that I really don't understand this example (below).
>> Can you try again, with something concrete enough for a rusty old
>> IDE hacker to understand?
> 
> The asynchronocity isn't at the IDE level - its at the PCI bus level. The
> IRQ path between a PCI card and the CPU is not synchronous to I/O cycles.

Yes, I know that much already.

But how does that factor into the need for this particular patch,
(apart from truly buggy drives which send the IRQ before clearing BUSY) ?

The device driver won't do ANY I/O until it sees the IRQ,
so things are synchronized already without needing to do
an extra status poll in response to the IRQ.

???

Thanks
