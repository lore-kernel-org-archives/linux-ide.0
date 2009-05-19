From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Tue, 19 May 2009 10:01:27 -0700
Message-ID: <da824cf30905191001p29217d44u62bcc1c38b0acd92@mail.gmail.com>
References: <200905172245.23774.arnd@arndb.de>
	 <200905181645.26305.arnd@arndb.de>
	 <20090519074355P.fujita.tomonori@lab.ntt.co.jp>
	 <200905191822.48420.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:62326 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZESRBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 13:01:32 -0400
In-Reply-To: <200905191822.48420.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, jgarzik@pobox.com, hancockrwd@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp

On Tue, May 19, 2009 at 9:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 May 2009, FUJITA Tomonori wrote:
>> > Would you agree to a patch that works with the same
>> > code on e.g. arm, microblaze, mn10300 and sh and
>> > uses only a few #ifdefs?
>>
>> Having such helper for a linear mapping might be helpful but your
>> approach is wrong.
>
> Do you like this approach better? I've merged a few architectures
> that were relatively simple. This file should be usable by all
> architectures that have a linear mapping and are either fully coheren=
t
> (like cris) or just require flushing the dcache when passing a
> buffer to the device.

I've reviewed the first bit and it looks fine (so far to me).
Two related bugs:
1) dma_alloc_coherent() is not respecting the coherent_dma_mask field
in device.h:struct device.
2) dma_map_single() is not respecting dma_mask in struct pci_dev (and
pointer from struct device).

=2E..
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

Key here is the DMA is coherent, bi-directional, and the DMA address fi=
t in
the coherent_dma_mask. "uncached/unbuffered" is one way of doing this a=
nd
is how we've implemented "DMA coherency" on parisc platforms that don't
have an IOMMU (which all have PA1.1 CPUs) - see arch/parisc/kernel/pci-=
dma.c

And I'll confess pci-dma.c doesn't implement support for coherent_dma_m=
ask .
AFAIK, the targeted platforms have < 4GB of RAM and only PCI devices.
ISA support is completely missing and is the only case this class of ma=
chines
need coherent_dma_mask support.

More comments on how DMA works for PARISC in
arch/parisc/include/asm/dma-mapping.h

hth,
grant
