From: suman Tripathi <stripathi@apm.com>
Subject: [PATCH v4 1/3] libahci: Implement the capability to override the generic ahci interrupt handler.
Date: Sat,  6 Feb 2016 11:25:22 +0530
Message-ID: <1454738124-9351-2-git-send-email-stripathi@apm.com>
References: <1454738124-9351-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:58577 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750931AbcBFF4I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Feb 2016 00:56:08 -0500
In-Reply-To: <1454738124-9351-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

From: Suman Tripathi <stripathi@apm.com>

This patch implements the capability to override the generic AHCI
interrupt handler so that the LDD drivers can implement their own
custom interrupt handler routines.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/ata/ahci.h    |    2 ++
 drivers/ata/libahci.c |   29 +++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a4faa43..e64bdad 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -360,6 +360,7 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	irqreturn_t 		(*ahci_irq_handler)(int irq, void *dev_instance);
 };

 #ifdef CONFIG_PCI_MSI
@@ -423,6 +424,7 @@ int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);

 static inline void __iomem *__ahci_port_base(struct ata_host *host,
 					     unsigned int port_no)
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index eda3cf2..d45a7a5 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -113,6 +113,9 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 				    const char *buf, size_t size);
 static ssize_t ahci_show_em_supported(struct device *dev,
 				      struct device_attribute *attr, char *buf);
+static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance);
+
+static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance);

 static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
@@ -512,6 +515,11 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)

 	if (!hpriv->start_engine)
 		hpriv->start_engine = ahci_start_engine;
+
+	if (!hpriv->ahci_irq_handler)
+		hpriv->ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ) ?
+					   ahci_single_edge_irq_intr :
+					   ahci_single_level_irq_intr;
 }
 EXPORT_SYMBOL_GPL(ahci_save_initial_config);

@@ -1816,7 +1824,7 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }

-static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 {
 	unsigned int i, handled = 0;

@@ -1842,6 +1850,7 @@ static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)

 	return handled;
 }
+EXPORT_SYMBOL_GPL(ahci_handle_port_intr);

 static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance)
 {
@@ -2505,14 +2514,18 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int irq = hpriv->irq;
 	int rc;

-	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
+	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
+		if (hpriv->ahci_irq_handler)
+			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
+				 and custom irq handler implemented\n");
+
 		rc = ahci_host_activate_multi_irqs(host, sht);
-	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
-		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
-				       IRQF_SHARED, sht);
-	else
-		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
-				       IRQF_SHARED, sht);
+	} else {
+		rc = ata_host_activate(host, irq, hpriv->ahci_irq_handler,
+			       	       IRQF_SHARED, sht);
+	}
+
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
--
1.7.1

