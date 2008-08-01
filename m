From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Sat, 02 Aug 2008 01:13:58 +0900
Message-ID: <48933646.6050102@gmail.com>
References: <1217581709.11188.489.camel@pasglop>	 <4892DE7C.2040708@gmail.com> <1217588203.11188.507.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:58739 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYHAQO0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 12:14:26 -0400
Received: by py-out-1112.google.com with SMTP id p76so583527pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 01 Aug 2008 09:14:25 -0700 (PDT)
In-Reply-To: <1217588203.11188.507.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

Benjamin Herrenschmidt wrote:
>>> +static void pata_macio_set_timings(struct ata_port *ap,
>>> +				   struct ata_device *adev)
>> Using single function for ->set_piomode and ->set_dmamode might not be
>> a good idea as libata core might call ->set_piomode with pio mode set
>> to PIO0 before reset but leaving the dma mode as is expecting the
>> transfer mode to be configured to PIO0.  However, this function would
>> configure considering the left-over DMA mode.
> 
> Would that be a problem as long as we use PIO ? Ie. the chipset will
> use the PIO timings when doing PIO transfers.

Some controllers share part of timing settings between PIO and DMA, so
the result might be different from expected.

> The reason I do both in
> one go is because of the shasta controller. For all the other one, I
> know quite precisely what all the bits are, and the PIO vs. DMA timing
> bits are clearly separate.
> 
> For shasta, I have no doc nor useful infos in the Darwin driver other
> than the timing tables, and they seem to have at least a one bit overlap
> between PIO and DMA timings. IE. This bit is set by the PIO timings and
> by some DMA timings, and it's unclear to me how to deal with that. IE,
> if you set a DMA timing where it's not set, and a PIO timing where it's
> set, should I set it or not ?
> 
> Thus I decided to do a single function that does both and OR them
> together, which corresponds to what Darwin does. I can still split them
> again, but there's still the question of that mysterious bit :-)

Yeah, exactly what I was talking about. :-) I think I'll just update the
core layer such that dma mode too is cleared when (re-)configuration starts.

>>> +static unsigned long pata_macio_mode_filter(struct ata_device *adev,
>>> +					    unsigned long xfer_mask)
>>> +{
>>> +	struct pata_macio_priv *priv = adev->link->ap->private_data;
>>> +
>>> +	if (priv->dma_regs == NULL)
>>> +		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>>> +	return xfer_mask;
>>> +}
>> Wouldn't it be better to clear these during initialization?
> 
> I could. Doesn't matter much where it's done, does it ? Doing there
> allows to deal with a failure in my port_start() callback, if the
> allocation of the DMA table fails, I clear dma_regs.

Functionally, it doesn't really matter but it's just customary to use
->mode_filter() to enforce dynamic restrictions - say ATA can go over
UDMA/66 but ATAPI can't or when both devices are present one transfer
mode affects the other kind of things.  Hmm... But then again,
ata_bmdma_mode_filter() is used to put the same kind of restriction as
yours.  Heh..  Never mind this suggestion.

>>> +	/* Convert the last command to an input/output */
>>> +	if (pi) {
>>> +		table--;
>>> +		st_le16(&table->command, write ? OUTPUT_LAST: INPUT_LAST);
>>> +		table++;
>>> +	}
>> libata guarantees that pi is not zero here.
> 
> Ok. Thanks. BTW. I do have another question about that though.
> 
> I set currently the max size of the sglist to half of my max of DMA
> commands a bit arbitrarily.
> 
> The reason is that I can only have 64K-4K per transfer (I don't think I
> can do 64K per DBDMA entry). So the above routine can potentially
> breakup, in the worst case scenario, the table into twice as many
> entries if they are all 64K precisely.
> 
> Is there a way I can set a max size for a given sglist segment ? I know
> the iommu can coalesce them back, but at least I know that breaking them
> up won't cause more than what the iommu had as an input .. I don't have
> an alignment restriction.

Maybe pci_set_dma_max_seg_size() which ends up in
blk_queue_max_segment_size().  sata_inic162x uses it and your
requirement seems similar.

>>> +	/* If dbdma didn't execute the STOP command yet, the
>>> +	 * active bit is still set. We consider that we aren't
>>> +	 * sharing interrupts (which is hopefully the case with
>> Wouldn't it be better to clear IRQF_SHARED for those?  Also, what
>> happens w/ irqpoll?
> 
> I don't think we ever use irqpoll on powerpc, but that's a good
> question. I don't know what the right answer is. In fact, I looked a bit
> at the libata core irq handling and it looks like if we return that the
> IRQ wasn't for us, after 1000 iteration, libata goes read the status and
> clear the IRQ anyway, which doesn't sound that a good idea if the IRQ is
> shared....

That code is activated only if ATA_IRQ_TRAP is set and it's not even in
config option.  I don't think anyone ever uses it.  Also, the worst
reading off status register and clearing BMDMA register can do is losing
an interrupt causing a timeout.  Weighed against the dreaded nobody
cared, it's not so bad.  libata definitely needs some improvements in
this area.

> I know some variant of the cell do have a register I can read to make
> sure the IRQ came from it (or not), but I have to figure out if it
> exists on the ohare variant or not. If it does, then I may be able to do
> something saner here.

Ah... if there's anything like that, please use it.  I have no idea why
the original TF and even BMDMA interface didn't include proper interrupt
pending bit.  Oh well, they were designed when floppy was popular after all.

> In the meantime, the above is the same as what I did for drivers/ide.
> 
> Another option would be to use the DMA channel IRQ (it's a separate IRQ
> I can use) and do like Darwin, that is, wait for both IRQs to happen
> before moving forward.

Hmm...

>>> +	/* Check that it can be enabled */
>>> +	if (pci_enable_device(pdev)) {
>>> +		dev_err(&pdev->dev,
>>> +			"Cannot enable controller PCI device\n");
>>> +		return -ENXIO;
>>> +	}
>> Maybe pcim_enable_device() can be used?  Or is it difficult because of
>> the macio stuff?
> 
> I wouldn't bother. There's no point in disabling it, this is just to
> make sure it's been properly enabled at boot.

pcim_enable_device() is a little bit more than managed pdev enable.  It
turns on resource management for other PCI resources like IO regions and
INTX setting.

Thanks.

-- 
tejun
