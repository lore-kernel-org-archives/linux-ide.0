From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Tue, 12 May 2009 11:23:20 +0200
Message-ID: <200905121123.21436.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de> <200905112238.55404.arnd@arndb.de> <20090512090602.65722342@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090512090602.65722342@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Tuesday 12 May 2009, Alan Cox wrote:
> Nakked-by: Alan Cox <alan@linux.intel.com>
> 
> Almost every PATA adapter can fall back to PIO, many are PIO only. We
> need a rather cleaner way to sort this.

Currently, the only architectures that don't set HAS_DMA are h8300, m32r
m68k (except SUN3 and Coldfire), microblaze and s390.
s390 will never get it, microblaze is currently implementing dma-mapping.h.

The other three are still using drivers/ide instead of drivers/ata.

One way to fix this would be to implement dma-mapping.h in h8300, m32r and
m68k and leave !HAS_DMA as the obscure s390 case (this one already can't
use ATA because of !HAS_MMIO).

The other way would be to add some #ifdef CONFIG_HAS_DMA in libata-core.c
and sas_ata.c.

	Arnd <><

	Arnd <><

