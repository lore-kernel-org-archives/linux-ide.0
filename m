From: Marina Makienko <makienko@ispras.ru>
Subject: [PATCH 07/13] ide: Potential null pointer dereference in ide_cmd_ioctl()
Date: Thu,  9 Aug 2012 17:55:24 +0400
Message-ID: <1344520529-19164-5-git-send-email-makienko@ispras.ru>
References: <1344520529-19164-1-git-send-email-makienko@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344520529-19164-1-git-send-email-makienko@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Marina Makienko <makienko@ispras.ru>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@ispras.ru
List-Id: linux-ide@vger.kernel.org

The function blk_get_request() can return NULL in some cases. There are
checks on it if function is called with argumetns one of which is
GFP_ATOMIC/GFP_NOIO/etc. If system couldn't find request
blk_get_request() return NULL.

But if there is function call with argument __GFP_WAIT
the system will wait until get request or the queue becomes
dead. If something kills the queue, blk_get_request()
return NULL and next operations will lead to errors.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Marina Makienko <makienko@ispras.ru>
---
 drivers/ide/ide-ioctls.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 4d19eb9..463f0ff 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -126,6 +126,8 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 		struct request *rq;
 
 		rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+		if (!rq)
+			return err;
 		rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 		err = blk_execute_rq(drive->queue, NULL, rq, 0);
 		blk_put_request(rq);
@@ -222,6 +224,8 @@ static int generic_drive_reset(ide_drive_t *drive)
 	int ret = 0;
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	if (!rq)
+		return ret;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_len = 1;
 	rq->cmd[0] = REQ_DRIVE_RESET;
-- 
1.7.7
