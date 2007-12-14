From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Date: Fri, 14 Dec 2007 02:23:13 -0600
Message-ID: <20071214082313.GA28118@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net> <20071205004841.GA25905@linux-sh.org> <20071205183912.GA4516@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:45338 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523AbXLNIRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Dec 2007 03:17:45 -0500
Content-Disposition: inline
In-Reply-To: <20071205183912.GA4516@loki.buserror.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org

On Wed, Dec 05, 2007 at 12:39:12PM -0600, Scott Wood wrote:
> On Wed, Dec 05, 2007 at 09:48:41AM +0900, Paul Mundt wrote:
> > On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > > >  	tristate "Generic platform device PATA support"
> > > > -	depends on EMBEDDED || ARCH_RPC
> > > > +	depends on EMBEDDED || ARCH_PPC
> > > 
> > > It needs to be || PPC, not || ARCH_PPC.
> > > 
> > Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.
> 
> Why is it dependent on anything other than platform bus support and ATA?

There's no way to specify dependency on platform bus as a config option,
that's likely what EMBEDDED was meant to do. Some platforms have platform
bus in spite of being !EMBEDDED, arch/arm/configs/rpc_defconfig seems
to be among those. PPC too.


-Olof
