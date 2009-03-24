From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/14] ide: use blk_run_queue() instead of blk_start_queueing()
Date: Wed, 25 Mar 2009 01:06:06 +0900
Message-ID: <1237910776-10983-5-git-send-email-tj@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41800 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760406AbZCXQGb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 12:06:31 -0400
In-Reply-To: <1237910776-10983-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

blk_start_queueing() is being phased out in favor of
[__]blk_run_queue().  Switch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-park.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 9490b44..31d3d32 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -24,11 +24,8 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 			start_queue = 1;
 		spin_unlock_irq(&hwif->lock);
 
-		if (start_queue) {
-			spin_lock_irq(q->queue_lock);
-			blk_start_queueing(q);
-			spin_unlock_irq(q->queue_lock);
-		}
+		if (start_queue)
+			blk_run_queue(q);
 		return;
 	}
 	spin_unlock_irq(&hwif->lock);
-- 
1.6.0.2

