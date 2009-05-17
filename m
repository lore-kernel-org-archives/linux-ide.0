From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Sun, 17 May 2009 03:00:25 -0600
Message-ID: <4A0FD229.9010401@gmail.com>
References: <20090513043409.GA13577@cynthia.pants.nu> <200905151316.31521.arnd@arndb.de> <4A0D5051.90708@gmail.com> <200905151355.09888.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200905151355.09888.arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <htejun@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp
List-Id: linux-ide@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 15 May 2009, Tejun Heo wrote:
>> Don't know much history here but I don't wanna sprinkle ifdefs around
>> in libata so I would much prefer dummy implementation which doesn't
>> fail compile.
> 
> My original patch did that by adding 'depends on HAS_DMA'.
> 
> The only architectures that don't have that are m68k, m32r,
> h8300, s390 and microblaze. More research has shown that
> they all found a different way to disable the ATA drivers
> already, except microblaze.
> 
> Alan, you objected the patch initially (and loudly), but
> maybe you can reconsider this. The only actual effect
> that my patch has is to allow an allyesconfig build on
> microblaze and that will implement dma-mapping.h in the
> next version.
> 
> All existing architectures do not care at all about this
> change, unless I'm missing something.
> 
> Besides, all the other users of the DMA mapping API
> also depend on CONFIG_HAS_DMA.

Yes, it fixes the compile problem by preventing libata from being 
compiled at all. But the point is that libata should be able to work 
without DMA support.
