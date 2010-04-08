From: Tejun Heo <tj@kernel.org>
Subject: [PATCH ide-2.6#master REPOST] ide: clean up timed out request handling
Date: Thu, 08 Apr 2010 16:52:16 +0900
Message-ID: <4BBD8B30.6040407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50412 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228Ab0DHHs6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 03:48:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, davem@davemloft.net
Cc: herbert@gondor.hengli.com.au

8f6205cd572fece673da0255d74843680f67f879 introduced a bug where a
timed out DMA request is never requeued and lost.
6072f7491f5ef391a575e18a1165e72a3eef1601 fixed this by making
ide_dma_timeout_retry() requeue the request itself.  While the fix is
correct, it makes DMA and non-DMA paths asymmetric regarding how the
in flight request is requeued.

As long as hwif->rq is set, the IDE driver is assuming ownership of
the request and the request should either be completed or requeued
when clearing hwif->rq.  In the timeout path, the ide driver holds
onto the request as long as the recovery action (ie. reset) is in
progress and clears it after the state machine is stopped (ide_stopped
return), so the existing requeueing logic is correct.  The bug
occurred because ide_dma_timeout_retry() explicitly clears hwif->rq
without requeueing it.

ide_dma_timeout_retry() is called only by ide_timer_expiry() and
returns ide_started only when ide_error() would return it - ie. after
reset state machine has started in which case the state machine will
eventually end up executing the ide_stopped path in ide_timer_expiry()
after reset protocol is complete.  So, there is no need to clear
hwif->rq from ide_dma_timeout_retry().  ide_timer_expiry() will handle
it the same way as PIO timeout path.

Kill hwif->rq clearing and requeueing from ide_dma_timeout_retry() and
let ide_timer_expiry() deal with it.  The end result should remain the
same.

grepping shows ide_dma_timeout_retry() is the only site which clears
hwif->rq without taking care of the request, so there shouldn't be
similar fallouts.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
David, here's the repost.  Thanks.

 drivers/ide/ide-dma.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index fd40a81..963bc8b 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -448,7 +448,6 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_dma_ops *dma_ops = hwif->dma_ops;
 	struct ide_cmd *cmd = &hwif->cmd;
-	struct request *rq;
 	ide_startstop_t ret = ide_stopped;

 	/*
@@ -486,14 +485,10 @@ ide_startstop_t ide_dma_timeout_retry(ide_drive_t *drive, int error)
 	ide_dma_off_quietly(drive);

 	/*
-	 * un-busy drive etc and make sure request is sane
+	 * make sure request is sane
 	 */
-	rq = hwif->rq;
-	if (rq) {
-		hwif->rq = NULL;
-		rq->errors = 0;
-		ide_requeue_and_plug(drive, rq);
-	}
+	if (hwif->rq)
+		hwif->rq->errors = 0;
 	return ret;
 }

