From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/22] SCSI: implement host_eh_scheduled hack for libata
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487904197-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:49594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751563AbWEKL74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:59:56 -0400
Received: by py-out-1112.google.com with SMTP id f28so211124pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:59:55 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata needs to invoke EH without scmd.  This patch adds
shost->host_eh_scheduled to implement such behavior.

As this is a temporary hack for libata, no general interface is
defined.  This patch simply adds handling for host_eh_scheduled where
needed and exports scsi_eh_wakeup() to modules.  The rest is upto
libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/scsi_error.c |    3 ++-
 drivers/scsi/scsi_lib.c   |    2 +-
 drivers/scsi/scsi_priv.h  |    1 -
 include/scsi/scsi_eh.h    |    1 +
 include/scsi/scsi_host.h  |    1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

b3095135fd8d02d5b31591d87243afb3aeb217da
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 1c75646..442ae59 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -56,6 +56,7 @@ void scsi_eh_wakeup(struct Scsi_Host *sh
 				printk("Waking error handler thread\n"));
 	}
 }
+EXPORT_SYMBOL_GPL(scsi_eh_wakeup);	/* exported only for libata */
 
 /**
  * scsi_eh_scmd_add - add scsi cmd to error handling.
@@ -1517,7 +1518,7 @@ int scsi_error_handler(void *data)
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
-		if (shost->host_failed == 0 ||
+		if ((shost->host_failed == 0 && shost->host_eh_scheduled == 0) ||
 		    shost->host_failed != shost->host_busy) {
 			SCSI_LOG_ERROR_RECOVERY(1,
 				printk("Error handler scsi_eh_%d sleeping\n",
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7b0f9a3..c55d195 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -566,7 +566,7 @@ void scsi_device_unbusy(struct scsi_devi
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_busy--;
 	if (unlikely(scsi_host_in_recovery(shost) &&
-		     shost->host_failed))
+		     (shost->host_failed || shost->host_eh_scheduled)))
 		scsi_eh_wakeup(shost);
 	spin_unlock(shost->host_lock);
 	spin_lock(sdev->request_queue->queue_lock);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 27c4827..0b39081 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -63,7 +63,6 @@ extern int scsi_delete_timer(struct scsi
 extern void scsi_times_out(struct scsi_cmnd *cmd);
 extern int scsi_error_handler(void *host);
 extern int scsi_decide_disposition(struct scsi_cmnd *cmd);
-extern void scsi_eh_wakeup(struct Scsi_Host *shost);
 extern int scsi_eh_scmd_add(struct scsi_cmnd *, int);
 
 /* scsi_lib.c */
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index d160880..e31ada2 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -35,6 +35,7 @@ static inline int scsi_sense_valid(struc
 }
 
 
+extern void scsi_eh_wakeup(struct Scsi_Host *shost);	/* libata only */
 extern void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
 			       struct list_head *done_q);
 extern void scsi_eh_flush_done_q(struct list_head *done_q);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index de6ce54..3b454c2 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -472,6 +472,7 @@ struct Scsi_Host {
 	 */
 	unsigned int host_busy;		   /* commands actually active on low-level */
 	unsigned int host_failed;	   /* commands that failed. */
+	unsigned int host_eh_scheduled;	   /* XXX - libata hack, do NOT use */
     
 	unsigned short host_no;  /* Used for IOCTL_GET_IDLUN, /proc/scsi et al. */
 	int resetting; /* if set, it means that last_reset is a valid value */
-- 
1.2.4


