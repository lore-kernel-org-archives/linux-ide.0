From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sat, 2 Oct 2004 16:56:29 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410021656.30122.bzolnier@elka.pw.edu.pl>
References: <1096602694.11460.29.camel@gaston> <200410011611.16859.bzolnier@elka.pw.edu.pl> <1096691450.12039.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:39407 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S266669AbUJBOz4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Oct 2004 10:55:56 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42349 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S27038AbUJBOzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Oct 2004 16:55:55 +0200
Received: from chello084010012196.chello.pl ([84.10.12.196]:61573 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S98651AbUJBOy1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 2 Oct 2004 16:54:27 +0200
In-Reply-To: <1096691450.12039.3.camel@gaston>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Saturday 02 October 2004 06:30, Benjamin Herrenschmidt wrote:
> On Sat, 2004-10-02 at 00:11, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 01 October 2004 05:51, Benjamin Herrenschmidt wrote:
> > > Hi Bart !
> > 
> > Hi!
> >  
> > > I noticed that you are about to absolete the whole lot of IDE
> > > default stuff
> > > 
> > > # define ide_default_io_base(index)	(0)
> > > # define ide_default_irq(base)		(0)
> > > # define ide_init_default_irq(base)	(0)
> > > 
> > > and others...
> > > 
> > > So how do I do to "cleanly" tell the IDE layer that my PCI IDE
> > > controller that shows on the PCI bus and is in legacy mode is
> > > using some IRQs (14 & 15 typically) that are _not_ the PCI irq
> > > line for this device ?
> > 
> > ->init_hwif() hook
> > 
> > i.e. piix.c is handling this with:
> > 
> > 	if (!hwif->irq)
> > 		hwif->irq = hwif->channel ? 15 : 14;
> > 
> 
> But that is a totally ugly hack ! And requires putting platform specific
> knowledge inside the drivers themselves which is even worse...
> 
> (In that case, irqs are 20 and 21 for example).

I think that if platform is using specific driver it is a
correct place to put such information but I may be wrong.

Well, at least it allows somebody knowing nothing about specific
platform (me) to see what IRQs are needed and why they are needed.
Following all IDE code paths using the default stuff and guessing
which parts are overridden by specific platform can get you insane.

I know that is not perfect and I'm open for better ideas.

Bartlomiej
