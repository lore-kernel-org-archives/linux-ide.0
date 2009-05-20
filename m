From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] libata: get rid of ATA_MAX_QUEUE loop in
	ata_qc_complete_multiple()
Date: Wed, 20 May 2009 09:40:07 +0200
Message-ID: <20090520074006.GI11363@kernel.dk>
References: <20090520065752.GC11363@kernel.dk> <4A13B08D.3060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:52551 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754072AbZETHkG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:40:06 -0400
Content-Disposition: inline
In-Reply-To: <4A13B08D.3060005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Wed, May 20 2009, Tejun Heo wrote:
> Hello, Jens.
> 
> Jens Axboe wrote:
> > @@ -5039,16 +5039,19 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
> >  		return -EINVAL;
> >  	}
> >  
> > -	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> > +	while (done_mask) {
> >  		struct ata_queued_cmd *qc;
> > +		unsigned int next = __ffs(done_mask);
> >  
> > -		if (!(done_mask & (1 << i)))
> > -			continue;
> > -
> > -		if ((qc = ata_qc_from_tag(ap, i))) {
> > +		qc = ata_qc_from_tag(ap, i + next);
> > +		if (qc) {
> >  			ata_qc_complete(qc);
> >  			nr_done++;
> >  		}
> > +		if (++next >= ATA_MAX_QUEUE)
> > +			break;
> 
> Given that __ffs doesn't care how far the first bit is on most archs
> (even the generic one), I think it would be simpler and more efficient
> to simply do done_mask &= ~(1 << i) and loop without adding to index
> and shifting.

It would be easier to read as well, agree. I'll repost it in 2 secs.

-- 
Jens Axboe

