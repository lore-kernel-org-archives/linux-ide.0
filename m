From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 10:58:35 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040614095835.GA11585@infradead.org>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <20040612103453.GB26482@infradead.org> <200406131936.08338.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:21203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262208AbUFNJ6g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 05:58:36 -0400
Content-Disposition: inline
In-Reply-To: <200406131936.08338.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 07:36:08PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > IMHO the PCI ->probe methods should always be __devinit.  It's rather
> > hard to make sure they're never every hotplugged in any way, especially
> > with the dynamic id adding via sysfs thing.
> 
> I generally agree but IMO it makes no sense for i.e. piix.c.

Are you sure?  I've seen piix3/4 in very strange place, iirc even in
a docking station which is hotpluggable.

And even if for this special hardware it's usually not doable there
are things like greg's fake hotplug pci driver.  So a non-__devinit pci
probe method is a bug, please fix them in PCI.
