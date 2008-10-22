From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Wed, 22 Oct 2008 08:12:07 +0200
Message-ID: <20081022061207.GB30682@gollum.tnic>
References: <20081018180747.GA29577@gollum.tnic> <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <20081022085808R.fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:24661 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYJVGMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 02:12:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so234794fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 21 Oct 2008 23:12:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081022085808R.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: bzolnier@gmail.com, valerio.p@libero.it, linux-ide@vger.kernel.org

On Wed, Oct 22, 2008 at 08:57:44AM +0900, FUJITA Tomonori wrote:
> On Mon, 20 Oct 2008 11:20:49 +0900
> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
> > On Sat, 18 Oct 2008 20:07:47 +0200
> > Borislav Petkov <petkovbb@googlemail.com> wrote:
> > 
> > > would you please take a look at this bug caused by
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=e5318b531b008c79d2a0c0df06a7b8628da38e2f
> > 
> > Did he confirm that this patch causes this bug?
> > 
> > But, yes, this patch might be the cause.
> > 
> > Using the dma safe check for all the non fs commands is the right
> > thing. But blk_queue_update_dma_pad() has side effects. It might be
> > the cause (but I'm not sure about it since I don't know how the ide
> > code completes requests).
> > 
> > IDE simply disables DMA for unaligned requests (unlike libata) so
> > there is no point to tell the block layer about the dma padding
> > limitation.
> > 
> > Valerio, can you try this patch?
> > 
> > Thanks,
> > 
> > 
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 3308b1c..6961877 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -1250,7 +1250,7 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
> >  		 * NOTE! The "len" and "addr" checks should possibly have
> >  		 * separate masks.
> >  		 */
> > -		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
> > +		alignment = queue_dma_alignment(q) | 15;
> >  		if ((unsigned long)buf & alignment || rq->data_len & alignment
> >  		    || object_is_on_stack(buf))
> >  			drive->dma = 0;
> > @@ -1981,7 +1981,6 @@ static int ide_cdrom_setup(ide_drive_t *drive)
> >  
> >  	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
> >  	blk_queue_dma_alignment(drive->queue, 31);
> > -	blk_queue_update_dma_pad(drive->queue, 15);
> >  	drive->queue->unplug_delay = (1 * HZ) / 1000;
> >  	if (!drive->queue->unplug_delay)
> >  		drive->queue->unplug_delay = 1;
> 
> Valerio told me that the above patch doesn't work however reverting
> the commit works for him.
> 
> I think that the dma safe check for all the non fs commands is the
> right thing. And I thought false positive (that is, disabling dma even
> if a request is dma-capable) is fine here...
> 
> Any ideas about what might be wrong?

Well, what I'd do is printk all those values which turn off the dma to see
exactly what happens. There are still some subtleties which could be the
culprit. For example, the old code used to do

buf = (unsigned long)page_address(bio_page(rq->bio));

and the new does

buf = bio_data(rq->bio)

however, the bio_data() accessor adds also the bio_offset(bio) to the buf.
Perhaps that could be one thing. Also, the old check

rq->data_len & 15

is now

rq->data_len & alignment

where alignment is 31 (1F), if i'm not mistaken, and that hits on data_len > F.

-- 
Regards/Gruss,
    Boris.
