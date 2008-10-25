From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 20:12:46 +0200
Message-ID: <20081025181246.GB32108@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic> <200810251458.46140.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:49720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYJYSMu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Oct 2008 14:12:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1349693fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 25 Oct 2008 11:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810251458.46140.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, valerio.p@libero.it
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 25, 2008 at 02:58:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 24 October 2008, Borislav Petkov wrote:
> > Hi,
> > 
> > > Is the culprit REQ_TYPE_BLOCK_PC request or REQ_TYPE_ATA_PC one?
> > 
> > Well, from what I see from the latest traces Valerio sent me, it is always a
> > REQ_TYPE_BLOCK_PC with sizes for rq->data_len which fail in the alignment test:
> > 
> > rq->data_len: 0xc,
> > rq->data_len: 0xf810,
> 
> [...]
> 
> > Those are, according to Valerio, taken during burning which looks like something
> > aroung 64K requests which fail the rq->data_len & alignment test where alignment
> > is 0x1f. The would've passed the old test rq->data_len & 0xf.
> 
> OK, I see it now after your mail & looking at the original commit:
> 
> @@ -1205,7 +1210,8 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
>  		 * NOTE! The "len" and "addr" checks should possibly have
>  		 * separate masks.
>  		 */
> -		if ((rq->data_len & 15) || (addr & mask))
> +		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
> +		if (addr & alignment || rq->data_len & alignment)
>  			info->dma = 0;
>  
>  		if (!((addr & stack_mask) ^
> 
> Please note the comment about separate masks...  This chunk of commit
> needs to be reverted as it clearly wasn't an intended change.

Valerio, care to try the patch against 2.6.27 below? Additionally, I've
attached it to this mail in case you're having trouble with kmail.

@Bart: This reverts the rq->data_len part and I'll port it to current
pata tree in case it does the job.

---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f16bb46..834b79d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1181,7 +1181,7 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * separate masks.
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
-		if (addr & alignment || rq->data_len & alignment)
+		if (addr & alignment || rq->data_len & q->dma_pad_mask)
 			info->dma = 0;
 
 		if (!((addr & stack_mask) ^

-- 
Regards/Gruss,
    Boris.

--oyUTqETQ0mS9luUI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="try1.patch"

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f16bb46..834b79d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1181,7 +1181,7 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * separate masks.
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
-		if (addr & alignment || rq->data_len & alignment)
+		if (addr & alignment || rq->data_len & q->dma_pad_mask)
 			info->dma = 0;
 
 		if (!((addr & stack_mask) ^

--oyUTqETQ0mS9luUI--
