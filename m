From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 11/12] sata_mv Introduce per-tag SG tables
Date: Thu, 24 Jan 2008 16:02:59 -0500
Message-ID: <4798FD03.8070206@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1944 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672AbYAXVDA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 16:03:00 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv Introduce per-tag SG tables.

In preparation for supporting NCQ, we must allocate separate SG tables
for each command tag, rather than just a single table per port as before.

Gen-I hardware cannot do NCQ, though, so we still allocate just a single
table for that, but populate it in all 32 slots to avoid special-cases
elsewhere in hotter paths of the code.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 14:17:39.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 14:46:16.000000000 -0500
@@ -395,8 +395,8 @@
 	dma_addr_t		crqb_dma;
 	struct mv_crpb		*crpb;
 	dma_addr_t		crpb_dma;
-	struct mv_sg		*sg_tbl;
-	dma_addr_t		sg_tbl_dma;
+	struct mv_sg		*sg_tbl[MV_MAX_Q_DEPTH];
+	dma_addr_t		sg_tbl_dma[MV_MAX_Q_DEPTH];
 
 	unsigned int		req_idx;
 	unsigned int		resp_idx;
@@ -472,6 +472,10 @@
 			void __iomem *port_mmio, int want_ncq);
 static int __mv_stop_dma(struct ata_port *ap);
 
+/* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
+ * because we have to allow room for worst case splitting of
+ * PRDs for 64K boundaries in mv_fill_sg().
+ */
 static struct scsi_host_template mv5_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -711,12 +715,23 @@
 
 static void mv_free_pool_items(struct ata_port *ap)
 {
+	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp = ap->private_data;
+	int tag;
 
-	if (pp->sg_tbl) {
-		dma_pool_free(mv_sg_tbl_pool, pp->sg_tbl, pp->sg_tbl_dma);
-		pp->sg_tbl = NULL;
+	/*
+	 * For GEN_I, there's no NCQ, so we have only a single sg_tbl.
+	 * For later hardware, we have one unique sg_tbl per NCQ tag.
+	 */
+	for (tag = 0; tag < MV_MAX_Q_DEPTH; ++tag) {
+		if (pp->sg_tbl[tag]) {
+			if (tag == 0 || !IS_GEN_I(hpriv))
+				dma_pool_free(mv_sg_tbl_pool, pp->sg_tbl[tag],
+							pp->sg_tbl_dma[tag]);
+			pp->sg_tbl[tag] = NULL;
+		}
 	}
+
 	if (pp->crqb) {
 		dma_pool_free(mv_crqb_pool, pp->crqb, pp->crqb_dma);
 		pp->crpb = NULL;
@@ -1136,7 +1151,7 @@
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	unsigned long flags;
-	int rc;
+	int tag, rc;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
@@ -1153,10 +1168,21 @@
 	pp->crpb = dma_pool_alloc(mv_crpb_pool, GFP_KERNEL, &pp->crpb_dma);
 	if (!pp->crpb)
 		goto out_alloc_failed;
-
-	pp->sg_tbl = dma_pool_alloc(mv_sg_tbl_pool, GFP_KERNEL, &pp->sg_tbl_dma);
-	if (!pp->sg_tbl)
-		goto out_alloc_failed;
+	/*
+	 * For GEN_I, there's no NCQ, so we only allocate a single sg_tbl.
+	 * For later hardware, we need one unique sg_tbl per NCQ tag.
+	 */
+	for (tag = 0; tag < MV_MAX_Q_DEPTH; ++tag) {
+		if (tag == 0 || !IS_GEN_I(hpriv)) {
+			pp->sg_tbl[tag] = dma_pool_alloc(mv_sg_tbl_pool,
+					      GFP_KERNEL, &pp->sg_tbl_dma[tag]);
+			if (!pp->sg_tbl[tag])
+				goto out_alloc_failed;
+		} else {
+			pp->sg_tbl[tag]     = pp->sg_tbl[0];
+			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
+		}
+	}
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
@@ -1209,7 +1235,7 @@
 	struct mv_sg *mv_sg, *last_sg = NULL;
 	unsigned int si;
 
-	mv_sg = pp->sg_tbl;
+	mv_sg = pp->sg_tbl[qc->tag];
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
@@ -1279,9 +1305,9 @@
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
 
 	pp->crqb[in_index].sg_addr =
-		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
+		cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
 	pp->crqb[in_index].sg_addr_hi =
-		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
+		cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);
 	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
 	cw = &pp->crqb[in_index].ata_cmd[0];
@@ -1372,8 +1398,8 @@
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
 
 	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
-	crqb->addr = cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
+	crqb->addr = cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
+	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
 
 	tf = &qc->tf;
