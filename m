From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] clear garbage after CDBs on SG_IO
Date: Thu, 16 Nov 2006 09:52:27 +0900
Message-ID: <20061116005227.GD27684@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:14213 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162132AbWKPAws (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 19:52:48 -0500
Received: by ug-out-1314.google.com with SMTP id m3so316483ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 16:52:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, dougg@torque.net
Cc: mfluhr@nero.com, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, linux-ide@vger.kernel.org

ATAPI devices transfer fixed number of bytes for CDBs (12 or 16).
Some ATAPI devices choke when shorter CDB is used and the left bytes
contain garbage.  Block SG_IO cleared left bytes but SCSI SG_IO
didn't.  This patch makes SCSI SG_IO clear it and simplify CDB
clearing in block SG_IO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mathieu Fluhr <mfluhr@nero.com>

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2dc3264..cac7f18 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -286,9 +286,8 @@ static int sg_io(struct file *file, requ
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(rq->cmd, cmd, hdr->cmd_len);
-	if (sizeof(rq->cmd) != hdr->cmd_len)
-		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
 
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d2c02df..3ac4890 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -410,6 +410,7 @@ int scsi_execute_async(struct scsi_devic
 		goto free_req;
 
 	req->cmd_len = cmd_len;
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;
