From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Mon, 27 Oct 2008 17:37:47 +0900
Message-ID: <20081027152147B.fujita.tomonori@lab.ntt.co.jp>
References: <20081024065043.GA4762@gollum.tnic>
	<200810251458.46140.bzolnier@gmail.com>
	<20081027144610A.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:53596 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbYJ0Ihz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 04:37:55 -0400
In-Reply-To: <20081027144610A.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, petkovbb@gmail.com, valerio.p@libero.it

On Mon, 27 Oct 2008 14:46:20 +0900
FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> On Sat, 25 Oct 2008 14:58:45 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Friday 24 October 2008, Borislav Petkov wrote:
> > > Hi,
> > > 
> > > > Is the culprit REQ_TYPE_BLOCK_PC request or REQ_TYPE_ATA_PC one?
> > > 
> > > Well, from what I see from the latest traces Valerio sent me, it is always a
> > > REQ_TYPE_BLOCK_PC with sizes for rq->data_len which fail in the alignment test:
> > > 
> > > rq->data_len: 0xc,
> > > rq->data_len: 0xf810,
> > 
> > [...]
> > 
> > > Those are, according to Valerio, taken during burning which looks like something
> > > aroung 64K requests which fail the rq->data_len & alignment test where alignment
> > > is 0x1f. The would've passed the old test rq->data_len & 0xf.
> > 
> > OK, I see it now after your mail & looking at the original commit:
> > 
> > @@ -1205,7 +1210,8 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
> >  		 * NOTE! The "len" and "addr" checks should possibly have
> >  		 * separate masks.
> >  		 */
> > -		if ((rq->data_len & 15) || (addr & mask))
> > +		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
> > +		if (addr & alignment || rq->data_len & alignment)
> >  			info->dma = 0;
> >  
> >  		if (!((addr & stack_mask) ^
> > 
> > Please note the comment about separate masks...  This chunk of commit
> > needs to be reverted as it clearly wasn't an intended change.
> > 
> > > /me researching DMA alignment requirements...
> > 
> > It is a combination of host and device requirements.
> > 
> > For 'rq->data_len' it should be 16 bytes because some devices fail otherwise.
> > 
> > For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
> > fix the regression first.
> 
> The most mysterious part for me (as I wrote before), ide-cd sets
> dma_alignment to 31 and dma_pad_mask to 15. So the current code
> enables DMA if data_len is a multiple of 32. The old code enables DMA
> if data_len is a multiple of 16.

Of course, 'multiple of' description is wrong. Should have been
32-byte and 16-byte alignment respectively.


> So the current code tightens DMA
> requirement; the current code disables DMA for requests which the old
> code enabled DMA for. I thought that disabling DMA is a safe option
> (that is, we can always disable DMA for any commands).
> 
> If Borislav's patch fixes the problem, the above assumption is
> wrong...
> 
> Very sorry about the breakage and thanks a lot for tracking it down!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
