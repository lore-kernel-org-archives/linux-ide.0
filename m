From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Tue, 05 Oct 2004 09:26:07 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096932367.12123.115.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <20041004013305.GA29791@havoc.gtf.org> <1096853636.23141.68.camel@gaston>
	 <200410042321.54530.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:6024 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268696AbUJDXbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2004 19:31:20 -0400
In-Reply-To: <200410042321.54530.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, 2004-10-05 at 07:21, Bartlomiej Zolnierkiewicz wrote:

> What about controllers in "half native" mode
> (legacy IRQs but native addressing)?

As far as IRQ routing is concerned, this is legacy mode, the controller
driver should call that function. But this is not a "standard" state, so
it would have done by the host controller driver, while the normal
"legacy" mode is well defined by the progif bits 0x1 and 0x4 and thus
the function for retreiving the irqs might be called by the generic ide
pci code no ?

> Your proposal sounds fine but I worry that instead of crappy #ifdefs
> it will end up having crappy switch (dev->device) statements.

Whatever we will have will be entirely in the arch. It will usually end
up beeing something like

	if (dev == onboard_ide_dev)
		return channel ? <chan_1_irq> : <chan_2_irq>;
	return NO_IRQ;

Since there will be only one of these on board on 99% of the time.

Ben.


