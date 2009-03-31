From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and
 scc_pata.c
Date: Wed, 01 Apr 2009 00:26:51 +0900 (JST)
Message-ID: <20090401.002651.95063058.anemo@mba.ocn.ne.jp>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
	<alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:51114 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762829AbZCaP0w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 11:26:52 -0400
In-Reply-To: <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert.Uytterhoeven@sonycom.com
Cc: grundler@google.com, linux-ide@vger.kernel.org, bzolnier@gmail.com, linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org, linux-kernel@google.com

On Tue, 31 Mar 2009 09:51:53 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> > email on March 14th:
> >     http://lkml.org/lkml/2009/3/14/17
> > 
> > No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> > or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> > "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> > someone else
> > would know or would be able to ACK this patch.
> 
> tx49xx is MIPS, for Nemoto-san.
> 
> > This patch:
> > o replaces "mask" variable in ide_dma_end() with #define.
> > o removes use of wmb() in ide-dma-sff.c and scc_pata.c.
> > o is not tested - I don't have (or want) the HW.
> > 
> > I did NOT remove wmb() use in tx4939ide.c. tx4939ide.c __raw_writeb()
> > for MMIO transactions. __raw_writeb() does NOT guarantee memory
> > transaction ordering.

The wmb() in tx4939ide.c was just copied from ide_dma_end().  On this
MIPS core memory operations are strictly ordered so that the wmb() can
be removed.

And on MIPS __raw_writeb() and writeb() do same thing except for
endian conversion.

I will send a patch just for tx4939ide.c.  Thank you for suggestion.

> > tx4939ide also uses mmiowb(). AFAIK, mmiowb() only has an effect on
> > SGI IA64 NUMA machines. I'm not going to guess how this driver might work.

On MIPS mmiowb() can be (ab)used to flush write buffer.  Please do not
drop this mmiowb().

---
Atsushi Nemoto
