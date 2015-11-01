From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 2/2] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Sun, 01 Nov 2015 13:43:45 -0500
Message-ID: <20151101184345.23222.58353.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62133 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbbKASt2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2015 13:49:28 -0500
In-Reply-To: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

For high frequency I/O the overhead of threaded interrupts impacts
performance.  Add an option to make it configurable, with the default
being hardirq.

A quick out-of-the-box test (i.e. no affinity tuning) shows ~10% random
read performance at ~20% less cpu.  The cpu wins appear to be from
reduced lock contention.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libahci.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c6f098a0435c..f10a702abfb5 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1826,6 +1826,26 @@ static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
 	return IRQ_WAKE_THREAD;
 }
 
+static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
+{
+	struct ata_port *ap = dev_instance;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 status;
+
+	VPRINTK("ENTER\n");
+
+	status = readl(port_mmio + PORT_IRQ_STAT);
+	writel(status, port_mmio + PORT_IRQ_STAT);
+
+	spin_lock(ap->lock);
+	ahci_handle_port_interrupt(ap, port_mmio, status);
+	spin_unlock(ap->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_HANDLED;
+}
+
 static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 {
 	unsigned int i, handled = 0;
@@ -2492,10 +2512,9 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 			continue;
 		}
 
-		rc = devm_request_threaded_irq(host->dev, irq,
-					       ahci_multi_irqs_intr,
-					       ahci_port_thread_fn, 0,
-					       pp->irq_desc, host->ports[i]);
+		rc = devm_request_irq(host->dev, irq, ahci_multi_irqs_intr_hard,
+				0, pp->irq_desc, host->ports[i]);
+
 		if (rc)
 			return rc;
 		ata_port_desc(host->ports[i], "irq %d", irq);

