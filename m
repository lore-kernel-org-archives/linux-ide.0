From: Robert Richter <rric@kernel.org>
Subject: [PATCH v4 1/3] ahci: Move interrupt enablement code to a separate function
Date: Sun, 31 May 2015 13:55:17 +0200
Message-ID: <1433073319-13796-2-git-send-email-rric@kernel.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33025 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbbEaLzb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2015 07:55:31 -0400
In-Reply-To: <1433073319-13796-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

This patch refactors ahci_init_interrupts() and moves msi code to a
separate function. Need the split since we add msix initialization in
a later patch. The initialization for msix will be done after msi but
before intx.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c7a92a743ed0..7ba5332476c6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1201,17 +1201,17 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
-static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
-				struct ahci_host_priv *hpriv)
+static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
+			struct ahci_host_priv *hpriv)
 {
 	int rc, nvec;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
-		goto intx;
+		return -ENODEV;
 
 	nvec = pci_msi_vec_count(pdev);
 	if (nvec < 0)
-		goto intx;
+		return nvec;
 
 	/*
 	 * If number of MSIs is less than number of ports then Sharing Last
@@ -1224,8 +1224,8 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	rc = pci_enable_msi_exact(pdev, nvec);
 	if (rc == -ENOSPC)
 		goto single_msi;
-	else if (rc < 0)
-		goto intx;
+	if (rc < 0)
+		return rc;
 
 	/* fallback to single MSI mode if the controller enforced MRSM mode */
 	if (readl(hpriv->mmio + HOST_CTL) & HOST_MRSM) {
@@ -1240,12 +1240,25 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	return nvec;
 
 single_msi:
-	if (pci_enable_msi(pdev))
-		goto intx;
+	rc = pci_enable_msi(pdev);
+	if (rc < 0)
+		return rc;
+
 	return 1;
+}
 
-intx:
+static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
+				struct ahci_host_priv *hpriv)
+{
+	int nvec;
+
+	nvec = ahci_init_msi(pdev, n_ports, hpriv);
+	if (nvec >= 0)
+		return nvec;
+
+	/* lagacy intx interrupts */
 	pci_intx(pdev, 1);
+
 	return 0;
 }
 
-- 
2.1.1

