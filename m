From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Sat, 26 Jan 2008 18:32:45 -0500
Message-ID: <479BC31D.1050206@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3068 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbYAZXcq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:32:46 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Create host-owned DMA memory pools, for use in allocating/freeing per-port
command/response queues and SG tables.  This gives us a way to guarantee we
meet the hardware address alignment requirements, and also reduces memory that
might otherwise be wasted on alignment gaps.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-26 12:50:54.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 13:01:56.000000000 -0500
@@ -107,14 +107,12 @@
 
 	/* CRQB needs alignment on a 1KB boundary. Size == 1KB
 	 * CRPB needs alignment on a 256B boundary. Size == 256B
-	 * SG count of 176 leads to MV_PORT_PRIV_DMA_SZ == 4KB
 	 * ePRD (SG) entries need alignment on a 16B boundary. Size == 16B
 	 */
 	MV_CRQB_Q_SZ		= (32 * MV_MAX_Q_DEPTH),
 	MV_CRPB_Q_SZ		= (8 * MV_MAX_Q_DEPTH),
-	MV_MAX_SG_CT		= 176,
+	MV_MAX_SG_CT		= 256,
 	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
-	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
 
 	MV_PORTS_PER_HC		= 4,
 	/* == (port / MV_PORTS_PER_HC) to determine HC from 0-7 port */
@@ -421,6 +419,14 @@
 	u32			irq_cause_ofs;
 	u32			irq_mask_ofs;
 	u32			unmask_all_irqs;
+	/*
+	 * These consistent DMA memory pools give us guaranteed
+	 * alignment for hardware-accessed data structures,
+	 * and less memory waste in accomplishing the alignment.
+	 */
+	struct dma_pool		*crqb_pool;
+	struct dma_pool		*crpb_pool;
+	struct dma_pool		*sg_tbl_pool;
 };
 
 struct mv_hw_ops {
@@ -1097,6 +1103,25 @@
 	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
 }
 
+static void mv_port_free_dma_mem(struct ata_port *ap)
+{
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	struct mv_port_priv *pp = ap->private_data;
+
+	if (pp->crqb) {
+		dma_pool_free(hpriv->crqb_pool, pp->crqb, pp->crqb_dma);
+		pp->crqb = NULL;
+	}
+	if (pp->crpb) {
+		dma_pool_free(hpriv->crpb_pool, pp->crpb, pp->crpb_dma);
+		pp->crpb = NULL;
+	}
+	if (pp->sg_tbl) {
+		dma_pool_free(hpriv->sg_tbl_pool, pp->sg_tbl, pp->sg_tbl_dma);
+		pp->sg_tbl = NULL;
+	}
+}
+
 /**
  *      mv_port_start - Port specific init/start routine.
  *      @ap: ATA channel to manipulate
@@ -1113,51 +1138,36 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
-	void *mem;
-	dma_addr_t mem_dma;
 	unsigned long flags;
 	int rc;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
-
-	mem = dmam_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
-				  GFP_KERNEL);
-	if (!mem)
-		return -ENOMEM;
-	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
+	ap->private_data = pp;
 
 	rc = ata_pad_alloc(ap, dev);
 	if (rc)
 		return rc;
 
-	/* First item in chunk of DMA memory:
-	 * 32-slot command request table (CRQB), 32 bytes each in size
-	 */
-	pp->crqb = mem;
-	pp->crqb_dma = mem_dma;
-	mem += MV_CRQB_Q_SZ;
-	mem_dma += MV_CRQB_Q_SZ;
-
-	/* Second item:
-	 * 32-slot command response table (CRPB), 8 bytes each in size
-	 */
-	pp->crpb = mem;
-	pp->crpb_dma = mem_dma;
-	mem += MV_CRPB_Q_SZ;
-	mem_dma += MV_CRPB_Q_SZ;
+	pp->crqb = dma_pool_alloc(hpriv->crqb_pool, GFP_KERNEL, &pp->crqb_dma);
+	if (!pp->crqb)
+		return -ENOMEM;
+	memset(pp->crqb, 0, MV_CRQB_Q_SZ);
 
-	/* Third item:
-	 * Table of scatter-gather descriptors (ePRD), 16 bytes each
-	 */
-	pp->sg_tbl = mem;
-	pp->sg_tbl_dma = mem_dma;
+	pp->crpb = dma_pool_alloc(hpriv->crpb_pool, GFP_KERNEL, &pp->crpb_dma);
+	if (!pp->crpb)
+		goto out_port_free_dma_mem;
+	memset(pp->crpb, 0, MV_CRPB_Q_SZ);
+
+	pp->sg_tbl = dma_pool_alloc(hpriv->sg_tbl_pool, GFP_KERNEL,
+							      &pp->sg_tbl_dma);
+	if (!pp->sg_tbl)
+		goto out_port_free_dma_mem;
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
 	mv_edma_cfg(pp, hpriv, port_mmio, 0);
-
 	mv_set_edma_ptrs(port_mmio, hpriv, pp);
 
 	spin_unlock_irqrestore(&ap->host->lock, flags);
@@ -1166,8 +1176,11 @@
 	 * we'll be unable to send non-data, PIO, etc due to restricted access
 	 * to shadow regs.
 	 */
-	ap->private_data = pp;
 	return 0;
+
+out_port_free_dma_mem:
+	mv_port_free_dma_mem(ap);
+	return -ENOMEM;
 }
 
 /**
@@ -1182,6 +1195,7 @@
 static void mv_port_stop(struct ata_port *ap)
 {
 	mv_stop_dma(ap);
+	mv_port_free_dma_mem(ap);
 }
 
 /**
@@ -2765,6 +2779,26 @@
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
+static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
+{
+	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
+							     MV_CRQB_Q_SZ, 0);
+	if (!hpriv->crqb_pool)
+		return -ENOMEM;
+
+	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
+							     MV_CRPB_Q_SZ, 0);
+	if (!hpriv->crpb_pool)
+		return -ENOMEM;
+
+	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
+							     MV_SG_TBL_SZ, 0);
+	if (!hpriv->sg_tbl_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  *      mv_init_one - handle a positive probe of a Marvell host
  *      @pdev: PCI device found
@@ -2810,6 +2844,10 @@
 	if (rc)
 		return rc;
 
+	rc = mv_create_dma_pools(hpriv, &pdev->dev);
+	if (rc)
+		return rc;
+
 	/* initialize adapter */
 	rc = mv_init_host(host, board_idx);
 	if (rc)
