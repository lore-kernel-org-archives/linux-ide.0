From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux v2.6.9... (compile stats)
Date: Thu, 21 Oct 2004 03:24:42 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041021022442.GI23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com> <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk> <41771813.8090204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21943 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270465AbUJUCYq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Oct 2004 22:24:46 -0400
Content-Disposition: inline
In-Reply-To: <41771813.8090204@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>, Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Oct 20, 2004 at 09:59:47PM -0400, Jeff Garzik wrote:
> >Hmm...  It misses a bunch of easy stuff, actually (tons of casts to void *
> >from what used to be unsigned long and is void __iomem * with your patch).
> 
> feel free to send a delta :)
 
Will do.

> >I don't see where you handle PIO stuff, though - no ioport_map() _or_
> >pci_iomap() in sight.
> 
> Correct, that part doesn't exist yet.  grep in the above quoted text for 
> "* map/unap" for the to-do list.
> 
> The mapping of the PIO PCI BARs requires independently mapping at least 
> 5 (but varies from controller to controller) IO port ranges, and 
> tracking those mappings in a coherent manner.

IDGI.  Why do you insist on releasing these guys in library code?  Even
with iomem case you are creating mappings in driver code, so the reverse
should also be done there...
