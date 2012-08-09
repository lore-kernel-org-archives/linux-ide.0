From: Marina Makienko <makienko@ispras.ru>
Subject: [PATCH 08/13] ide: Potential null pointer dereference in ide_devset_execute()
Date: Thu,  9 Aug 2012 17:55:25 +0400
Message-ID: <1344520529-19164-6-git-send-email-makienko@ispras.ru>
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
 drivers/ide/ide-devsets.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index 9e98122..acdb87f 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -166,6 +166,8 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 		return setting->set(drive, arg);
 
 	rq = blk_get_request(q, READ, __GFP_WAIT);
+	if (!rq)
+		return -EIO;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_len = 5;
 	rq->cmd[0] = REQ_DEVSET_EXEC;
-- 
1.7.7
