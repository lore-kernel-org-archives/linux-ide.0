From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <1137916710230-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:27288 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbWAVH7J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:59:09 -0500
Received: by wproxy.gmail.com with SMTP id 57so731387wri
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:59:09 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Export two SCSI EH command handling functions.  To be used by libata EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/scsi_error.c |    7 ++++---
 include/scsi/scsi_eh.h    |    3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

089544e4124c0a027694e7234f3b3cd1a5103d55
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a2333d2..6bac3d2 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -584,8 +584,7 @@ static int scsi_request_sense(struct scs
  *    keep a list of pending commands for final completion, and once we
  *    are ready to leave error handling we handle completion for real.
  **/
-static void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
-			       struct list_head *done_q)
+void scsi_eh_finish_cmd(struct scsi_cmnd *scmd, struct list_head *done_q)
 {
 	scmd->device->host->host_failed--;
 	scmd->eh_eflags = 0;
@@ -597,6 +596,7 @@ static void scsi_eh_finish_cmd(struct sc
 	scsi_setup_cmd_retry(scmd);
 	list_move_tail(&scmd->eh_entry, done_q);
 }
+EXPORT_SYMBOL(scsi_eh_finish_cmd);
 
 /**
  * scsi_eh_get_sense - Get device sense data.
@@ -1425,7 +1425,7 @@ static void scsi_eh_ready_devs(struct Sc
  * @done_q:	list_head of processed commands.
  *
  **/
-static void scsi_eh_flush_done_q(struct list_head *done_q)
+void scsi_eh_flush_done_q(struct list_head *done_q)
 {
 	struct scsi_cmnd *scmd, *next;
 
@@ -1454,6 +1454,7 @@ static void scsi_eh_flush_done_q(struct 
 		}
 	}
 }
+EXPORT_SYMBOL(scsi_eh_flush_done_q);
 
 /**
  * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index fabd879..d160880 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -35,6 +35,9 @@ static inline int scsi_sense_valid(struc
 }
 
 
+extern void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
+			       struct list_head *done_q);
+extern void scsi_eh_flush_done_q(struct list_head *done_q);
 extern void scsi_report_bus_reset(struct Scsi_Host *, int);
 extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
 extern int scsi_block_when_processing_errors(struct scsi_device *);
-- 
1.0.8


