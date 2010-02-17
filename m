From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 5/5] pata_efar: Enable PARALLEL_SCAN
Date: Wed, 17 Feb 2010 13:17:52 +0000
Message-ID: <20100217131749.16884.3192.stgit@localhost.localdomain>
References: <20100217131532.16884.21696.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100217131532.16884.21696.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: jeff@garzik.org.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Again originally proposed by Bartlomiej but this does it by using the
generic helper logic instead.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/pata_efar.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 2a9014c..4289db0 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -278,7 +278,8 @@ static int efar_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_sff_init_one(pdev, ppi, &efar_sht, NULL, 0);
+	return ata_pci_sff_init_one(pdev, ppi, &efar_sht, NULL,
+					ATA_HOST_PARALLEL_SCAN);
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
