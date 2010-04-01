From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: v2: ide: Must hold queue lock when requeueing
Date: Thu, 1 Apr 2010 14:13:39 +0800
Message-ID: <20100401061339.GA21145@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <20100331062029.GA11559@gondor.apana.org.au> <4BB40DD0.6050306@kernel.org> <20100401061159.GA21077@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:53848 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753198Ab0DAGNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 02:13:44 -0400
Content-Disposition: inline
In-Reply-To: <20100401061159.GA21077@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 02:11:59PM +0800, Herbert Xu wrote:
> 
> OK, here are the two patches again using ide_requeue_and_plug.

ide: Must hold queue lock when requeueing

ide-atapi requeues requests without holding the queue lock.
This patch fixes it by using ide_requeue_and_plug.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index eb2181a..9aedb9a 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -263,8 +263,8 @@ void ide_retry_pc(ide_drive_t *drive)
 	 * of it.  The failed command will be retried after sense data
 	 * is acquired.
 	 */
-	blk_requeue_request(failed_rq->q, failed_rq);
 	drive->hwif->rq = NULL;
+	ide_requeue_and_plug(drive, failed_rq);
 	if (ide_queue_sense_rq(drive, pc)) {
 		blk_start_request(failed_rq);
 		ide_complete_rq(drive, -EIO, blk_rq_bytes(failed_rq));

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
