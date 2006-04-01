From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/14] libata: dec scmd->retries for qcs with zero err_mask
Date: Sat, 1 Apr 2006 19:48:37 +0900
Message-ID: <11438885172983-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:39690 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751506AbWDAKsr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:47 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210249nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:46 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

qcs might get retried because of unrelated failure.  e.g. NCQ command
failure causes the whole command set to be aborted.  Decrement
scmd->retries for such retrials to avoid unnecessarily failing
commands.  Note that scmd->retries will be incremented the first time.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

712ea26a9289746c7887ef8878ea6b32c16d85c9
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2870652..4400815 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -831,11 +831,14 @@ void ata_eh_qc_complete(struct ata_queue
  *	should be retried.  To be used from EH.
  *
  *	SCSI midlayer limits the number of retries to scmd->allowed.
- *	This function might need to adjust scmd->retries for commands
- *	which get retried due to unrelated NCQ failures.
+ *	scmd->retries is decremented for commands which get retried
+ *	due to unrelated failures (qc->err_mask is zero).
  */
 void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	if (!qc->err_mask && scmd->retries)
+		scmd->retries--;
 	__ata_eh_qc_complete(qc);
 }
 
-- 
1.2.4


