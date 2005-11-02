From: Martin Murray <mmurray@deepthought.org>
Subject: Re: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Wed, 2 Nov 2005 12:23:16 -0500
Message-ID: <20051102172316.GF2361@deepthought.org>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com> <20051102084917.GM26049@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from carbon.deepthought.org ([66.180.175.50]:901 "EHLO
	carbon.deepthought.org") by vger.kernel.org with ESMTP
	id S965139AbVKBRXW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 12:23:22 -0500
Content-Disposition: inline
In-Reply-To: <20051102084917.GM26049@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org


    I looked into this yesterday, and it appears that sglists are
hardcoded to a maximum of 256 sectors or (256*512) 128kb. Specifically, 
ide_build_sglist() in ide-dma.c the lines are as follows:

    if ((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256)
        BUG();

    Other than that, as far as I could tell, modifying Mr. Thelin's
patch to use SG would be straightforward. ide_map_sg() in ide-io.c would
have to be modified to allocate the scatter gather list, and the
ide_taskfile_ioctl() in ide-taskfile.c would have to be modified to copy
to userspace the scatter/gather list instead of the buffer that is 
allocated. I'll happily try this after class unless its incorrect.

    One thing I don't understand is, if Mr. Thelin's code that requests,
as said, a little over 128k is a DMA command, then shouldn't the kernel
have bugged? And if it didn't bug, was the data transferred via PIO? Or
does the chipset handle the PIO to the drive and dma the result?

Regards, Martin

* Jens Axboe <axboe@suse.de> [051102 03:48]:
> On Tue, Nov 01 2005, Timothy Thelin wrote:
> > 
> > > On Tue, Nov 01 2005, Timothy Thelin wrote:
> > > > Changes:
> > > > Increases the taskfile data transfer limit from 128K to a
> > > > theoretical 2-4MB (arch dependant) by using __get_free_pages
> > > > instead of kmalloc.  Note that larger requests have a lower
> > > > success rate because of needing to find a larger amount of
> > > > free consecutive memory.
> > > 
> > > I don't think this is a good way to do it. IDE already supports sg for
> > > regular fs requests, the correct solution would be to make 
> > > sure the user
> > > driven taskfile submission is sg based as well. That would 
> > > enable large
> > > transfers without risking allocation failures.
> > 
> > Agreed. I looked into doing sg first, but the changes
> > required would be more invasive and have a higher risk of
> > breaking existing things. This was targeted as an interim
> > solution by someone without lots of ide core experience
> > until someone came up with a proper sg solution.
> 
> That's understandable.
> 
> > > An interface that doesn't
> > > work for anything but a freshly booted kernel is pretty 
> > > worthless, imho.
> > > User interfaces must work predictably.
> > > 
> > 
> > A question though: is __get_free_pages less successful than
> > kmalloc in returning the same sized chunk of memory?  If
> > it's the same success rate (and I thought it was, is it not?),
> 
> Hmm I'm not sure. kmalloc() will go to the size-128k slab pool for the
> memory, while __get_free_pages() will just try and find 128k/page_size
> consecutive free pages in memory. So it's different paths. You can try
> it though, if you can think of a good way to fragment your memory :-)
> 
> > then up to 128K the interface acts just like before, but now it
> > can possibly do larger transfers rather than having no
> > ability to do larger transfers.
> > 
> > My personal interests are in transfering data in the
> > 130K-140K range, just over what kmalloc can do, and 
> > this interim solution has been great for that.
> > 
> > It might be possible for me to begin work on an sg solution
> > in a couple of weeks (design advice anyone?).
> 
> Since the general fs io path already deals with sg requests all the
> time, you should be able to take advantage of that. Basically it's a
> taskfile requests with a fully bio mapped request. Some nice examples of
> that can be found in drivers/block/scsi_ioctl.c, you want to be using
> blk_rq_map_user() for setting up the request data parts. Since the API
> didn't have any alignment restrictions before (it always copied data,
> blk_rq_map_user() will set up your request for zero-copy dma), you
> probably also have to deal with bouncing the memory to a kernel
> allocated buffer (which can be sg as well, so just single page
> allocations are needed).
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Martin Murray, <mmurray@deepthought.org>, :\\//\\//:
- What is Industrial Music? It's the sound of angry
  Belgians having a fight with a washing machine.
Fear: Seeing B8:00:4C:CD:21, and knowing what it means.
