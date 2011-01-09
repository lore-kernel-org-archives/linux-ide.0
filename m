From: Vasily Tarasov <sectorsize512@gmail.com>
Subject: [PATCH] ide: no need to check for the rq pointer to be NULL
Date: Sun, 9 Jan 2011 18:51:46 -0500
Message-ID: <20110109235146.GA5353@white.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56167 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1AIXvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jan 2011 18:51:53 -0500
Received: by qyj19 with SMTP id 19so1103140qyj.19
        for <linux-ide@vger.kernel.org>; Sun, 09 Jan 2011 15:51:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

From: Vasily Tarasov <sectorsize512@gmail.com>

No need to check for the rq pointer to be NULL before calling
blk_fetch_request().  First we call it, then we test the pointer that it
returns.

Signed-off-by: Vasily Tarasov <sectorsize512@gmail.com>

---

--- linux-2.6.37/drivers/ide/ide-io.c.orig	2011-01-04 19:50:19.000000000 -0500
+++ linux-2.6.37/drivers/ide/ide-io.c	2011-01-09 18:15:44.000000000 -0500
@@ -438,7 +438,7 @@ void do_ide_request(struct request_queue
 	ide_drive_t	*drive = q->queuedata;
 	ide_hwif_t	*hwif = drive->hwif;
 	struct ide_host *host = hwif->host;
-	struct request	*rq = NULL;
+	struct request	*rq;
 	ide_startstop_t	startstop;
 
 	spin_unlock_irq(q->queue_lock);
@@ -485,16 +485,13 @@ repeat:
 
 		spin_unlock_irq(&hwif->lock);
 		spin_lock_irq(q->queue_lock);
+		rq = blk_fetch_request(drive->queue);
+		spin_unlock_irq(q->queue_lock);
+		spin_lock_irq(&hwif->lock);
 		/*
 		 * we know that the queue isn't empty, but this can happen
 		 * if the q->prep_rq_fn() decides to kill a request
 		 */
-		if (!rq)
-			rq = blk_fetch_request(drive->queue);
-
-		spin_unlock_irq(q->queue_lock);
-		spin_lock_irq(&hwif->lock);
-
 		if (!rq) {
 			ide_unlock_port(hwif);
 			goto out;
