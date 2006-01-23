From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: separate out ahci_fill_cmd_slot()
Date: Mon, 23 Jan 2006 17:16:26 +0900
Message-ID: <20060123081626.GA664@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:3439 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751423AbWAWIXA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2006 03:23:00 -0500
Received: by wproxy.gmail.com with SMTP id i7so911889wra
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2006 00:22:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Separate out ahci_fill_cmd_slot() from ahci_qc_prep().
ahci_fill_cmd_slot() can later be used to issue non-standard commands.
(e.g. softreset)

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work1/drivers/scsi/ahci.c
===================================================================
--- work1.orig/drivers/scsi/ahci.c	2006-01-23 17:02:42.000000000 +0900
+++ work1/drivers/scsi/ahci.c	2006-01-23 17:04:17.000000000 +0900
@@ -498,6 +498,15 @@ static unsigned int ahci_dev_classify(st
 	return ata_dev_classify(&tf);
 }
 
+static inline void ahci_fill_cmd_slot(struct ata_port *ap, u32 opts)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	pp->cmd_slot[0].opts = cpu_to_le32(opts);
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+}
+
 static void ahci_phy_reset(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -576,42 +585,35 @@ static void ahci_qc_prep(struct ata_queu
 {
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
+	int is_atapi = is_atapi_taskfile(&qc->tf);
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
 
 	/*
-	 * Fill in command slot information (currently only one slot,
-	 * slot 0, is currently since we don't do queueing)
-	 */
-
-	opts = cmd_fis_len;
-	if (qc->tf.flags & ATA_TFLAG_WRITE)
-		opts |= AHCI_CMD_WRITE;
-	if (is_atapi_taskfile(&qc->tf))
-		opts |= AHCI_CMD_ATAPI;
-
-	pp->cmd_slot[0].opts = cpu_to_le32(opts);
-	pp->cmd_slot[0].status = 0;
-	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
-	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
-
-	/*
 	 * Fill in command table information.  First, the header,
 	 * a SATA Register - Host to Device command FIS.
 	 */
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
-	if (opts & AHCI_CMD_ATAPI) {
+	if (is_atapi) {
 		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
 		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
 	}
 
-	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+	n_elem = 0;
+	if (qc->flags & ATA_QCFLAG_DMAMAP)
+		n_elem = ahci_fill_sg(qc);
 
-	n_elem = ahci_fill_sg(qc);
+	/*
+	 * Fill in command slot information.
+	 */
+	opts = cmd_fis_len | cpu_to_le32(n_elem << 16);
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		opts |= AHCI_CMD_WRITE;
+	if (is_atapi)
+		opts |= AHCI_CMD_ATAPI;
 
-	pp->cmd_slot[0].opts |= cpu_to_le32(n_elem << 16);
+	ahci_fill_cmd_slot(ap, opts);
 }
 
 static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
