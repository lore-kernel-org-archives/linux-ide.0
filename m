From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: inline ata_qc_complete()
Date: Sat, 11 Feb 2006 15:13:49 +0900
Message-ID: <20060211061349.GA2905@htj.dyndns.org>
References: <11395518482722-git-send-email-htejun@gmail.com> <43EC8077.4080003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:50204 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751251AbWBKGNx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 01:13:53 -0500
Received: by zproxy.gmail.com with SMTP id i1so746657nzh
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 22:13:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43EC8077.4080003@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

This patch inlines ata_qc_complete() and uninlines __ata_qc_complete()
as suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, later EH patches might add one or two more condition tests to
ata_qc_complete().  I don't know whether ata_qc_complete will still
fit as an inline function after EH changes but if it doesn't, it
should be converted then, I guess.  This patch is against the current
upstream (489ff4c7d167be954f715128790bd80d3c888322).

Thanks.

 drivers/scsi/libata-core.c |   23 ++---------------------
 drivers/scsi/libata.h      |    1 -
 include/linux/libata.h     |   20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 38e72c1..fffbaa9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3621,7 +3621,7 @@ void ata_qc_free(struct ata_queued_cmd *
 	}
 }
 
-inline void __ata_qc_complete(struct ata_queued_cmd *qc)
+void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
@@ -3639,25 +3639,6 @@ inline void __ata_qc_complete(struct ata
 	qc->complete_fn(qc);
 }
 
-/**
- *	ata_qc_complete - Complete an active ATA command
- *	@qc: Command to complete
- *	@err_mask: ATA Status register contents
- *
- *	Indicate to the mid and upper layers that an ATA
- *	command has completed, with either an ok or not-ok status.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_qc_complete(struct ata_queued_cmd *qc)
-{
-	if (unlikely(qc->flags & ATA_QCFLAG_EH_SCHEDULED))
-		return;
-
-	__ata_qc_complete(qc);
-}
-
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -4877,7 +4858,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
-EXPORT_SYMBOL_GPL(ata_qc_complete);
+EXPORT_SYMBOL_GPL(__ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_tf_load);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 1cd071a..9d76923 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -46,7 +46,6 @@ extern struct ata_queued_cmd *ata_qc_new
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
-extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1e1986..695d9ae 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -556,7 +556,7 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern void ata_qc_complete(struct ata_queued_cmd *qc);
+extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
@@ -756,6 +756,24 @@ static inline void ata_qc_reinit(struct 
 	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
 }
 
+/**
+ *	ata_qc_complete - Complete an active ATA command
+ *	@qc: Command to complete
+ *	@err_mask: ATA Status register contents
+ *
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+static inline void ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	if (unlikely(qc->flags & ATA_QCFLAG_EH_SCHEDULED))
+		return;
+
+	__ata_qc_complete(qc);
+}
 
 /**
  *	ata_irq_on - Enable interrupts on a port.
