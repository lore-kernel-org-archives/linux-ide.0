From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 15:44:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040614144448.GA21851@infradead.org>
References: <200406111750.30312.bzolnier@elka.pw.edu.pl> <200406131936.08338.bzolnier@elka.pw.edu.pl> <20040614095835.GA11585@infradead.org> <200406141636.01353.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:15833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262389AbUFNOot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 10:44:49 -0400
Content-Disposition: inline
In-Reply-To: <200406141636.01353.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com

On Mon, Jun 14, 2004 at 04:36:01PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Are you sure?  I've seen piix3/4 in very strange place, iirc even in
> > a docking station which is hotpluggable.
> 
> Do you mean that south-bridge chipset itself is hotpluggable?
> 
> AFAIK it is only ATA hotplug not PCI one.

that thingy had an ide controller that was hotpluggable in the dockingstation.
And IIRC it was a piix4 with everything but ide and superio disabled.

