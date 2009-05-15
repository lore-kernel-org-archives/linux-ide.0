From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Fri, 15 May 2009 13:16:30 +0200
Message-ID: <200905151316.31521.arnd@arndb.de>
References: <20090513043409.GA13577@cynthia.pants.nu> <20090514091928R.fujita.tomonori@lab.ntt.co.jp> <4A0CFE1F.5080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <4A0CFE1F.5080409@gmail.com>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, hancockrwd@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Friday 15 May 2009, Tejun Heo wrote:
> FUJITA Tomonori wrote:
> > Can libata call dma_supported() per device to decide DMA or PIO mod=
e?
> > Then, we can solve this problem by add dummy DMA API (just calls BU=
G)
> > on such architectures, without Kconfig magic or adding ifdef (like =
the
> > old ide stack does), I think.

That would be the !CONFIG_PCI half of the old
include/asm-generic/dma-mapping.h file that you just removed,
right?

In general, I'd prefer keeping the asm-generic/dma-mapping-broken.h
implementation that gives us a compile-time error, but maybe there
is an even better option based on the mn10300 implementation which
basically pretends everything works with just page_to_phys() mappings.

> Sure it can. =A0Which specific drivers are we talking about?

The main problem is libata-core.c, which references DMA mapping
API calls that are only implemented on architectures setting
CONFIG_HAS_DMA.

	Arnd <><
--
To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
