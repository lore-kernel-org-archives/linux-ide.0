From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: libata/avr32 build failure
Date: Fri, 4 Apr 2008 13:39:31 -0700
Message-ID: <20080404133931.482d8614.randy.dunlap@oracle.com>
References: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
	<47F5E1A0.4060905@garzik.org>
	<20080404095408.88a92c7c.randy.dunlap@oracle.com>
	<47F67766.6030903@garzik.org>
	<47F6796A.7040905@oracle.com>
	<47F68E59.9090205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:58493 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbYDDUkD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Apr 2008 16:40:03 -0400
In-Reply-To: <47F68E59.9090205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-ide@vger.kernel.org

On Fri, 04 Apr 2008 16:23:53 -0400 Jeff Garzik wrote:

> Randy Dunlap wrote:
> > Jeff Garzik wrote:
> >> Randy Dunlap wrote:
> >>> On Fri, 04 Apr 2008 04:06:56 -0400 Jeff Garzik wrote:
> >>>
> >>>> Stephen Rothwell wrote:
> >>>>> Hi Jeff,
> >>>>>
> >>>>> For a while the linux-next build for avr32 defconfig (and others) has
> >>>>> been failing like this:
> >>>>>
> >>>>> drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' 
> >>>>> undeclared here (not in a function)
> >>>>>
> >>>>> It seems to be because the declaration of ata_pci_default_filter is
> >>>>> protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
> >>>>> only.
> >>>>>
> >>>>> Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
> >>>>> March 29).
> >>>> fixed being pushed right now (patch from Tejun fixed it)
> >>>
> >>> Some fixes other than what was in today's (April 04)
> >>> [git patches] libata fixes?
> >>>
> >>> I hope there is more.  I don't see how that fixes this error.
> >>> Nor does gcc see how, after I apply that patch.
> >>
> >> It wasn't sent in #upstream-fixes, it was applied to #upstream...
> >>
> >> Is that where you are looking?
> > 
> > I'm just trying to build linux-next with or without today's "libata fixes".
> > ATA with CONFIG_PCI=n still has build errors, as reported above.
> 
> OK, that's expected.

Uh, that's not good.  What does it mean?

(a) linux-next is not pulling the correct branch of your git tree
or
(b) linux-next just won't work with libata
or
(c) we have too many trees in the forest
or
something else?  (if so, what?)


---
~Randy
