From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 10/14] sata_mv Use DMA memory pools for hardware memory tables
Date: Thu, 24 Jan 2008 16:02:25 -0500
Message-ID: <4798FCE1.30702@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1934 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756444AbYAXVC0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 16:02:26 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv Use DMA memory pools for hardware memory tables.

Create module-owned DMA memory pools, for use in allocating/freeing per-port
command/response queues and SG tables.  This gives us a way to guarantee we
meet the hardware address alignment requirements, and also reduces memory that
might otherwise be wasted on alignment gaps.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 12:40:10.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 14:17:39.000000000 -0500
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
@@ -701,6 +699,33 @@
  */
 static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
 
+/*
+ * These consistent DMA memory pools are owned by this module,
+ * and shared among all device instances.  This gives us guaranteed
+ * alignment for hardware-accessed data structures, and low memory
+ * waste in accomplishing the alignment.
+ */
+static struct dma_pool *mv_crpb_pool;
+static struct dma_pool *mv_crqb_pool;
+static struct dma_pool *mv_sg_tbl_pool;
+
+static void mv_free_pool_items(struct ata_port *ap)
+{
+	struct mv_port_priv *pp = ap->private_data;
+
+	if (pp->sg_tbl) {
+		dma_pool_free(mv_sg_tbl_pool, pp->sg_tbl, pp->sg_tbl_dma);
+		pp->sg_tbl = NULL;
+	}
+	if (pp->crqb) {
+		dma_pool_free(mv_crqb_pool, pp->crqb, pp->crqb_dma);
+		pp->crpb = NULL;
+	}
+	if (pp->crqb) {
+		dma_pool_free(mv_crqb_pool, pp->crqb, pp->crqb_dma);
+		pp->crqb = NULL;
+	}
+}
 
 /* move to PCI layer or libata core? */
 static int pci_go_64(struct pci_dev *pdev)
@@ -1110,8 +1135,6 @@
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
-	void *mem;
-	dma_addr_t mem_dma;
 	unsigned long flags;
 	int rc;
 
@@ -1119,37 +1142,21 @@
 	if (!pp)
 		return -ENOMEM;
 
-	mem = dmam_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
-				  GFP_KERNEL);
-	if (!mem)
-		return -ENOMEM;
-	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
-
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
-
-	/* Third item:
-	 * Table of scatter-gather descriptors (ePRD), 16 bytes each
-	 */
-	pp->sg_tbl = mem;
-	pp->sg_tbl_dma = mem_dma;
+	pp->crqb = dma_pool_alloc(mv_crqb_pool, GFP_KERNEL, &pp->crqb_dma);
+	if (!pp->crqb)
+		goto out_alloc_failed;
+
+	pp->crpb = dma_pool_alloc(mv_crpb_pool, GFP_KERNEL, &pp->crpb_dma);
+	if (!pp->crpb)
+		goto out_alloc_failed;
+
+	pp->sg_tbl = dma_pool_alloc(mv_sg_tbl_pool, GFP_KERNEL, &pp->sg_tbl_dma);
+	if (!pp->sg_tbl)
+		goto out_alloc_failed;
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
@@ -1165,6 +1172,10 @@
 	 */
 	ap->private_data = pp;
 	return 0;
+
+out_alloc_failed:
+	mv_free_pool_items(ap);
+	return -ENOMEM;
 }
 
 /**
@@ -1179,6 +1190,7 @@
 static void mv_port_stop(struct ata_port *ap)
 {
 	mv_stop_dma(ap);
+	mv_free_pool_items(ap);
 }
 
 /**
@@ -2825,14 +2837,39 @@
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
 
+static void mv_destroy_pools(void)
+{
+	if (mv_sg_tbl_pool)
+		dma_pool_destroy(mv_sg_tbl_pool);
+	if (mv_crpb_pool)
+		dma_pool_destroy(mv_crpb_pool);
+	if (mv_crqb_pool)
+		dma_pool_destroy(mv_crqb_pool);
+}
+
 static int __init mv_init(void)
 {
+	/* Ideally, a device (second parameter) would "own" these pools.
+	 * But for maximum memory efficiency, we really need one global
+	 * set of each, shared among all like devices.  As below.
+	 */
+	mv_crqb_pool = dma_pool_create("mv_crqb_q", NULL, MV_CRQB_Q_SZ,
+					MV_CRQB_Q_SZ, 0);
+	mv_crpb_pool = dma_pool_create("mv_crpb_q", NULL, MV_CRPB_Q_SZ,
+					MV_CRPB_Q_SZ, 0);
+	mv_sg_tbl_pool = dma_pool_create("mv_sg_tbl", NULL, MV_SG_TBL_SZ,
+					  MV_SG_TBL_SZ, 0);
+	if (!mv_crqb_pool || !mv_crpb_pool || !mv_sg_tbl_pool) {
+		mv_destroy_pools();
+		return -ENOMEM;
+	}
 	return pci_register_driver(&mv_pci_driver);
 }
 
 static void __exit mv_exit(void)
 {
 	pci_unregister_driver(&mv_pci_driver);
+	mv_destroy_pools();
 }
 
 MODULE_AUTHOR("Brett Russ");
