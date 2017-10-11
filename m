From: Radha Mohan Chintakuntla <mohun106@gmail.com>
Subject: [PATCH] ahci: Add support for Cavium's fifth generation SATA controller
Date: Tue, 10 Oct 2017 22:37:51 -0700
Message-ID: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
List-Id: linux-ide@vger.kernel.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support for Cavium's fifth generation SATA controller.
It is an on-chip controller and complies with AHCI 1.3.1. As the
controller uses 64-bit addresses it cannot use the standard AHCI BAR5
and so uses BAR4.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 drivers/ata/ahci.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9f78bb0..5443cb7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -57,6 +57,7 @@ enum {
 	AHCI_PCI_BAR_STA2X11	= 0,
 	AHCI_PCI_BAR_CAVIUM	= 0,
 	AHCI_PCI_BAR_ENMOTUS	= 2,
+	AHCI_PCI_BAR_CAVIUM_GEN5	= 4,
 	AHCI_PCI_BAR_STANDARD	= 5,
 };
 
@@ -1570,8 +1571,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ahci_pci_bar = AHCI_PCI_BAR_STA2X11;
 	else if (pdev->vendor == 0x1c44 && pdev->device == 0x8000)
 		ahci_pci_bar = AHCI_PCI_BAR_ENMOTUS;
-	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
-		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
+	else if (pdev->vendor == PCI_VENDOR_ID_CAVIUM) {
+		if (pdev->device == 0xa01c)
+			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
+		if (pdev->device == 0xa084)
+			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM_GEN5;
+	}
 
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
-- 
1.7.1
