From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Fri, 22 May 2009 16:07:32 +0200
Message-ID: <200905221607.34025.arnd@arndb.de>
References: <200905181645.26305.arnd@arndb.de> <200905191822.48420.arnd@arndb.de> <20090522211258Q.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090522211258Q.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: jgarzik@pobox.com, hancockrwd@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp, Grant Grundler <grundler@google.com>
List-Id: linux-ide@vger.kernel.org

On Friday 22 May 2009, FUJITA Tomonori wrote:
> I don't think that this works for all architectures because a returned
> buffer of alloc_pages_node might not be DMA-capable. Needs to use the
> coherent_dma_mask here. See x86's dma_alloc_coherent and Alpha's
> pci-noop.c (there might be other examples).

Right, Grant also made the same comment.

> I think that having a generic header for simple mapping functions
> (dma_map_single, dma_map_page, dma_map_sg, etc) would be useful but
> I'm not sure if we can't have a generic version of
> dma_alloc_coherent.
>
> There are lots of architectures that do 
> architecture-specific things. For example, you replaced avr32
> dma-mapping.h except for dma_alloc_coherent, which seems to be can't
> be generic.

I agree that it won't be fully generic, because all architectures
with non-coherent DMA will have to do architecture specific setup
to get uncached mappings here. I believe that it can be generic
enough to support all architectures that have a cache-coherent PCI
bus, hence the #ifdef CONFIG_DMA_COHERENT around this function.

E.g. cris could use a one-line redirect to
asm-generic/dma-mapping-linear.h if it did not have the
special dma_get_cache_alignment function. I still would
like to find a better way to handle this one than to
redefine the function.

> BTW, it looks odd to add dma_debug to dma_map_single, etc but not
> dma_alloc_coherent. ;)

hehe, sure. I copied the dma_debug stuff from sh, the comments
from avr32 and the dma_alloc_coherent implementation from powerpc,
so I missed this one.

Thanks for the review.

	Arnd <><
