From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Wed, 5 Dec 2007 09:48:41 +0900
Message-ID: <20071205004841.GA25905@linux-sh.org>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170719.GB15599@localhost.localdomain> <20071204184826.GA5758@lixom.net> <20071204194921.GB1253@localhost.localdomain> <20071204200121.GA6782@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip10.gyao.ne.jp ([61.122.117.248]:21612 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751425AbXLEAtN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 19:49:13 -0500
Content-Disposition: inline
In-Reply-To: <20071204200121.GA6782@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> >  	tristate "Generic platform device PATA support"
> > -	depends on EMBEDDED || ARCH_RPC
> > +	depends on EMBEDDED || ARCH_PPC
> 
> It needs to be || PPC, not || ARCH_PPC.
> 
Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.

ARCH_RPC is not a typo, it's an ARM platform. Please grep first :-)
