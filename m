From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: Add pata_dma option so users can disable pata_dma as they can with old-ide
Date: Sat, 23 Jun 2007 19:41:34 +0200
Message-ID: <200706231941.34557.bzolnier@gmail.com>
References: <20070622144939.026ed6ac@the-village.bc.nu> <200706222104.25482.bzolnier@gmail.com> <20070622202610.3b805cfe@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28896 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbXFWRwn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019618ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:42 -0700 (PDT)
In-Reply-To: <20070622202610.3b805cfe@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org


Hi,

On Friday 22 June 2007, Alan Cox wrote:
> > > I think a /sys/ "dma" attribute (pick a name) might be most appropriate,
> > > or we just just implement HDIO_[GS]ET_DMA as a simpler/lazier mechanism.
> > 
> > The problem is that libata lacks any locking needed for having this
> > (and other useful) settings tunable on per device basis.
> 
> Actually libata does have the paths for it and uses them when drives are
> hotplugged. Tejun posted an explanation of how to implement it a while
> ago when I proposed a totally bogus implementation - it has to be done
> via the EH code.

I must have missed the original discussion.

> So we'd add user mode masks to each device and the sysfs nodes would
> update that mask and trigger the EH processing to halt activity, retune
> the disks and continue

Sounds good.

Thanks,
Bart
