From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Tue, 29 Jan 2008 13:24:00 -0500
Message-ID: <479F6F40.7040401@rtr.ca>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1901 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbYA2SYB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jan 2008 13:24:01 -0500
In-Reply-To: <479F5E1F.8030508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Create host-owned DMA memory pools, for use in allocating/freeing 
>> per-port
>> command/response queues and SG tables.  This gives us a way to 
>> guarantee we
>> meet the hardware address alignment requirements, and also reduces 
>> memory that
>> might otherwise be wasted on alignment gaps.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> ACK patches 1-13
> 
> applied patches 1-9 to #upstream.  patch #10 failed, with git-am 
> reporting it as a corrupt patch.
..

That's weird.  I can save the email from linux-ide here,
and apply as a patch (after 01-09) with no issues at all.

Jeff got mail reader problems?

Here it is again, in case it got corrupted in transit to you.

* * * *

In preparation for supporting NCQ, we must allocate separate SG tables
for each command tag, rather than just a single table per port as before.

Gen-I hardware cannot do NCQ, though, so we still allocate just a single
table for that, but populate it in all 32 slots to avoid special-cases
elsewhere in hotter paths of the code.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-26 14:18:05.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 14:19:12.000000000 -0500
@@ -398,8 +398,8 @@
 	dma_addr_t		crqb_dma;
 	struct mv_crpb		*crpb;
 	dma_addr_t		crpb_dma;
-	struct mv_sg		*sg_tbl;
-	dma_addr_t		sg_tbl_dma;
+	struct mv_sg		*sg_tbl[MV_MAX_Q_DEPTH];
+	dma_addr_t		sg_tbl_dma[MV_MAX_Q_DEPTH];
 
 	unsigned int		req_idx;
 	unsigned int		resp_idx;
@@ -483,6 +483,10 @@
 			void __iomem *port_mmio, int want_ncq);
 static int __mv_stop_dma(struct ata_port *ap);
 
+/* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
+ * because we have to allow room for worst case splitting of
+ * PRDs for 64K boundaries in mv_fill_sg().
+ */
 static struct scsi_host_template mv5_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -1107,6 +1111,7 @@
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp = ap->private_data;
+	int tag;
 
 	if (pp->crqb) {
 		dma_pool_free(hpriv->crqb_pool, pp->crqb, pp->crqb_dma);
@@ -1116,9 +1121,18 @@
 		dma_pool_free(hpriv->crpb_pool, pp->crpb, pp->crpb_dma);
 		pp->crpb = NULL;
 	}
-	if (pp->sg_tbl) {
-		dma_pool_free(hpriv->sg_tbl_pool, pp->sg_tbl, pp->sg_tbl_dma);
-		pp->sg_tbl = NULL;
+	/*
+	 * For GEN_I, there's no NCQ, so we have only a single sg_tbl.
+	 * For later hardware, we have one unique sg_tbl per NCQ tag.
+	 */
+	for (tag = 0; tag < MV_MAX_Q_DEPTH; ++tag) {
+		if (pp->sg_tbl[tag]) {
+			if (tag == 0 || !IS_GEN_I(hpriv))
+				dma_pool_free(hpriv->sg_tbl_pool,
+					      pp->sg_tbl[tag],
+					      pp->sg_tbl_dma[tag]);
+			pp->sg_tbl[tag] = NULL;
+		}
 	}
 }
 
@@ -1139,7 +1153,7 @@
 	struct mv_port_priv *pp;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	unsigned long flags;
-	int rc;
+	int tag, rc;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
@@ -1160,10 +1174,21 @@
 		goto out_port_free_dma_mem;
 	memset(pp->crpb, 0, MV_CRPB_Q_SZ);
 
-	pp->sg_tbl = dma_pool_alloc(hpriv->sg_tbl_pool, GFP_KERNEL,
-							      &pp->sg_tbl_dma);
-	if (!pp->sg_tbl)
-		goto out_port_free_dma_mem;
+	/*
+	 * For GEN_I, there's no NCQ, so we only allocate a single sg_tbl.
+	 * For later hardware, we need one unique sg_tbl per NCQ tag.
+	 */
+	for (tag = 0; tag < MV_MAX_Q_DEPTH; ++tag) {
+		if (tag == 0 || !IS_GEN_I(hpriv)) {
+			pp->sg_tbl[tag] = dma_pool_alloc(hpriv->sg_tbl_pool,
+					      GFP_KERNEL, &pp->sg_tbl_dma[tag]);
+			if (!pp->sg_tbl[tag])
+				goto out_port_free_dma_mem;
+		} else {
+			pp->sg_tbl[tag]     = pp->sg_tbl[0];
+			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
+		}
+	}
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 
@@ -1213,7 +1238,7 @@
	struct mv_sg *mv_sg, *last_sg = NULL;
	unsigned int si;
 
-	mv_sg = pp->sg_tbl;
+	mv_sg = pp->sg_tbl[qc->tag];
	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
@@ -1283,9 +1308,9 @@
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
 
 	pp->crqb[in_index].sg_addr =
-		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
+		cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
 	pp->crqb[in_index].sg_addr_hi =
-		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
+		cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);
 	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
 	cw = &pp->crqb[in_index].ata_cmd[0];
@@ -1376,8 +1401,8 @@
 	in_index = pp->req_idx & MV_MAX_Q_DEPTH_MASK;
 
 	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
-	crqb->addr = cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
+	crqb->addr = cpu_to_le32(pp->sg_tbl_dma[qc->tag] & 0xffffffff);
+	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma[qc->tag] >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
 
 	tf = &qc->tf;
