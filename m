From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Wed, 5 Dec 2007 12:39:12 -0600
Message-ID: <20071205183912.GA4516@loki.buserror.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net> <20071205004841.GA25905@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:36986 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXLESja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 13:39:30 -0500
Content-Disposition: inline
In-Reply-To: <20071205004841.GA25905@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

On Wed, Dec 05, 2007 at 09:48:41AM +0900, Paul Mundt wrote:
> On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > >  	tristate "Generic platform device PATA support"
> > > -	depends on EMBEDDED || ARCH_RPC
> > > +	depends on EMBEDDED || ARCH_PPC
> > 
> > It needs to be || PPC, not || ARCH_PPC.
> > 
> Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.

Why is it dependent on anything other than platform bus support and ATA?

-Scott
