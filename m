From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Tue, 19 May 2009 11:08:27 -0700
Message-ID: <da824cf30905191108y77a44a2av7911dc2784b7ea90@mail.gmail.com>
References: <200905172245.23774.arnd@arndb.de>
	 <200905191822.48420.arnd@arndb.de>
	 <da824cf30905191001p29217d44u62bcc1c38b0acd92@mail.gmail.com>
	 <200905191740.21150.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200905191740.21150.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, jgarzik@pobox.com, hancockrwd@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

On Tue, May 19, 2009 at 10:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 May 2009 17:01:27 Grant Grundler wrote:
>> On Tue, May 19, 2009 at 9:22 AM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> I've reviewed the first bit and it looks fine (so far to me).
>> Two related bugs:
>> 1) dma_alloc_coherent() is not respecting the coherent_dma_mask fiel=
d
>> in device.h:struct device.
>
> Hmm, I've taken that function unchanged from powerpc. I guess that me=
ans
> that powerpc is broken =C2=A0here as well, right?

Not necessarily. It might work fine for the subset of machines that
use that code.
But generic code should use the masks - even if they are set to ~0UL.

>> 2) dma_map_single() is not respecting dma_mask in struct pci_dev (an=
d
>> pointer from struct device).
>
> What should it do with the mask?

Verify or enforce that the physical memory is allocated from a memory
pool suitable for
use by that device. If any bits "stick out" from the address (vs the
mask), the device
won't be able to DMA to that address and very likely truncate the addre=
ss.

By default the PCI dma_mask is 32-bits. Drivers that can support more
than 32-bits
(some PCI, most PCI-X and all PCI-E devices) will be calling pci_set_dm=
a_mask()
and pci_set_coherent_dma_mask() or the equivalent DMA API call.


> All the architectures I've looked
> at as well as arch/parisc/kernel/pci-dma.c ignore it.

pci-dma.c ignores it for the same reason it ignores coherent_dma_mask.
None of those parisc machines have host memory at a physical address th=
at is NOT
reachable via DMA by *all* known/supported devices.

Maybe it's ok and we just need a comment stating the constraints of
the generic code.

And there must be some way (e.g. dma_support()) to verify the highest p=
hysical
memory location is reachable by the given device. So that would be anot=
her way
to enforce the mask.

> Should dma_map_* just fail in case of an address exceeding dma_mask?

That would probably be correct behavior too. But my gut feeling is we d=
on't want
the device driver module to load unless we know the device can DMA to
any possible host memory location handed to dma_map_single().
My preference is the initialization path fail first. dma_alloc_coherent=
()
is generally in the initialization path after the drivers call pci_set*=
mask().


>
>> > +/**
>> > + * dma_alloc_coherent - allocate consistent memory for DMA
>> > + * @dev: valid struct device pointer, or NULL for ISA and EISA-li=
ke devices
>> > + * @size: required memory size
>> > + * @handle: bus-specific DMA address
>> > + *
>> > + * Allocate some uncached, unbuffered memory for a device for
>> > + * performing DMA. =C2=A0This function allocates pages, and will
>> > + * return the CPU-viewed address, and sets @handle to be the
>> > + * device-viewed address.
>>
>> Key here is the DMA is coherent, bi-directional, and the DMA address=
 fit in
>> the coherent_dma_mask. "uncached/unbuffered" is one way of doing thi=
s and
>> is how we've implemented "DMA coherency" on parisc platforms that do=
n't
>> have an IOMMU (which all have PA1.1 CPUs) - see arch/parisc/kernel/p=
ci-dma.c
>
> All the architectures I've looked at come with their own version of _=
alloc_coherent
> that works in similar ways to allocate an uncached mapping.

That's what I expected. I'm pretty sure parisc could use a generic
implementation
for PA7100LC and PA7300LC CPUs (other parisc CPUs/memory controllers do=
n't
support uncached mappings to host memory). So we would need run-time de=
tection
and set dma_ops appropriately.

> Now that you
> mention this, I realize that there is a bug on cris, which after my p=
atch either
> has two conflicting implementations of dma_{alloc,free}_coherent, or
> is missing the dma_coherent_dev() function that is hidden inside of t=
he
> same #ifdef. The one in arch/cris/arch-v32/drivers/pci/dma.c does see=
m
> to be correct though.

Ok - cool!

thanks,
grant
--
To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
