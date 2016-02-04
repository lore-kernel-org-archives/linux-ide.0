From: suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 1/3] libahci: Implement the capability to override the generic ahci interrupt handler.
Date: Fri,  5 Feb 2016 02:50:24 +0530
Message-ID: <1454620826-22554-2-git-send-email-stripathi@apm.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [198.137.200.161] ([198.137.200.161]:60065 "EHLO
	denmail01.amcc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753560AbcBDVVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 16:21:16 -0500
In-Reply-To: <1454620826-22554-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

From: Suman Tripathi <stripathi@apm.com>

This patch implements the capability to override the generic
ahci interrupt handler so that the LDD drivers can implement
there own custom interrupt handler routines.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/ata/ahci.h    |    2 ++
 drivers/ata/libahci.c |   32 +++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a4faa43..3d883ee 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -360,6 +360,7 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	irqreturn_t 		(*ahci_irq_intr)(int irq, void *dev_instance);
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
index eda3cf2..5d3035a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1816,7 +1816,7 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }

-static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 {
 	unsigned int i, handled = 0;

@@ -1842,6 +1842,7 @@ static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)

 	return handled;
 }
+EXPORT_SYMBOL_GPL(ahci_handle_port_intr);

 static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance)
 {
@@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int irq = hpriv->irq;
 	int rc;
+	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);

-	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
-		rc = ahci_host_activate_multi_irqs(host, sht);
-	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
-		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
-				       IRQF_SHARED, sht);
-	else
-		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
-				       IRQF_SHARED, sht);
+	ahci_irq_handler = hpriv->ahci_irq_intr;
+
+	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
+		if (!ahci_irq_handler)
+			rc = ahci_host_activate_multi_irqs(host, sht);
+		else
+			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
+				 and custom irq handler implemented\n");
+
+	} else {
+		if (!ahci_irq_handler) {
+			ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
+			 		    ahci_single_edge_irq_intr :
+					    ahci_single_level_irq_intr);
+		}
+	}
+
+	rc = ata_host_activate(host, irq, ahci_irq_handler,
+			       IRQF_SHARED, sht);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
--
1.7.1

