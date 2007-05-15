From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Wed, 16 May 2007 06:32:45 +1000
Message-ID: <1179261166.32247.187.camel@localhost.localdomain>
References: <20070515061153.425BDDDEE8@ozlabs.org>
	 <20070515110818.GA23094@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43839 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836AbXEOUd0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 16:33:26 -0400
In-Reply-To: <20070515110818.GA23094@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: jgarzik@pobox.com, Linux IDE <linux-ide@vger.kernel.org>

On Tue, 2007-05-15 at 07:08 -0400, Alan Cox wrote:
> On Tue, May 15, 2007 at 04:11:23PM +1000, Benjamin Herrenschmidt wrote:
> > +	if (!try_mmio)
> > +		goto use_pio;
> 
> Please use a different naming scheme "PIO" means something quite different
> in ATA

Indeed, the naming's a bit confusing, I'll fix that.

> Rest looks fine although I'd be interested to know if you can measure any
> performance change.

Nothing significant here on the box but I had cases of setups where
there was simply no IO space accessible on the PCI bus (one of the
reason for using a controller that does MMIO).

Cheers,
Ben.


