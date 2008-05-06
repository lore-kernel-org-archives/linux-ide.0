From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v2 00/13] removing the on-stack struct request
Date: Tue, 6 May 2008 11:39:52 +0900
Message-ID: <20080506113953H.tomof@acm.org>
References: <20080505220240D.tomof@acm.org>
	<200805051849.25441.bzolnier@gmail.com>
	<20080505190409.GB329@kernel.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:34973 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYEFCkw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 May 2008 22:40:52 -0400
In-Reply-To: <20080505190409.GB329@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jens.axboe@oracle.com
Cc: bzolnier@gmail.com, fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, petkovbb@gmail.com

On Mon, 5 May 2008 21:04:09 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Mon, May 05 2008, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 05 May 2008, FUJITA Tomonori wrote:
> > > On Sat, 3 May 2008 15:10:02 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > 
> > > > Hi,
> > > > 
> > > > On Thursday 01 May 2008, FUJITA Tomonori wrote:
> > > > > This is an updated version of the patchset to clean up the asymmetry
> > > > > of blk_get/put_request usage:
> > > > > 
> > > > > http://marc.info/?l=linux-ide&m=120882410712466&w=2
> > > > > 
> > > > > This patchset removes the code calling blk_put_request against the
> > > > > requests that are not allocated via blk_get_request. They can use
> > > > > __GFP_WAIT allocation so we can easily convert them to
> > > > > use blk_get/put_request properly.
> > > > > 
> > > > > This patchset enables us to remove the following hack in
> > > > > blk_put_request:
> > > > > 
> > > > > /*
> > > > >  * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
> > > > >  * following if (q) test.
> > > > >  */
> > > > > if (q) {
> > > > > 	spin_lock_irqsave(q->queue_lock, flags);
> > > > > 	__blk_put_request(q, req);
> > > > > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > > > > }
> > > > > 
> > > > > The major changes are:
> > > > > 
> > > > > - I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
> > > > > the same thing that blk_execute_rq() does. So let's simply use
> > > > > blk_execute_rq(). The nice side effect is that I unexport
> > > > > blk_end_sync_rq() since I converted all the users.
> > > > > 
> > > > > - I drop the unnecessary patch to make ide_do_drive_cmd return
> > > > > rq->errors:
> > > > > 
> > > > > http://marc.info/?l=linux-ide&m=120882410612456&w=2
> > > > > 
> > > > > #1-10 are for the ide subsystem and #11-13 for the block layer. This
> > > > > is against the lastest Linus tree.
> > > > 
> > > > Thanks.
> > > > 
> > > > I applied patches #1-10 after making ide_do_drive_cmd() more similar to
> > > > blk_execute_rq() (to ease the conversion - it is really better to handle
> > > > subtle changes first). [ I'll send these pre-patches in separate mails. ]
> > > 
> > > Thanks for applying the patches.
> > > 
> > > 
> > > > However I'm still not quite sure about following change in patch #1:
> > > > 
> > > > @@ -456,24 +452,21 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
> > > > ...
> > > > -	cgc->stat = ide_cd_queue_pc(drive, &req);
> > > > +	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
> > > > +				    cgc->data_direction == CGC_DATA_WRITE,
> > > > +				    cgc->buffer, cgc->buflen,
> > > > +				    cgc->sense, cgc->timeout, flags);
> > > >  	if (!cgc->stat)
> > > > -		cgc->buflen -= req.data_len;
> > > > +		cgc->buflen = 0;
> > > > ...
> > > > 
> > > > IIRC rq->data_len may be modified while the request is processed?
> > > 
> > > I think that rq->data_len is modified only when a request is
> > > successful but I might overlook or misunderstand something. How about
> > > the attached patch (against the latest your quilt patchset)? It's a
> > > bit hacky but it should work as before.
> > > 
> > > 
> > > > [ The only other (minor) complaint is that patches #9-10 should be at the
> > > >   beginning of the patch series but since no patches contained problems it
> > > >   wouldn't be wise to ask respin just for that (and I'm too lazy to review
> > > >   it all again ;-). ]
> > > 
> > > Thanks.
> > > 
> > > If you are ok with the attached patch, I'm happy to incorporate it
> > > into the patchset and send a new version as you like.
> > > 
> > > 
> > > ==
> > > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > > Subject: ide: let ide_cd_queue_pc return rq->data_len
> > > 
> > > ide_cdrom_packet needs rq->data_len after the completion so this patch
> > > makes ide_cd_queue_pc return rq->data_len.
> > > 
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > 
> > Thanks!  I just integrated this change with patch #1 so there is no need
> > for you to repost the whole patchset.

Thanks a lot!


> > WRT patches #11-13: since they are quite straightforward I wonder whether
> > it might make sense to push them through IDE tree (they depend on #1-10)?
> > 
> > Jens, if you are fine with it I'll add your SOB and add them to the queue.
> 
> Since they are so small, not an issue with me. You may add my
> Signed-off-by, I'm glad that we are (finally) getting rid of the
> on-stack requests.

Yeah, the remaining on-stack requests are used in the paths that we
can't fail to allocate the requests (e.g. from interrupt
context). They are legitimate, as discussed before. We got rid of the
asymmetry of blk_get_request and blk_put_request usage in IDE and the
hack in blk_put_request so I'm glad too.

Thanks,
