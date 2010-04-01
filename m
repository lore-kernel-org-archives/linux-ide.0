From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: v2: ide: Requeue request after DMA timeout
Date: Thu, 1 Apr 2010 14:11:59 +0800
Message-ID: <20100401061159.GA21077@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <20100331062029.GA11559@gondor.apana.org.au> <4BB40DD0.6050306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:59488 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753198Ab0DAGML (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 02:12:11 -0400
Content-Disposition: inline
In-Reply-To: <4BB40DD0.6050306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 12:06:56PM +0900, Tejun Heo wrote:
>
> Nice catch but I think it would be better to call
> ide_requeue_and_plug() instead of adding ide_requeue_request().

OK, here are the two patches again using ide_requeue_and_plug.

ide: Requeue request after DMA timeout

I noticed that my KVM virtual machines were experiencing IDE
issues resulting in processes stuck on waiting for buffers to
complete.

The root cause is of course race conditions in the ancient qemu
backend that I'm using.  However, the fact that the guest isn't
recovering is a bug.

I've tracked it down to the change made last year to dequeue
requests at the start rather than at the end in the IDE layer.

commit 8f6205cd572fece673da0255d74843680f67f879
Author: Tejun Heo <tj@kernel.org>
Date:   Fri May 8 11:53:59 2009 +0900

    ide: dequeue in-flight request

The problem is that the function ide_dma_timeout_retry does not
requeue the current request, causing one request to be lost for
each DMA timeout.

This patch fixes this by requeueing the request.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index ee58c88..fd40a81 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -492,6 +492,7 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
 	if (rq) {
 		hwif->rq = NULL;
 		rq->errors = 0;
+		ide_requeue_and_plug(drive, rq);
 	}
 	return ret;
 }
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index db96138..172ac92 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -566,7 +566,7 @@ plug_device_2:
 		blk_plug_device(q);
 }
 
-static void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
+void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
 	unsigned long flags;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 97e6ab4..3239d1c 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1169,6 +1169,7 @@ extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 extern void ide_timer_expiry(unsigned long);
 extern irqreturn_t ide_intr(int irq, void *dev_id);
 extern void do_ide_request(struct request_queue *);
+extern void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq);
 
 void ide_init_disk(struct gendisk *, ide_drive_t *);
 
Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
