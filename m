From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 16:36:01 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406141636.01353.bzolnier@elka.pw.edu.pl>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <200406131936.08338.bzolnier@elka.pw.edu.pl> <20040614095835.GA11585@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59570 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263059AbUFNOcU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 10:32:20 -0400
In-Reply-To: <20040614095835.GA11585@infradead.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com


[ Greg added to cc: ]

On Monday 14 of June 2004 11:58, Christoph Hellwig wrote:
> On Sun, Jun 13, 2004 at 07:36:08PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > IMHO the PCI ->probe methods should always be __devinit.  It's rather
> > > hard to make sure they're never every hotplugged in any way, especially
> > > with the dynamic id adding via sysfs thing.
> >
> > I generally agree but IMO it makes no sense for i.e. piix.c.
>
> Are you sure?  I've seen piix3/4 in very strange place, iirc even in
> a docking station which is hotpluggable.

Do you mean that south-bridge chipset itself is hotpluggable?

AFAIK it is only ATA hotplug not PCI one.

> And even if for this special hardware it's usually not doable there
> are things like greg's fake hotplug pci driver.  So a non-__devinit pci
> probe method is a bug, please fix them in PCI.

Greg, should I add "fake" PCI hotplug support to some IDE
drivers just to make fake hotplug PCI driver happy?

Cheers.

