From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH 1/5] Block: Discard may need to allocate pages
Date: Sat, 2 May 2009 23:11:50 -0700
Message-ID: <20090503061150.GF10704@linux.intel.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <49D8A3D7.5070507@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:64588 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751019AbZECGLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 May 2009 02:11:50 -0400
Content-Disposition: inline
In-Reply-To: <49D8A3D7.5070507@panasas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, Matthew Wilcox <matthew@wil.cx>


[I thought I replied to this, but I don't see an indication that I did]

On Sun, Apr 05, 2009 at 03:28:07PM +0300, Boaz Harrosh wrote:
> > +++ b/block/blk-barrier.c
> > @@ -356,6 +356,8 @@ static void blkdev_discard_end_io(struct bio *bio, int err)
> >  		clear_bit(BIO_UPTODATE, &bio->bi_flags);
> >  	}
> >  
> > +	if (bio_has_data(bio))
> > +		__free_page(bio_page(bio));
> 
> Page freed which was allocated by the LLD

It wasn't allocated by the LLD.  It was allocated by the ULD.

> >  	bio_put(bio);
> 
> OK bio was allocated by user code but shouldn't

?  Are you saying the bio should be allocated by each driver
implementing a discard operation?

> >  	while (nr_sects && !ret) {
> > -		bio = bio_alloc(gfp_mask, 0);
> > +		bio = bio_alloc(gfp_mask, 1);
> 
> blkdev_issue_discard() and blk_ioctl_discard() has half a page
> of common (and changing) code, could be done to use a common
> helper that sets policy about bio allocation sizes and such.
> 
> Just my $0.017

Yes, that works nicely.  Thanks for the suggestion.

> > @@ -1118,7 +1120,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
> >  		req->cmd_flags |= REQ_DISCARD;
> >  		if (bio_barrier(bio))
> >  			req->cmd_flags |= REQ_SOFTBARRIER;
> > -		req->q->prepare_discard_fn(req->q, req);
> > +		req->q->prepare_discard_fn(req->q, req, bio);
> 
> Allocation of bio page could be done commonly here.
> The prepare_discard_fn() is made to return the needed size. It is not as if we actually
> give the driver a choice about the allocation.

Not all drivers need to allocate a page.  Some drivers may need
to allocate more than one page, depending on how large the range is.
And the driver can't just return the page size it needs here -- it needs
to fill in the contents of the page too.

I suppose we could do something fairly disgusting like:

		for (;;) {
			struct page *page;
			needed = req->q->prepare_discard_fn(req->q, req, bio);
			if (!needed)
				break;
			page = alloc_page(GFP_KERNEL);
			if (bio_add_pc_page(q, bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
				goto fail;
		}

Then the driver can return 0 => success, anything else => allocate more
ram, try again.

> I have one question:
> 
> At [PATCH 4/5] and [PATCH 4/5] you do:
> +	struct page *page = alloc_page(GFP_KERNEL);
> 
> does that zero the alloced page? since if I understand correctly this page
> will go on the wire, a SW target on the other size could snoop random Kernel
> memory, is that allowed? OK I might be totally clueless here.

alloc_page doesn't zero the page.

scsi only sends out 24 bytes of that page on the wire, and it initialises
all 24 bytes.  ide/ata send multiples of 512 bytes on the wire, and
they're careful to zero any of the space they're not using.
