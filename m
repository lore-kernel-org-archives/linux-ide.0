From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] SCSI: revert clear-garbage-after-CDB fix
Date: Sun, 17 Dec 2006 10:46:56 +0900
Message-ID: <20061217014656.GJ5400@htj.dyndns.org>
References: <20061217014508.GG5400@htj.dyndns.org> <20061217014557.GH5400@htj.dyndns.org> <20061217014633.GI5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:25279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbWLQBrF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 20:47:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1186212uga
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 17:47:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061217014633.GI5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Jens Axboe <jens.axboe@oracle.com>, Douglas Gilbert <dougg@torque.net>

Upper layer is already passing in enough information via req->cmd_len
and requiring it to do the same thing twice makes it easy to miss -
scsi_execute() doesn't do it.

Now that libata is updated to handle garbage after CDB, remove
unnecessary CDB clearing.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Douglas Gilbert <dougg@torque.net>
---
 block/scsi_ioctl.c      |    1 -
 drivers/scsi/scsi_lib.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f322b6a..513d82c 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -262,7 +262,6 @@ static int sg_io(struct file *file, request_queue_t *q,
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
-	memset(rq->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(rq->cmd, cmd, hdr->cmd_len);
 
 	memset(sense, 0, sizeof(sense));
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1748e27..a1df156 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -410,7 +410,6 @@ int scsi_execute_async(struct scsi_device *sdev, const unsigned char *cmd,
 		goto free_req;
 
 	req->cmd_len = cmd_len;
-	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;
-- 
1.4.4.2

