From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata: implement ata_eh_schedule_port()
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <11440026693828-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:32415 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWDBSbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:21 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550556nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:21 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_eh_schedule_port() is the gateway to EH and does one of the
followings depending on how it's invoked.

* Without any flag: It simply schedules EH.  EH will kick in after all
  commands are drained (unless another event occurs, of course).

* ATA_EH_ABORT: EH is scheduled and all currently active qc's get
  aborted.  The caller is responsible for making sure the controller
  and devices are in stable state in this case.

* ATA_EH_FREEZE: It does everything ATA_EH_ABORT does and then freezes
  the port; thus, making the port inaccessible until it gets reset.
  This can be used to safely schedule EH when an HSM violation event
  occurs.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   52 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    5 ++++
 3 files changed, 58 insertions(+), 0 deletions(-)

c31b07c28393b6a586dc1e1bcb5809f5c8e3be79
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 600b323..735f328 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5245,5 +5245,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_device_resume
 
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
+EXPORT_SYMBOL_GPL(ata_eh_schedule_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index a1fe14f..d443ef2 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -239,6 +239,58 @@ void ata_eh_schedule_qc(struct ata_queue
 	scsi_eh_schedule_cmd(qc->scsicmd);
 }
 
+/**
+ *	ata_eh_schedule_port - schedule error handling without a qc
+ *	@ap: ATA port to schedule EH for
+ *	@flags: ATA_EH_* flags
+ *
+ *	Schedule error hanlding for the speficied ATA port.  EH will
+ *	kick in as soon as all commands are drained.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_eh_schedule_port(struct ata_port *ap, unsigned int flags)
+{
+	int internal_cmd = ata_tag_internal(ap->active_tag);
+	int i;
+
+	WARN_ON(!ap->ops->error_handler);
+
+	if (!internal_cmd)
+		scsi_eh_schedule_host(ap->host);
+
+	if (!(flags & (ATA_EH_ABORT | ATA_EH_FREEZE)))
+		return;
+
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, i);
+		if (qc) {
+			if (!internal_cmd)
+				ata_eh_schedule_qc(qc);
+			else {
+				qc->flags |= ATA_QCFLAG_FAILED;
+				__ata_qc_complete(qc);
+			}
+		}
+	}
+
+	if (!(flags & ATA_EH_FREEZE))
+		return;
+
+	/* Timeout handler might try to freeze an already frozen port
+	 * if it races against interrupt handler or another timeout.
+	 * Such races should be _very_ rare.  Whine and ignore.
+	 */
+	if (ap->flags & ATA_FLAG_FROZEN) {
+		printk(KERN_INFO "ata%u: ata_eh_schedule_port invoked on "
+		       "a frozen port\n", ap->id);
+		return;
+	}
+
+	ata_port_freeze(ap);
+}
+
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
 	/* nada */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 13bcb3c..c65cda9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -223,6 +223,10 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* flags for ata_eh_shduled_port */
+	ATA_EH_ABORT		= (1 << 0), /* abort all active commands */
+	ATA_EH_FREEZE		= (1 << 1), /* freeze port (implies ABORT) */
+
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
 };
@@ -652,6 +656,7 @@ extern unsigned long ata_pci_default_fil
  */
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eng_timeout(struct ata_port *ap);
+extern void ata_eh_schedule_port(struct ata_port *ap, unsigned int flags);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-- 
1.2.4


