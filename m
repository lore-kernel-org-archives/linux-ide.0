From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 9 Apr 2009 14:41:10 +0100
Message-ID: <20090409144110.34654dd9@lxorguk.ukuu.org.uk>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
	<49DDEF02.7090004@garzik.org>
	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
	<49DDF33E.6000102@garzik.org>
	<20090409141254.283d9f11@lxorguk.ukuu.org.uk>
	<49DDF920.70801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44987 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072AbZDINlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 09:41:02 -0400
In-Reply-To: <49DDF920.70801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> > What are the locking sematics for ap->flags ?
> 
> In general, for both driver-private flags and ATA_FLAG_xxx, the flags 
> should be set at compile or pci_driver::probe() time, and never touched 
> after that.

Ok we should document that.

> 
> So your patch is a bit of abuse, really, by fiddling with ap->flags at 
> all ;-)  The drivers, for example, never touch the driver-private flags 
> after they are set at init.  The core will occasionally twiddle flags, 
> inside of spin_lock_irqsave(ap->lock)

Which is the lock I am using

> Thus 'set' has always been an illusion for libata.  It's really been 
> read-only.

Which nicely solves the flags2 problem - we have flags, and we have
dynamic flags and if we move the other changing flags into dynflags over
time all will be happy.
