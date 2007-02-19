From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 10:18:14 +1100
Message-ID: <1171927094.18571.82.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	 <200702151141.49708.jens@de.ibm.com> <20070215171414.GU923@austin.ibm.com>
	 <200702151909.26082.arnd@arndb.de>
	 <20070219215659.15539fb3@localhost.localdomain>
	 <1171920081.18571.77.camel@localhost.localdomain>
	 <20070219234651.4a19a912@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38941 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965532AbXBSXXI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Feb 2007 18:23:08 -0500
In-Reply-To: <20070219234651.4a19a912@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Linas Vepstas <linas@austin.ibm.com>, Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>

On Mon, 2007-02-19 at 23:46 +0000, Alan wrote:
> > > into one in drivers/ide but really want splitting for libata with some
> > > kind of libata-pmac owning the shared stuff
> > 
> > You meand driver/ide/ppc/pmac.c ?
> 
> Yes
> 
> > moving them out of the macio_asic to a PCI device at one point, so yes,
> > maybe you are right, I should move the DMA bits to some "common" file
> > and split the various implementations.
> 
> I suspect it is worth doing when moving to libata at least, even if not
> for the older driver.

Yup. I don't when I'll have time to "libataify" it though. I need to
look into the best way of handling hotplug with the mediabay for that.
The current hacks are only really suitable for drivers/ide

Ben.


