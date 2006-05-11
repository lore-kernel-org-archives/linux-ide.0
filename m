From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/11] libata-eh-fw: implement freeze/thaw
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504441058-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:56748 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751641AbWEKM1e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:34 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175445nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:34 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Freezing is performed atomic w.r.t. host_set->lock and once frozen
LLDD is not allowed to access the port or any qc on it.  Also, libata
makes sure that no new qc gets issued to a frozen port.

A frozen port is thawed after a reset operation completes
successfully, so reset methods must do its job while the port is
frozen.  During initialization all ports get frozen before requesting
IRQ, so reset methods are always invoked on a frozen port.

Optional ->freeze and ->thaw operations notify LLDD that the port is
being frozen and thawed, respectively.  LLDD can disable/enable
hardware interrupt in these callbacks if the controller's IRQ mask can
be changed dynamically.  If the controller doesn't allow such
operation, LLDD can check for frozen state in the interrupt handler
and ack/clear interrupts unconditionally while frozen.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   26 ++++++++++-
 drivers/scsi/libata-eh.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 ++
 3 files changed, 131 insertions(+), 2 deletions(-)

ce9d6dcb786c6bc5e65dc4cd20be3af0bc5e1d69
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7483518..436ff5b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -987,6 +987,12 @@ unsigned ata_exec_internal(struct ata_de
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
+	/* no internal command while frozen */
+	if (ap->flags & ATA_FLAG_FROZEN) {
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		return AC_ERR_SYSTEM;
+	}
+
 	/* initialize internal qc */
 
 	/* XXX: Tag 0 is used for drivers with legacy EH as some
@@ -2564,8 +2570,11 @@ void ata_std_postreset(struct ata_port *
 		ata_scr_write(ap, SCR_ERROR, serror);
 
 	/* re-enable interrupts */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (!ap->ops->error_handler) {
+		/* FIXME: hack. create a hook instead */
+		if (ap->ioaddr.ctl_addr)
+			ata_irq_on(ap);
+	}
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
@@ -2680,6 +2689,8 @@ int ata_drive_probe_reset(struct ata_por
 {
 	int rc = -EINVAL;
 
+	ata_eh_freeze_port(ap);
+
 	if (probeinit)
 		probeinit(ap);
 
@@ -2724,6 +2735,9 @@ int ata_drive_probe_reset(struct ata_por
 	if (rc == 0) {
 		if (postreset)
 			postreset(ap, classes);
+
+		ata_eh_thaw_port(ap);
+
 		if (classes[0] == ATA_DEV_UNKNOWN)
 			rc = -ENODEV;
 	}
@@ -4038,6 +4052,10 @@ static struct ata_queued_cmd *ata_qc_new
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
+	/* no command while frozen */
+	if (unlikely(ap->flags & ATA_FLAG_FROZEN))
+		return NULL;
+
 	/* the last tag is reserved for internal command. */
 	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
@@ -4952,6 +4970,7 @@ int ata_device_add(const struct ata_prob
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
+		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
 		count++;
 	}
 
@@ -5384,5 +5403,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_device_resume
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_port_abort);
+EXPORT_SYMBOL_GPL(ata_port_freeze);
+EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
+EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 037a561..cb4e2b8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -291,6 +291,109 @@ int ata_port_abort(struct ata_port *ap)
 	return nr_aborted;
 }
 
+/**
+ *	__ata_port_freeze - freeze port
+ *	@ap: ATA port to freeze
+ *
+ *	This function is called when HSM violation or some other
+ *	condition disrupts normal operation of the port.  Frozen port
+ *	is not allowed to perform any operation until the port is
+ *	thawed, which usually follows a successful reset.
+ *
+ *	ap->ops->freeze() callback can be used for freezing the port
+ *	hardware-wise (e.g. mask interrupt and stop DMA engine).  If a
+ *	port cannot be frozen hardware-wise, the interrupt handler
+ *	must ack and clear interrupts unconditionally while the port
+ *	is frozen.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+static void __ata_port_freeze(struct ata_port *ap)
+{
+	WARN_ON(!ap->ops->error_handler);
+
+	if (ap->ops->freeze)
+		ap->ops->freeze(ap);
+
+	ap->flags |= ATA_FLAG_FROZEN;
+
+	DPRINTK("ata%u port frozen\n", ap->id);
+}
+
+/**
+ *	ata_port_freeze - abort & freeze port
+ *	@ap: ATA port to freeze
+ *
+ *	Abort and freeze @ap.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Number of aborted commands.
+ */
+int ata_port_freeze(struct ata_port *ap)
+{
+	int nr_aborted;
+
+	WARN_ON(!ap->ops->error_handler);
+
+	nr_aborted = ata_port_abort(ap);
+	__ata_port_freeze(ap);
+
+	return nr_aborted;
+}
+
+/**
+ *	ata_eh_freeze_port - EH helper to freeze port
+ *	@ap: ATA port to freeze
+ *
+ *	Freeze @ap.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_eh_freeze_port(struct ata_port *ap)
+{
+	unsigned long flags;
+
+	if (!ap->ops->error_handler)
+		return;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	__ata_port_freeze(ap);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
+ *	ata_port_thaw_port - EH helper to thaw port
+ *	@ap: ATA port to thaw
+ *
+ *	Thaw frozen port @ap.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_eh_thaw_port(struct ata_port *ap)
+{
+	unsigned long flags;
+
+	if (!ap->ops->error_handler)
+		return;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	ap->flags &= ~ATA_FLAG_FROZEN;
+
+	if (ap->ops->thaw)
+		ap->ops->thaw(ap);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("ata%u port thawed\n", ap->id);
+}
+
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
 	/* nada */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4221d7a..3f22eff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -665,6 +665,10 @@ extern void ata_eng_timeout(struct ata_p
 
 extern void ata_port_schedule_eh(struct ata_port *ap);
 extern int ata_port_abort(struct ata_port *ap);
+extern int ata_port_freeze(struct ata_port *ap);
+
+extern void ata_eh_freeze_port(struct ata_port *ap);
+extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-- 
1.2.4


