From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Fri, 30 Oct 2015 17:09:46 -0400
Message-ID: <20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4784 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030348AbbJ3VP2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2015 17:15:28 -0400
In-Reply-To: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 drivers/ata/libahci.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c6f098a0435c..69bbd679d6aa 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -57,6 +57,10 @@ MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)
 module_param_named(ignore_sss, ahci_ignore_sss, int, 0444);
 MODULE_PARM_DESC(ignore_sss, "Ignore staggered spinup flag (0=don't ignore, 1=ignore)");
 
+static int use_threaded_interrupts;
+module_param(use_threaded_interrupts, int, 0444);
+MODULE_PARM_DESC(, "Defer interrupt handling to a thread (0=don't defer, 1=defer)");
+
 static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			unsigned hints);
 static ssize_t ahci_led_show(struct ata_port *ap, char *buf);
@@ -1826,6 +1830,26 @@ static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
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
@@ -2492,10 +2516,16 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 			continue;
 		}
 
-		rc = devm_request_threaded_irq(host->dev, irq,
-					       ahci_multi_irqs_intr,
-					       ahci_port_thread_fn, 0,
-					       pp->irq_desc, host->ports[i]);
+		if (use_threaded_interrupts)
+			rc = devm_request_threaded_irq(host->dev, irq,
+					ahci_multi_irqs_intr,
+					ahci_port_thread_fn, 0,
+					pp->irq_desc, host->ports[i]);
+		else
+			rc = devm_request_irq(host->dev, irq,
+					ahci_multi_irqs_intr_hard, 0,
+					pp->irq_desc, host->ports[i]);
+
 		if (rc)
 			return rc;
 		ata_port_desc(host->ports[i], "irq %d", irq);

