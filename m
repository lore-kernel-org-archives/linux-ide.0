From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v1 2/2] ahci_xgene: Implement the workaround to fix the missing of edge interrupt for HOST_IRQ_STAT
Date: Thu, 14 Jan 2016 11:00:24 +0530
Message-ID: <1452749424-28919-3-git-send-email-stripathi@apm.com>
References: <1452749424-28919-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:49761 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752238AbcANFbL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2016 00:31:11 -0500
In-Reply-To: <1452749424-28919-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

Due to H/W errata, the HOST_IRQ_STAT register misses the edge interrupt
when clearing the HOST_IRQ_STAT register and hardware reporting the
PORT_IRQ_STAT register at the same clock cycle.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/ata/ahci_xgene.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index e2c6d9e..4df7a00 100644
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
 		hpriv->flags |= AHCI_HFLAG_YES_FBS | AHCI_HFLAG_EDGE_IRQ;
+		hpriv->ahci_irq_intr = xgene_ahci_irq_intr;
 		break;
 	default:
 		break;
--
1.7.1

