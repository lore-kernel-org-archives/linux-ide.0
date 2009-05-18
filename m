From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Mon, 18 May 2009 19:45:09 +0900
Message-ID: <20090518194448U.fujita.tomonori@lab.ntt.co.jp>
References: <20090514091928R.fujita.tomonori@lab.ntt.co.jp>
	<4A0CFE1F.5080409@gmail.com>
	<200905151316.31521.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200905151316.31521.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: arnd@arndb.de
Cc: htejun@gmail.com, fujita.tomonori@lab.ntt.co.jp, hancockrwd@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Fri, 15 May 2009 13:16:30 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 15 May 2009, Tejun Heo wrote:
> > FUJITA Tomonori wrote:
> > > Can libata call dma_supported() per device to decide DMA or PIO mode?
> > > Then, we can solve this problem by add dummy DMA API (just calls BUG)
> > > on such architectures, without Kconfig magic or adding ifdef (like the
> > > old ide stack does), I think.
> 
> That would be the !CONFIG_PCI half of the old
> include/asm-generic/dma-mapping.h file that you just removed,
> right?

No.

The old include/asm-generic/dma-mapping.h is a workaround for lazy
architecture maintainers who have not converted pci_* API to dma_*
API.
