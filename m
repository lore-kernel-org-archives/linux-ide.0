From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/02] libata: implement ata_eh_wait()
Date: Wed, 31 May 2006 19:20:05 +0900
Message-ID: <20060531102005.GB8106@htj.dyndns.org>
References: <20060531101932.GA8106@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:6899 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964914AbWEaKUL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 06:20:11 -0400
Received: by py-out-1112.google.com with SMTP id e30so1020911pya
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 03:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060531101932.GA8106@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Implement ata_eh_wait().  On return from this function, it's
guaranteed that the EH which was pending or in progress when the
function was called is complete - including the tailing part of SCSI
EH.  This will be used by hotplug and others to synchronize with EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 +
 include/linux/libata.h     |    2 ++
 4 files changed, 42 insertions(+), 0 deletions(-)

c6cf9e99d1de5ca6a08fb639bb73031ffe50d802
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11df827..66df895 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5189,6 +5189,7 @@ static void ata_host_init(struct ata_por
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
+	init_waitqueue_head(&ap->eh_wait_q);
 
 	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index b88f492..9173d8f 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -237,6 +237,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
+		ap->flags |= ATA_FLAG_EH_IN_PROGRESS;
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
 
 		spin_unlock_irqrestore(hs_lock, flags);
@@ -290,12 +291,49 @@ void ata_scsi_error(struct Scsi_Host *ho
 		ata_port_printk(ap, KERN_INFO, "EH complete\n");
 	ap->flags &= ~ATA_FLAG_RECOVERED;
 
+	/* tell wait_eh that we're done */
+	ap->flags &= ~ATA_FLAG_EH_IN_PROGRESS;
+	wake_up_all(&ap->eh_wait_q);
+
 	spin_unlock_irqrestore(hs_lock, flags);
 
 	DPRINTK("EXIT\n");
 }
 
 /**
+ *	ata_port_wait_eh - Wait for the currently pending EH to complete
+ *	@ap: Port to wait EH for
+ *
+ *	Wait until the currently pending EH is complete.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_port_wait_eh(struct ata_port *ap)
+{
+	unsigned long flags;
+	DEFINE_WAIT(wait);
+
+ retry:
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	while (ap->flags & (ATA_FLAG_EH_PENDING | ATA_FLAG_EH_IN_PROGRESS)) {
+		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		schedule();
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	/* make sure SCSI EH is complete */
+	if (scsi_host_in_recovery(ap->host)) {
+		msleep(10);
+		goto retry;
+	}
+}
+
+/**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
  *
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index b76ad7d..d56d9e1 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -103,6 +103,7 @@ extern void ata_schedule_scsi_eh(struct 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
+extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3f9c65f..2eb5828 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -157,6 +157,7 @@ enum {
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
 
 	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
+	ATA_FLAG_EH_IN_PROGRESS	= (1 << 16), /* EH in progress */
 	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
 	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
 
@@ -490,6 +491,7 @@ struct ata_port {
 
 	u32			msg_enable;
 	struct list_head	eh_done_q;
+	wait_queue_head_t	eh_wait_q;
 
 	void			*private_data;
 
-- 
1.3.2

