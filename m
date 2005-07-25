From: Mark Lord <mlord@pobox.com>
Subject: libata total system lockup fix
Date: Mon, 25 Jul 2005 09:47:28 -0400
Message-ID: <42E4ED70.1050501@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030104010000040700050006"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57872 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261214AbVGYNr0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 09:47:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030104010000040700050006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

We corresponded about this bugfix ages ago,
but I find I'm still patching it into each new
kernel.org kernel to keep my system from locking
up hard in the libata error handling path.

(error handling is triggered by the KDE/Gnome desktop
polling the empty ATAPI drive every second or two,
gets an error when no disc inserted, thereby triggering
SCSI/libata error paths, which lock system hard once
in a few thousand tries -- about once every two hours).

This patch originally came to me from you, and I've now
forgotten where you got it from.  But it does fix the
problem here.  I have also circulated this patch among
many other users of "ata_piix" on modern laptops,
and it seems to cure random lockups for them as well.

This configuration (2.6 kernel, ata_piix driving hard disk
and DVD-RW drive in a Centrino laptop) is now very very
commonplace, and the lockups are driving users crazy.

Sure would be nice to see it in 2.6.13 or 2.6.14 by default.

Cheers

-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


--------------030104010000040700050006
Content-Type: text/x-patch;
 name="libata_error_handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata_error_handling.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.6.12/drivers/scsi/libata-core.c linux/drivers/scsi/libata-core.c
--- linux-2.6.12/drivers/scsi/libata-core.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/drivers/scsi/libata-core.c	2005-07-02 12:33:25.000000000 -0400
@@ -41,6 +41,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
+#include "scsi_logging.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -2803,6 +2804,11 @@
 	DPRINTK("EXIT\n");
 }
 
+void ata_qc_timeout_done(struct scsi_cmnd *scmd)
+{
+	return;
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2835,17 +2841,16 @@
 		struct scsi_cmnd *cmd = qc->scsicmd;
 
 		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
-
 			/* finish completing original command */
+			qc->scsidone = ata_qc_timeout_done;
+
 			__ata_qc_complete(qc);
 
 			atapi_request_sense(ap, dev, cmd);
 
 			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
 		}
+		goto out;
 	}
 
 	/* hack alert!  We cannot use the supplied completion
diff -u --recursive --new-file --exclude='.*' linux-2.6.12/drivers/scsi/libata-scsi.c linux/drivers/scsi/libata-scsi.c
--- linux-2.6.12/drivers/scsi/libata-scsi.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2005-07-02 12:33:25.000000000 -0400
@@ -380,12 +380,6 @@
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
-
 	DPRINTK("EXIT\n");
 	return 0;
 }
diff -u --recursive --new-file --exclude='.*' linux-2.6.12/drivers/scsi/scsi_error.c linux/drivers/scsi/scsi_error.c
--- linux-2.6.12/drivers/scsi/scsi_error.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/drivers/scsi/scsi_error.c	2005-07-02 12:33:25.000000000 -0400
@@ -1613,6 +1613,40 @@
 	scsi_eh_flush_done_q(&eh_done_q);
 }
 
+static void scsi_invoke_strategy_handler(struct Scsi_Host *shost)
+{
+	int rtn;
+	struct list_head *lh, *lh_sf;
+	struct scsi_cmnd *scmd;
+	unsigned long flags;
+	LIST_HEAD(eh_work_q);
+	LIST_HEAD(eh_done_q);
+
+	rtn = shost->hostt->eh_strategy_handler(shost);
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	list_splice_init(&shost->eh_cmd_q, &eh_work_q);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
+
+	list_for_each_safe(lh, lh_sf, &eh_work_q) {
+		scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
+
+		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CANCEL_CMD) ||
+		    !SCSI_SENSE_VALID(scmd))
+			continue;
+		scmd->retries = scmd->allowed;
+		scsi_eh_finish_cmd(scmd, &eh_done_q);
+	}
+
+	if (!list_empty(&eh_work_q))
+		if (!scsi_eh_abort_cmds(&eh_work_q, &eh_done_q))
+			scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
+
+	scsi_eh_flush_done_q(&eh_done_q);
+}
+
 /**
  * scsi_error_handler - Handle errors/timeouts of SCSI cmds.
  * @data:	Host for which we are running.
@@ -1627,7 +1661,6 @@
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
-	int rtn;
 	DECLARE_MUTEX_LOCKED(sem);
 
 	/*
@@ -1683,8 +1716,8 @@
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (shost->hostt->eh_strategy_handler) 
-			rtn = shost->hostt->eh_strategy_handler(shost);
+		if (shost->hostt->eh_strategy_handler)
+			scsi_invoke_strategy_handler(shost);
 		else
 			scsi_unjam_host(shost);
 

--------------030104010000040700050006--
