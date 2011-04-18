From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Mon, 18 Apr 2011 22:09:45 +0100
Message-ID: <20110418220945.4713e15d@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303157287.7167.26.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303157287.7167.26.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> Well your deliberate decision is crashing my box on boot.  That makes
> this a regression from the IDE cmd64x driver. I hear indirectly there's
> a similar problem on sparc.

Sure - I'm not saying there isn't a problem just cautioning that there is
more to fixing it than blindly adding checks. If you simply check the
fields you break the split bridge boxes on x86. They aren't very common
these days but they probably outnumber PA-RISC Linux users 8)

> No, that analysis is wrong: Parisc (and actually presumably every
> non-x86) doesn't use legacy mode.  The bars are all wired up (I posted
> the original lspci output showing this).  The problem is that when you
> try to prod the registers behind the secondary bar we get an instant
> crash because the memory doesn't respond ... I'm assuming the secondary
> bar isn't actually wired up to the chip.

Then your PCI configuration is faulty - no ?

I'd have thought the best way to fix that would be a PCI quirk for the
platform. However if it's multiple non x86 platforms being hit then the
driver probably needs the smarts to cope with this weird wiring.

> > The patch seems to be broken for all these cases and also incredibly
> > invasive given you can just pass a dummy port in as one of
> > your struct ata_port_info * pointers to ata_pci_dma_init_one()
> 
> You mean in ata_pci_bmdma_init_one()?  yes, that might work ... I still
> need to know how to detect this.
> 
> > You shouldn't need to touch a single line of the core libata code,
> > although it might be the best way of doing it. Either way if you do the
> > number of ports needs to be a bitmask instead and you need to leave
> > native mode alone.
> 
> The core libata code looked broken in the assumption that it had to poke
> a double register pair for sff mode (the hard coded loop over two
> ports) ... this is what won't work on non-x86 boxes.  

Worked implementation example: drivers/ata/pata_via.c - see the use of
VIA_IDFLAG_SINGLE

I think that will do what you need ?

Alan

