From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 21/27] libata: drop @finish_qc from ata_qc_complete_multiple()
Date: Tue, 25 Mar 2008 22:16:59 +0900
Message-ID: <12064510281611-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:15483 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbYCYNR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539072wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:57 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

ata_qc_complete_multiple() took @finish_qc and called it on every qc
before completing it.  This was to give opportunity to update TF cache
before ata_qc_complete() tries to fill result_tf.  Now that result TF
is a separate operation, this is no longer necessary.

Update sata_sil24, which was the only user of this mechanism, such
that it implements its own ops->qc_fill_rtf() and drop @finish_qc from
ata_qc_complete_multiple().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    2 +-
 drivers/ata/libata-core.c |    6 +-----
 drivers/ata/sata_sil24.c  |   19 +++++++++----------
 include/linux/libata.h    |    3 +--
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3071a23..1389c64 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1696,7 +1696,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	else
 		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
 
-	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
+	rc = ata_qc_complete_multiple(ap, qc_active);
 
 	/* while resetting, invalid completions are expected */
 	if (unlikely(rc < 0 && !resetting)) {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cf7b9e5..9a14be2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4595,7 +4595,6 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
  *	ata_qc_complete_multiple - Complete multiple qcs successfully
  *	@ap: port in question
  *	@qc_active: new qc_active mask
- *	@finish_qc: LLDD callback invoked before completing a qc
  *
  *	Complete in-flight commands.  This functions is meant to be
  *	called from low-level driver's interrupt routine to complete
@@ -4608,8 +4607,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Number of completed commands on success, -errno otherwise.
  */
-int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
-			     void (*finish_qc)(struct ata_queued_cmd *))
+int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active)
 {
 	int nr_done = 0;
 	u32 done_mask;
@@ -4630,8 +4628,6 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 			continue;
 
 		if ((qc = ata_qc_from_tag(ap, i))) {
-			if (finish_qc)
-				finish_qc(qc);
 			ata_qc_complete(qc);
 			nr_done++;
 		}
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index fc9d48c..79952f8 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -348,6 +348,7 @@ static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
+static bool sil24_qc_fill_rtf(struct ata_queued_cmd *qc);
 static void sil24_pmp_attach(struct ata_port *ap);
 static void sil24_pmp_detach(struct ata_port *ap);
 static void sil24_freeze(struct ata_port *ap);
@@ -407,6 +408,7 @@ static struct ata_port_operations sil24_ops = {
 	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
+	.qc_fill_rtf		= sil24_qc_fill_rtf,
 
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
@@ -914,6 +916,12 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static bool sil24_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	sil24_read_tf(qc->ap, qc->tag, &qc->result_tf);
+	return true;
+}
+
 static void sil24_pmp_attach(struct ata_port *ap)
 {
 	sil24_config_pmp(ap, 1);
@@ -1098,15 +1106,6 @@ static void sil24_error_intr(struct ata_port *ap)
 	}
 }
 
-static void sil24_finish_qc(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct sil24_port_priv *pp = ap->private_data;
-
-	if (qc->flags & ATA_QCFLAG_RESULT_TF)
-		sil24_read_tf(ap, qc->tag, &pp->tf);
-}
-
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
@@ -1131,7 +1130,7 @@ static inline void sil24_host_intr(struct ata_port *ap)
 	}
 
 	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
-	rc = ata_qc_complete_multiple(ap, qc_active, sil24_finish_qc);
+	rc = ata_qc_complete_multiple(ap, qc_active);
 	if (rc > 0)
 		return;
 	if (rc < 0) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8b381ce..03f4ae3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -921,8 +921,7 @@ extern void ata_id_string(const u16 *id, unsigned char *s,
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
-				    void (*finish_qc)(struct ata_queued_cmd *));
+extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
-- 
1.5.2.4

