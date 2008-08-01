From: Alan Cox <alan@redhat.com>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Fri, 1 Aug 2008 12:58:04 -0400
Message-ID: <20080801165804.GA21906@devserv.devel.redhat.com>
References: <1217581709.11188.489.camel@pasglop> <4892DE7C.2040708@gmail.com> <1217588203.11188.507.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYHARMe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 13:12:34 -0400
Content-Disposition: inline
In-Reply-To: <1217588203.11188.507.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tejun Heo <htejun@gmail.com>, list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

> I know and I believe it should still be ok ... As I said, the chipset
> should use the PIO field in the register for PIO transfers. And if the
> above unknown bit is set, I suspect it's just going to increase the
> setup time a bit or something like that, which won't hurt other than
> perfs.

What I do with some other drivers is set the PIO mode in the pio mode function
but defer DMA timing setup to bmdma_start/stop methods. Some chips need this
in the PC world and that works nicely.

> > > +static unsigned long pata_macio_mode_filter(struct ata_device *adev,
> > > +					    unsigned long xfer_mask)
> > > +{
> > > +	struct pata_macio_priv *priv = adev->link->ap->private_data;
> > > +
> > > +	if (priv->dma_regs == NULL)
> > > +		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> > > +	return xfer_mask;
> > > +}
> > 
> > Wouldn't it be better to clear these during initialization?
> 
> I could. Doesn't matter much where it's done, does it ? Doing there
> allows to deal with a failure in my port_start() callback, if the
> allocation of the DMA table fails, I clear dma_regs.

For x86 we clear it later in some cases too - because the allocation is
done after we pass the sht and ata parameters to the setup functions.

> The reason is that I can only have 64K-4K per transfer (I don't think I
> can do 64K per DBDMA entry). So the above routine can potentially
> breakup, in the worst case scenario, the table into twice as many
> entries if they are all 64K precisely.

See ata_sff_dumb_qc_prep - we have PC chips with the same bug!

--
   "Engineers are 'small children' when it comes to product warning labels"
					-- John Duino

