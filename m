From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
	open bugs) II
Date: Sun, 16 Sep 2007 12:12:35 -0500
Message-ID: <1189962755.3383.5.camel@localhost.localdomain>
References: <20070809233458.12d8447c@the-village.bc.nu>
	 <20070809224305.GA1611@one.firstfloor.org>
	 <20070810001443.610185e1@the-village.bc.nu>
	 <20070809231141.GB1845@one.firstfloor.org>
	 <20070810002453.384a9b4c@the-village.bc.nu>
	 <p73sl6rencd.fsf@bingen.suse.de>
	 <20070810145430.17d72a76@the-village.bc.nu>
	 <1186757538.3335.3.camel@localhost.localdomain>
	 <20070810175808.52b5446a@the-village.bc.nu>
	 <1186770505.6334.3.camel@localhost.localdomain>
	 <20070810202718.GB11892@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:40244 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbXIPRMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Sep 2007 13:12:38 -0400
In-Reply-To: <20070810202718.GB11892@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-pcmcia@lists.infradead.org

On Fri, 2007-08-10 at 22:27 +0200, Andi Kleen wrote:
> > Surely we don't need to wait until then?  This is the correct fix, isn't
> > it?  (Obviously I'll split it into a generic and a pcmcia specific piece
> > if it looks OK to everyone).
> > 
> > It sets the PCMCIA dma_mask up correctly and introduces a DMA_MASK_NONE
> > (I prefer that to DMA_0BIT_MASK but I can add that too if people want)
> > and gives Alan his is_device_dma_capable() API.
> 
> Patch looks good to me.

No one else has commented ... shall I just submit the following two for
the merge window?

James


