From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/22] SCSI: Introduce scsi_req_abort_cmd (REPOST)
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487901100-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:49594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751562AbWEKL74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:59:56 -0400
Received: by py-out-1112.google.com with SMTP id f28so211124pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:59:56 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Luben Tuikov <ltuikov@yahoo.com>, Tejun Heo <htejun@gmail.com>

Introduce scsi_req_abort_cmd(struct scsi_cmnd *).
This function requests that SCSI Core start recovery for the
command by deleting the timer and adding the command to the eh
queue.  It can be called by either LLDDs or SCSI Core.  LLDDs who
implement their own error recovery MAY ignore the timeout event if
they generated scsi_req_abort_cmd.

First post:
http://marc.theaimsgroup.com/?l=linux-scsi&m=113833937421677&w=2

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/scsi.c      |   18 ++++++++++++++++++
 include/scsi/scsi_cmnd.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

2dcc69f8559ce963d637e881ca168afd91ee2478
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 73994e2..dae4f08 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -720,6 +720,24 @@ void scsi_init_cmd_from_req(struct scsi_
 static DEFINE_PER_CPU(struct list_head, scsi_done_q);
 
 /**
+ * scsi_req_abort_cmd -- Request command recovery for the specified command
+ * cmd: pointer to the SCSI command of interest
+ *
+ * This function requests that SCSI Core start recovery for the
+ * command by deleting the timer and adding the command to the eh
+ * queue.  It can be called by either LLDDs or SCSI Core.  LLDDs who
+ * implement their own error recovery MAY ignore the timeout event if
+ * they generated scsi_req_abort_cmd.
+ */
+void scsi_req_abort_cmd(struct scsi_cmnd *cmd)
+{
+	if (!scsi_delete_timer(cmd))
+		return;
+	scsi_times_out(cmd);
+}
+EXPORT_SYMBOL(scsi_req_abort_cmd);
+
+/**
  * scsi_done - Enqueue the finished SCSI command into the done queue.
  * @cmd: The SCSI Command for which a low-level device driver (LLDD) gives
  * ownership back to SCSI Core -- i.e. the LLDD has finished with it.
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 1ace1b9..88c6c4d 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -151,5 +151,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
+extern void scsi_req_abort_cmd(struct scsi_cmnd *cmd);
 
 #endif /* _SCSI_SCSI_CMND_H */
-- 
1.2.4


