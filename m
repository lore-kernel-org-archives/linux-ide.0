From: suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v3 2/3] libahci: ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
Date: Fri,  5 Feb 2016 02:50:25 +0530
Message-ID: <1454620826-22554-3-git-send-email-stripathi@apm.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454620826-22554-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>

This patch removes the AHCI_HFLAG_EDGE_IRQ support from libahci.
The flexibility to override the irq handlers in the LLD's are
already present, so controller's implementing a EDGE triger latch
can implement their own interrupt handler inside the driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci.h       |    3 +--
 drivers/ata/ahci_xgene.c |   40 +++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c    |   44 ++------------------------------------------
 3 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 3d883ee..284ce3a 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -240,8 +240,7 @@ enum {
 						        error-handling stage) */
 	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
 	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
-	AHCI_HFLAG_EDGE_IRQ		= (1 << 19), /* HOST_IRQ_STAT behaves as
-							Edge Triggered */
+
 #ifdef CONFIG_PCI_MSI
 	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* multiple PCI MSIs */
 	AHCI_HFLAG_MULTI_MSIX		= (1 << 21), /* per-port MSI-X */
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index e2c6d9e..a56ceeb 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -548,6 +548,43 @@ softreset_retry:
 	return rc;
 }

+static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int rc = 0;
+	void __iomem *mmio;
+	u32 irq_stat, irq_masked;
+
+	VPRINTK("ENTER\n");
+
+	hpriv = host->private_data;
+	mmio = hpriv->mmio;
+
+	/* sigh.  0xffffffff is a valid return from h/w */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_stat)
+		return IRQ_NONE;
+
+	irq_masked = irq_stat & hpriv->port_map;
+
+	spin_lock(&host->lock);
+
+	/*
+	 * HOST_IRQ_STAT behaves as edge triggered latch meaning that
+	 * it should be cleared before all the port events are cleared.
+	 */
+	writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+	rc = ahci_handle_port_intr(host, irq_masked);
+
+	spin_unlock(&host->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(rc);
+}
+
 static struct ata_port_operations xgene_ahci_v1_ops = {
 	.inherits = &ahci_ops,
 	.host_stop = xgene_ahci_host_stop,
@@ -779,7 +816,8 @@ skip_clk_phy:
 		hpriv->flags = AHCI_HFLAG_NO_NCQ;
 		break;
 	case XGENE_AHCI_V2:
-		hpriv->flags |= AHCI_HFLAG_YES_FBS | AHCI_HFLAG_EDGE_IRQ;
+		hpriv->flags |= AHCI_HFLAG_YES_FBS;
+		hpriv->ahci_irq_intr = xgene_ahci_irq_intr;
 		break;
 	default:
 		break;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 5d3035a..424d2b3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1844,43 +1844,6 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 }
 EXPORT_SYMBOL_GPL(ahci_handle_port_intr);

-static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance)
-{
-	struct ata_host *host = dev_instance;
-	struct ahci_host_priv *hpriv;
-	unsigned int rc = 0;
-	void __iomem *mmio;
-	u32 irq_stat, irq_masked;
-
-	VPRINTK("ENTER\n");
-
-	hpriv = host->private_data;
-	mmio = hpriv->mmio;
-
-	/* sigh.  0xffffffff is a valid return from h/w */
-	irq_stat = readl(mmio + HOST_IRQ_STAT);
-	if (!irq_stat)
-		return IRQ_NONE;
-
-	irq_masked = irq_stat & hpriv->port_map;
-
-	spin_lock(&host->lock);
-
-	/*
-	 * HOST_IRQ_STAT behaves as edge triggered latch meaning that
-	 * it should be cleared before all the port events are cleared.
-	 */
-	writel(irq_stat, mmio + HOST_IRQ_STAT);
-
-	rc = ahci_handle_port_intr(host, irq_masked);
-
-	spin_unlock(&host->lock);
-
-	VPRINTK("EXIT\n");
-
-	return IRQ_RETVAL(rc);
-}
-
 static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
@@ -2517,11 +2480,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 				 and custom irq handler implemented\n");

 	} else {
-		if (!ahci_irq_handler) {
-			ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
-			 		    ahci_single_edge_irq_intr :
-					    ahci_single_level_irq_intr);
-		}
+		if (!ahci_irq_handler)
+			ahci_irq_handler = ahci_single_level_irq_intr;
 	}

 	rc = ata_host_activate(host, irq, ahci_irq_handler,
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
