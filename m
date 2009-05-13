From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Wed, 13 May 2009 06:12:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905130610240.18305@zirkon.biophys.uni-duesseldorf.de>
References: <20090511222702.352192505@arndb.de>
 <200905112238.55404.arnd@arndb.de>
 <20090512090602.65722342@lxorguk.ukuu.org.uk>
 <200905121123.21436.arnd@arndb.de> <20090513033027.GA13193@cynthia.pants.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout-apollo.uni-duesseldorf.de ([134.99.128.36]:41553 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750821AbZEMEMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 00:12:33 -0400
In-reply-to: <20090513033027.GA13193@cynthia.pants.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Boyer <flar@allandria.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, ysato@users.sourceforge.jp

Hi,

> > Currently, the only architectures that don't set HAS_DMA are h8300, m32r
> > m68k (except SUN3 and Coldfire), microblaze and s390.
> > s390 will never get it, microblaze is currently implementing dma-mapping.h.
> > 
> > The other three are still using drivers/ide instead of drivers/ata.
> > 
> > One way to fix this would be to implement dma-mapping.h in h8300, m32r and
> > m68k and leave !HAS_DMA as the obscure s390 case (this one already can't
> > use ATA because of !HAS_MMIO).
> 
> If I'm reading the m68k code correctly, SUN3 is the one that doesn't have
> DMA. It is implemented on any m68k with a standard Motorola MMU. It might
> be possible to get the DMA code working on a sun3, but I doubt they ever
> have IDE hardware.

The Atari IDE interface does not use DMA. I don't see what addition of DMA 
mapping for IDE would achieve. 

If it doesn't interfere with plain PIO mode, fine. 

	Michael

