From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 16:26:33 +0200
Message-ID: <20080826142633.GI20055@kernel.dk>
References: <20080826072841.GS20055@kernel.dk> <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk> <20080826101713.GW20055@kernel.dk> <48B3F7C3.6010600@wasp.net.au> <20080826124816.GA20055@kernel.dk> <48B3FD40.3000109@kernel.org> <20080826130657.GB20055@kernel.dk> <20080826135822.GE20055@kernel.dk> <48B4113D.8070608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [93.163.65.50] ([93.163.65.50]:1742 "EHLO kernel.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbYHZO0f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 10:26:35 -0400
Content-Disposition: inline
In-Reply-To: <48B4113D.8070608@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Brad Campbell <brad@wasp.net.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org

On Tue, Aug 26 2008, Tejun Heo wrote:
> Jens Axboe wrote:
> > OK, something like this. Jeff, if you think this is fine, let me know
> > and I'll submit a proper patch with description and so on.
> 
> FWIW, looks good to me.  Just one small concern below...
> 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 79e3a8e..879ceac 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -2100,6 +2100,10 @@ retry:
> >  static inline u8 ata_dev_knobble(struct ata_device *dev)
> >  {
> >  	struct ata_port *ap = dev->link->ap;
> > +
> > +	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
> > +		return 0;
> > +
> >  	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
> >  }
> >  
> > @@ -3998,6 +4002,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> >  	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
> >  	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
> >  
> > +	/* Devices that do not need bridging limits applied */
> > +	{ "Mtron",		NULL,		0, },
> 
> "Mtron" looks like a broad match but then again for some reason many
> non-traditional ATA vendors don't like to give descriptive
> identifications to their devices.  Any chance there is something more to
> match?  :-(

We could make it "MTRON MSP", I think that covers both the 70xx and 75xx
range.

-- 
Jens Axboe

