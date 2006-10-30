From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 18:56:33 +0100
Message-ID: <1162230993.2948.60.camel@laptopd505.fenrus.org>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk>
	 <1162220239.2948.27.camel@laptopd505.fenrus.org>
	 <20061030154444.GH4563@kernel.dk>
	 <1162225002.2948.45.camel@laptopd505.fenrus.org>
	 <20061030162621.GK4563@kernel.dk>
	 <1162225915.2948.49.camel@laptopd505.fenrus.org>
	 <20061030175224.GB14055@kernel.dk>
Reply-To: arjan@infradead.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:62864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161337AbWJ3R4h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 12:56:37 -0500
In-Reply-To: <20061030175224.GB14055@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu


> > what I meant is that cfq_set_request() calls a few inlines that also
> > take locks so it might be one of those instead
> 
> I looked over them, and cfq_cic_link() should use _irqsave() instead of
> _irq() if called without __GFP_WAIT set. That doesn't happen in the
> normal io path though, so I'm not sure that is it.
> 
> So if the bug is using spin_lock_irq() with interrupts already disabled,
> iirc that would trigger a different warning...

it's not spin_lock_irq() that'll warn, but the unlock... :)

> Naturally, that is a bug fair and simple, nothing to do with lockdep.
> 
> 
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 4bae64e..da9bddf 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1355,6 +1355,7 @@ cfq_cic_link(struct cfq_data *cfqd, stru
>  	structirely reason rb_node **p;
>  	struct rb_node *parent;
>  	struct cfq_io_context *__cic;
> +	unsigned long flags;
>  	void *k;
>  
>  	cic->ioc = ioc;
> @@ -1384,9 +1385,9 @@ restart:
>  	rb_link_node(&cic->rb_node, parent, p);
>  	rb_insert_color(&cic->rb_node, &ioc->cic_root);
>  
> -	spin_lock_irq(cfqd->queue->queue_lock);
> +	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
>  	list_add(&cic->queue_list, &cfqd->cic_list);
> -	spin_unlock_irq(cfqd->queue->queue_lock);
> +	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
>  }

this looks entirely reasonable and correct

Acked-By: Arjan van de Ven <arjan@linux.intel.com>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

