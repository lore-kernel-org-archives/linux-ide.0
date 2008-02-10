From: Byron Bradley <byron.bbradley@gmail.com>
Subject: [PATCH] sata_mv: platform driver allocs dma without create
Date: Sun, 10 Feb 2008 21:17:30 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0802102117150.9668@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755055AbYBJVR4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, saeed@marvell.com, mlord@pobox.com
List-Id: linux-ide@vger.kernel.org

When the sata_mv driver is used as a platform driver,
mv_create_dma_pools() is never called so it fails when trying
to alloc in mv_pool_start().

Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>
Acked-by: Mark Lord <mlord@pobox.com>
---

Mark, based on the comment from Andrew Morton on the "sata_mv: fix loop
with last port" patch I have changed your Signed-off-by to an Acked-by.
Hopefully thats correct.

 drivers/ata/sata_mv.c |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f5333ce..04b5717 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2881,6 +2881,26 @@ done:
 	return rc;
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
  *      mv_platform_probe - handle a positive probe of an soc Marvell
  *      host
@@ -2934,6 +2954,10 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->base = ioremap(res->start, res->end - res->start + 1);
 	hpriv->base -= MV_SATAHC0_REG_BASE;

+	rc = mv_create_dma_pools(hpriv, &pdev->dev);
+	if (rc)
+		return rc;
+
 	/* initialize adapter */
 	rc = mv_init_host(host, chip_soc);
 	if (rc)
@@ -3070,26 +3094,6 @@ static void mv_print_info(struct ata_host *host)
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }

-static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
-{
-	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
-							     MV_CRQB_Q_SZ, 0);
-	if (!hpriv->crqb_pool)
-		return -ENOMEM;
-
-	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
-							     MV_CRPB_Q_SZ, 0);
-	if (!hpriv->crpb_pool)
-		return -ENOMEM;
-
-	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
-							     MV_SG_TBL_SZ, 0);
-	if (!hpriv->sg_tbl_pool)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /**
  *      mv_pci_init_one - handle a positive probe of a PCI Marvell host
  *      @pdev: PCI device found
-- 
1.5.4.rc2.38.gd6da3
