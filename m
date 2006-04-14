From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] Fix a logic error in ahci_init_one()
Date: Fri, 14 Apr 2006 15:31:21 +0800
Message-ID: <1144999881.24774.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35725 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750731AbWDNHmk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Apr 2006 03:42:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Fix an bug in error handling, also variable
pci_dev_busy has no use, remove it.

Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>


---

This patch is against libata-dev.git upstream[1]

[1] 26ec634c31a11a003040e10b4d650495158632fd

 drivers/scsi/ahci.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1b8429c..8c4ebba 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1176,7 +1176,7 @@ static int ahci_init_one (struct pci_dev
 	unsigned long base;
 	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int have_msi, pci_dev_busy = 0;
+	int have_msi;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -1189,10 +1189,8 @@ static int ahci_init_one (struct pci_dev
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		pci_dev_busy = 1;
+	if (rc)
 		goto err_out;
-	}
 
 	if (pci_enable_msi(pdev) == 0)
 		have_msi = 1;
@@ -1269,8 +1267,7 @@ err_out_msi:
 		pci_intx(pdev, 0);
 	pci_release_regions(pdev);
 err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
+	pci_disable_device(pdev);
 	return rc;
 }
 
-- 
1.2.6
