From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 10:28:40 +1100
Message-ID: <1171927720.18571.84.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	 <1171920081.18571.77.camel@localhost.localdomain>
	 <20070219234651.4a19a912@localhost.localdomain>
	 <200702200017.32924.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54251 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965547AbXBSXcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Feb 2007 18:32:01 -0500
In-Reply-To: <200702200017.32924.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Linas Vepstas <linas@austin.ibm.com>, Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>

On Tue, 2007-02-20 at 00:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 20 February 2007 00:46, Alan wrote:
> > > > into one in drivers/ide but really want splitting for libata with some
> > > > kind of libata-pmac owning the shared stuff
> > > 
> > > You meand driver/ide/ppc/pmac.c ?
> > 
> > Yes
> > 
> > > moving them out of the macio_asic to a PCI device at one point, so yes,
> > > maybe you are right, I should move the DMA bits to some "common" file
> > > and split the various implementations.
> > 
> > I suspect it is worth doing when moving to libata at least, even if not
> > for the older driver.
> 
> fully agreed, the way to go for both drivers

I don't think it's worth touching the drivers/ide version.

Ben.


