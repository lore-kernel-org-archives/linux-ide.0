From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v2 1/3] ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
Date: Wed, 27 Jan 2016 15:19:55 +0530
Message-ID: <1453888197-11368-2-git-send-email-stripathi@apm.com>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453888197-11368-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, svtripathi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch removes the AHCI_HFLAG_EDGE_IRQ support from libahci.
The upcoming patches will have the flexibility to override
irq handlers in the LLD's. Controller's implementing a EDGE trigger
latch can implement their own interrupt handler inside the driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci.h       |    3 +--
 drivers/ata/ahci_xgene.c |    2 +-
 drivers/ata/libahci.c    |   40 ----------------------------------------
 3 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a4faa43..e9b57e8 100644
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
index e2c6d9e..892ec74 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -779,7 +779,7 @@ skip_clk_phy:
 		hpriv->flags = AHCI_HFLAG_NO_NCQ;
 		break;
 	case XGENE_AHCI_V2:
-		hpriv->flags |= AHCI_HFLAG_YES_FBS | AHCI_HFLAG_EDGE_IRQ;
+		hpriv->flags |= AHCI_HFLAG_YES_FBS;
 		break;
 	default:
 		break;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index eda3cf2..08be136 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1843,43 +1843,6 @@ static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 	return handled;
 }

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
@@ -2507,9 +2470,6 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)

 	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
 		rc = ahci_host_activate_multi_irqs(host, sht);
-	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
-		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
-				       IRQF_SHARED, sht);
 	else
 		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
 				       IRQF_SHARED, sht);
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
