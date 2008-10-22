From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Wed, 22 Oct 2008 13:27:16 +0200
Message-ID: <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp>
	 <20081022085808R.fujita.tomonori@lab.ntt.co.jp>
	 <20081022061207.GB30682@gollum.tnic>
	 <20081022155025S.fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:64492 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYJVL1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 07:27:18 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1112991rnd.17
        for <linux-ide@vger.kernel.org>; Wed, 22 Oct 2008 04:27:16 -0700 (PDT)
In-Reply-To: <20081022155025S.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: bzolnier@gmail.com, valerio.p@libero.it, linux-ide@vger.kernel.org

On Wed, Oct 22, 2008 at 8:50 AM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Wed, 22 Oct 2008 08:12:07 +0200
> Borislav Petkov <petkovbb@googlemail.com> wrote:
>
>> On Wed, Oct 22, 2008 at 08:57:44AM +0900, FUJITA Tomonori wrote:
>> > On Mon, 20 Oct 2008 11:20:49 +0900
>> > FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
>> >
>> > > On Sat, 18 Oct 2008 20:07:47 +0200
>> > > Borislav Petkov <petkovbb@googlemail.com> wrote:
>> > >
>> > > > would you please take a look at this bug caused by
>> > > >
>> > > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=e5318b531b008c79d2a0c0df06a7b8628da38e2f
>> > >
>> > > Did he confirm that this patch causes this bug?
>> > >
>> > > But, yes, this patch might be the cause.
>> > >
>> > > Using the dma safe check for all the non fs commands is the right
>> > > thing. But blk_queue_update_dma_pad() has side effects. It might be
>> > > the cause (but I'm not sure about it since I don't know how the ide
>> > > code completes requests).
>> > >
>> > > IDE simply disables DMA for unaligned requests (unlike libata) so
>> > > there is no point to tell the block layer about the dma padding
>> > > limitation.
>> > >
>> > > Valerio, can you try this patch?
>> > >
>> > > Thanks,
>> > >
>> > >
>> > > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>> > > index 3308b1c..6961877 100644
>> > > --- a/drivers/ide/ide-cd.c
>> > > +++ b/drivers/ide/ide-cd.c
>> > > @@ -1250,7 +1250,7 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
>> > >            * NOTE! The "len" and "addr" checks should possibly have
>> > >            * separate masks.
>> > >            */
>> > > -         alignment = queue_dma_alignment(q) | q->dma_pad_mask;
>> > > +         alignment = queue_dma_alignment(q) | 15;
>> > >           if ((unsigned long)buf & alignment || rq->data_len & alignment
>> > >               || object_is_on_stack(buf))
>> > >                   drive->dma = 0;
>> > > @@ -1981,7 +1981,6 @@ static int ide_cdrom_setup(ide_drive_t *drive)
>> > >
>> > >   blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
>> > >   blk_queue_dma_alignment(drive->queue, 31);
>> > > - blk_queue_update_dma_pad(drive->queue, 15);
>> > >   drive->queue->unplug_delay = (1 * HZ) / 1000;
>> > >   if (!drive->queue->unplug_delay)
>> > >           drive->queue->unplug_delay = 1;
>> >
>> > Valerio told me that the above patch doesn't work however reverting
>> > the commit works for him.
>> >
>> > I think that the dma safe check for all the non fs commands is the
>> > right thing. And I thought false positive (that is, disabling dma even
>> > if a request is dma-capable) is fine here...
>> >
>> > Any ideas about what might be wrong?
>>
>> Well, what I'd do is printk all those values which turn off the dma to see
>> exactly what happens.
>
> Thanks!
>
>> There are still some subtleties which could be the
>> culprit. For example, the old code used to do
>>
>> buf = (unsigned long)page_address(bio_page(rq->bio));
>>
>> and the new does
>>
>> buf = bio_data(rq->bio)
>>
>> however, the bio_data() accessor adds also the bio_offset(bio) to the buf.
>> Perhaps that could be one thing.
>
> But we should use bio_data() here? Later we do I/O against an address,
> bio_page(rq->bio) + bio_offset(bio)? cdrom_newpc_intr uses bio_data to
> get an address to do I/O against?

Yes, but this is only for PIO transfers. dma transfers are completed
much earlier in the IRQ handler.

>> Also, the old check
>>
>> rq->data_len & 15
>>
>> is now
>>
>> rq->data_len & alignment
>>
>> where alignment is 31 (1F), if i'm not mistaken, and that hits on data_len > F.
>
> True, but it means now we disable dma with requests that we used to
> enable dma with. As I wrote in the previous mail, is it always a safe
> option?

Honestly, I don't know. It might just as well be only a problem with this single
drive since I'm not familiar with other similar regressions. I've been burning
here with bleeding edge kernels just fine. I think we'll know more about the
problem after we dump the relevant data. Valerio, can you try the following
patch and send back the output after retrying to burn on your machine?

Thanks.


diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 13265a8..6943462 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1251,8 +1251,14 @@ static void cdrom_do_block_pc(ide_drive_t
*drive, struct request *rq)
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
 		if ((unsigned long)buf & alignment || rq->data_len & alignment
-		    || object_is_on_stack(buf))
+		    || object_is_on_stack(buf)) {
+			printk(KERN_ERR "Disabling dma for ATA_PC, "
+			       "queue_dma_alignment: 0x%x, q->dma_pad_mask: 0x%x,"
+			       "buf: %p, rq->data_len: 0x%x, on_stack: %d\n",
+			       queue_dma_alignment(q), q->dma_pad_mask, buf,
+			       rq->data_len, object_is_on_stack(buf));
 			drive->dma = 0;
+		}
 	}
 }



-- 
Regards/Gruss,
Boris
