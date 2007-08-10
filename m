From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open
	bugs) II
Date: Fri, 10 Aug 2007 22:27:18 +0200
Message-ID: <20070810202718.GB11892@one.firstfloor.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1186770505.6334.3.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, Natalie Protasevich <protasnb@gmail.com>, linux-ide@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

> Surely we don't need to wait until then?  This is the correct fix, isn't
> it?  (Obviously I'll split it into a generic and a pcmcia specific piece
> if it looks OK to everyone).
> 
> It sets the PCMCIA dma_mask up correctly and introduces a DMA_MASK_NONE
> (I prefer that to DMA_0BIT_MASK but I can add that too if people want)
> and gives Alan his is_device_dma_capable() API.

Patch looks good to me.

-Andi
