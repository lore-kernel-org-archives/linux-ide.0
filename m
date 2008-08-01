From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Fri, 01 Aug 2008 20:56:43 +1000
Message-ID: <1217588203.11188.507.camel@pasglop>
References: <1217581709.11188.489.camel@pasglop>
	 <4892DE7C.2040708@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54302 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000AbYHAK6A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 06:58:00 -0400
In-Reply-To: <4892DE7C.2040708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

On Fri, 2008-08-01 at 18:59 +0900, Tejun Heo wrote:
> Hello,
> 
> I don't know anything about ppc macs or macio controllers and only
> tentatively reviewed common libata stuff.  I couldn't spot any major
> problem.  A few nits follow.

Fair enough, that's what I was after anyway :-)

Thanks !
Ben.

> > +#include "pata_macio.h"
> 
> In libata, LLDs usually don't use header files for constants and stuff
> unless they need to be shared.

Ok, I was hesitating a bit ... it's more handy when hacking to have it
separate but I may fold them together when I'm done.

> > +static void pata_macio_apply_timings(struct ata_port *ap, unsigned int device)
> > +{
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	void __iomem *rbase = ap->ioaddr.cmd_addr;
> > +
> > +	if (device != 0 && device != 1)
> > +		return;
> 
> This condition is guaranteed not to be triggered by the core layer.

I though that too, but wasn't 100% sure... ie, if something goes wrong
for some reason in the core (a bug ?) I prefer the above to blasting
beyond the array boundary. Maybe I can turn that into a BUG_ON.

> > +static void pata_macio_set_timings(struct ata_port *ap,
> > +				   struct ata_device *adev)
> 
> Using single function for ->set_piomode and ->set_dmamode might not be
> a good idea as libata core might call ->set_piomode with pio mode set
> to PIO0 before reset but leaving the dma mode as is expecting the
> transfer mode to be configured to PIO0.  However, this function would
> configure considering the left-over DMA mode.

Would that be a problem as long as we use PIO ? Ie. the chipset will
use the PIO timings when doing PIO transfers. The reason I do both in
one go is because of the shasta controller. For all the other one, I
know quite precisely what all the bits are, and the PIO vs. DMA timing
bits are clearly separate.

For shasta, I have no doc nor useful infos in the Darwin driver other
than the timing tables, and they seem to have at least a one bit overlap
between PIO and DMA timings. IE. This bit is set by the PIO timings and
by some DMA timings, and it's unclear to me how to deal with that. IE,
if you set a DMA timing where it's not set, and a PIO timing where it's
set, should I set it or not ?

Thus I decided to do a single function that does both and OR them
together, which corresponds to what Darwin does. I can still split them
again, but there's still the question of that mysterious bit :-)

> Hmmm... I guess we need to clear the DMA mode on reset, but anyways
> that's what libata has been assuming till now.  set_piomode only deals
> with pio mode.

I know and I believe it should still be ok ... As I said, the chipset
should use the PIO field in the register for PIO transfers. And if the
above unknown bit is set, I suspect it's just going to increase the
setup time a bit or something like that, which won't hurt other than
perfs.

> > +{
> > +	struct pata_macio_priv *priv = ap->private_data;
> > +	const struct pata_macio_timing *t;
> > +
> > +	dev_dbg(priv->dev, "Set timings: DEV=%d, PIO=0x%x (%s), DMA=0x%x (%s)\n",
> > +		adev->devno,
> > +		adev->pio_mode, ata_mode_string(ata_xfer_mode2mask(adev->pio_mode)),
> > +		adev->dma_mode, ata_mode_string(ata_xfer_mode2mask(adev->dma_mode)));
> > +
> > +	if (adev->devno != 0 && adev->devno != 1)
> > +		return;
> 
> This condition is guaranteed not to be triggered by the core layer.

Same as above... I prefer avoiding an array overflow if the core happens
to misbehave. Maybe I should use BUG_ON instead.

> > +static unsigned long pata_macio_mode_filter(struct ata_device *adev,
> > +					    unsigned long xfer_mask)
> > +{
> > +	struct pata_macio_priv *priv = adev->link->ap->private_data;
> > +
> > +	if (priv->dma_regs == NULL)
> > +		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> > +	return xfer_mask;
> > +}
> 
> Wouldn't it be better to clear these during initialization?

I could. Doesn't matter much where it's done, does it ? Doing there
allows to deal with a failure in my port_start() callback, if the
allocation of the DMA table fails, I clear dma_regs.

> > +	/* Convert the last command to an input/output */
> > +	if (pi) {
> > +		table--;
> > +		st_le16(&table->command, write ? OUTPUT_LAST: INPUT_LAST);
> > +		table++;
> > +	}
> 
> libata guarantees that pi is not zero here.

Ok. Thanks. BTW. I do have another question about that though.

I set currently the max size of the sglist to half of my max of DMA
commands a bit arbitrarily.

The reason is that I can only have 64K-4K per transfer (I don't think I
can do 64K per DBDMA entry). So the above routine can potentially
breakup, in the worst case scenario, the table into twice as many
entries if they are all 64K precisely.

Is there a way I can set a max size for a given sglist segment ? I know
the iommu can coalesce them back, but at least I know that breaking them
up won't cause more than what the iommu had as an input .. I don't have
an alignment restriction.

> > +	/* Add the stop command to the end of the list */
> > +	memset(table, 0, sizeof(struct dbdma_cmd));
> > +	st_le16(&table->command, DBDMA_STOP);
> > +
> > +	dev_dbgdma(priv->dev, "%s: %d DMA list entries\n", __func__, pi);
> > +}
> > +
> > +static void pata_macio_bmdma_setup (struct ata_queued_cmd *qc)
> 
>                                      ^ Heh heh.  On other BMDMA ops too.

Copy/paste from another driver :-) I'll fix that up.

