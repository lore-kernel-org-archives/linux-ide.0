From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Tue, 4 Dec 2007 21:26:57 -0600
Message-ID: <20071205032657.GB13906@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net> <20071205004841.GA25905@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:60219 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbXLEDWw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 22:22:52 -0500
Content-Disposition: inline
In-Reply-To: <20071205004841.GA25905@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org

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
> 
> ARCH_RPC is not a typo, it's an ARM platform. Please grep first :-)

I'm sorry, but seeing ARCH_RPC and not having an arch/rpc made me
suspect it being a typo. It surprises me that the ARM guys chose such
a generic prefix as ARCH_ for their specific platforms.  (powerpc uses
PPC_<platform>).

Anyway, thanks for catching it.


-Olof
