From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 1/2] libahci: Implement the workaround to fix the missing of edge interrupt for HOST_IRQ_STAT
Date: Thu, 24 Dec 2015 13:01:28 +0530
Message-ID: <1450942289-12660-2-git-send-email-stripathi@apm.com>
References: <1450942289-12660-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450942289-12660-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Due to H/W errata, the HOST_IRQ_STAT register misses the edge interrupt
when clearing the HOST_IRQ_STAT register and hardware reporting the
PORT_IRQ_STAT register at the same clock cycle. As such, the
algorithm below outlines the workaround.

1. Read HOST_IRQ_STAT register and save the state.
2. Clear the HOST_IRQ_STAT register.
3. Read back the HOST_IRQ_STAT register.
4. If HOST_IRQ_STAT register equals to zero, then
   traverse the rest of port's PORT_IRQ_STAT register
   to check if an interrupt is triggered at that point else
   go to step 6.
5. If PORT_IRQ_STAT register of rest ports is not equal to zero
   then update the state of HOST_IRQ_STAT saved in step 1.
6. Handle port interrupts.
7. Exit

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci.h    |    2 ++
 drivers/ata/libahci.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 45586c1..736f4a5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -242,6 +242,8 @@ enum {
 	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
 	AHCI_HFLAG_EDGE_IRQ		= (1 << 19), /* HOST_IRQ_STAT behaves as
 							Edge Triggered */
+	AHCI_HFLAG_EDGE_IRQ_BROKEN	= (1 << 20), /* HOST_IRQ_STAT miss edge
+							from PORT_IRQ_STAT */

 	/* ap->flags bits */

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 096064c..02b85c2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1832,10 +1832,55 @@ static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
 	return IRQ_WAKE_THREAD;
 }

+static void ahci_handle_broken_edge_irq(struct ata_host *host,
+					u32 *irq_masked)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	unsigned int i, temp_irq_masked;
+	struct ata_port *next_ap;
+	void __iomem *port_mmio;
+	int j;
+
+	if (!readl(mmio + HOST_IRQ_STAT)) {
+		temp_irq_masked = *irq_masked;
+
+		for (i = 0; i < __sw_hweight32(hpriv->port_map);
+		     i++) {
+			if (*irq_masked & (1 << i)) {
+				for (j = 0;
+				     j < __sw_hweight32(hpriv->port_map);
+				     j++) {
+					if (i == j)
+						continue;
+
+					next_ap = host->ports[j];
+					port_mmio = ahci_port_base(next_ap);
+					if (readl(port_mmio + PORT_IRQ_STAT))
+						temp_irq_masked |= (1 << j);
+				}
+			}
+		}
+		*irq_masked = temp_irq_masked;
+	}
+
+}
+
 static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 {
+	struct ahci_host_priv *hpriv = host->private_data;
 	unsigned int i, handled = 0;

+	/*
+	 * For hardware with broken edge trigger latch
+	 * the HOST_IRQ_STAT register misses the edge interrupt
+	 * when clearing of HOST_IRQ_STAT register and hardware
+	 * reporting the PORT_IRQ_STAT register at the
+	 * same clock cycle.
+	 */
+	if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ_BROKEN)
+		ahci_handle_broken_edge_irq(host, &irq_masked);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap;

--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
