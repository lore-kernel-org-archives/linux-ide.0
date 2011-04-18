From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on
 boot on parisc
Date: Mon, 18 Apr 2011 15:08:07 -0500
Message-ID: <1303157287.7167.26.camel@mulgrave.site>
References: <1303152147.7167.12.camel@mulgrave.site>
	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
Sender: linux-parisc-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 2011-04-18 at 20:52 +0100, Alan Cox wrote:
> On Mon, 18 Apr 2011 13:42:27 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > currently libata-sff is completely ignoring the enabled/disabled status
> > of the interfaces. 
> 
> Yes - it makes some machines work rather better because the BIOSes
> sometimes mess up the registers. It wad a *deliberate* decision not to
> port it over and as a result stuff works that failed before. Windows
> drivers clearly ignore the bits in many cases.

Well your deliberate decision is crashing my box on boot.  That makes
this a regression from the IDE cmd64x driver. I hear indirectly there's
a similar problem on sparc.

> In addition
> - Your patch seems to be applying the enable bits apply in native mode
>   (they don't generally)
> - You seem to be assuming either first or both ports enabled, secondly
>   only is just as valid

Yes, I know ... but that config is broken today and a fix, given the
hardcoded assumptions in libata-sff, would be more invasive (and not
really of interest to the crash problem).

> This matters for CMD64x as several 64x devices are found on hotpluggable
> 'docking stations' using a PCI split bridge. Only doing the checks for
> chips in legacy mode should avoid that problem. In native mode the PCI
> bars are the only register bases used so the problem doesn't arise.

No, that analysis is wrong: Parisc (and actually presumably every
non-x86) doesn't use legacy mode.  The bars are all wired up (I posted
the original lspci output showing this).  The problem is that when you
try to prod the registers behind the secondary bar we get an instant
crash because the memory doesn't respond ... I'm assuming the secondary
bar isn't actually wired up to the chip.

> The patch seems to be broken for all these cases and also incredibly
> invasive given you can just pass a dummy port in as one of
> your struct ata_port_info * pointers to ata_pci_dma_init_one()

You mean in ata_pci_bmdma_init_one()?  yes, that might work ... I still
need to know how to detect this.

> You shouldn't need to touch a single line of the core libata code,
> although it might be the best way of doing it. Either way if you do the
> number of ports needs to be a bitmask instead and you need to leave
> native mode alone.

The core libata code looked broken in the assumption that it had to poke
a double register pair for sff mode (the hard coded loop over two
ports) ... this is what won't work on non-x86 boxes.  

James


