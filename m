From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sat, 02 Oct 2004 14:30:51 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096691450.12039.3.camel@gaston>
References: <1096602694.11460.29.camel@gaston>
	 <200410011611.16859.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:26038 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267251AbUJBEfB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Oct 2004 00:35:01 -0400
In-Reply-To: <200410011611.16859.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sat, 2004-10-02 at 00:11, Bartlomiej Zolnierkiewicz wrote:
> On Friday 01 October 2004 05:51, Benjamin Herrenschmidt wrote:
> > Hi Bart !
> 
> Hi!
>  
> > I noticed that you are about to absolete the whole lot of IDE
> > default stuff
> > 
> > # define ide_default_io_base(index)	(0)
> > # define ide_default_irq(base)		(0)
> > # define ide_init_default_irq(base)	(0)
> > 
> > and others...
> > 
> > So how do I do to "cleanly" tell the IDE layer that my PCI IDE
> > controller that shows on the PCI bus and is in legacy mode is
> > using some IRQs (14 & 15 typically) that are _not_ the PCI irq
> > line for this device ?
> 
> ->init_hwif() hook
> 
> i.e. piix.c is handling this with:
> 
> 	if (!hwif->irq)
> 		hwif->irq = hwif->channel ? 15 : 14;
> 

But that is a totally ugly hack ! And requires putting platform specific
knowledge inside the drivers themselves which is even worse...

(In that case, irqs are 20 and 21 for example).

Ben.


