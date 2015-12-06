From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2] ahci: compile out msi/msix infrastructure
Date: Sat, 05 Dec 2015 16:18:44 -0800
Message-ID: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55257 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbbLFATL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Dec 2015 19:19:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

Quoting Arnd:
    The AHCI driver is used for some on-chip devices that do not use PCI
    for probing, and it can be built even when CONFIG_PCI is disabled, but
    that now results in a build failure:

    ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
    ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
    ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'

Add ifdef CONFIG_PCI_MSI infrastructure to compile out the mutli-msi and
multi-msix code.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested--by: Arnd Bergmann <arnd@arndb.de>
[arnd: fix up pci enabled case]
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Fixes: d684a90d38e2 ("ahci: per-port msix support")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Changes in v2:
Arnd noticed that although I tested the CONFIG_PCI_MSI=n case on ARM, I
neglected to re-test the CONFIG_PCI_MSI=y case.  All fixed up now.

 drivers/ata/ahci.h    |   26 ++++++++++++++++++++++++--
 drivers/ata/libahci.c |    7 +------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 878470f9c3e2..a4faa438889c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,6 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
 
+#include <linux/pci.h>
 #include <linux/clk.h>
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
@@ -237,12 +238,18 @@ enum {
 	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
 						        port start (wait until
 						        error-handling stage) */
-	AHCI_HFLAG_MULTI_MSI		= (1 << 16), /* multiple PCI MSIs */
 	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
 	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
 	AHCI_HFLAG_EDGE_IRQ		= (1 << 19), /* HOST_IRQ_STAT behaves as
 							Edge Triggered */
-	AHCI_HFLAG_MULTI_MSIX		= (1 << 20), /* per-port MSI-X */
+#ifdef CONFIG_PCI_MSI
+	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* multiple PCI MSIs */
+	AHCI_HFLAG_MULTI_MSIX		= (1 << 21), /* per-port MSI-X */
+#else
+	/* compile out MSI infrastructure */
+	AHCI_HFLAG_MULTI_MSI		= 0,
+	AHCI_HFLAG_MULTI_MSIX		= 0,
+#endif
 
 	/* ap->flags bits */
 
@@ -355,6 +362,21 @@ struct ahci_host_priv {
 	void			(*start_engine)(struct ata_port *ap);
 };
 
+#ifdef CONFIG_PCI_MSI
+static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
+{
+	if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
+		return hpriv->msix[port].vector;
+	else
+		return hpriv->irq + port;
+}
+#else
+static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
+{
+	return hpriv->irq;
+}
+#endif
+
 extern int ahci_ignore_sss;
 
 extern struct device_attribute *ahci_shost_attrs[];
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1b6c7cc415bf..eda3cf2163bb 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2469,12 +2469,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 	 */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ahci_port_priv *pp = host->ports[i]->private_data;
-		int irq;
-
-		if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
-			irq = hpriv->msix[i].vector;
-		else
-			irq = hpriv->irq + i;
+		int irq = ahci_irq_vector(hpriv, i);
 
 		/* Do not receive interrupts sent by dummy ports */
 		if (!pp) {

