From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq
 problem
Date: Tue, 28 Nov 2006 14:12:00 +0000
Message-ID: <20061128141200.104facf3@localhost.localdomain>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
	<456BDCAC.4060609@tw.ibm.com>
	<20061128102534.5a42c9b2@localhost.localdomain>
	<456C0F11.30301@gmail.com>
	<20061128104659.4ec91296@localhost.localdomain>
	<456C410C.9060604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56796 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S934349AbWK1OGH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 09:06:07 -0500
In-Reply-To: <456C410C.9060604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

On Tue, 28 Nov 2006 09:00:44 -0500
Mark Lord <mlord@pobox.com> wrote:

> Alan, I confess that I really don't understand this example (below).
> Can you try again, with something concrete enough for a rusty old
> IDE hacker to understand?

The asynchronocity isn't at the IDE level - its at the PCI bus level. The
IRQ path between a PCI card and the CPU is not synchronous to I/O cycles.

Alan
