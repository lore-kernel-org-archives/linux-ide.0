From: Jens Axboe <axboe@suse.de>
Subject: Re: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Wed, 2 Nov 2005 09:49:18 +0100
Message-ID: <20051102084917.GM26049@suse.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:3882 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932643AbVKBIsV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 03:48:21 -0500
Content-Disposition: inline
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, Nov 01 2005, Timothy Thelin wrote:
> 
> > On Tue, Nov 01 2005, Timothy Thelin wrote:
> > > Changes:
> > > Increases the taskfile data transfer limit from 128K to a
> > > theoretical 2-4MB (arch dependant) by using __get_free_pages
> > > instead of kmalloc.  Note that larger requests have a lower
> > > success rate because of needing to find a larger amount of
> > > free consecutive memory.
> > 
> > I don't think this is a good way to do it. IDE already supports sg for
> > regular fs requests, the correct solution would be to make 
> > sure the user
> > driven taskfile submission is sg based as well. That would 
> > enable large
> > transfers without risking allocation failures.
> 
> Agreed. I looked into doing sg first, but the changes
> required would be more invasive and have a higher risk of
> breaking existing things. This was targeted as an interim
> solution by someone without lots of ide core experience
> until someone came up with a proper sg solution.

That's understandable.

> > An interface that doesn't
> > work for anything but a freshly booted kernel is pretty 
> > worthless, imho.
> > User interfaces must work predictably.
> > 
> 
> A question though: is __get_free_pages less successful than
> kmalloc in returning the same sized chunk of memory?  If
> it's the same success rate (and I thought it was, is it not?),

Hmm I'm not sure. kmalloc() will go to the size-128k slab pool for the
memory, while __get_free_pages() will just try and find 128k/page_size
consecutive free pages in memory. So it's different paths. You can try
it though, if you can think of a good way to fragment your memory :-)

> then up to 128K the interface acts just like before, but now it
> can possibly do larger transfers rather than having no
> ability to do larger transfers.
> 
> My personal interests are in transfering data in the
> 130K-140K range, just over what kmalloc can do, and 
> this interim solution has been great for that.
> 
> It might be possible for me to begin work on an sg solution
> in a couple of weeks (design advice anyone?).

Since the general fs io path already deals with sg requests all the
time, you should be able to take advantage of that. Basically it's a
taskfile requests with a fully bio mapped request. Some nice examples of
that can be found in drivers/block/scsi_ioctl.c, you want to be using
blk_rq_map_user() for setting up the request data parts. Since the API
didn't have any alignment restrictions before (it always copied data,
blk_rq_map_user() will set up your request for zero-copy dma), you
probably also have to deal with bouncing the memory to a kernel
allocated buffer (which can be sg as well, so just single page
allocations are needed).

-- 
Jens Axboe

