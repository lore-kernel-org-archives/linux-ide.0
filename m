From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/23] libata-sff: prd is BMDMA specific
Date: Mon, 10 May 2010 21:41:41 +0200
Message-ID: <1273520507-32459-18-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44969 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0EJTmm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:42 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

struct ata_prd and ap->prd are BMDMA specific.  Add bmdma_ prefix to
them and move them inside CONFIG_ATA_SFF.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c   |   27 +++++++++++++++------------
 drivers/ata/pata_ns87415.c |    2 +-
 drivers/ata/pata_scc.c     |    4 ++--
 drivers/ata/sata_nv.c      |    4 ++--
 drivers/ata/sata_promise.c |   21 +++++++++++----------
 drivers/ata/sata_sil.c     |    6 +++---
 drivers/ata/sata_svw.c     |    2 +-
 include/linux/ata.h        |    2 +-
 include/linux/libata.h     |    5 ++---
 9 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 3dba070..f0e4a5e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2630,6 +2630,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
 static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_bmdma_prd *prd = ap->bmdma_prd;
 	struct scatterlist *sg;
 	unsigned int si, pi;
 
@@ -2651,8 +2652,8 @@ static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 			if ((offset + sg_len) > 0x10000)
 				len = 0x10000 - offset;
 
-			ap->prd[pi].addr = cpu_to_le32(addr);
-			ap->prd[pi].flags_len = cpu_to_le32(len & 0xffff);
+			prd[pi].addr = cpu_to_le32(addr);
+			prd[pi].flags_len = cpu_to_le32(len & 0xffff);
 			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
@@ -2661,7 +2662,7 @@ static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 		}
 	}
 
-	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 /**
@@ -2680,6 +2681,7 @@ static void ata_bmdma_fill_sg(struct ata_queued_cmd *qc)
 static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_bmdma_prd *prd = ap->bmdma_prd;
 	struct scatterlist *sg;
 	unsigned int si, pi;
 
@@ -2702,16 +2704,16 @@ static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
 				len = 0x10000 - offset;
 
 			blen = len & 0xffff;
-			ap->prd[pi].addr = cpu_to_le32(addr);
+			prd[pi].addr = cpu_to_le32(addr);
 			if (blen == 0) {
 				/* Some PATA chipsets like the CS5530 can't
 				   cope with 0x0000 meaning 64K as the spec
 				   says */
-				ap->prd[pi].flags_len = cpu_to_le32(0x8000);
+				prd[pi].flags_len = cpu_to_le32(0x8000);
 				blen = 0x8000;
-				ap->prd[++pi].addr = cpu_to_le32(addr + 0x8000);
+				prd[++pi].addr = cpu_to_le32(addr + 0x8000);
 			}
-			ap->prd[pi].flags_len = cpu_to_le32(blen);
+			prd[pi].flags_len = cpu_to_le32(blen);
 			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
 			pi++;
@@ -2720,7 +2722,7 @@ static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
 		}
 	}
 
-	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 /**
@@ -2852,7 +2854,7 @@ void ata_bmdma_setup(struct ata_queued_cmd *qc)
 
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
-	iowrite32(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+	iowrite32(ap->bmdma_prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
 	/* specify data direction, triple-check start bit is clear */
 	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