> > +static u8 pata_macio_bmdma
> > +	/* If ACTIVE is cleared, the STOP command have passed and
> > +	 * transfer is complete. If not, we to flush the channel.
> 
> 					missing have?

Yup, thanks.

> > +	 */
> > +	if ((dstat & ACTIVE) == 0)
> > +		return rstat;
> > +
> > +	dev_dbgdma(priv->dev, "%s: DMA still active, flushing...\n", __func__);
> > +
> > +	/* If dbdma didn't execute the STOP command yet, the
> > +	 * active bit is still set. We consider that we aren't
> > +	 * sharing interrupts (which is hopefully the case with
> 
> Wouldn't it be better to clear IRQF_SHARED for those?  Also, what
> happens w/ irqpoll?

I don't think we ever use irqpoll on powerpc, but that's a good
question. I don't know what the right answer is. In fact, I looked a bit
at the libata core irq handling and it looks like if we return that the
IRQ wasn't for us, after 1000 iteration, libata goes read the status and
clear the IRQ anyway, which doesn't sound that a good idea if the IRQ is
shared....

I know some variant of the cell do have a register I can read to make
sure the IRQ came from it (or not), but I have to figure out if it
exists on the ohare variant or not. If it does, then I may be able to do
something saner here.

In the meantime, the above is the same as what I did for drivers/ide.

Another option would be to use the DMA channel IRQ (it's a separate IRQ
I can use) and do like Darwin, that is, wait for both IRQs to happen
before moving forward.


> > +	/* Allocate space for the DBDMA commands.
> > +	 *
> > +	 * The +2 is +1 for the stop command and +1 to allow for
> > +	 * aligning the start address to a multiple of 16 bytes.
> > +	 */
> > +	priv->dma_table_cpu = dma_alloc_coherent(priv->dev,
> > +						 (MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
> > +						 &priv->dma_table_dma, GFP_KERNEL);
> 
> dmam_alloc_coherent() maybe?

Good point. Thanks.

> > +	/* Check that it can be enabled */
> > +	if (pci_enable_device(pdev)) {
> > +		dev_err(&pdev->dev,
> > +			"Cannot enable controller PCI device\n");
> > +		return -ENXIO;
> > +	}
> 
> Maybe pcim_enable_device() can be used?  Or is it difficult because of
> the macio stuff?

I wouldn't bother. There's no point in disabling it, this is just to
make sure it's been properly enabled at boot.

Many thanks for your review !

Cheers,
Ben.


