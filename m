From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: implement ata_scsi_timed_out()
Date: Fri, 10 Feb 2006 15:10:48 +0900
Message-ID: <11395518483886-git-send-email-htejun@gmail.com>
References: <11395518482722-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:24824 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751162AbWBJGKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 01:10:53 -0500
Received: by zproxy.gmail.com with SMTP id 14so369992nzn
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 22:10:53 -0800 (PST)
In-Reply-To: <11395518482722-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_scsi_timed_out(), to be used as
scsi_host_template->eh_timed_out callback for all libata drivers.
Without this function, the following race exists.

If a qc completes after SCSI timer expires but before libata EH kicks
in, the qc gets completed but the scsicmd still gets passed to libata
EH resulting in ->eng_timeout invocation with NULL qc, which none is
handling properly.

This patch makes sure that scmd and qc share the same lifetime.
Original idea from Jeff Garzik <jgarzik@pobox.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-scsi.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    1 +
 3 files changed, 43 insertions(+), 0 deletions(-)

0421953f2a2dee014a3e288c523129a3c602e3ae
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 977a53d..d53e0bc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4913,6 +4913,7 @@ EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
+EXPORT_SYMBOL_GPL(ata_scsi_timed_out);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1df468e..d67cc2f 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -717,6 +717,47 @@ int ata_scsi_slave_config(struct scsi_de
 }
 
 /**
+ *	ata_scsi_timed_out - SCSI layer time out callback
+ *	@cmd: timed out SCSI command
+ *
+ *	Handles SCSI layer timeout.  We race with normal completion of
+ *	the qc for @cmd.  If the qc is already gone, we lose and let
+ *	the scsi command finish (EH_HANDLED).  Otherwise, the qc has
+ *	timed out and EH should be invoked.  Prevent ata_qc_complete()
+ *	from finishing it by setting EH_SCHEDULED and return
+ *	EH_NOT_HANDLED.
+ *
+ *	LOCKING:
+ *	Called from timer context
+ *
+ *	RETURNS:
+ *	EH_HANDLED or EH_NOT_HANDLED
+ */
+enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *host = cmd->device->host;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	unsigned long flags;
+	struct ata_queued_cmd *qc;
+	enum scsi_eh_timer_return ret = EH_HANDLED;
+
+	DPRINTK("ENTER\n");
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc) {
+		assert(qc->scsicmd == cmd);
+		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		ret = EH_NOT_HANDLED;
+	}
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("EXIT, ret=%d\n", ret);
+	return ret;
+}
+
+/**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
  *
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c70a57..c1e1986 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -509,6 +509,7 @@ extern void ata_host_set_remove(struct a
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
+extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-- 
1.1.5


