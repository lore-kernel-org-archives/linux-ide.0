From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Fri, 22 May 2009 17:05:53 +0200
Message-ID: <200905221705.54426.arnd@arndb.de>
References: <200905191822.48420.arnd@arndb.de> <200905221607.34025.arnd@arndb.de> <20090522233846I.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090522233846I.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: jgarzik@pobox.com, hancockrwd@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp, grundler@google.com
List-Id: linux-ide@vger.kernel.org

On Friday 22 May 2009, FUJITA Tomonori wrote:
> I'm not sure. And only mips internally uses CONFIG_DMA_COHERENT.
> 
> The reason why many architectures need architecture-specific
> alloc_coherent() is not about coherent or not.
> 
> I like a new helper header file having only generic functions without
> any ifdef.

Ok, fair enough. Fixing dma_alloc_coherent to handle
coherent_dma_mask and debug_dma correctly would also
make it even bigger, and it was already doing more than
you'd want from a commonly used inline function.
It may be useful to put it into kernel/dma-coherent.c
under an #ifdef, but I'll leave this one alone for now.

I'll leave dma_alloc_coherent and dma_free_coherent
as extern declarations then, and leave out the
simple dma_coherent_dev() and dma_cache_sync() that
all architectures would need to override.

dma_get_cache_alignment() is still less generic than
the other functions, as this is still architecture
specific. Should I leave that out as well then?

One more idea I had was to rename all the functions in
this file from dma_* to dma_linear_*. This would mean
that all architectures using it would still need to
do something like #define dma_map_sg dma_linear_map_sg
for each function they want to use but can easily chose
to provide their own ones for those they need different.

It might also help architectures that work with dma_ops,
which could then define their own
struct dma_ops dma_ops_linear = {
	.map_single = dma_linear_map_single,
	.map_sg = dma_linear_map_sg,
	...
};

Would you prefer me to do it this way, or just keep the
standard function names as in the current patch?

	Arnd <><
