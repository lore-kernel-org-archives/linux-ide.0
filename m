From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Better timeout recovery
Date: Mon, 13 Oct 2008 17:10:59 +0100
Message-ID: <20081013171059.3c676c6c@lxorguk.ukuu.org.uk>
References: <20081013141050.7772.52587.stgit@localhost.localdomain>
	<87y70sbhx2.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49077 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756443AbYJMQLI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 12:11:08 -0400
In-Reply-To: <87y70sbhx2.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org


> > +	status = ata_sff_altstatus(ap);
> > +	if (!(status & ATA_BUSY))
> > +		return;
> 
> Shouldn't this rather be
> 
> 	if (status & ATA_BUSY)
> 		return;
> ?

Doh yes - I thought I fixed that after debugging it backwards in qemu

> > +	ata_port_printk(ap, KERN_WARNING, "lost interrupt (Status 0x%x)\n",
> > +								status);
> 
> >From your changelog entry I got the impression that this is known to
> happen on various controllers and there is nothing the user or you
> (kernel developers) can do about it. So, will this become a debug level
> message later too?

Probably it shouldn't. It occurs but rarely on such boxes and as you get
a long pause before the recovery we need to know. It may also be that we
eventually should move buggier controllers to run with a parallel sanity
checking timer just as networking sometimes does

> > + *	ata_sff_drain_fifo - Stock FIFO drain logic for SFF controllers
> > + *	@ap: port to drain
> 
> There is no @ap argument.

Good point ;)

> > + *	pcmcia_8bit_drain_fifo - Stock FIFO drain logic for SFF controllers
> > + *	@ap: port to drain
> 
> No argument @ap.

Ditto - there was one originally ;)

Thanks
Alan
