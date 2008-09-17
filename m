From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ide-cd: fix printk format warning
Date: Wed, 17 Sep 2008 22:24:46 +0400
Message-ID: <20080917182446.GD29966@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:20620 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbYIQSY4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 14:24:56 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1481868eyi.37
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 11:24:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org



Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/ide/ide-cd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b34c370..3cc2702 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1266,7 +1266,7 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 	int xferlen;
 
 	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd_type: 0x%x, block: %llu\n",
-		      __func__, rq->cmd_type, (u64)block);
+		      __func__, rq->cmd_type, (unsigned long long)block);
 
 	if (blk_fs_request(rq)) {
 		if (drive->atapi_flags & IDE_AFLAG_SEEKING) {
