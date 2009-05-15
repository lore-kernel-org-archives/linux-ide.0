From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Fri, 15 May 2009 20:21:53 +0900
Message-ID: <4A0D5051.90708@gmail.com>
References: <20090513043409.GA13577@cynthia.pants.nu> <20090514091928R.fujita.tomonori@lab.ntt.co.jp> <4A0CFE1F.5080409@gmail.com> <200905151316.31521.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:30041 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbZEOLV4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 07:21:56 -0400
In-Reply-To: <200905151316.31521.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, hancockrwd@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp

Hello,

Arnd Bergmann wrote:
> On Friday 15 May 2009, Tejun Heo wrote:
>> FUJITA Tomonori wrote:
>>> Can libata call dma_supported() per device to decide DMA or PIO mode?
>>> Then, we can solve this problem by add dummy DMA API (just calls BUG)
>>> on such architectures, without Kconfig magic or adding ifdef (like the
>>> old ide stack does), I think.
> 
> That would be the !CONFIG_PCI half of the old
> include/asm-generic/dma-mapping.h file that you just removed,
> right?
> 
> In general, I'd prefer keeping the asm-generic/dma-mapping-broken.h
> implementation that gives us a compile-time error, but maybe there
> is an even better option based on the mn10300 implementation which
> basically pretends everything works with just page_to_phys() mappings.

Don't know much history here but I don't wanna sprinkle ifdefs around
in libata so I would much prefer dummy implementation which doesn't
fail compile.

>> Sure it can.  Which specific drivers are we talking about?
> 
> The main problem is libata-core.c, which references DMA mapping
> API calls that are only implemented on architectures setting
> CONFIG_HAS_DMA.

Yeah, sure, libata-core is used by every driver but I was wondering
whether only SFF drivers are of interest or there are others.

Thanks.

-- 
tejun
