From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 3/7] ahci: Use new interfaces for MSI/MSI-X enablement
Date: Tue,  7 Jan 2014 19:05:38 +0100
Message-ID: <7fe2a5563efac19c87213a48b58cae6b4d76c91d.1389103215.git.agordeev@redhat.com>
References: <cover.1389103215.git.agordeev@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1389103215.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/ata/ahci.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8516f4d..cfdb079 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1098,13 +1098,13 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 			 struct ahci_host_priv *hpriv)
 {
-	int rc, nvec;
+	int nvec;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
 		goto intx;
 
-	rc = pci_msi_vec_count(pdev);
-	if (rc < 0)
+	nvec = pci_msi_vec_count(pdev);
+	if (nvec < 0)
 		goto intx;
 
 	/*
@@ -1112,19 +1112,16 @@ int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	 * Message mode could be enforced. In this case assume that advantage
 	 * of multipe MSIs is negated and use single MSI mode instead.
 	 */
-	if (rc < n_ports)
+	if (nvec < n_ports)
 		goto single_msi;
 
-	nvec = rc;
-	rc = pci_enable_msi_block(pdev, nvec);
-	if (rc)
+	if (pci_enable_msi_range(pdev, nvec, nvec) < 0)
 		goto intx;
 
 	return nvec;
 
 single_msi:
-	rc = pci_enable_msi(pdev);
-	if (rc)
+	if (pci_enable_msi_range(pdev, 1, 1) < 0)
 		goto intx;
 	return 1;
 
-- 
1.7.7.6
