From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH v2 2/2] ahci: Use pci_enable_msi_exact() instead of pci_enable_msi_range()
Date: Thu, 17 Apr 2014 14:13:50 +0200
Message-ID: <b29508ba0f127aac11d1fc25ed93c9e281b7700e.1397736364.git.agordeev@redhat.com>
References: <cover.1397736364.git.agordeev@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1397736364.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The driver calls pci_enable_msi_range() function with the
range of [nvec..nvec] which what pci_enable_msi_exact()
function is for.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 649ac1c..0927d5f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1166,7 +1166,7 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 				struct ahci_host_priv *hpriv)
 {
-	int nvec;
+	int rc, nvec;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
 		goto intx;
@@ -1183,10 +1183,10 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec < n_ports)
 		goto single_msi;
 
-	nvec = pci_enable_msi_range(pdev, nvec, nvec);
-	if (nvec == -ENOSPC)
+	rc = pci_enable_msi_exact(pdev, nvec);
+	if (rc == -ENOSPC)
 		goto single_msi;
-	else if (nvec < 0)
+	else if (rc < 0)
 		goto intx;
 
 	/*
-- 
1.7.7.6
