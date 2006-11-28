From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq
 problem
Date: Tue, 28 Nov 2006 10:46:59 +0000
Message-ID: <20061128104659.4ec91296@localhost.localdomain>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
	<456BDCAC.4060609@tw.ibm.com>
	<20061128102534.5a42c9b2@localhost.localdomain>
	<456C0F11.30301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1240 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S935836AbWK1Kkt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 05:40:49 -0500
In-Reply-To: <456C0F11.30301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

> > The IRQ delivery is async to the I/O so this makes a lot of sense for all
> > cases.
> 
> I don't think that's true unless the controller is doing something funky 
> as in SET XFERMODE.  Can you enlighten me?

It is true for all cases. There is no synchronization between interrupt
delivery and I/O cycles and both of them are asynchronous. It is
especially obvious on older APIC based boxes that use a 4 wire bus to
send interrupt messages around.

This leads to suprising sequences like


	device raises IRQ
				kernel blocks device IRQ at chip
				kernel reads to post the block
				kernel does other stuff
	IRQ message finally arrives
				IRQ taken

