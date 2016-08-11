From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] ahci: disable correct irq for dymmy ports
Date: Thu, 11 Aug 2016 13:42:34 -0400
Message-ID: <20160811174234.GF2695@mtj.duckdns.org>
References: <1470925562-28914-1-git-send-email-hch@lst.de>
 <1470925562-28914-2-git-send-email-hch@lst.de>
 <20160811163637.GD2695@mtj.duckdns.org>
 <20160811170136.GB25717@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35906 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcHKRmh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 13:42:37 -0400
Received: by mail-yw0-f194.google.com with SMTP id u134so106232ywg.3
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2016 10:42:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160811170136.GB25717@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Thu, Aug 11, 2016 at 07:01:36PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 11, 2016 at 12:36:37PM -0400, Tejun Heo wrote:
> > > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > > index 7461a58..dcf2c72 100644
> > > --- a/drivers/ata/libahci.c
> > > +++ b/drivers/ata/libahci.c
> > > @@ -2524,7 +2524,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
> > >  
> > >  		/* Do not receive interrupts sent by dummy ports */
> > >  		if (!pp) {
> > > -			disable_irq(irq + i);
> > > +			disable_irq(irq);
> > >  			continue;
> > >  		}
> > 
> > I'm not following.  The driver at that point has irqs in the range
> > [@irq, @irq + @host->n_ports - 1] and is trying to activate them and
> > the above code block disables irq for a port which should be skipped.
> > Why wouldn't it need to be indexed?
> 
> Because ahci_irq_vector does that indexing already.  This call changed
> when Dan added ahci_irq_vector to support the MSI-X case - since
> then ahci_irq_vector either does the base irq + index logic for
> MSI or uses the msix_entries array for MSI-X, and irq contains the
> result of that operation.

lol, sorry.  Was looking at an old (v4.0) tree.  Applying to
libata/for-4.8-fixes.

Thanks.

-- 
tejun
