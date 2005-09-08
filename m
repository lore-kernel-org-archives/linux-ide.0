From: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] ide: ide-dma.c should always check hwif->cds before hwif->cds->foo
Date: Thu, 8 Sep 2005 08:56:34 -0700
Message-ID: <20050908155634.GO3966@smtp.west.cox.net>
References: <20050908151529.GL3966@smtp.west.cox.net> <58cb370e05090808472f5e12e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14031 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964853AbVIHP4f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Sep 2005 11:56:35 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e05090808472f5e12e4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Hiroshi DOYU <hdoyu@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE Mailing List <linux-ide@vger.kernel.org>

On Thu, Sep 08, 2005 at 05:47:38PM +0200, Bartlomiej Zolnierkiewicz wrote:

> On 9/8/05, Tom Rini <trini@kernel.crashing.org> wrote:
> > In some cases (such as the mips Toshiba TX4939 w/ onboard IDE, not PCI
> > IDE), hwif->cds can be NULL, so test that prior to testing
> > hwif->cds->foo
> 
> Both ide_iomio_dma() and ide_mapped_mmio_dma() are only called from
> ide_dma_iobase().  ide_setup_dma() is the only user of ide_dma_iobase()
> and it is supposed to be used only by IDE PCI drivers.
> 
> What is the reason for this change?

I'll try and explain for Hiroshi DOYU, but the IDE driver for the tx4939
(overall port still need a little bit more review before being sent to
linux-mips, so the ide driver hasn't been submitted yet either) calls
ide_setup_dma(), and has hwif->cds == NULL.

-- 
Tom Rini
http://gate.crashing.org/~trini/
