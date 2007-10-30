From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.24-rc1] sata_promise: ASIC PRD table bug workaround
Date: Tue, 30 Oct 2007 10:07:40 +0100 (MET)
Message-ID: <200710300907.l9U97eW8024996@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:57157 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbXJ3JH6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 05:07:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mikpe@it.uu.se
Cc: linux-ide@vger.kernel.org, screwdriver@lxnt.info

On Mon, 29 Oct 2007 15:07:06 -0400, Jeff Garzik wrote:
> Mikael Pettersson wrote:
> > @@ -155,7 +155,7 @@ static struct scsi_host_template pdc_ata
> >  	.queuecommand		= ata_scsi_queuecmd,
> >  	.can_queue		= ATA_DEF_QUEUE,
> >  	.this_id		= ATA_SHT_THIS_ID,
> > -	.sg_tablesize		= LIBATA_MAX_PRD,
> > +	.sg_tablesize		= LIBATA_MAX_PRD-1,
> >  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
> >  	.emulated		= ATA_SHT_EMULATED,
> >  	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> 
> IMO, this will be difficult for human eyes to see, many months from now.
> 
> I would prefer a 'PDC_MAX_PRD' constant, defined to this value.

Agreed. I'll do this change.

> > @@ -530,7 +608,7 @@ static void pdc_qc_prep(struct ata_queue
> >  
> >  	switch (qc->tf.protocol) {
> >  	case ATA_PROT_DMA:
> > -		ata_qc_prep(qc);
> > +		pdc_fill_sg(qc);
> >  		/* fall through */
> >  
> >  	case ATA_PROT_NODATA:
> > @@ -546,11 +624,11 @@ static void pdc_qc_prep(struct ata_queue
> >  		break;
> >  
> >  	case ATA_PROT_ATAPI:
> > -		ata_qc_prep(qc);
> > +		pdc_fill_sg(qc);
> >  		break;
> >  
> >  	case ATA_PROT_ATAPI_DMA:
> > -		ata_qc_prep(qc);
> > +		pdc_fill_sg(qc);
> >  		/*FALLTHROUGH*/
> 
> Note that this is not exactly an equivalent change -- you are removing 
> the test in ata_qc_prep() that occurs prior to ata_fill_sg() call.

As Alexander replied, pdc_fill_sg() does include ata_qc_prep()'s
initial test. Unfortunately the name pdc_qc_prep() is already taken
[it switches on qc->tf.protocol], so that leaves either pdc_fill_sg()
[slightly imprecise as you noted], or uglies like __pdc_qc_prep(),
pdc_qc_prep2(), or pdc_qc_prep_and_fill_sg() as names for the new
procedure. I welcome suggestions for a better name.

/Mikael
