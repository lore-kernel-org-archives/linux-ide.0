From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 22:11:10 +0200
Message-ID: <200707262211.10223.bzolnier@gmail.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <20070725213925.2f25906c@the-village.bc.nu> <Pine.LNX.4.60.0707262136530.6614@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:13315 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765642AbXGZUNZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 16:13:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so593218ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 13:13:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.60.0707262136530.6614@poirot.grange>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


Hi,

On Thursday 26 July 2007, Guennadi Liakhovetski wrote:
> On Wed, 25 Jul 2007, Alan Cox wrote:
> 
> > > driver to using platform-device. I got a reply, that it's not worth it now 
> > > that IDE is slowly becoming obsolete, and the pata_platform serves the 
> > > perpose perfectly well. I found this argument reasonable, I had the same 
> > > doubt, just wanted to double-check. So, why do we now need a new legacy 
> > > (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> > > exists?
> > 
> > We don't *need* it but some people still want to use old IDE and the
> > author was willing to make it neatly compatible so that anything that
> > works with the pata_platform should be able to use the ide_platform
> > driver and vice versa. For the shorter term that can only be a good thing
> > - arch code doesn't need to care about which driver is used, end users
> > can pick and it doesn't end up adding new ties between code and old IDE.
> 
> Ok, thanks for the explanation Alan. So, there's no technical argument, 
> just "being nice to the users", and add a new driver, which we know we'll 

There are some rough edges (especially older and/or rare hardware,
this goes for both cotrollers and devices) that SCSI/libata don't
handle and IDE subsystem do.

> have to remove soon, thus having to persuade its users, who by that time 

Well, we've been hearing "soon" for two years now...

> will get used to it and will not want to invest money into switching to 
> another one...

PS wrt ide_arm.c changes, you really should have cc:ed the author... ;)

Thanks,
Bart
