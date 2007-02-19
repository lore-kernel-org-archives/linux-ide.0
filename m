From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 08:21:21 +1100
Message-ID: <1171920081.18571.77.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	 <200702151141.49708.jens@de.ibm.com> <20070215171414.GU923@austin.ibm.com>
	 <200702151909.26082.arnd@arndb.de>
	 <20070219215659.15539fb3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56120 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932696AbXBSV0e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Feb 2007 16:26:34 -0500
In-Reply-To: <20070219215659.15539fb3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Linas Vepstas <linas@austin.ibm.com>, Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>

On Mon, 2007-02-19 at 21:56 +0000, Alan wrote:
> > I fear that the hardest part is yet to come, when we integrate the
> > driver for the the PS3 (currently called gelic_net) into spidernet.
> > The trouble is that the hardware is sufficiently similar to share
> > all the high-level mechanisms like the DMA data structures and
> > descriptor chains, but the low-level mechanisms are hidden in the
> > hypervisor on the PS3. Someone will have to invest a significant
> > amount of time coordinating this so we don't break celleb and qs20
> > in the process.
> 
> That to me implies they should be different drivers using a common
> libata-something file. The PPC mac drivers likewise are currently mashed
> into one in drivers/ide but really want splitting for libata with some
> kind of libata-pmac owning the shared stuff

You meand driver/ide/ppc/pmac.c ?

This driver is really for one family of IP blocks, the apple ones. They
have the same DMA engine and same taskfile register layout, they only
differ in the timning register format & timing abilities.

However, they also differ in probing mecanism because Apple has been
moving them out of the macio_asic to a PCI device at one point, so yes,
maybe you are right, I should move the DMA bits to some "common" file
and split the various implementations.

Ben.


