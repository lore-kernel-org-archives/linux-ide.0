From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Mon, 2 May 2005 18:01:10 +0200
Message-ID: <20050502160110.GA4817@suse.de>
References: <7A8F92187EF7A249BF847F1BF4903C040AFCD0@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:19118 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261355AbVEBQBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2005 12:01:22 -0400
Content-Disposition: inline
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C040AFCD0@ausx2kmpc103.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Mon, May 02 2005, Stuart_Hayes@Dell.com wrote:
> >  		idescsi_input_buffers (ide_d return; }
> >  		count = min(pc->sg->length - pc->b_count, bcount);
> > -		buf = page_address(pc->sg->page) + pc->sg->offset;
> > +#ifdef CONFIG_HIGHMEM
> > +		local_irq_save(flags);
> > +#endif
> > 
> > This is just aweful, don't add tons of ifdefs. If you must
> > differentiate, just do something ala: 
> > 
> >         if (PageHighMem(page)) {
> >                 save interrupts
> >                 buf = kmap
> >         } else
> >                 buf = page_address(xxx).
> > 
> > and so on. But why are you still doing it this way? Did we not agree
> > that adding a host template no-high-mem defines was way better?? 
> 
> The ifdefs were at Bart's request.
> 
> The reason I went back to the kmap_atomic() fix instead of adding a  
> no-high-mem flag in the host is that I couldn't get James to accept that

But, why? The no_highmem flag doesn't make sense for regular host
adapters, they can just set pdev->dma_mask appropriately. But we cannot
do that for ide-scsi, so I think it would be acceptable to add it
because of that.

> patch, while this one is ide-scsi only, and Bart did accept it.  And, to
> be honest, I wasn't really sure why the kmap_atomic() fix was inferior.
> 
> But I'd certainly defer to your (or Bart's) judgment on those things--
> you guys have a lot more experience than me with the kernel.  I am
> hesitant to change the "ifdef"s to "if"s at this point, since Bart
> already accepted it (previously) with the ifdefs, but I'd be more than 
> happy to change it if he agrees.

The PageHighMem variant would be acceptable to me, although I still
prefer the highmem bounce approach.

-- 
Jens Axboe

