From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Mon, 18 May 2009 08:03:12 +0200
Message-ID: <10f740e80905172303n4ef3cfc2j9922e19c281d471b@mail.gmail.com>
References: <20090513043409.GA13577@cynthia.pants.nu>
	 <200905172138.55145.arnd@arndb.de> <4A106E22.1010705@pobox.com>
	 <200905172245.23774.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200905172245.23774.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <htejun@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Mon, May 18, 2009 at 00:45, Arnd Bergmann <arnd@arndb.de> wrote:
> --- /dev/null
> +++ b/include/asm-generic/dma-mapping.h
> @@ -0,0 +1,399 @@
> +#ifndef _ASM_GENERIC_DMA_MAPPING_H
> +#define _ASM_GENERIC_DMA_MAPPING_H
> +/*
> + * This provides a no-op variant of the DMA mapping API,
> + * for use by architectures that do not actually support
> + * DMA, or that are fully consistent and linear-mapped
> + * in their DMA implementation.
> + */
> +
> +#include <asm/scatterlist.h>
> +
> +/*
> + * If any driver asks for DMA, it's not supported.
> + */
> +#ifndef dma_supported
> +static inline int
> +dma_supported(struct device *dev, u64 mask)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#endif
> +
> +#ifndef dma_set_mask
> +static inline int
> +dma_set_mask(struct device *dev, u64 dma_mask)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!dev->dma_mask || !dma_supported(dev, dma_=
mask))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 *dev->dma_mask =3D dma_mask;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#endif
> +
> +/**
> + * dma_alloc_coherent - allocate consistent memory for DMA
> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like =
devices
> + * @size: required memory size
> + * @handle: bus-specific DMA address
> + *
> + * Allocate some uncached, unbuffered memory for a device for
> + * performing DMA. =C2=A0This function allocates pages, and will
> + * return the CPU-viewed address, and sets @handle to be the
> + * device-viewed address.
> + */
> +#ifndef dma_alloc_coherent
> +static inline void *
> +dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_=
handle,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfp_t=
 flag)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void *virt =3D kmalloc(size, flag);

kmalloc() may fail.

> + =C2=A0 =C2=A0 =C2=A0 *dma_handle =3D virt_to_phys(virt);

Not all variants of virt_to_phys() may handle the NULL case very well.
I took a statistically invalid sample: some just cast to unsigned
long, other subtract PAGE_OFFSET.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
