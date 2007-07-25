From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Wed, 25 Jul 2007 21:39:25 +0100
Message-ID: <20070725213925.2f25906c@the-village.bc.nu>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:50992 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753763AbXGYUcn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2007 16:32:43 -0400
In-Reply-To: <Pine.LNX.4.60.0707252130090.6234@poirot.grange>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

> driver to using platform-device. I got a reply, that it's not worth it now 
> that IDE is slowly becoming obsolete, and the pata_platform serves the 
> perpose perfectly well. I found this argument reasonable, I had the same 
> doubt, just wanted to double-check. So, why do we now need a new legacy 
> (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> exists?


We don't *need* it but some people still want to use old IDE and the
author was willing to make it neatly compatible so that anything that
works with the pata_platform should be able to use the ide_platform
driver and vice versa. For the shorter term that can only be a good thing
- arch code doesn't need to care about which driver is used, end users
can pick and it doesn't end up adding new ties between code and old IDE.

