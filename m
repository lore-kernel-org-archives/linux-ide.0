From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH] ide: another possible ide panic fix for blk-end-request
Date: Mon, 04 Feb 2008 14:53:12 -0500 (EST)
Message-ID: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755506AbYBDTxO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Feb 2008 14:53:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@googlemail.com
Cc: linux-ide@vger.kernel.org, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com

Hi Jens, Bart, Boris,

I have reviewed all blk-end-request patches again to confirm whether
there are any similar problems with the last week's ide-cd panic:
    http://lkml.org/lkml/2008/1/29/140

And I found a possible similar bug in ide-io change:
ide_end_drive_cmd() could be called for blk_pc_request() which could
have bios.  To complete such requests correctly, we need to pass
the actual size of the request.
Otherwise, __blk_end_request() returns 1 because the request still has
bios, and the system will BUG() unnecessarily.

The following patch fixes the bug and should be applied on top of
Linus' git.
Please review and apply.


Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>
Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
---
 drivers/ide/ide-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ide/ide-io.c	2008-02-01 18:20:02.000000000 -0500
+++ b/drivers/ide/ide-io.c	2008-02-01 18:21:50.000000000 -0500
@@ -388,7 +388,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	spin_lock_irqsave(&ide_lock, flags);
 	HWGROUP(drive)->rq = NULL;
 	rq->errors = err;
-	if (__blk_end_request(rq, (rq->errors ? -EIO : 0), 0))
+	if (unlikely(__blk_end_request(rq, (rq->errors ? -EIO : 0),
+				       blk_rq_bytes(rq))))
 		BUG();
 	spin_unlock_irqrestore(&ide_lock, flags);
 }

Thanks,
Kiyoshi Ueda
