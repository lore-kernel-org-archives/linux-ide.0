From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: ide: Requeue request after DMA timeout
Date: Wed, 31 Mar 2010 14:17:31 +0800
Message-ID: <20100331061731.GA11480@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:42563 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752993Ab0CaGzd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Mar 2010 02:55:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi:

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

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index ee58c88..62a257f 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -492,6 +492,7 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
 	if (rq) {
 		hwif->rq = NULL;
 		rq->errors = 0;
+		ide_requeue_request(drive, rq);
 	}
 	return ret;
 }
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index db96138..0a5f346 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -566,6 +566,16 @@ plug_device_2:
 		blk_plug_device(q);
 }
 
+void ide_requeue_request(ide_drive_t *drive, struct request *rq)
+{
+	struct request_queue *q = drive->queue;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_requeue_request(q, rq);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
 static void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 97e6ab4..c369f27 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1169,6 +1169,7 @@ extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 extern void ide_timer_expiry(unsigned long);
 extern irqreturn_t ide_intr(int irq, void *dev_id);
 extern void do_ide_request(struct request_queue *);
+extern void ide_requeue_request(ide_drive_t *drive, struct request *rq);
 
 void ide_init_disk(struct gendisk *, ide_drive_t *);
 
