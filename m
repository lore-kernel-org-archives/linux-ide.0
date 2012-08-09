From: Marina Makienko <makienko@ispras.ru>
Subject: [PATCH 09/13] ide: Potential null pointer dereference in set_multcount()
Date: Thu,  9 Aug 2012 17:55:26 +0400
Message-ID: <1344520529-19164-7-git-send-email-makienko@ispras.ru>
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
 drivers/ide/ide-disk.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 16f69be..538d206 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -479,6 +479,10 @@ static int set_multcount(ide_drive_t *drive, int arg)
 		return -EBUSY;
 
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	if (!rq) {
+		printk(KERN_ERR PFX"set_multcount: blk_get_request() failed. \n");
+		return 1;
+	}
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
 	drive->mult_req = arg;
-- 
1.7.7
