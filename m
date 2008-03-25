From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 20/27] libata: add qc_fill_rtf port operation
Date: Tue, 25 Mar 2008 22:16:58 +0900
Message-ID: <12064510282219-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:15483 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbYCYNRm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:42 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539072wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:41 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

On command completion, ata_qc_complete() directly called ops->tf_read
to fill qc->result_tf.  This patch adds ops->qc_fill_rtf to replace
hardcoded ops->tf_read usage.

ata_sff_qc_fill_rtf() which uses ops->tf_read to fill result_tf is
implemented and set in ata_base_port_ops and other ops tables which
don't inherit from ata_base_port_ops, so this patch doesn't introduce
any behavior change.

ops->qc_fill_rtf() is similar to ops->sff_tf_read() but can only be
called when a command finishes.  As some non-SFF controllers don't
have TF registers defined unless they're associated with in-flight
commands, this limited operation makes life easier for those drivers
and help lifting SFF assumptions from libata core layer.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c     |    3 ++-
 drivers/ata/libata-sff.c      |   20 ++++++++++++++++++++
 drivers/ata/sata_sx4.c        |    1 +
 drivers/scsi/ipr.c            |    1 +
 drivers/scsi/libsas/sas_ata.c |    1 +
 include/linux/libata.h        |    2 ++
 6 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d99929c..cf7b9e5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,6 +74,7 @@ const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
+	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
 	.prereset		= ata_std_prereset,
 	.postreset		= ata_std_postreset,
 	.error_handler		= ata_std_error_handler,
@@ -4484,7 +4485,7 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 
 	qc->result_tf.flags = qc->tf.flags;
-	ap->ops->sff_tf_read(ap, &qc->result_tf);
+	ap->ops->qc_fill_rtf(qc);
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5be8a60..5ae813f 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1408,6 +1408,25 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 }
 
 /**
+ *	ata_sff_qc_fill_rtf - fill result TF using ->sff_tf_read
+ *	@qc: qc to fill result TF for
+ *
+ *	@qc is finished and result TF needs to be filled.  Fill it
+ *	using ->sff_tf_read.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	true indicating that result TF is successfully filled.
+ */
+bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	qc->ap->ops->sff_tf_read(qc->ap, &qc->result_tf);
+	return true;
+}
+
+/**
  *	ata_sff_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -2724,6 +2743,7 @@ EXPORT_SYMBOL_GPL(ata_sff_irq_on);
 EXPORT_SYMBOL_GPL(ata_sff_irq_clear);
 EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
 EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
+EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
 EXPORT_SYMBOL_GPL(ata_sff_host_intr);
 EXPORT_SYMBOL_GPL(ata_sff_interrupt);
 EXPORT_SYMBOL_GPL(ata_sff_freeze);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 6e90be0..637635d 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -251,6 +251,7 @@ static struct ata_port_operations pdc_20621_ops = {
 	.phy_reset		= pdc_20621_phy_reset,
 	.qc_prep		= pdc20621_qc_prep,
 	.qc_issue		= pdc20621_qc_issue,
+	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
 	.sff_data_xfer		= ata_sff_data_xfer,
 	.eng_timeout		= pdc_eng_timeout,
 	.sff_irq_clear		= pdc20621_irq_clear,
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 5bddae1..2ecd329 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5280,6 +5280,7 @@ static struct ata_port_operations ipr_sata_ops = {
 	.sff_tf_read = ipr_tf_read,
 	.qc_prep = ata_noop_qc_prep,
 	.qc_issue = ipr_qc_issue,
+	.qc_fill_rtf = ata_sff_qc_fill_rtf,
 	.port_start = ata_sas_port_start,
 	.port_stop = ata_sas_port_stop
 };
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a1664b8..2ec2558 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -356,6 +356,7 @@ static struct ata_port_operations sas_sata_ops = {
 	.sff_tf_read		= sas_ata_tf_read,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= sas_ata_qc_issue,
+	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
 	.port_start		= ata_sas_port_start,
 	.port_stop		= ata_sas_port_stop,
 	.scr_read		= sas_ata_scr_read,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e232140..8b381ce 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -713,6 +713,7 @@ struct ata_port_operations {
 	int  (*check_atapi_dma)(struct ata_queued_cmd *qc);
 	void (*qc_prep)(struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
+	bool (*qc_fill_rtf)(struct ata_queued_cmd *qc);
 
 	/*
 	 * Configuration and exception handling
@@ -1403,6 +1404,7 @@ extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
+extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_host_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc);
 extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
-- 
1.5.2.4

