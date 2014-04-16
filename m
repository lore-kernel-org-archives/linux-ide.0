From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Wed, 16 Apr 2014 09:39:19 +0200
Message-ID: <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
 <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743AbaDPHhf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2014 03:37:35 -0400
Content-Disposition: inline
In-Reply-To: <20140415182001.GF30990@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Tue, Apr 15, 2014 at 02:20:01PM -0400, Tejun Heo wrote:
> On Tue, Apr 15, 2014 at 01:18:12PM -0500, David Milburn wrote:
> > This patch also solves the problem, would this better?
> 
> Yes, this is a lot better.  Alexander, does this look good to you?

Yep, apart from a minor comment below.
Also, we're not going to see complains on spurious interrupts, aren't we?

> Also, shouldn't this cc stable?
> 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 5a0bf8e..831b1b4 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1236,14 +1236,14 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
> >  		struct ahci_port_priv *pp = host->ports[i]->private_data;
> >  
> >  		/* pp is NULL for dummy ports */
> > -		if (pp)
> > +		if (pp) {
> >  			desc = pp->irq_desc;
> > -		else
> > -			desc = dev_driver_string(host->dev);
> >  
> > -		rc = devm_request_threaded_irq(host->dev,
> > -			irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
> > -			desc, host->ports[i]);
> > +			rc = devm_request_threaded_irq(host->dev,
> > +						       irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
> > +						       desc, host->ports[i]);

We could dereference 'pp->irq_desc' here and get rid of 'desc' variable.

> > +		}
> > +
> >  		if (rc)
> >  			goto out_free_irqs;
> >  	}
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
