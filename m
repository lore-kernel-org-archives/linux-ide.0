From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH 1/5] Block: Discard may need to allocate pages
Date: Sun, 05 Apr 2009 15:28:07 +0300
Message-ID: <49D8A3D7.5070507@panasas.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756100AbZDEMaq@vger.kernel.org>
In-Reply-To: <1238683047-13588-1-git-send-email-willy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-ide@vger.kernel.org

On 04/02/2009 05:37 PM, Matthew Wilcox wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> 
> SCSI and ATA both need to send data to the device.  In order to do this,
> the BIO must be allocated with room for a page to be added, and the bio
> needs to be passed to the discard prep function.  We also need to free
> the page attached to the BIO before we free it.
> 
> init_request_from_bio() is not currently called from a context which
> forbids sleeping, and to make sure it stays that way (so we don't have
> to use GFP_ATOMIC), add a might_sleep() to it.
> 

I understand you have inherited this code, but I think it is a bit of a mess
and you are only adding to the it.

> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  block/blk-barrier.c       |    4 +++-
>  block/blk-core.c          |    4 +++-
>  block/ioctl.c             |    4 +++-
>  drivers/mtd/mtd_blkdevs.c |    2 +-
>  include/linux/blkdev.h    |    3 ++-
>  5 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-barrier.c b/block/blk-barrier.c
> index f7dae57..82a3035 100644
> --- a/block/blk-barrier.c
> +++ b/block/blk-barrier.c
> @@ -356,6 +356,8 @@ static void blkdev_discard_end_io(struct bio *bio, int err)
>  		clear_bit(BIO_UPTODATE, &bio->bi_flags);
>  	}
>  
> +	if (bio_has_data(bio))
> +		__free_page(bio_page(bio));

Page freed which was allocated by the LLD

>  	bio_put(bio);

OK bio was allocated by user code but shouldn't

>  }
>  
> @@ -387,7 +389,7 @@ int blkdev_issue_discard(struct block_device *bdev,
>  		return -EOPNOTSUPP;
>  
>  	while (nr_sects && !ret) {
> -		bio = bio_alloc(gfp_mask, 0);
> +		bio = bio_alloc(gfp_mask, 1);

blkdev_issue_discard() and blk_ioctl_discard() has half a page
of common (and changing) code, could be done to use a common
helper that sets policy about bio allocation sizes and such.

Just my $0.017

>  		if (!bio)
>  			return -ENOMEM;
>  
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 996ed90..7899761 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1095,6 +1095,8 @@ EXPORT_SYMBOL(blk_put_request);
>  
>  void init_request_from_bio(struct request *req, struct bio *bio)
>  {
> +	might_sleep();
> +
>  	req->cpu = bio->bi_comp_cpu;
>  	req->cmd_type = REQ_TYPE_FS;
>  
> @@ -1118,7 +1120,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
>  		req->cmd_flags |= REQ_DISCARD;
>  		if (bio_barrier(bio))
>  			req->cmd_flags |= REQ_SOFTBARRIER;
> -		req->q->prepare_discard_fn(req->q, req);
> +		req->q->prepare_discard_fn(req->q, req, bio);

Allocation of bio page could be done commonly here.
The prepare_discard_fn() is made to return the needed size. It is not as if we actually
give the driver a choice about the allocation.

So now we allocate the page and free it at the same level.
And we do it only in one place.

Same common code in [PATCH 4/5] and [PATCH 4/5] is done once, here.

>  	} else if (unlikely(bio_barrier(bio)))
>  		req->cmd_flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
>  
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0f22e62..088a9ba 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -145,7 +145,7 @@ static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
>  		DECLARE_COMPLETION_ONSTACK(wait);
>  		struct bio *bio;
>  
> -		bio = bio_alloc(GFP_KERNEL, 0);
> +		bio = bio_alloc(GFP_KERNEL, 1);

This is deja vu, don't you think ;)

>  		if (!bio)
>  			return -ENOMEM;
>  
> @@ -170,6 +170,8 @@ static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
>  			ret = -EOPNOTSUPP;
>  		else if (!bio_flagged(bio, BIO_UPTODATE))
>  			ret = -EIO;
> +		if (bio_has_data(bio))
> +			__free_page(bio_page(bio));
>  		bio_put(bio);
>  	}
>  	return ret;
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 1409f01..2b6ed4b 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -33,7 +33,7 @@ struct mtd_blkcore_priv {
>  };
>  
>  static int blktrans_discard_request(struct request_queue *q,
> -				    struct request *req)
> +				    struct request *req, struct bio *bio)
>  {
>  	req->cmd_type = REQ_TYPE_LINUX_BLOCK;
>  	req->cmd[0] = REQ_LB_OP_DISCARD;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 465d6ba..9d9bd7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -260,7 +260,8 @@ typedef void (request_fn_proc) (struct request_queue *q);
>  typedef int (make_request_fn) (struct request_queue *q, struct bio *bio);
>  typedef int (prep_rq_fn) (struct request_queue *, struct request *);
>  typedef void (unplug_fn) (struct request_queue *);
> -typedef int (prepare_discard_fn) (struct request_queue *, struct request *);
> +typedef int (prepare_discard_fn) (struct request_queue *, struct request *,
> +							struct bio *bio);
>  
>  struct bio_vec;
>  struct bvec_merge_data {

I have one question:

At [PATCH 4/5] and [PATCH 4/5] you do:
+	struct page *page = alloc_page(GFP_KERNEL);

does that zero the alloced page? since if I understand correctly this page
will go on the wire, a SW target on the other size could snoop random Kernel
memory, is that allowed? OK I might be totally clueless here.

Have a good day
Boaz
