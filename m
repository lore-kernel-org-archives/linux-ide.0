From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Tue, 4 Dec 2007 14:39:33 -0600
Message-ID: <20071204203933.GA8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net> <20071204203751.GA3015@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:35903 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbXLDUfa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:35:30 -0500
Content-Disposition: inline
In-Reply-To: <20071204203751.GA3015@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>

On Tue, Dec 04, 2007 at 11:37:51PM +0300, Anton Vorontsov wrote:
> On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > >  	tristate "Generic platform device PATA support"
> > > -	depends on EMBEDDED || ARCH_RPC
> > > +	depends on EMBEDDED || ARCH_PPC
> > 
> > It needs to be || PPC, not || ARCH_PPC.
> 
> D'oh.
> 
> - - - -
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [PATCH v2.2] [libata] pata_of_platform: OF-Platform PATA device driver
> 
> This driver nicely wraps around pata_platform library functions,
> and provides OF platform bus bindings to the PATA devices.
> 
> In addition fix ARCH_RPC typo in the PATA_PLATFORM Kconfig entry,
> spotted by Olof Johansson.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Reviewed-by: Olof Johansson <olof@lixom.net>
