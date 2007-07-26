From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 21:41:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0707262136530.6614@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
 <Pine.LNX.4.60.0707252130090.6234@poirot.grange> <20070725213925.2f25906c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764085AbXGZTlv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 15:41:51 -0400
In-Reply-To: <20070725213925.2f25906c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

On Wed, 25 Jul 2007, Alan Cox wrote:

> > driver to using platform-device. I got a reply, that it's not worth it now 
> > that IDE is slowly becoming obsolete, and the pata_platform serves the 
> > perpose perfectly well. I found this argument reasonable, I had the same 
> > doubt, just wanted to double-check. So, why do we now need a new legacy 
> > (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> > exists?
> 
> We don't *need* it but some people still want to use old IDE and the
> author was willing to make it neatly compatible so that anything that
> works with the pata_platform should be able to use the ide_platform
> driver and vice versa. For the shorter term that can only be a good thing
> - arch code doesn't need to care about which driver is used, end users
> can pick and it doesn't end up adding new ties between code and old IDE.

Ok, thanks for the explanation Alan. So, there's no technical argument, 
just "being nice to the users", and add a new driver, which we know we'll 
have to remove soon, thus having to persuade its users, who by that time 
will get used to it and will not want to invest money into switching to 
another one...

Thanks
Guennadi
---
Guennadi Liakhovetski
