From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Mon, 31 Mar 2008 19:34:40 -0400
Message-ID: <47F17510.7060902@rtr.ca>
References: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3042 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbYCaXel (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:34:41 -0400
In-Reply-To: <47F1736F.8020104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Clean up uses of mv_stop_edma{_engine}() to match datasheet requirements.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_mv.c	2008-03-31 17:18:15.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-03-31 18:12:56.000000000 -0400
@@ -517,7 +517,7 @@
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
 static int mv_stop_edma(struct ata_port *ap);
-static int mv_stop_edma_engine(struct ata_port *ap);
+static int mv_stop_edma_engine(void __iomem *port_mmio);
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq);
 
 /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
@@ -805,7 +805,7 @@
 	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
 		if (want_ncq != using_ncq)
-			mv_stop_edma_engine(ap);
+			mv_stop_edma(ap);
 	}
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		struct mv_host_priv *hpriv = ap->host->private_data;
@@ -841,57 +841,41 @@
 
 /**
  *      mv_stop_edma_engine - Disable eDMA engine
- *      @ap: ATA channel to manipulate
- *
- *      Verify the local cache of the eDMA state is accurate with a
- *      WARN_ON.
+ *      @port_mmio: io base address
  *
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_stop_edma_engine(struct ata_port *ap)
+static int mv_stop_edma_engine(void __iomem *port_mmio)
 {
-	void __iomem *port_mmio = mv_ap_base(ap);
-	struct mv_port_priv *pp	= ap->private_data;
-	u32 reg;
-	int i, err = 0;
+	int i;
 
-	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
-		/* Disable EDMA if active.   The disable bit auto clears.
-		 */
-		writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
-		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-	} else {
-		WARN_ON(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS));
-	}
+	/* Disable eDMA.  The disable bit auto clears. */
+	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 
-	/* now properly wait for the eDMA to stop */
-	for (i = 1000; i > 0; i--) {
-		reg = readl(port_mmio + EDMA_CMD_OFS);
+	/* Wait for the chip to confirm eDMA is off. */
+	for (i = 10000; i > 0; i--) {
+		u32 reg = readl(port_mmio + EDMA_CMD_OFS);
 		if (!(reg & EDMA_EN))
-			break;
-
-		udelay(100);
-	}
-
-	if (reg & EDMA_EN) {
-		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
-		err = -EIO;
+			return 0;
+		udelay(10);
 	}
-
-	return err;
+	return -EIO;
 }
 
 static int mv_stop_edma(struct ata_port *ap)
 {
-	unsigned long flags;
-	int rc;
-
-	spin_lock_irqsave(&ap->host->lock, flags);
-	rc = mv_stop_edma_engine(ap);
-	spin_unlock_irqrestore(&ap->host->lock, flags);
+	void __iomem *port_mmio = mv_ap_base(ap);
+	struct mv_port_priv *pp = ap->private_data;
 
-	return rc;
+	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
+		return 0;
+	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+	if (mv_stop_edma_engine(port_mmio)) {
+		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
+		return -EIO;
+	}
+	return 0;
 }
 
 #ifdef ATA_DEBUG
@@ -1401,7 +1385,7 @@
 		 * port.  Turn off EDMA so there won't be problems accessing
 		 * shadow block, etc registers.
 		 */
-		mv_stop_edma_engine(ap);
+		mv_stop_edma(ap);
 		return ata_qc_issue_prot(qc);
 	}
 
@@ -1915,8 +1899,12 @@
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port);
 
-	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
-
+	/*
+	 * The datasheet warns against setting ATA_RST when EDMA is active
+	 * (but doesn't say what the problem might be).  So we first try
+	 * to disable the EDMA engine before doing the ATA_RST operation.
+	 */
+	mv_stop_edma_engine(port_mmio);
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);	/* command */
@@ -2191,8 +2179,12 @@
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port);
 
-	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
-
+	/*
+	 * The datasheet warns against setting ATA_RST when EDMA is active
+	 * (but doesn't say what the problem might be).  So we first try
+	 * to disable the EDMA engine before doing the ATA_RST operation.
+	 */
+	mv_stop_edma_engine(port_mmio);
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);		/* command */
@@ -2250,6 +2242,10 @@
 	return;
 }
 
+/*
+ * Caller must ensure that EDMA is not active,
+ * by first doing mv_stop_edma() where needed.
+ */
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no)
 {
@@ -2392,10 +2388,11 @@
 {
 	struct ata_port *ap = link->ap;
 	struct mv_host_priv *hpriv = ap->host->private_data;
+	struct mv_port_priv *pp = ap->private_data;
 	void __iomem *mmio = hpriv->base;
 
-	mv_stop_edma(ap);
 	mv_reset_channel(hpriv, mmio, ap->port_no);
+	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	mv_phy_reset(ap, class, deadline);
 
 	return 0;
