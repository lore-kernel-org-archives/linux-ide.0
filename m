From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 2/2] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Wed, 11 Nov 2015 16:27:38 -0800
Message-ID: <20151112002738.37012.56239.stgit@dwillia2-desk3.jf.intel.com>
References: <20151112002727.37012.65672.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27723 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbbKLA2H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Nov 2015 19:28:07 -0500
In-Reply-To: <20151112002727.37012.65672.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

For high frequency I/O the overhead of threaded interrupts impacts
performance.  A quick out-of-the-box test (i.e. no affinity tuning)
shows ~10% random read performance at ~20% less cpu.  The cpu wins
appear to be from reduced lock contention.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libahci.c |   34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0a5645fb02f8..1b6c7cc415bf 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1796,41 +1796,24 @@ static void ahci_port_intr(struct ata_port *ap)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 }
 
-static irqreturn_t ahci_port_thread_fn(int irq, void *dev_instance)
+static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 {
 	struct ata_port *ap = dev_instance;
-	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	status = atomic_xchg(&pp->intr_status, 0);
-	if (!status)
-		return IRQ_NONE;
-
-	spin_lock_bh(ap->lock);
-	ahci_handle_port_interrupt(ap, port_mmio, status);
-	spin_unlock_bh(ap->lock);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
-{
-	struct ata_port *ap = dev_instance;
-	void __iomem *port_mmio = ahci_port_base(ap);
-	struct ahci_port_priv *pp = ap->private_data;
-	u32 status;
-
 	VPRINTK("ENTER\n");
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	atomic_or(status, &pp->intr_status);
+	spin_lock(ap->lock);
+	ahci_handle_port_interrupt(ap, port_mmio, status);
+	spin_unlock(ap->lock);
 
 	VPRINTK("EXIT\n");
 
-	return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
 }
 
 static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
@@ -2499,10 +2482,9 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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

