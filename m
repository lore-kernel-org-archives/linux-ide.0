From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Sat, 02 Aug 2008 08:40:26 +1000
Message-ID: <1217630426.11188.528.camel@pasglop>
References: <1217581709.11188.489.camel@pasglop>
	 <4892DE7C.2040708@gmail.com> <1217588203.11188.507.camel@pasglop>
	 <48933646.6050102@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41844 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466AbYHAWku (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 18:40:50 -0400
In-Reply-To: <48933646.6050102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

On Sat, 2008-08-02 at 01:13 +0900, Tejun Heo wrote:

> > Thus I decided to do a single function that does both and OR them
> > together, which corresponds to what Darwin does. I can still split them
> > again, but there's still the question of that mysterious bit :-)
> 
> Yeah, exactly what I was talking about. :-) I think I'll just update the
> core layer such that dma mode too is cleared when (re-)configuration starts.

Ok. As I said tho, I think the current approach will work fine for me.
Those timing regs are cycle counts for various parts of the cycle with
sometime a magic bit that just hard-extended a part of the cycle. So in
the case of the "weird" shared bit, having it spurriously set is of
little consequence other than slowing things down a bit. Having it
spurriously cleared is what I try to avoid.

But yes, it does make sense to clear dma_mode when you re-configure.

> Functionally, it doesn't really matter but it's just customary to use
> ->mode_filter() to enforce dynamic restrictions - say ATA can go over
> UDMA/66 but ATAPI can't or when both devices are present one transfer
> mode affects the other kind of things.  Hmm... But then again,
> ata_bmdma_mode_filter() is used to put the same kind of restriction as
> yours.  Heh..  Never mind this suggestion.

No problem :-)

> >>> +	/* Convert the last command to an input/output */
> >>> +	if (pi) {
> >>> +		table--;
> >>> +		st_le16(&table->command, write ? OUTPUT_LAST: INPUT_LAST);
> >>> +		table++;
> >>> +	}
> >> libata guarantees that pi is not zero here.
> > 
> > Ok. Thanks. BTW. I do have another question about that though.
> > 
> > I set currently the max size of the sglist to half of my max of DMA
> > commands a bit arbitrarily.
> > 
> > The reason is that I can only have 64K-4K per transfer (I don't think I
> > can do 64K per DBDMA entry). So the above routine can potentially
> > breakup, in the worst case scenario, the table into twice as many
> > entries if they are all 64K precisely.
> > 
> > Is there a way I can set a max size for a given sglist segment ? I know
> > the iommu can coalesce them back, but at least I know that breaking them
> > up won't cause more than what the iommu had as an input .. I don't have
> > an alignment restriction.
> 
> Maybe pci_set_dma_max_seg_size() which ends up in
> blk_queue_max_segment_size().  sata_inic162x uses it and your
> requirement seems similar.

Bingo ! I need to check this dma_params business, dunon in what case
the pointer exists in the struct dev though, but that looks like it will
do the trick. The iommu layer will deal with it too.

> > I don't think we ever use irqpoll on powerpc, but that's a good
> > question. I don't know what the right answer is. In fact, I looked a bit
> > at the libata core irq handling and it looks like if we return that the
> > IRQ wasn't for us, after 1000 iteration, libata goes read the status and
> > clear the IRQ anyway, which doesn't sound that a good idea if the IRQ is
> > shared....
> 
> That code is activated only if ATA_IRQ_TRAP is set and it's not even in
> config option.  I don't think anyone ever uses it.

Ah ok. Good then.

>   Also, the worst
> reading off status register and clearing BMDMA register can do is losing
> an interrupt causing a timeout.  Weighed against the dreaded nobody
> cared, it's not so bad.  libata definitely needs some improvements in
> this area.

The nobody cares thingy should be dealt by the irq core anyway.

> > I know some variant of the cell do have a register I can read to make
> > sure the IRQ came from it (or not), but I have to figure out if it
> > exists on the ohare variant or not. If it does, then I may be able to do
> > something saner here.
> 
> Ah... if there's anything like that, please use it.  I have no idea why
> the original TF and even BMDMA interface didn't include proper interrupt
> pending bit.  Oh well, they were designed when floppy was popular after all.

Heh :-)

> > In the meantime, the above is the same as what I did for drivers/ide.
> > 
> > Another option would be to use the DMA channel IRQ (it's a separate IRQ
> > I can use) and do like Darwin, that is, wait for both IRQs to happen
> > before moving forward.
> 
> Hmm...

Yup, I'm not fan of that option neither :-)

I'll see if I can dig more info about that interrupt pending register.
I'll have to do some experiments on the -one- ohare based machine I have
(which probably also needs a new disk)  to see if it has such a
register.

In the meantime though, the current hack should do the job at least as
well as the one in drivers/ide does :-)

> pcim_enable_device() is a little bit more than managed pdev enable.  It
> turns on resource management for other PCI resources like IO regions and
> INTX setting.

Oh ok, it would turn my pcim_request_region automagically into managed
ones so I don't have to bother releasing them ? Nice... I wonder if it's
worth adding something like that to of_device / macio_device :-)

Thanks !

Ben.


