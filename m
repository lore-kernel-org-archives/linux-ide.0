From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 3/4] ahci: per-port msix support
Date: Fri, 30 Oct 2015 17:09:40 -0400
Message-ID: <20151030210940.8538.97829.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13079 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760810AbbJ3VPX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Oct 2015 17:15:23 -0400
In-Reply-To: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>

From: Dan Williams <dan.j.williamps@intel.com>

Some AHCI controllers support per-port MSI-X vectors.  At the same time
the Linux AHCI driver needs to support one-off architectures that
implement a single MSI-X vector for all ports.  The heuristic for
enabling AHCI ports becomes, in order of preference:

1/ per-port multi-MSI-X

2/ per-port multi-MSI

3/ single MSI

4/ single MSI-X

5/ legacy INTX

This all depends on AHCI implementations with potentially broken MSI-X
requesting less vectors than the number of ports.  If this assumption is
violated we will need to start explicitly white-listing AHCI-MSIX
implementations.

Reported-by: Ricardo Neri <ricardo.neri@intel.com>
[ricardo: fix struct msix_entry handling]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/ahci.c    |   69 +++++++++++++++++++++++++++++++++----------------
 drivers/ata/ahci.h    |    2 +
 drivers/ata/libahci.c |   19 ++++++++++---
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a46660204e3a..688c785bb973 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1292,15 +1292,14 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 #endif
 
 /*
- * ahci_init_msix() only implements single MSI-X support, not multiple
- * MSI-X per-port interrupts. This is needed for host controllers that only
- * have MSI-X support implemented, but no MSI or intx.
+ * ahci_init_msix() - optionally enable per-port MSI-X otherwise defer
+ * to single msi.
  */
 static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
-			  struct ahci_host_priv *hpriv)
+			  struct ahci_host_priv *hpriv, unsigned long flags)
 {
-	int rc, nvec;
-	struct msix_entry entry = {};
+	unsigned int nvec, i;
+	int rc;
 
 	/* Do not init MSI-X if MSI is disabled for the device */
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
@@ -1310,22 +1309,40 @@ static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec < 0)
 		return nvec;
 
