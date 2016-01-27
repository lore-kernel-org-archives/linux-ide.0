From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v2 3/3] ahci_xgene: Implement the workaround to fix the missing of edge interrupt for HOST_IRQ_STAT.
Date: Wed, 27 Jan 2016 15:19:57 +0530
Message-ID: <1453888197-11368-4-git-send-email-stripathi@apm.com>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453888197-11368-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, svtripathi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Due to H/W errata, the HOST_IRQ_STAT register misses the edge interrupt
when clearing the HOST_IRQ_STAT register and hardware reporting the
PORT_IRQ_STAT register at the same clock cycle.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci_xgene.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 892ec74..60076a3 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -548,6 +548,89 @@ softreset_retry:
 	return rc;
 }

+/**
+ * xgene_ahci_handle_broken_edge_irq - Handle the broken irq.
+ * @ata_host: Host that recieved the irq
+ * @irq_masked: HOST_IRQ_STAT value
+ *
+ * For hardware with broken edge trigger latch
+ * the HOST_IRQ_STAT register misses the edge interrupt
+ * when clearing of HOST_IRQ_STAT register and hardware
+ * reporting the PORT_IRQ_STAT register at the
+ * same clock cycle.
+ * As such, the algorithm below outlines the workaround.
+ *
+ * 1. Read HOST_IRQ_STAT register and save the state.
+ * 2. Clear the HOST_IRQ_STAT register.
+ * 3. Read back the HOST_IRQ_STAT register.
+ * 4. If HOST_IRQ_STAT register equals to zero, then
+ *    traverse the rest of port's PORT_IRQ_STAT register
+ *    to check if an interrupt is triggered at that point else
+ *    go to step 6.
+ * 5. If PORT_IRQ_STAT register of rest ports is not equal to zero
+ *    then update the state of HOST_IRQ_STAT saved in step 1.
+ * 6. Handle port interrupts.
+ * 7. Exit
+ */
+static int xgene_ahci_handle_broken_edge_irq(struct ata_host *host,
+					     u32 irq_masked)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *port_mmio;
+	int i;
+
+	if (!readl(hpriv->mmio + HOST_IRQ_STAT)) {
+		for (i = 0; i < host->n_ports; i++) {
+			if (irq_masked & (1 << i))
+				continue;
+
+			port_mmio = ahci_port_base(host->ports[i]);
+			if (readl(port_mmio + PORT_IRQ_STAT))
+				irq_masked |= (1 << i);
+		}
+	}
+
+	return ahci_handle_port_intr(host, irq_masked);
+}
+
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
+	rc = xgene_ahci_handle_broken_edge_irq(host, irq_masked);
+
+	spin_unlock(&host->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(rc);
+
+}
+
 static struct ata_port_operations xgene_ahci_v1_ops = {
 	.inherits = &ahci_ops,
 	.host_stop = xgene_ahci_host_stop,
@@ -780,6 +863,7 @@ skip_clk_phy:
 		break;
 	case XGENE_AHCI_V2:
 		hpriv->flags |= AHCI_HFLAG_YES_FBS;
+		hpriv->ahci_irq_intr = xgene_ahci_irq_intr;
 		break;
 	default:
 		break;
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
