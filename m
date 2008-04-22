From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 09/11] ide: call blk_put_request properly
Date: Tue, 22 Apr 2008 09:26:40 +0900
Message-ID: <1208824002-3596-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:43242 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759274AbYDVA2L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:11 -0400
In-Reply-To: <1208824002-3596-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Jens Axboe <jens.axboe@oracle.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Now all the users of ide_do_drive_cmd using ide_wait are converted to
use blk_get_request instead of struct request on the stack. This puts
WARN_ON to catch an overlooked user. We can remove WARN_ON and "if
(rq->q)" part after a while.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index ce09f70..194e666 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1669,7 +1669,9 @@ int ide_do_drive_cmd (ide_drive_t *drive, struct request *rq, ide_action_t actio
 		if (rq->errors)
 			err = rq->errors;
 
-		blk_put_request(rq);
+		WARN_ON(!rq->q);
+		if (rq->q)
+			blk_put_request(rq);
 	}
 
 	return err;
-- 
1.5.4.2

