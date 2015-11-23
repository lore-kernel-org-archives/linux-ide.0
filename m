From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ahci: don't use MSI when PCI is disabled
Date: Mon, 23 Nov 2015 10:47:43 +0100
Message-ID: <4754092.OYovO36g28@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

The AHCI driver is used for some on-chip devices that do not
use PCI for probing, and it can be built even when CONFIG_PCI
is disabled, but that now results in a build failure:

ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'

This adds an #ifdef so we use that code only if actual PCI MSI
is available.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d684a90d38e2 ("ahci: per-port msix support")

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1b6c7cc415bf..54fe01d8145b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1796,7 +1796,8 @@ static void ahci_port_intr(struct ata_port *ap)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 }
 
-static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
+static irqreturn_t __maybe_unused ahci_multi_irqs_intr_hard(int irq,
+							    void *dev_instance)
 {
 	struct ata_port *ap = dev_instance;
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -2454,6 +2455,7 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 }
 EXPORT_SYMBOL_GPL(ahci_set_em_messages);
 
+#ifdef CONFIG_PCI_MSI
 static int ahci_host_activate_multi_irqs(struct ata_host *host,
 					 struct scsi_host_template *sht)
 {
@@ -2492,6 +2494,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 
 	return ata_host_register(host, sht);
 }
+#endif
 
 /**
  *	ahci_host_activate - start AHCI host, request IRQs and register it
@@ -2510,9 +2513,12 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int irq = hpriv->irq;
 	int rc;
 
+#ifdef CONFIG_PCI_MSI
 	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
 		rc = ahci_host_activate_multi_irqs(host, sht);
-	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
+	else
+#endif
+	if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
 		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
 				       IRQF_SHARED, sht);
 	else
