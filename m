From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq
 problem
Date: Tue, 28 Nov 2006 10:25:34 +0000
Message-ID: <20061128102534.5a42c9b2@localhost.localdomain>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
	<456BDCAC.4060609@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53173 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S935806AbWK1KUq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 05:20:46 -0500
In-Reply-To: <456BDCAC.4060609@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

On Tue, 28 Nov 2006 14:52:28 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> Some devices raise irq early before clearing the BSY.
> This patch waits up to 10 microseconds to workaround the early irq problem.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Alan Cox <alan@redhat.com>

The IRQ delivery is async to the I/O so this makes a lot of sense for all
cases.
