From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Sat, 25 Oct 2008 14:58:45 +0200
Message-ID: <200810251458.46140.bzolnier@gmail.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810222215.02762.bzolnier@gmail.com> <20081024065043.GA4762@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:63127 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYJYNBn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Oct 2008 09:01:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so410794yxm.1
        for <linux-ide@vger.kernel.org>; Sat, 25 Oct 2008 06:01:42 -0700 (PDT)
In-Reply-To: <20081024065043.GA4762@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, valerio.p@libero.it, linux-ide@vger.kernel.org

On Friday 24 October 2008, Borislav Petkov wrote:
> Hi,
> 
> > Is the culprit REQ_TYPE_BLOCK_PC request or REQ_TYPE_ATA_PC one?
> 
> Well, from what I see from the latest traces Valerio sent me, it is always a
> REQ_TYPE_BLOCK_PC with sizes for rq->data_len which fail in the alignment test:
> 
> rq->data_len: 0xc,
> rq->data_len: 0xf810,

[...]

> Those are, according to Valerio, taken during burning which looks like something
> aroung 64K requests which fail the rq->data_len & alignment test where alignment
> is 0x1f. The would've passed the old test rq->data_len & 0xf.

OK, I see it now after your mail & looking at the original commit:

@@ -1205,7 +1210,8 @@ static ide_startstop_t cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * NOTE! The "len" and "addr" checks should possibly have
 		 * separate masks.
 		 */
-		if ((rq->data_len & 15) || (addr & mask))
+		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
+		if (addr & alignment || rq->data_len & alignment)
 			info->dma = 0;
 
 		if (!((addr & stack_mask) ^

Please note the comment about separate masks...  This chunk of commit
needs to be reverted as it clearly wasn't an intended change.

> /me researching DMA alignment requirements...

It is a combination of host and device requirements.

For 'rq->data_len' it should be 16 bytes because some devices fail otherwise.

For 'addr' we may try to use 4 bytes instead of the current 32 ones but lets
fix the regression first.

Thanks,
Bart