@@ -2957,9 +2959,10 @@ EXPORT_SYMBOL_GPL(ata_bmdma_status);
 int ata_bmdma_port_start(struct ata_port *ap)
 {
 	if (ap->mwdma_mask || ap->udma_mask) {
-		ap->prd = dmam_alloc_coherent(ap->host->dev, ATA_PRD_TBL_SZ,
-					      &ap->prd_dma, GFP_KERNEL);
-		if (!ap->prd)
+		ap->bmdma_prd =
+			dmam_alloc_coherent(ap->host->dev, ATA_PRD_TBL_SZ,
+					    &ap->bmdma_prd_dma, GFP_KERNEL);
+		if (!ap->bmdma_prd)
 			return -ENOMEM;
 	}
 
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 830431f..fdbba2d 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -126,7 +126,7 @@ static void ns87415_bmdma_setup(struct ata_queued_cmd *qc)
 
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
-	iowrite32(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+	iowrite32(ap->bmdma_prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
 	/* specify data direction, triple-check start bit is clear */
 	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index abbe05a..9a65c5e 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -430,7 +430,7 @@ static void scc_bmdma_setup (struct ata_queued_cmd *qc)
 	void __iomem *mmio = ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr */
-	out_be32(mmio + SCC_DMA_TABLE_OFS, ap->prd_dma);
+	out_be32(mmio + SCC_DMA_TABLE_OFS, ap->bmdma_prd_dma);
 
 	/* specify data direction, triple-check start bit is clear */
 	dmactl = in_be32(mmio + SCC_DMA_CMD);
@@ -943,7 +943,7 @@ static int scc_port_start (struct ata_port *ap)
 	if (rc)
 		return rc;
 
-	out_be32(mmio + SCC_DMA_PTERADD, ap->prd_dma);
+	out_be32(mmio + SCC_DMA_PTERADD, ap->bmdma_prd_dma);
 	return 0;
 }
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 71168e8..23dbde8 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -272,7 +272,7 @@ enum ncq_saw_flag_list {
 };
 
 struct nv_swncq_port_priv {
-	struct ata_prd	*prd;	 /* our SG list */
+	struct ata_bmdma_prd *prd;	 /* our SG list */
 	dma_addr_t	prd_dma; /* and its DMA mapping */
 	void __iomem	*sactive_block;
 	void __iomem	*irq_block;
@@ -2027,7 +2027,7 @@ static void nv_swncq_fill_sg(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
 	struct nv_swncq_port_priv *pp = ap->private_data;
-	struct ata_prd *prd;
+	struct ata_bmdma_prd *prd;
 	unsigned int si, idx;
 
 	prd = pp->prd + ATA_MAX_PRD * qc->tag;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 09a6179..f03ad48 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -500,7 +500,7 @@ static int pdc_sata_scr_write(struct ata_link *link,
 static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	dma_addr_t sg_table = ap->prd_dma;
+	dma_addr_t sg_table = ap->bmdma_prd_dma;
 	unsigned int cdb_len = qc->dev->cdb_len;
 	u8 *cdb = qc->cdb;
 	struct pdc_port_priv *pp = ap->private_data;
@@ -588,6 +588,7 @@ static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 static void pdc_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_bmdma_prd *prd = ap->bmdma_prd;
 	struct scatterlist *sg;
 	const u32 SG_COUNT_ASIC_BUG = 41*4;
 	unsigned int si, idx;
@@ -614,8 +615,8 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 			if ((offset + sg_len) > 0x10000)
 				len = 0x10000 - offset;
 
-			ap->prd[idx].addr = cpu_to_le32(addr);
-			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
+			prd[idx].addr = cpu_to_le32(addr);
+			prd[idx].flags_len = cpu_to_le32(len & 0xffff);
 			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
 
 			idx++;
@@ -624,27 +625,27 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 		}
 	}
 
-	len = le32_to_cpu(ap->prd[idx - 1].flags_len);
+	len = le32_to_cpu(prd[idx - 1].flags_len);
 
 	if (len > SG_COUNT_ASIC_BUG) {
 		u32 addr;
 
 		VPRINTK("Splitting last PRD.\n");
 
-		addr = le32_to_cpu(ap->prd[idx - 1].addr);
-		ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
+		addr = le32_to_cpu(prd[idx - 1].addr);
+		prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
 		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
 
 		addr = addr + len - SG_COUNT_ASIC_BUG;
 		len = SG_COUNT_ASIC_BUG;
-		ap->prd[idx].addr = cpu_to_le32(addr);
-		ap->prd[idx].flags_len = cpu_to_le32(len);
+		prd[idx].addr = cpu_to_le32(addr);
+		prd[idx].flags_len = cpu_to_le32(len);
 		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
 
 		idx++;
 	}
 
-	ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
@@ -659,7 +660,7 @@ static void pdc_qc_prep(struct ata_queued_cmd *qc)
 		pdc_fill_sg(qc);
 		/*FALLTHROUGH*/
 	case ATA_PROT_NODATA:
-		i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,
+		i = pdc_pkt_header(&qc->tf, qc->ap->bmdma_prd_dma,
 				   qc->dev->devno, pp->pkt);
 		if (qc->tf.flags & ATA_TFLAG_LBA48)
 			i = pdc_prep_lba48(&qc->tf, pp->pkt, i);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 9c367f7..2dda312 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -284,7 +284,7 @@ static void sil_bmdma_setup(struct ata_queued_cmd *qc)
 	void __iomem *bmdma = ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr. */
-	iowrite32(ap->prd_dma, bmdma + ATA_DMA_TABLE_OFS);
+	iowrite32(ap->bmdma_prd_dma, bmdma + ATA_DMA_TABLE_OFS);
 
 	/* issue r/w command */
 	ap->ops->sff_exec_command(ap, &qc->tf);
@@ -311,10 +311,10 @@ static void sil_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
-	struct ata_prd *prd, *last_prd = NULL;
+	struct ata_bmdma_prd *prd, *last_prd = NULL;
 	unsigned int si;
 
-	prd = &ap->prd[0];
+	prd = &ap->bmdma_prd[0];
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		/* Note h/w doesn't support 64-bit, so we unconditionally
 		 * truncate dma_addr_t to u32.
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 7257f2d..101fd6a 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -224,7 +224,7 @@ static void k2_bmdma_setup_mmio(struct ata_queued_cmd *qc)
 
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
-	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+	writel(ap->bmdma_prd_dma, mmio + ATA_DMA_TABLE_OFS);
 
 	/* specify data direction, triple-check start bit is clear */
 	dmactl = readb(mmio + ATA_DMA_CMD);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 700c5b9..fe6e681 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -467,7 +467,7 @@ enum ata_ioctls {
 
 /* core structures */
 
-struct ata_prd {
+struct ata_bmdma_prd {
 	__le32			addr;
 	__le32			flags_len;
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61ff9a1..b220451 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -716,14 +716,13 @@ struct ata_port {
 	unsigned int		print_id; /* user visible unique port ID */
 	unsigned int		port_no; /* 0 based port no. inside the host */
 
-	struct ata_prd		*prd;	 /* our SG list */
-	dma_addr_t		prd_dma; /* and its DMA mapping */
-
 #ifdef CONFIG_ATA_SFF
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
 	struct delayed_work	sff_pio_task;
+	struct ata_bmdma_prd	*bmdma_prd;	/* BMDMA SG list */
+	dma_addr_t		bmdma_prd_dma;	/* and its DMA mapping */
 #endif /* CONFIG_ATA_SFF */
 
 	unsigned int		pio_mask;
-- 
1.6.4.2

