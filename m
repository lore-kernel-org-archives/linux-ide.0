From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] sil24: add ATAPI support
Date: Fri, 18 Nov 2005 14:16:45 +0900
Message-ID: <20051118051645.GD27358@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:41353 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964845AbVKRFQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2005 00:16:54 -0500
Received: by zproxy.gmail.com with SMTP id 13so112295nzn
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 21:16:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This patch implements ATAPI support for sil24 and bumps driver version
to 0.23.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jeff, it has been converted to use ->dev_config as pointed out.

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-18 14:11:32.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-18 14:15:02.000000000 +0900
@@ -5,17 +5,6 @@
  *
  * Based on preview driver from Silicon Image.
  *
- * NOTE: No NCQ/ATAPI support yet.  The preview driver didn't support
- * NCQ nor ATAPI, and, unfortunately, I couldn't find out how to make
- * those work.  Enabling those shouldn't be difficult.  Basic
- * structure is all there (in libata-dev tree).  If you have any
- * information about this hardware, please contact me or linux-ide.
- * Info is needed on...
- *
- * - How to issue tagged commands and turn on sactive on issue accordingly.
- * - Where to put an ATAPI command and how to tell the device to send it.
- * - How to enable/use 64bit.
- *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -42,7 +31,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.22"	/* Silicon Image's preview driver was 0.10 */
+#define DRV_VERSION	"0.23"
 
 /*
  * Port request block (PRB) 32 bytes
@@ -221,11 +210,22 @@ enum {
 	IRQ_STAT_4PORTS		= 0xf,
 };
 
-struct sil24_cmd_block {
+struct sil24_ata_block {
 	struct sil24_prb prb;
 	struct sil24_sge sge[LIBATA_MAX_PRD];
 };
 
+struct sil24_atapi_block {
+	struct sil24_prb prb;
+	u8 cdb[16];
+	struct sil24_sge sge[LIBATA_MAX_PRD - 1];
+};
+
+union sil24_cmd_block {
+	struct sil24_ata_block ata;
+	struct sil24_atapi_block atapi;
+};
+
 /*
  * ap->private_data
  *
@@ -233,7 +233,7 @@ struct sil24_cmd_block {
  * here from the previous interrupt.
  */
 struct sil24_port_priv {
-	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
+	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
 	struct ata_taskfile tf;			/* Cached taskfile registers */
 };
@@ -244,6 +244,7 @@ struct sil24_host_priv {
 	void __iomem *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
 };
 
+static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u8 sil24_check_status(struct ata_port *ap);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
@@ -297,6 +298,8 @@ static struct scsi_host_template sil24_s
 static const struct ata_port_operations sil24_ops = {
 	.port_disable		= ata_port_disable,
 
+	.dev_config		= sil24_dev_config,
+
 	.check_status		= sil24_check_status,
 	.check_altstatus	= sil24_check_status,
 	.dev_select		= ata_noop_dev_select,
@@ -364,6 +367,16 @@ static struct ata_port_info sil24_port_i
 	},
 };
 
+static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+
+	if (ap->cdb_len == 16)
+		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
+	else
+		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
+}
+
 static inline void sil24_update_tf(struct ata_port *ap)
 {
 	struct sil24_port_priv *pp = ap->private_data;
@@ -419,7 +432,7 @@ static int sil24_issue_SRST(struct ata_p
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
-	struct sil24_prb *prb = &pp->cmd_block[0].prb;
+	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
 	u32 irq_enable, irq_stat;
 	int cnt;
@@ -477,16 +490,11 @@ static void sil24_phy_reset(struct ata_p
 	}
 
 	ap->device->class = ata_dev_classify(&pp->tf);
-
-	/* No ATAPI yet */
-	if (ap->device->class == ATA_DEV_ATAPI)
-		ap->ops->port_disable(ap);
 }
 
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
-				 struct sil24_cmd_block *cb)
+				 struct sil24_sge *sge)
 {
-	struct sil24_sge *sge = cb->sge;
 	struct scatterlist *sg;
 	unsigned int idx = 0;
 
@@ -507,23 +515,47 @@ static void sil24_qc_prep(struct ata_que
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
-	struct sil24_cmd_block *cb = pp->cmd_block + qc->tag;
-	struct sil24_prb *prb = &cb->prb;
+	union sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+	struct sil24_prb *prb;
+	struct sil24_sge *sge;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_PIO:
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
+		prb = &cb->ata.prb;
+		sge = cb->ata.sge;
+		prb->ctrl = 0;
 		break;
+
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_DMA:
+	case ATA_PROT_ATAPI_NODATA:
+		prb = &cb->atapi.prb;
+		sge = cb->atapi.sge;
+		memset(cb->atapi.cdb, 0, 32);
+		memcpy(cb->atapi.cdb, qc->cdb, ap->cdb_len);
+
+		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
+			if (qc->tf.flags & ATA_TFLAG_WRITE)
+				prb->ctrl = PRB_CTRL_PACKET_WRITE;
+			else
+				prb->ctrl = PRB_CTRL_PACKET_READ;
+		} else
+			prb->ctrl = 0;
+
+		break;
+
 	default:
-		/* ATAPI isn't supported yet */
+		prb = NULL;	/* shut up, gcc */
+		sge = NULL;
 		BUG();
 	}
 
 	ata_tf_to_fis(&qc->tf, prb->fis, 0);
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-		sil24_fill_sg(qc, cb);
+		sil24_fill_sg(qc, sge);
 }
 
 static int sil24_qc_issue(struct ata_queued_cmd *qc)
@@ -750,7 +782,7 @@ static int sil24_port_start(struct ata_p
 {
 	struct device *dev = ap->host_set->dev;
 	struct sil24_port_priv *pp;
-	struct sil24_cmd_block *cb;
+	union sil24_cmd_block *cb;
 	size_t cb_size = sizeof(*cb);
 	dma_addr_t cb_dma;
 	int rc = -ENOMEM;
