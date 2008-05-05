From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2 00/13] removing the on-stack struct request
Date: Mon, 5 May 2008 18:49:24 +0200
Message-ID: <200805051849.25441.bzolnier@gmail.com>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <200805031510.02167.bzolnier@gmail.com> <20080505220240D.tomof@acm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:11071 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664AbYEEQdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 12:33:02 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1107902nfc.21
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2008 09:33:01 -0700 (PDT)
In-Reply-To: <20080505220240D.tomof@acm.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, jens.axboe@oracle.com, petkovbb@gmail.com

On Monday 05 May 2008, FUJITA Tomonori wrote:
> On Sat, 3 May 2008 15:10:02 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Hi,
> > 
> > On Thursday 01 May 2008, FUJITA Tomonori wrote:
> > > This is an updated version of the patchset to clean up the asymmetry
> > > of blk_get/put_request usage:
> > > 
> > > http://marc.info/?l=linux-ide&m=120882410712466&w=2
> > > 
> > > This patchset removes the code calling blk_put_request against the
> > > requests that are not allocated via blk_get_request. They can use
> > > __GFP_WAIT allocation so we can easily convert them to
> > > use blk_get/put_request properly.
> > > 
> > > This patchset enables us to remove the following hack in
> > > blk_put_request:
> > > 
> > > /*
> > >  * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
> > >  * following if (q) test.
> > >  */
> > > if (q) {
> > > 	spin_lock_irqsave(q->queue_lock, flags);
> > > 	__blk_put_request(q, req);
> > > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > > }
> > > 
> > > The major changes are:
> > > 
> > > - I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
> > > the same thing that blk_execute_rq() does. So let's simply use
> > > blk_execute_rq(). The nice side effect is that I unexport
> > > blk_end_sync_rq() since I converted all the users.
> > > 
> > > - I drop the unnecessary patch to make ide_do_drive_cmd return
> > > rq->errors:
> > > 
> > > http://marc.info/?l=linux-ide&m=120882410612456&w=2
> > > 
> > > #1-10 are for the ide subsystem and #11-13 for the block layer. This
> > > is against the lastest Linus tree.
> > 
> > Thanks.
> > 
> > I applied patches #1-10 after making ide_do_drive_cmd() more similar to
> > blk_execute_rq() (to ease the conversion - it is really better to handle
> > subtle changes first). [ I'll send these pre-patches in separate mails. ]
> 
> Thanks for applying the patches.
> 
> 
> > However I'm still not quite sure about following change in patch #1:
> > 
> > @@ -456,24 +452,21 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
> > ...
> > -	cgc->stat = ide_cd_queue_pc(drive, &req);
> > +	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
> > +				    cgc->data_direction == CGC_DATA_WRITE,
> > +				    cgc->buffer, cgc->buflen,
> > +				    cgc->sense, cgc->timeout, flags);
> >  	if (!cgc->stat)
> > -		cgc->buflen -= req.data_len;
> > +		cgc->buflen = 0;
> > ...
> > 
> > IIRC rq->data_len may be modified while the request is processed?
> 
> I think that rq->data_len is modified only when a request is
> successful but I might overlook or misunderstand something. How about
> the attached patch (against the latest your quilt patchset)? It's a
> bit hacky but it should work as before.
> 
> 
> > [ The only other (minor) complaint is that patches #9-10 should be at the
> >   beginning of the patch series but since no patches contained problems it
> >   wouldn't be wise to ask respin just for that (and I'm too lazy to review
> >   it all again ;-). ]
> 
> Thanks.
> 
> If you are ok with the attached patch, I'm happy to incorporate it
> into the patchset and send a new version as you like.
> 
> 
> ==
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: ide: let ide_cd_queue_pc return rq->data_len
> 
> ide_cdrom_packet needs rq->data_len after the completion so this patch
> makes ide_cd_queue_pc return rq->data_len.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Thanks!  I just integrated this change with patch #1 so there is no need
for you to repost the whole patchset.

WRT patches #11-13: since they are quite straightforward I wonder whether
it might make sense to push them through IDE tree (they depend on #1-10)?

Jens, if you are fine with it I'll add your SOB and add them to the queue.

Thanks,
Bart