-	if (!nvec) {
+	/*
+	 * Proper MSI-X implementations will have a vector per-port.
+	 * Barring that, we prefer single-MSI over single-MSIX.  If this
+	 * check fails (not enough MSI-X vectors for all ports) we will
+	 * be called again with the flag clear iff ahci_init_msi()
+	 * fails.
+	 */
+	if (flags & AHCI_HFLAG_MULTI_MSIX) {
+		if (nvec < n_ports)
+			return -ENODEV;
+		else
+			nvec = min(nvec, n_ports);
+	} else if (nvec) {
+		nvec = 1;
+	} else {
+		/*
+		 * Emit dev_err() since this was the non-legacy irq
+		 * method of last resort.
+		 */
 		rc = -ENODEV;
 		goto fail;
 	}
 
-	/*
-	 * There can be more than one vector (e.g. for error detection or
-	 * hdd hotplug). Only the first vector (entry.entry = 0) is used.
-	 */
-	rc = pci_enable_msix_exact(pdev, &entry, 1);
+	for (i = 0; i < nvec; i++)
+		hpriv->msix[i].entry = i;
+	rc = pci_enable_msix_exact(pdev, hpriv->msix, nvec);
 	if (rc < 0)
 		goto fail;
 
-	hpriv->irq = entry.vector;
+	if (nvec > 1)
+		hpriv->flags |= AHCI_HFLAG_MULTI_MSIX;
+	hpriv->irq = hpriv->msix[0].vector; /* for single msi-x */
 
-	return 1;
+	return nvec;
 fail:
 	dev_err(&pdev->dev,
 		"failed to enable MSI-X with error %d, # of vectors: %d\n",
@@ -1389,20 +1406,25 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 {
 	int nvec;
 
+	/*
+	 * Try to enable per-port MSI-X.  If the host is not capable
+	 * fall back to single MSI before finally attempting single
+	 * MSI-X.
+	 */
+	nvec = ahci_init_msix(pdev, n_ports, hpriv, AHCI_HFLAG_MULTI_MSIX);
+	if (nvec >= 0)
+		return nvec;
+
 	nvec = ahci_init_msi(pdev, n_ports, hpriv);
 	if (nvec >= 0)
 		return nvec;
 
-	/*
-	 * Currently, MSI-X support only implements single IRQ mode and
-	 * exists for controllers which can't do other types of IRQ. Only
-	 * set it up if MSI fails.
-	 */
-	nvec = ahci_init_msix(pdev, n_ports, hpriv);
+	/* try single-msix */
+	nvec = ahci_init_msix(pdev, n_ports, hpriv, 0);
 	if (nvec >= 0)
 		return nvec;
 
-	/* lagacy intx interrupts */
+	/* legacy intx interrupts */
 	pci_intx(pdev, 1);
 	hpriv->irq = pdev->irq;
 
@@ -1564,7 +1586,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!host)
 		return -ENOMEM;
 	host->private_data = hpriv;
-
+	hpriv->msix = devm_kzalloc(&pdev->dev,
+			sizeof(struct msix_entry) * n_ports, GFP_KERNEL);
+	if (!hpriv->msix)
+		return -ENOMEM;
 	ahci_init_interrupts(pdev, n_ports, hpriv);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 5b8e8a0fab48..5ab9d158c90c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -240,6 +240,7 @@ enum {
 	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
 	AHCI_HFLAG_EDGE_IRQ		= (1 << 19), /* HOST_IRQ_STAT behaves as
 							Edge Triggered */
+	AHCI_HFLAG_MULTI_MSIX		= (1 << 20), /* per-port MSI-X */
 
 	/* ap->flags bits */
 
@@ -341,6 +342,7 @@ struct ahci_host_priv {
 	 * the PHY position in this array.
 	 */
 	struct phy		**phys;
+	struct msix_entry	*msix;		/* Optional MSI-X support */
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 373c7b1602ff..c6f098a0435c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -43,6 +43,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/pci.h>
 #include "ahci.h"
 #include "libata.h"
 
@@ -2463,9 +2464,10 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 }
 EXPORT_SYMBOL_GPL(ahci_set_em_messages);
 
-static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
+static int ahci_host_activate_multi_irqs(struct ata_host *host,
 					 struct scsi_host_template *sht)
 {
+	struct ahci_host_priv *hpriv = host->private_data;
 	int i, rc;
 
 	rc = ata_host_start(host);
@@ -2477,6 +2479,12 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 	 */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ahci_port_priv *pp = host->ports[i]->private_data;
+		int irq;
+
+		if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
+			irq = hpriv->msix[i].vector;
+		else
+			irq = hpriv->irq + i;
 
 		/* Do not receive interrupts sent by dummy ports */
 		if (!pp) {
@@ -2484,14 +2492,15 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host, int irq,
 			continue;
 		}
 
-		rc = devm_request_threaded_irq(host->dev, irq + i,
+		rc = devm_request_threaded_irq(host->dev, irq,
 					       ahci_multi_irqs_intr,
 					       ahci_port_thread_fn, 0,
 					       pp->irq_desc, host->ports[i]);
 		if (rc)
 			return rc;
-		ata_port_desc(host->ports[i], "irq %d", irq + i);
+		ata_port_desc(host->ports[i], "irq %d", irq);
 	}
+
 	return ata_host_register(host, sht);
 }
 
@@ -2512,8 +2521,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int irq = hpriv->irq;
 	int rc;
 
-	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
-		rc = ahci_host_activate_multi_irqs(host, irq, sht);
+	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
+		rc = ahci_host_activate_multi_irqs(host, sht);
 	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
 		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
 				       IRQF_SHARED, sht);

