From: Theodore Tso <tytso@mit.edu>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
	question)
Date: Fri, 1 May 2009 09:14:59 -0400
Message-ID: <20090501131459.GA7681@mit.edu>
References: <E1LzLgA-0004j6-9W@closure.thunk.org> <49F90CA2.4080602@garzik.org> <20090430083309.437f9248@lithium.local.net> <20090430113445.GA4809@mit.edu> <20090430113814.GB4809@mit.edu> <49FA55A0.8080303@gmail.com> <20090501025132.GA7275@mit.edu> <49FA78B4.2070900@gmail.com> <20090501113533.GB10704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:59869 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbZEANPK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 May 2009 09:15:10 -0400
Content-Disposition: inline
In-Reply-To: <20090501113533.GB10704@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Alex Buell <alex.buell@munted.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Fri, May 01, 2009 at 04:35:33AM -0700, Matthew Wilcox wrote:
> On Thu, Apr 30, 2009 at 10:21:08PM -0600, Robert Hancock wrote:
> > I'm suspecting that that Ultrabay slot might be using the PATA ports on  
> > the chipset, with a PATA-SATA bridge chip or something. I haven't seen  
> > an Intel chipset with some SATA ports using AHCI and some in PIIX mode  
> > before, the ones I've seen with both had the PIIX mode driving PATA  
> > ports. If it is indeed bridged through PATA on that laptop, there's no  
> > way you're going to get any NCQ support on that slot.
> >
> > I don't know why Lenovo would do that, as it would kind of cripple SATA  
> > drives in that slot, but hardware people do some bizarre things 
> > sometimes..
> 
> I have to agree with Robert.  If you look at the ich8 data sheet
> (313056-003), the mobile version has 3 ATA ports and 1 IDE port "that
> can be electrically isolated".  See pages 41, 43, and 50-51.  on page 41,
> it says the IDE port has "Tri-state modes to enable swap bay".
> 
> So I don't blame Lenovo for hooking up the Ultrabay slot using the IDE
> port.  They were pretty much told to do it.

Gaah.... so basically a SATA device (the X25-M) is talking to a
SATA-PATA bridge chip, which is then talking the IDE port in the ICH8
chipset, which shows up as piix, which we're then pretending is SATA
at the OS level via the ata_piix driver.  Did I get that right?
(Excuse me while I go find a barf bag....)

The sad thing is there doesn't seem to be a good reason to do that,
since SATA is designed to be hot-swapping, so it's not like they need
to use tri-state modes on the IDE port --- especially if said IDE is
fronted by a PATA-SATA bridge chip anyway...

Oh.... and I suspect I know why they did it; I'm guessing they wanted
to support PATA Ultrabay devices for backwards compatibility on the
X60, and perhaps they were running out of connector pins on the
docking station (the Ultrabay slot is on the X61's "media slice"), and
they didn't have enough wires to run both PATA and SATA interfaces to
the docking station, *and* they wanted to use the same docking station
for the X60 and X61 Thinkpads.

Ah, well.  I hope it made sense to *someone* at Lenovo...  It would be
interesting to see if they fixed this in the X200 or not.

    	      	      	   	    	      	 - Ted
