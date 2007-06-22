From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add pata_dma option so users can disable
 pata_dma as they can with old-ide
Date: Fri, 22 Jun 2007 20:26:10 +0100
Message-ID: <20070622202610.3b805cfe@the-village.bc.nu>
References: <20070622144939.026ed6ac@the-village.bc.nu>
	<20070622165221.2ce648f6@the-village.bc.nu>
	<467BFE6F.7050300@rtr.ca>
	<200706222104.25482.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60527 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760930AbXFVTUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 15:20:39 -0400
In-Reply-To: <200706222104.25482.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org

> > I think a /sys/ "dma" attribute (pick a name) might be most appropriate,
> > or we just just implement HDIO_[GS]ET_DMA as a simpler/lazier mechanism.
> 
> The problem is that libata lacks any locking needed for having this
> (and other useful) settings tunable on per device basis.

Actually libata does have the paths for it and uses them when drives are
hotplugged. Tejun posted an explanation of how to implement it a while
ago when I proposed a totally bogus implementation - it has to be done
via the EH code.

So we'd add user mode masks to each device and the sysfs nodes would
update that mask and trigger the EH processing to halt activity, retune
the disks and continue
