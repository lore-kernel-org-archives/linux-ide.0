From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: improve AC_ERR_DEV handling for ->post_internal_cmd
Date: Tue, 20 Mar 2007 15:24:11 +0900
Message-ID: <20070320062411.GE6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:22898 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbXCTGYR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 02:24:17 -0400
Received: by py-out-1112.google.com with SMTP id a29so364441pyi
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 23:24:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

->post_internal_cmd is simplified EH for internal commands.  Its
primary mission is to stop the controller such that no rogue memory
access or other activities occur after the internal command is
released.  It may provide error diagnostics by setting qc->err_mask
but this hasn't been a requirement.

To ignore SETXFER failure for CFA devices, libata needs to know
whether a command was failed by the device or for any other reason.
ie. internal command needs to get AC_ERR_DEV right.

This patch makes the following changes to AC_ERR_DEV handling and
->post_internal_cmd semantics to accomodate this need and simplify
callback implementation.

1. As long as the correct bits in the result TF registers are set,
   there is no need to set AC_ERR_DEV explicitly.  libata EH core
   takes care of that for both normal and internal commands.

2. The only requirement for ->post_internal_cmd() is to put the
   controller into quiescent state.  It needs not to set any err_mask.

3. ata_exec_internal_sg() performs minimal error analysis such that
   AC_ERR_DEV is automatically set as long as result_tf is filled
   correctly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dc7b562..f097417 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1338,10 +1338,7 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
-	if (qc->flags & ATA_QCFLAG_FAILED)
-		qc->err_mask |= AC_ERR_OTHER;
-
-	if (qc->err_mask) {
+	if (qc->flags & ATA_QCFLAG_FAILED) {
 		/* make DMA engine forget about the failed command */
 		ahci_stop_engine(port_mmio);
 		ahci_start_engine(port_mmio);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14629a3..a6d3ee2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1270,12 +1270,16 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	if (ap->ops->post_internal_cmd)
 		ap->ops->post_internal_cmd(qc);
 
-	if ((qc->flags & ATA_QCFLAG_FAILED) && !qc->err_mask) {
-		if (ata_msg_warn(ap))
-			ata_dev_printk(dev, KERN_WARNING,
-				"zero err_mask for failed "
-				"internal command, assuming AC_ERR_OTHER\n");
-		qc->err_mask |= AC_ERR_OTHER;
+	/* perform minimal error analysis */
+	if (qc->flags & ATA_QCFLAG_FAILED) {
+		if (qc->result_tf.command & (ATA_ERR | ATA_DF))
+			qc->err_mask |= AC_ERR_DEV;
+
+		if (!qc->err_mask)
+			qc->err_mask |= AC_ERR_OTHER;
+
+		if (qc->err_mask & ~AC_ERR_OTHER)
+			qc->err_mask &= ~AC_ERR_OTHER;
 	}
 
 	/* finish up */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7349c3d..dd4adb6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1150,7 +1150,9 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 		return ATA_EH_SOFTRESET;
 	}
 
-	if (!(qc->err_mask & AC_ERR_DEV))
+	if (stat & (ATA_ERR | ATA_DF))
+		qc->err_mask |= AC_ERR_DEV;
+	else
 		return 0;
 
 	switch (qc->dev->class) {
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index dcf5fe5..92726bc 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -488,7 +488,7 @@ static void inic_error_handler(struct ata_port *ap)
 static void inic_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	/* make DMA engine forget about the failed command */
-	if (qc->err_mask)
+	if (qc->flags & ATA_QCFLAG_FAILED)
 		inic_reset_port(inic_port_base(qc->ap));
 }
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 78df546..f402741 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -576,11 +576,8 @@ static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	if (qc->flags & ATA_QCFLAG_FAILED)
-		qc->err_mask |= AC_ERR_OTHER;
-
 	/* make DMA engine forget about the failed command */
-	if (qc->err_mask)
+	if (qc->flags & ATA_QCFLAG_FAILED)
 		pdc_reset_port(ap);
 }
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 7e3242e..689d867 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -923,11 +923,8 @@ static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	if (qc->flags & ATA_QCFLAG_FAILED)
-		qc->err_mask |= AC_ERR_OTHER;
-
 	/* make DMA engine forget about the failed command */
-	if (qc->err_mask)
+	if (qc->flags & ATA_QCFLAG_FAILED)
 		sil24_init_port(ap);
 }
 
