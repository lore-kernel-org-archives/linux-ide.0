From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: return AC_ERR_* from issue functions
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <11379167103159-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:27826 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbWAVH6p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:45 -0500
Received: by xproxy.gmail.com with SMTP id s14so513090wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:45 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Return AC_ERR_* mask from issue fuctions instead of 0/-1.  This
enables things like failing a qc with AC_ERR_HSM when the device
doesn't set DRDY when the qc is about to be issued.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    4 ++--
 drivers/scsi/libata-core.c  |   17 ++++++++---------
 drivers/scsi/libata-scsi.c  |   10 ++++------
 drivers/scsi/libata.h       |    2 +-
 drivers/scsi/pdc_adma.c     |    4 ++--
 drivers/scsi/sata_mv.c      |    4 ++--
 drivers/scsi/sata_promise.c |    4 ++--
 drivers/scsi/sata_qstor.c   |    4 ++--
 drivers/scsi/sata_sil24.c   |    4 ++--
 drivers/scsi/sata_sx4.c     |    4 ++--
 include/linux/libata.h      |    4 ++--
 11 files changed, 29 insertions(+), 32 deletions(-)

027f06c43b4e575cc58d2dcb6af8723ef3cd3f2d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e7b937b..75b1fb5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -184,7 +184,7 @@ struct ahci_port_priv {
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static int ahci_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void ahci_phy_reset(struct ata_port *ap);
 static void ahci_irq_clear(struct ata_port *ap);
@@ -798,7 +798,7 @@ static irqreturn_t ahci_interrupt (int i
 	return IRQ_RETVAL(handled);
 }
 
-static int ahci_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f5519f0..b29bf0d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1125,10 +1125,9 @@ ata_exec_internal(struct ata_port *ap, s
 	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	if (ata_qc_issue(qc)) {
-		qc->err_mask = AC_ERR_OTHER;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
 		ata_qc_complete(qc);
-	}
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -3674,10 +3673,10 @@ static inline int ata_should_dma_map(str
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *	Zero on success, negative on error.
+ *	Zero on success, AC_ERR_* mask on failure
  */
 
-int ata_qc_issue(struct ata_queued_cmd *qc)
+unsigned int ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -3702,7 +3701,7 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 sg_err:
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	return -1;
+	return AC_ERR_SYSTEM;
 }
 
 
@@ -3721,10 +3720,10 @@ sg_err:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *	Zero on success, negative on error.
+ *	Zero on success, AC_ERR_* mask on failure
  */
 
-int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -3769,7 +3768,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	default:
 		WARN_ON(1);
-		return -1;
+		return AC_ERR_SYSTEM;
 	}
 
 	return 0;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c496309..95e3c27 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1322,10 +1322,9 @@ static void ata_scsi_translate(struct at
 		goto early_finish;
 
 	/* select device, send command to hardware */
-	if (ata_qc_issue(qc)) {
-		qc->err_mask |= AC_ERR_OTHER;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
 		ata_qc_complete(qc);
-	}
 
 	VPRINTK("EXIT\n");
 	return;
@@ -2044,10 +2043,9 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	if (ata_qc_issue(qc)) {
-		qc->err_mask |= AC_ERR_OTHER;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
 		ata_qc_complete(qc);
-	}
 
 	DPRINTK("EXIT\n");
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e03ce48..9d76923 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -45,7 +45,7 @@ extern struct ata_queued_cmd *ata_qc_new
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern int ata_qc_issue(struct ata_queued_cmd *qc);
+extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index e8df0c9..3a6bf58 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -131,7 +131,7 @@ static void adma_host_stop(struct ata_ho
 static void adma_port_stop(struct ata_port *ap);
 static void adma_phy_reset(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
-static int adma_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 adma_bmdma_status(struct ata_port *ap);
@@ -419,7 +419,7 @@ static inline void adma_packet_start(str
 	writew(aPIOMD4 | aGO, chan + ADMA_CONTROL);
 }
 
-static int adma_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int adma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct adma_port_priv *pp = qc->ap->private_data;
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 89bcd85..281223a 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -328,7 +328,7 @@ static void mv_host_stop(struct ata_host
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
-static int mv_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs);
 static void mv_eng_timeout(struct ata_port *ap);
@@ -1040,7 +1040,7 @@ static void mv_qc_prep(struct ata_queued
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
 	struct mv_port_priv *pp = qc->ap->private_data;
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b0b0a69..bac36d5 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -95,7 +95,7 @@ static void pdc_qc_prep(struct ata_queue
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
-static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_ata_sht = {
@@ -544,7 +544,7 @@ static inline void pdc_packet_start(stru
 	readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
-static int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index de05e28..2afbeb7 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -120,7 +120,7 @@ static void qs_host_stop(struct ata_host
 static void qs_port_stop(struct ata_port *ap);
 static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
-static int qs_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
@@ -352,7 +352,7 @@ static inline void qs_packet_start(struc
 	readl(chan + QS_CCT_CFF);          /* flush */
 }
 
-static int qs_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int qs_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct qs_port_priv *pp = qc->ap->private_data;
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index fb59012..5a7a7b1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -251,7 +251,7 @@ static void sil24_scr_write(struct ata_p
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void sil24_phy_reset(struct ata_port *ap);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
-static int sil24_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
 static void sil24_eng_timeout(struct ata_port *ap);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
@@ -557,7 +557,7 @@ static void sil24_qc_prep(struct ata_que
 		sil24_fill_sg(qc, sge);
 }
 
-static int sil24_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index bc87c16..3175c6b 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -174,7 +174,7 @@ static void pdc20621_get_from_dimm(struc
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe,
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
-static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_sata_sht = {
@@ -678,7 +678,7 @@ static void pdc20621_packet_start(struct
 	}
 }
 
-static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8ff3a7f..b1ea2f9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -427,7 +427,7 @@ struct ata_port_operations {
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 
 	void (*qc_prep) (struct ata_queued_cmd *qc);
-	int (*qc_issue) (struct ata_queued_cmd *qc);
+	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
 	void (*eng_timeout) (struct ata_port *ap);
 
@@ -515,7 +515,7 @@ extern void ata_port_stop (struct ata_po
 extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
-extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
+extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
 		unsigned int buflen);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
-- 
1.0.8


