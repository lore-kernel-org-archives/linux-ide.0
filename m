From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Thu, 17 Apr 2014 09:45:43 -0400
Message-ID: <20140417134543.GD15326@htj.dyndns.org>
References: <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
 <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
 <20140416191454.GC22569@htj.dyndns.org>
 <20140417082934.GA30477@dhcp-26-207.brq.redhat.com>
 <20140417132942.GB15326@htj.dyndns.org>
 <20140417124436.GC2270@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:57802 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbaDQNpr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 09:45:47 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so395608qaq.16
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2014 06:45:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140417124436.GC2270@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 02:44:36PM +0200, Alexander Gordeev wrote:
> On Thu, Apr 17, 2014 at 09:29:42AM -0400, Tejun Heo wrote:
> > On Thu, Apr 17, 2014 at 10:29:35AM +0200, Alexander Gordeev wrote:
> > > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > > index e45b18e..9f1169a 100644
> > > --- a/drivers/ata/ahci.c
> > > +++ b/drivers/ata/ahci.c
> > > @@ -1240,6 +1240,8 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
> > >  						       irq + i, ahci_hw_interrupt,
> > >  						       ahci_thread_fn, IRQF_SHARED,
> > >  						       pp->irq_desc, host->ports[i]);
> > > +		else
> > > +			disable_irq(irq + i);
> > 
> > Hmmm?  Request failed.  Why would it require an explicit disable?
> 
> 	if (pp)
> 		rc = devm_request_threaded_irq(..., irq + i, ...)
> 	else
> 		disable_irq(irq + i);

Ah, was looking at the old code.  But again, we didn't even request
the irq, why would we disable it?

Thanks.

-- 
tejun
