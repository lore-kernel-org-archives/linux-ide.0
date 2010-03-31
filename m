From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: ide: Must hold queue lock when requeueing
Date: Wed, 31 Mar 2010 14:20:29 +0800
Message-ID: <20100331062029.GA11559@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:42561 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754881Ab0CaGz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Mar 2010 02:55:27 -0400
Content-Disposition: inline
In-Reply-To: <20100331061731.GA11480@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

ide: Must hold queue lock when requeueing

ide-atapi requeues requests without holding the queue lock.
This patch fixes it by using the new ide_requeue_request function.
 
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index eb2181a..12e9d7c 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -263,8 +263,8 @@ void ide_retry_pc(ide_drive_t *drive)
 	 * of it.  The failed command will be retried after sense data
 	 * is acquired.
 	 */
-	blk_requeue_request(failed_rq->q, failed_rq);
 	drive->hwif->rq = NULL;
+	ide_requeue_request(drive, failed_rq);
 	if (ide_queue_sense_rq(drive, pc)) {
 		blk_start_request(failed_rq);
 		ide_complete_rq(drive, -EIO, blk_rq_bytes(failed_rq));

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
