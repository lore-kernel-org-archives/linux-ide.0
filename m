From: Robert Richter <rric@kernel.org>
Subject: [PATCH v5 2/2] ahci: Add support for Cavium's ThunderX host controller
Date: Fri,  5 Jun 2015 19:49:26 +0200
Message-ID: <1433526566-21136-3-git-send-email-rric@kernel.org>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433526566-21136-1-git-send-email-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>
List-Id: linux-ide@vger.kernel.org

From: Robert Richter <rrichter@cavium.com>

This patch adds support for Cavium's ThunderX host controller. The
controller resides on the SoC and is a AHCI compatible SATA controller
with one port, compliant with Serial ATA 3.1 and AHCI Revision 1.31.
There can exists multiple SATA controllers on the SoC.

The controller depends on MSI-X support since the PCI ECAM controller
on the SoC does not implement MSI nor lagacy intx interrupt support.
Thus, during device initialization, if MSI fails MSI-X will be used to
enable the device's interrupts.

The controller uses non-standard BAR0 for its register range. The
already existing device lookup (vendor and device id) that is already
implemented for other host controllers is used to change the PCI BAR.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f300aa583678..094649db3330 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -53,6 +53,7 @@
 
 enum {
 	AHCI_PCI_BAR_STA2X11	= 0,
+	AHCI_PCI_BAR_CAVIUM	= 0,
 	AHCI_PCI_BAR_ENMOTUS	= 2,
 	AHCI_PCI_BAR_STANDARD	= 5,
 };
@@ -1379,11 +1380,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_info(&pdev->dev,
 			 "PDC42819 can only drive SATA devices with this driver\n");
 
-	/* Both Connext and Enmotus devices use non-standard BARs */
+	/* Some devices use non-standard BARs */
 	if (pdev->vendor == PCI_VENDOR_ID_STMICRO && pdev->device == 0xCC06)
 		ahci_pci_bar = AHCI_PCI_BAR_STA2X11;
 	else if (pdev->vendor == 0x1c44 && pdev->device == 0x8000)
 		ahci_pci_bar = AHCI_PCI_BAR_ENMOTUS;
+	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
+		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 
 	/*
 	 * The JMicron chip 361/363 contains one SATA controller and one
-- 
2.1.1
