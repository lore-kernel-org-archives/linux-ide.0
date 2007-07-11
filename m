From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] Native-mode fix for Pegasos pata_via
Date: Wed, 11 Jul 2007 23:39:23 +0100
Message-ID: <46955C1B.6000108@genesi-usa.com>
References: <4694EF08.9000607@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:1381 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934416AbXGKWic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 18:38:32 -0400
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk ([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>)
	id 1I8kZP-000253-Tf
	for linux-ide@vger.kernel.org; Wed, 11 Jul 2007 22:22:04 +0000
In-Reply-To: <4694EF08.9000607@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Okay we got a tester and it sort of works.

There were some timeout errors though, and the irq reported by the printk's
is irq 0 (this would explain why there is a timeout!)..

I am curious as to why this would happen, is there some kind of settle time
for making these changes, or does libata reevaluate it's IRQ usage between
the printk and enabling/using DMA (I would expect it does, but it doesn't
help having 4 timeouts!?)

Any comments here would be welcome.

http://www.powerdeveloper.org/forums/viewtopic.php?p=8433#8433

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> PATCH..
> 
> ~
> 
> Pegasos currently sets it's IDE controller to PCI native mode but leaves the
> ISA IDE IRQ steering set to 14/15 and IDE Interrupt Routing to compatibility
> mode to keep compatibility with some old broken block drivers.
> 
> Rather than clutter up libata with such things for one platform, the fix is
> to force the controller into native mode here.
> 
> We only enable this fix if we are using libata drivers, to avoid breaking
> the old block driver as was the intention of the firmware configuration.
> Currently won't work if the IDE interrupt line isn't set to 14, however the
> chances of this happening on Pegasos are very slim. It just makes the fixup
> easier.
> 
> ~
> 
> This is TOTALLY untested but it does compile just fine. If anyone could throw
> in some suggestions it would be awesome. Testing the patch (minus the checks
> for pata_via being compiled) with via86cxxx would be great too. I just don't
> have a Pegasos I or II handy here to run any of this.
> 
