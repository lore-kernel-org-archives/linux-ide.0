From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH 1/5] Block: Discard may need to allocate pages
Date: Mon, 6 Apr 2009 13:34:51 -0700
Message-ID: <20090406203451.GA24758@linux.intel.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <49D8A3D7.5070507@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755275AbZDFUfS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49D8A3D7.5070507@panasas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-ide@vger.kernel.org

On Sun, Apr 05, 2009 at 03:28:07PM +0300, Boaz Harrosh wrote:
> > +	if (bio_has_data(bio))
> > +		__free_page(bio_page(bio));
> 
> Page freed which was allocated by the LLD

Not by the LLD.  By the ULD.

> blkdev_issue_discard() and blk_ioctl_discard() has half a page
> of common (and changing) code, could be done to use a common
> helper that sets policy about bio allocation sizes and such.

Sure, could be done.

> > -		req->q->prepare_discard_fn(req->q, req);
> > +		req->q->prepare_discard_fn(req->q, req, bio);
> 
> Allocation of bio page could be done commonly here.

Not all prepare_discard_fn() implementations need or want a bio page.
The CFA ERASE SECTORS command is a non-data command, for example.

> The prepare_discard_fn() is made to return the needed size. It is not as if we actually
> give the driver a choice about the allocation.

Umm ... prepare_discard_fn() needs to fill in the page.  I don't
understand what code you propose here.

> > -		bio = bio_alloc(GFP_KERNEL, 0);
> > +		bio = bio_alloc(GFP_KERNEL, 1);
> 
> This is deja vu, don't you think ;)

Yep.

> I have one question:
> 
> At [PATCH 4/5] and [PATCH 4/5] you do:
> +	struct page *page = alloc_page(GFP_KERNEL);
> 
> does that zero the alloced page? since if I understand correctly this page
> will go on the wire, a SW target on the other size could snoop random Kernel
> memory, is that allowed? OK I might be totally clueless here.

The prepare_discard_fn() is responsible for not leaking data.  The ATA
one does it via memset() to a 512 byte boundary.  The SCSI one
initialises the 24 bytes that it sends on the wire.  I don't think
either implementation leaks uninitialised data.
