From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG] bug when enabling VM DEBUG
Date: Wed, 12 May 2010 13:24:59 +0100
Message-ID: <1273667099.23818.86.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
	 <AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>
	 <4BEA1559.9000107@gmail.com>
	 <1273662639.23818.67.camel@e102109-lin.cambridge.arm.com>
	 <20100512115340.GA11261@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33356 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175Ab0ELMZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 08:25:16 -0400
In-Reply-To: <20100512115340.GA11261@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Robert Hancock <hancockrwd@gmail.com>, saeed bishara <saeed.bishara@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, DE/ATA development list <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Wed, 2010-05-12 at 12:53 +0100, Sebastian Andrzej Siewior wrote:
> * Catalin Marinas | 2010-05-12 12:10:39 [+0100]:
> 
> >> > --- a/drivers/ata/libata-sff.c
> >> > +++ b/drivers/ata/libata-sff.c
> >> > @@ -894,7 +894,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
> >> >                                         do_write);
> >> >          }
> >> >
> >> > -       if (!do_write)
> >> > +       if (!do_write&&  !PageSlab(page))
> >> >                  flush_dcache_page(page);
> >>
> >> I would think that check belongs inside flush_dcache_page itself, rather
> >> than forcing every driver to include it..
> >
> >Sebastian (cc'ed) reported this as well for MIPS.
> Thx. The patch above looks what I've sent a while ago. Jeff was going to
> merge it afaik.
> 
> >I think it makes sense for this check to be done in the
> >flush_dcache_page() function.
> 
> Why should flush_dcache_page() not flush pages you tell it?
> From Documentation/cachetlb.txt:
> |   NOTE: This routine need only be called for page cache pages
> |          which can potentially ever be mapped into the address
> |          space of a user process.  So for example, VFS layer code
> |          handling vfs symlinks in the page cache need not call
> |          this interface at all.
> 
> A page from slab or stack is not going to see the sky of user land and
> therefore it should not be fed into flush_dcache_page().

You are right :), so fixing the driver is the best approach.

-- 
Catalin

