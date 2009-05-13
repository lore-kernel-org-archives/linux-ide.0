From: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Tue, 12 May 2009 21:34:09 -0700
Message-ID: <20090513043409.GA13577@cynthia.pants.nu>
References: <20090511222702.352192505@arndb.de> <200905112238.55404.arnd@arndb.de> <20090512090602.65722342@lxorguk.ukuu.org.uk> <200905121123.21436.arnd@arndb.de> <20090513033027.GA13193@cynthia.pants.nu> <alpine.DEB.1.00.0905130610240.18305@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905130610240.18305@zirkon.biophys.uni-duesseldorf.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Wed, May 13, 2009 at 06:12:31AM +0200, Michael Schmitz wrote:
> The Atari IDE interface does not use DMA. I don't see what addition of DMA 
> mapping for IDE would achieve. 

The macide driver doesn't support anything with DMA hardware either. In
fact, no m68k Macintosh has both DMA capability and an IDE controller.
However, we do support the basic DMA routines on the main m68k platforms.
It's just not used for IDE. I think the proposed change was to require
that the DMA routines be present, not that the IDE ports actually have
to have a DMA capability.

> If it doesn't interfere with plain PIO mode, fine. 

I agree. There definitely needs to still be support for IDE ports that
don't have DMA capability.

	Brad Boyer
	flar@allandria.com

