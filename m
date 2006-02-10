From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: separate out ahci_fill_cmd_slot()
Date: Fri, 10 Feb 2006 17:25:47 +0900
Message-ID: <20060210082547.GA17734@htj.dyndns.org>
References: <20060123081626.GA664@htj.dyndns.org> <43D99CBA.4090801@pobox.com> <20060201170452.GA22989@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:18093 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751198AbWBJIZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 03:25:51 -0500
Received: by zproxy.gmail.com with SMTP id 14so390578nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 00:25:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060201170452.GA22989@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Separate out ahci_fill_cmd_slot() from ahci_qc_prep().
ahci_fill_cmd_slot() can later be used to issue non-standard commands.
(e.g. softreset)

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Forgot to drop the inline.  Sorry.

ahci-separate-ahci_fill_cmd_slot

Index: work1/drivers/scsi/ahci.c
===================================================================
--- work1.orig/drivers/scsi/ahci.c	2006-02-10 17:23:14.000000000 +0900
+++ work1/drivers/scsi/ahci.c	2006-02-10 17:24:00.000000000 +0900
@@ -507,6 +507,15 @@ static unsigned int ahci_dev_classify(st
 	return ata_dev_classify(&tf);
 }
 
+static void ahci_fill_cmd_slot(struct ata_port *ap, u32 opts)
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
@@ -585,42 +594,35 @@ static void ahci_qc_prep(struct ata_queu
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
+	opts = cmd_fis_len | n_elem << 16;
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		opts |= AHCI_CMD_WRITE;
+	if (is_atapi)
+		opts |= AHCI_CMD_ATAPI;
 
-	pp->cmd_slot[0].opts |= cpu_to_le32(n_elem << 16);
+	ahci_fill_cmd_slot(ap, opts);
 }
 
 static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
