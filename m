From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 20:38:49 -0900
Message-ID: <20151222053849.GB26544@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org>
 <20151222035944.GG20661@kmo-pixel>
 <20151222052611.GA10487@xzibit.linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35487 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbLVFiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Dec 2015 00:38:54 -0500
Content-Disposition: inline
In-Reply-To: <20151222052611.GA10487@xzibit.linux.bs1.fc.nec.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Tejun Heo <tj@kernel.org>, "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

On Tue, Dec 22, 2015 at 05:26:12AM +0000, Junichi Nomura wrote:
> On 12/22/15 12:59, Kent Overstreet wrote:
> > reproduced it with 32 bit pae:
> > 
> >> 1. Exclude memory above 4G line with boot param "max_addr=4G".
> > 
> > doesn't work - max_addr=1G doesn't work either
> > 
> >> 2. Disable highmem with "highmem=0".
> > 
> > works!
> > 
> >> 3. Try booting 64bit kernel.
> > 
> > works
> 
> blk_queue_bio() does split then bounce, which makes the segment
> counting based on pages before bouncing and could go wrong.
> 
> What do you think of a patch like this?

Artem, can you give this patch a try?

> 
> -- 
> Jun'ichi Nomura, NEC Corporation
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5131993b..1d1c3c7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1689,8 +1689,6 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
>  	struct request *req;
>  	unsigned int request_count = 0;
>  
> -	blk_queue_split(q, &bio, q->bio_split);
> -
>  	/*
>  	 * low level driver can indicate that it wants pages above a
>  	 * certain limit bounced to low memory (ie for highmem, or even
> @@ -1698,6 +1696,8 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
>  	 */
>  	blk_queue_bounce(q, &bio);
>  
> +	blk_queue_split(q, &bio, q->bio_split);
> +
>  	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
>  		bio->bi_error = -EIO;
>  		bio_endio(bio);
