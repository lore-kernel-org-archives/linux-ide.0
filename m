From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH v2 1/9] ahci: Fix broken fallback to single MSI mode
Date: Fri, 17 Jan 2014 17:02:15 +0100
Message-ID: <e05f8749ee0fa300c56a0c6f09298c96a3706071.1389904166.git.agordeev@redhat.com>
References: <cover.1389904166.git.agordeev@redhat.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <cover.1389904166.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Commit 7b92b4f ("PCI/MSI: Remove pci_enable_msi_block_auto()")
introduced a regression - in case multiple MSIs initialization
fails the code falls back to INTx rather than to single MSI.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/ata/ahci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8516f4d..df24eef4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1117,8 +1117,10 @@ int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 
 	nvec = rc;
 	rc = pci_enable_msi_block(pdev, nvec);
-	if (rc)
+	if (rc < 0)
 		goto intx;
+	else if (rc > 0)
+		goto single_msi;
 
 	return nvec;
 
-- 
1.7.7.6
