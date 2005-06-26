From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: remove qc->tag
Date: Sun, 26 Jun 2005 23:30:02 +0900
Message-ID: <20050626143002.GB24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:17086 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261280AbVFZOaH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:30:07 -0400
Received: by rproxy.gmail.com with SMTP id i8so723308rne
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:30:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the second patch of six misc updates to ncq.

 This patch removes redundant qc->tag field.  The value can be
calculated from qc itself easily.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-26 21:07:20.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-26 21:07:27.000000000 +0900
@@ -518,6 +518,7 @@ static void ahci_qc_prep(struct ata_queu
 	dma_addr_t cmd_tbl_dma;
 	u32 opts;
 	int offset;
+	unsigned int tag;
 
 	/*
 	 * Fill in command slot information
@@ -542,14 +543,15 @@ static void ahci_qc_prep(struct ata_queu
 	/*
 	 * the tag determines the offset into the allocated cmd table
 	 */
-	offset = qc->tag * AHCI_CMD_TOTAL;
+	tag = ata_qc_to_tag(qc);
+	offset = tag * AHCI_CMD_TOTAL;
 
 	cmd_tbl_dma = pp->cmd_tbl_dma + offset;
 
-	pp->cmd_slot[qc->tag].opts = cpu_to_le32(opts);
-	pp->cmd_slot[qc->tag].status = 0;
-	pp->cmd_slot[qc->tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);
-	pp->cmd_slot[qc->tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
+	pp->cmd_slot[tag].opts = cpu_to_le32(opts);
+	pp->cmd_slot[tag].status = 0;
+	pp->cmd_slot[tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
 
 	/*
 	 * Fill in command table information.  First, the header,
@@ -935,15 +937,16 @@ static int ahci_qc_issue(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
+	unsigned int tag = ata_qc_to_tag(qc);
 
 	if (qc->flags & ATA_QCFLAG_NCQ) {
-		pp->sactive |= (1 << qc->tag);
+		pp->sactive |= (1 << tag);
 
-		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+		writel(1 << tag, port_mmio + PORT_SCR_ACT);
 		readl(port_mmio + PORT_SCR_ACT);
 	}
 
-	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
+	writel(1 << tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-26 21:07:22.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-26 21:07:27.000000000 +0900
@@ -3005,12 +3005,8 @@ static struct ata_queued_cmd *ata_qc_new
 	unsigned int i;
 
 	for (i = 0; i < ATA_MAX_CMDS; i++)
-		if (!test_and_set_bit(i, &ap->qactive)) {
-			struct ata_queued_cmd *qc = &ap->qcmd[i];
-
-			qc->tag = i;
-			return qc;
-		}
+		if (!test_and_set_bit(i, &ap->qactive))
+			return &ap->qcmd[i];
 
 	return NULL;
 }
@@ -3068,11 +3064,10 @@ static void __ata_qc_complete(struct ata
 	}
 
 	qc->flags = 0;
-	tag = qc->tag;
+	tag = ata_qc_to_tag(qc);
 	if (likely(ata_tag_valid(tag))) {
 		if (tag == ap->active_tag)
 			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
 		do_clear = 1;
 	}
 
@@ -3281,7 +3276,7 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = qc->tag;
+	qc->ap->active_tag = ata_qc_to_tag(qc);
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
 	if (qc->flags & ATA_QCFLAG_NCQ)
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-26 21:07:20.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-26 21:07:27.000000000 +0900
@@ -649,7 +649,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		if (ncq) {
 			tf->hob_feature = scsicmd[7];
 			tf->feature = scsicmd[8];
-			tf->nsect = qc->tag << 3;
+			tf->nsect = ata_qc_to_tag(qc) << 3;
 			tf->hob_lbal = scsicmd[2];
 			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
 					scsicmd[8];
@@ -688,7 +688,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		qc->nsect = scsicmd[4];
 
 		if (ncq) {
-			tf->nsect = qc->tag << 3;
+			tf->nsect = ata_qc_to_tag(qc) << 3;
 			tf->feature = scsicmd[4];
 			tf->device &= ~ATA_DEVICE_OBS;
 			qc->flags |= ATA_QCFLAG_NCQ;
@@ -711,7 +711,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		if (ncq) {
 			tf->feature = scsicmd[13];
 			tf->hob_feature = scsicmd[12];
-			tf->nsect = qc->tag << 3;
+			tf->nsect = ata_qc_to_tag(qc) << 3;
 			tf->hob_lbal = scsicmd[6];
 			tf->hob_lbam = scsicmd[5];
 			tf->hob_lbah = scsicmd[4];
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-26 21:07:20.000000000 +0900
+++ work/include/linux/libata.h	2005-06-26 21:07:45.000000000 +0900
@@ -240,7 +240,6 @@ struct ata_queued_cmd {
 	u8			cdb[ATAPI_CDB_LEN];
 
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
-	unsigned int		tag;
 	unsigned int		n_elem;
 
 	int			dma_dir;
@@ -568,13 +567,20 @@ static inline struct ata_queued_cmd *ata
 	if (likely(ata_tag_valid(tag))) {
 		struct ata_queued_cmd *qc = &ap->qcmd[tag];
 
-		if (tag == qc->tag)
+		if (ap->qactive & (1 << tag))
 			return qc;
 	}
 
 	return NULL;
 }
 
+static inline unsigned int ata_qc_to_tag(struct ata_queued_cmd *qc)
+{
+	unsigned int tag = qc - qc->ap->qcmd;
+	BUG_ON(!ata_tag_valid(tag));
+	return tag;
+}
+
 static inline void ata_tf_init(struct ata_port *ap, struct ata_taskfile *tf, unsigned int device)
 {
 	memset(tf, 0, sizeof(*tf));
