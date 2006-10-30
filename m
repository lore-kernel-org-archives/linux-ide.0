From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 18:57:44 +0100
Message-ID: <20061030175744.GA384@elte.hu>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <1162230993.2948.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161340AbWJ3R6n@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1162230993.2948.60.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> >  	struct rb_node *parent;
> >  	struct cfq_io_context *__cic;
> > +	unsigned long flags;
> >  	void *k;
> >  
> >  	cic->ioc = ioc;
> > @@ -1384,9 +1385,9 @@ restart:
> >  	rb_link_node(&cic->rb_node, parent, p);
> >  	rb_insert_color(&cic->rb_node, &ioc->cic_root);
> >  
> > -	spin_lock_irq(cfqd->queue->queue_lock);
> > +	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
> >  	list_add(&cic->queue_list, &cfqd->cic_list);
> > -	spin_unlock_irq(cfqd->queue->queue_lock);
> > +	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
> >  }
> 
> this looks entirely reasonable and correct
> 
> Acked-By: Arjan van de Ven <arjan@linux.intel.com>

yep.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
