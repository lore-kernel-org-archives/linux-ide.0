From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Tue, 5 Oct 2004 01:56:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410050156.08574.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <200410042321.54530.bzolnier@elka.pw.edu.pl> <1096932367.12123.115.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:34494 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268710AbUJDXzl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 19:55:41 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42761 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S53835AbUJDXzS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2004 01:55:18 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:61383 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S58644AbUJDXx5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 2 others);
	Tue, 5 Oct 2004 01:53:57 +0200
In-Reply-To: <1096932367.12123.115.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tuesday 05 October 2004 01:26, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-05 at 07:21, Bartlomiej Zolnierkiewicz wrote:
> 
> > What about controllers in "half native" mode
> > (legacy IRQs but native addressing)?
> 
> As far as IRQ routing is concerned, this is legacy mode, the controller
> driver should call that function. But this is not a "standard" state, so
> it would have done by the host controller driver, while the normal
> "legacy" mode is well defined by the progif bits 0x1 and 0x4 and thus
> the function for retreiving the irqs might be called by the generic ide
> pci code no ?

Yep.

> > Your proposal sounds fine but I worry that instead of crappy #ifdefs
> > it will end up having crappy switch (dev->device) statements.
> 
> Whatever we will have will be entirely in the arch. It will usually end
> up beeing something like
> 
> 	if (dev == onboard_ide_dev)
> 		return channel ? <chan_1_irq> : <chan_2_irq>;
> 	return NO_IRQ;
> 
> Since there will be only one of these on board on 99% of the time.

Yep.
