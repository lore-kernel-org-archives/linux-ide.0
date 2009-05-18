From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] asm-generic: add a dma-mapping.h file
Date: Mon, 18 May 2009 18:54:49 -0400
Message-ID: <4A11E739.6080106@pobox.com>
References: <20090513043409.GA13577@cynthia.pants.nu> <200905172138.55145.arnd@arndb.de> <4A106E22.1010705@pobox.com> <200905172245.23774.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200905172245.23774.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <htejun@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

Arnd Bergmann wrote:
> h8300 and m32r currently do not provide a DMA mapping API
> and therefore cannot use the ATA drivers. This adds a
> generic version of dma-mapping.h for architectures that
> have none or very minimal actual support for DMA in hardware
> and makes the two architectures use it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> On Sunday 17 May 2009 20:05:54 Jeff Garzik wrote:
> 
>> That's what needs to happen.  We provide no-op functions for e.g. PCI 
>> and x86 DMI, for platforms where this support does not exist.
>>
>> Pretty much all architectures support some form of ATA.  m68k, m32r, 
>> h8300 and microblaze all have IDE interface, which means that libata 
>> needs to work on that platform.
>>
>> The only !ATA arch in the entire kernel is s390, AFAICT.
> 
> m68k only defines NO_DMA for Sun3 and Dragonball. Sun3 does
> not have ATA, Dragonball could probably just enable HAS_DMA.
> 
> ---
>  arch/h8300/Kconfig                   |    2 +-
>  arch/h8300/include/asm/dma-mapping.h |    1 +
>  arch/m32r/Kconfig                    |    2 +-
>  arch/m32r/include/asm/dma-mapping.h  |    1 +
>  include/asm-generic/dma-mapping.h    |  399 ++++++++++++++++++++++++++++++++++
>  5 files changed, 403 insertions(+), 2 deletions(-)
>  create mode 100644 arch/h8300/include/asm/dma-mapping.h
>  create mode 100644 arch/m32r/include/asm/dma-mapping.h
>  create mode 100644 include/asm-generic/dma-mapping.h

My main comment is a bit non-specific...   I tend to think that all 
no-dma platforms should provide an API whose implementation always 
returns errors, e.g. an inlined version of dma-mapping-broken.h.

That sort of setup permits the compiler's dead code elimination to work 
on these no-dma platforms, while not crapping up the libata code with a 
bunch of ifdefs.

	Jeff




