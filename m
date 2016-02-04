From: suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 3/3] ahci_xgene: Implement the workaround to fix the missing of edge interrupt for HOST_IRQ_STAT.
Date: Fri,  5 Feb 2016 02:50:26 +0530
Message-ID: <1454620826-22554-4-git-send-email-stripathi@apm.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:60064 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752559AbcBDVVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 16:21:16 -0500
In-Reply-To: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

From: Suman Tripathi <stripathi@apm.com>

Due to H/W errata, the HOST_IRQ_STAT register misses the edge interrupt
when clearing the HOST_IRQ_STAT register and hardware reporting the
PORT_IRQ_STAT register at the same clock cycle.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/ata/ahci_xgene.c |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index a56ceeb..6270bad 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -548,6 +548,51 @@ softreset_retry:
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
 static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
@@ -576,7 +621,7 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	 */
 	writel(irq_stat, mmio + HOST_IRQ_STAT);

-	rc = ahci_handle_port_intr(host, irq_masked);
+	rc = xgene_ahci_handle_broken_edge_irq(host, irq_masked);

 	spin_unlock(&host->lock);

--
1.7.1

