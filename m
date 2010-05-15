From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: Remove excess command issue delays
Date: Sat, 15 May 2010 15:09:37 +0100
Message-ID: <20100515150937.746f73ec@lxorguk.ukuu.org.uk>
References: <20100505092350.586.46344.stgit@localhost.localdomain>
	<20100505092503.586.89942.stgit@localhost.localdomain>
	<4BEE05E5.70904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51466 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752472Ab0EOODA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 May 2010 10:03:00 -0400
In-Reply-To: <4BEE05E5.70904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org

On Fri, 14 May 2010 22:24:37 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On 05/05/2010 05:25 AM, Alan Cox wrote:
> >   /**
> > + *	ata_sff_exec_command_nopost - issue ATA command to host controller
> > + *	@ap: port to which command is being issued
> > + *	@tf: ATA taskfile register set
> > + *
> > + *	Issues ATA command, with proper synchronization with interrupt
> > + *	handler / other threads. This version of the helper does not protect
> > + *	against any delayed writes done by the underlying fabric, it must
> > + *	therefore not be used for MMIO devices unless the device handles
> > + *	the 400nS command delay stall internally.
> > + *
> > + *	LOCKING:
> > + *	spin_lock_irqsave(host lock)
> > + */
> > +void ata_sff_exec_command_nopost(struct ata_port *ap,
> > +                                        const struct ata_taskfile *tf)
> > +{
> > +	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> > +	iowrite8(tf->command, ap->ioaddr.command_addr);
> > +}
> > +EXPORT_SYMBOL_GPL(ata_sff_exec_command_nopost);
> 
> where did the 400ns delay go, for the 'nopost' version?

Good question. It should indeed have an ndelay(400) after the iowrite8
I'll go fix that.
