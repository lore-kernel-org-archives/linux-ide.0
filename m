From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: blacklist for early irq problem
Date: Thu, 30 Nov 2006 11:29:35 +0000
Message-ID: <20061130112935.2e226eb0@localhost.localdomain>
References: <200611180759.34622.t.powa@gmx.de>
	<20061118002357.564dbb9d.akpm@osdl.org>
	<455F790C.2030509@garzik.org>
	<456BDCAC.4060609@tw.ibm.com>
	<456C4514.9090107@tw.ibm.com>
	<456C4ACC.1050806@rtr.ca>
	<456C8A51.3000605@garzik.org>
	<456EA7D6.2050101@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50070 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1759244AbWK3LYG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 06:24:06 -0500
In-Reply-To: <456EA7D6.2050101@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

On Thu, 30 Nov 2006 17:43:51 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

> Some devices raise irq early before clearing the BSY.
> This patch adds blacklist and waits up to 10 microseconds to workaround the early irq problem.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Alan Cox <alan@redhat.com>

Looks good to me
