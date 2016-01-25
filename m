From: Ocean HY1 He <hehy1@lenovo.com>
Subject: [PATCH] Let AHCI dirver skip Lenovo SWRAID controller
Date: Mon, 25 Jan 2016 03:11:40 +0000
Message-ID: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.209]:59335 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753558AbcAYDUt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jan 2016 22:20:49 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ocean HY1 He <hehy1@lenovo.com>

Lenovo SWRAID solution is based on Intel Non-RSTE RAID controller which
is called Lenovo SWRAID controller by set Lenovo dedicated PCI
SVID:SDID.

Because AHCI driver now take control this Lenovo SWRAID controller for
MDRAID, Lenovo SWRAID driver fails to load later. It's not proper to
disable AHCI driver, because system has SATA contoller used for SATA
DVD, M.2 etc. There is no chance to load Lenovo SWRAID first, because
almost all Linux distros load AHCI driver first during installation.

As default, when Lenovo SWRAID controller is detected, let AHCI driver
skip it thus MDRAID is disabled. Use the boot option 'ahci.lenovo_swraid=0'
could disable Lenovo SWRAID.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/ata/ahci.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 594fcab..8ec51a6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -557,6 +557,35 @@ static int marvell_enable = 1;
 module_param(marvell_enable, int, 0644);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
+static int lenovo_swraid = 1;
+module_param(lenovo_swraid, int, 0644);
+MODULE_PARM_DESC(lenovo_swraid, "SWRAID via SATA(RAID mode) (1 = enable (default))");
+
+static int lenovo_swraid_enable(struct pci_dev *pdev)
+{
+	if (!lenovo_swraid)
+		return 0;
+
+	/* Lenovo Gen6 Servers */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    (pdev->device == 0xa186 || pdev->device == 0xa206) &&
+	    pdev->subsystem_vendor == 0x1d49) {
+			dev_info(&pdev->dev,
+				  "Skip SATA controller for Lenovo SWRAID.\n");
+			return -ENODEV;
+	}
+
+	/* Lenovo Gen5 Servers */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    pdev->device == 0x8d06 &&
+	    pdev->subsystem_vendor == 0x17aa) {
+			dev_info(&pdev->dev,
+				  "Skip SATA controller for Lenovo SWRAID.\n");
+			return -ENODEV;
+	}
+
+	return 0;
+}
 
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
@@ -1466,6 +1495,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pdev->vendor == PCI_VENDOR_ID_MARVELL && !marvell_enable)
 		return -ENODEV;
 
+	/* Let AHCI driver skip the Lenovo SWRAID controller. */
+	if (lenovo_swraid_enable(pdev))
+		return -ENODEV;
+
 	/* Apple BIOS on MCP89 prevents us using AHCI */
 	if (is_mcp89_apple(pdev))
 		ahci_mcp89_apple_enable(pdev);
-- 
1.8.3.1
