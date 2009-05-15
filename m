From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Fri, 15 May 2009 13:55:08 +0200
Message-ID: <200905151355.09888.arnd@arndb.de>
References: <20090513043409.GA13577@cynthia.pants.nu> <200905151316.31521.arnd@arndb.de> <4A0D5051.90708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZEOL4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 07:56:53 -0400
In-Reply-To: <4A0D5051.90708@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, hancockrwd@gmail.com, alan@lxorguk.ukuu.org.uk, flar@allandria.com, schmitz@biophys.uni-duesseldorf.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, takata@linux-m32r.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, ysato@users.sourceforge.jp

On Friday 15 May 2009, Tejun Heo wrote:
> Don't know much history here but I don't wanna sprinkle ifdefs around
> in libata so I would much prefer dummy implementation which doesn't
> fail compile.

My original patch did that by adding 'depends on HAS_DMA'.

The only architectures that don't have that are m68k, m32r,
h8300, s390 and microblaze. More research has shown that
they all found a different way to disable the ATA drivers
already, except microblaze.

Alan, you objected the patch initially (and loudly), but
maybe you can reconsider this. The only actual effect
that my patch has is to allow an allyesconfig build on
microblaze and that will implement dma-mapping.h in the
next version.

All existing architectures do not care at all about this
change, unless I'm missing something.

Besides, all the other users of the DMA mapping API
also depend on CONFIG_HAS_DMA.

	Arnd <><
