From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/11] libata-eh-fw: implement ata_port_schedule_eh() and ata_port_abort()
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504442652-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:9236 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751657AbWEKM1f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:35 -0400
Received: by py-out-1112.google.com with SMTP id f28so217988pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:34 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_port_schedule_eh() directly schedules EH for @ap without
associated qc.  Once EH scheduled, no further qc is allowed and EH
kicks in as soon as all currently active qc's are drained.

ata_port_abort() schedules all currently active commands for EH by
qc_completing them with ATA_QCFLAG_FAILED set.  If ata_port_abort()
doesn't find any qc to abort, it directly schedule EH using
ata_port_schedule_eh().

These two functions provide ways to invoke EH for conditions which
aren't directly related to any specfic qc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 ++
 drivers/scsi/libata-eh.c   |   54 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   23 +++++++++++++++++++
 drivers/scsi/libata.h      |    1 +
 include/linux/libata.h     |    4 +++
 5 files changed, 84 insertions(+), 0 deletions(-)

8bf0da935c2cc87ba065a10866fdf212cc0abe37
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2b18033..7483518 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5382,5 +5382,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_device_suspen
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
+EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
+EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 471846f..037a561 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -237,6 +237,60 @@ void ata_qc_schedule_eh(struct ata_queue
 	scsi_req_abort_cmd(qc->scsicmd);
 }
 
+/**
+ *	ata_port_schedule_eh - schedule error handling without a qc
+ *	@ap: ATA port to schedule EH for
+ *
+ *	Schedule error handling for @ap.  EH will kick in as soon as
+ *	all commands are drained.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_port_schedule_eh(struct ata_port *ap)
+{
+	WARN_ON(!ap->ops->error_handler);
+
+	ap->flags |= ATA_FLAG_EH_PENDING;
+	ata_schedule_scsi_eh(ap->host);
+
+	DPRINTK("port EH scheduled\n");
+}
+
+/**
+ *	ata_port_abort - abort all qc's on the port
+ *	@ap: ATA port to abort qc's for
+ *
+ *	Abort all active qc's of @ap and schedule EH.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Number of aborted qc's.
+ */
+int ata_port_abort(struct ata_port *ap)
+{
+	int tag, nr_aborted = 0;
+
+	WARN_ON(!ap->ops->error_handler);
+
+	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+
+		if (qc) {
+			qc->flags |= ATA_QCFLAG_FAILED;
+			ata_qc_complete(qc);
+			nr_aborted++;
+		}
+	}
+
+	if (!nr_aborted)
+		ata_port_schedule_eh(ap);
+
+	return nr_aborted;
+}
+
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
 	/* nada */
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index a9b4083..fd7064b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2596,3 +2596,26 @@ void ata_scsi_scan_host(struct ata_port 
 	}
 }
 
+/**
+ *	ata_schedule_scsi_eh - schedule EH for SCSI host
+ *	@shost:	SCSI host to invoke error handling on.
+ *
+ *	Schedule SCSI EH without scmd.  This is a hack.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ **/
+void ata_schedule_scsi_eh(struct Scsi_Host *shost)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(shost->host_lock, flags);
+
+	if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
+	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0) {
+		shost->host_eh_scheduled++;
+		scsi_eh_wakeup(shost);
+	}
+
+	spin_unlock_irqrestore(shost->host_lock, flags);
+}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 1e81c37..e2bbddf 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -98,6 +98,7 @@ extern void ata_scsi_set_sense(struct sc
 extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
+extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fbabfb6..4221d7a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -662,6 +662,10 @@ extern unsigned long ata_pci_default_fil
  * EH
  */
 extern void ata_eng_timeout(struct ata_port *ap);
+
+extern void ata_port_schedule_eh(struct ata_port *ap);
+extern int ata_port_abort(struct ata_port *ap);
+
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-- 
1.2.4


