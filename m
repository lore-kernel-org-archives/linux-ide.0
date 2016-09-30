From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: Re: [PATCH 2/3] ata: Enabling ATA Command Priorities
Date: Fri, 30 Sep 2016 09:04:13 -0700
Message-ID: <20160930160413.GB13637@hgst.com>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <1475000096-6148-3-git-send-email-adam.manzanares@hgst.com>
 <20160929084529.GC11087@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160929084529.GC11087@mtj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The 09/29/2016 10:45, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 27, 2016 at 11:14:55AM -0700, Adam Manzanares wrote:
> > +/**
> > + *	ata_ncq_prio_enabled - Test whether NCQ prio is enabled
> > + *	@dev: ATA device to test for
> > + *
> > + *	LOCKING:
> > + *	spin_lock_irqsave(host lock)
> > + *
> > + *	RETURNS:
> > + *	1 if NCQ prio is enabled for @dev, 0 otherwise.
> > + */
> > +static inline int ata_ncq_prio_enabled(struct ata_device *dev)
> > +{
> > +	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
> > +			      ATA_DFLAG_NCQ_PRIO)) == ATA_DFLAG_NCQ_PRIO;
> 
> I'm not sure this needs to test PIO and NCQ_OFF.  This functions
> pretty much can assume that it'd be only called in NCQ context, no?
>

This should only be called in the NCQ context so these checks are redundant
I'll clean this up in the next version of the patches.

> Thanks.
> 
> -- 
> tejun

Take care,
Adam
