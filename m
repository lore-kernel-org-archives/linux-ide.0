From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Wed, 22 Oct 2008 17:57:14 +0200
Message-ID: <9ea470500810220857o153dd0fica23dc877fa895ce@mail.gmail.com>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp>
	 <20081022155025S.fujita.tomonori@lab.ntt.co.jp>
	 <9ea470500810220427w30485f0fs5017c2da08fd1796@mail.gmail.com>
	 <200810221645.22289.valerio.passini@unicam.it>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48329 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYJVP5Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 11:57:16 -0400
Received: by gxk9 with SMTP id 9so7610810gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 22 Oct 2008 08:57:14 -0700 (PDT)
In-Reply-To: <200810221645.22289.valerio.passini@unicam.it>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valerio Passini <valerio.passini@unicam.it>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org

Hi,

On Wed, Oct 22, 2008 at 4:45 PM, Valerio Passini
<valerio.passini@unicam.it> wrote:

[.. ]

> Hi Boris, please send me patches already formatted to be applied by patch
> program, because the substitution of spaces with tabs and other indentation
> characters requires a lot of time and it has never worked (or explain me how
> to make it work :))

Ups, sorry, I had the wrong branch here. This patch below should be fine:

[.. ]

> P.S: I have received messages from bugzilla, but I have subscribed to this
> mailing list on Fujita's suggestion just to ease communication. What do you
> prefer between bugzilla and linux-ide?

Let's keep the conversation on linux-ide. I'll upload the fix to bugzilla
after we've figured out the root cause.

Thanks.

-- 
Regards/Gruss,
Boris


---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f16bb46..98051e4 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1165,7 +1165,6 @@ static void cdrom_do_block_pc(ide_drive_t
*drive, struct request *rq)
 		struct request_queue *q = drive->queue;
 		unsigned int alignment;
 		unsigned long addr;
-		unsigned long stack_mask = ~(THREAD_SIZE - 1);

 		if (rq->bio)
 			addr = (unsigned long)bio_data(rq->bio);
@@ -1181,12 +1180,15 @@ static void cdrom_do_block_pc(ide_drive_t
*drive, struct request *rq)
 		 * separate masks.
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
-		if (addr & alignment || rq->data_len & alignment)
-			info->dma = 0;
-
-		if (!((addr & stack_mask) ^
-		      ((unsigned long)current->stack & stack_mask)))
+		if (addr & alignment || rq->data_len & alignment
+			|| object_is_on_stack((void *)addr)) {
+			printk(KERN_ERR "Disabling dma for ATA_PC, "
+					"queue_dma_alignment: 0x%x, q->dma_pad_mask: 0x%x,"
+					"addr: 0x%lx, rq->data_len: 0x%x, on_stack: %d\n",
+					queue_dma_alignment(q), q->dma_pad_mask, addr,
+					rq->data_len, object_is_on_stack((void *)addr));
 			info->dma = 0;
+		}
 	}
 }
