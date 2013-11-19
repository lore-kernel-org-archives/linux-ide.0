From: James Laird <jhl@mafipulation.org>
Subject: [PATCH] ahci: mcp89: enter AHCI mode under Apple BIOS emulation
Date: Tue, 19 Nov 2013 11:06:38 +1100
Message-ID: <20131119000637.GA6243@unibuddy.saluda.saludamedical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from neuropathy.axdf.net ([54.252.116.19]:59340 "EHLO
	neuropathy.axdf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab3KSAOM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Nov 2013 19:14:12 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Apple's BIOS emulation forcibly disables MCP89 AHCI, eg. on Macbook7,1.
We can re-enable it, replacing the previous workaround of using
ata_generic.

Signed-off-by: James Laird <jhl@mafipulation.org>

 drivers/ata/ahci.c        | 58 +++++++++++++++++++++++++++++++++++++++--------
 drivers/ata/ata_generic.c |  7 ------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e2903d0..e2a3249 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -83,6 +83,8 @@ enum board_ids {
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline);
+static void ahci_mcp89_apple_enable(struct pci_dev *pdev);
+static inline bool is_mcp89_apple(struct pci_dev *pdev);
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 				unsigned long deadline);
 #ifdef CONFIG_PM
@@ -659,6 +661,10 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 	if (rc)
 		return rc;
 
+	/* Apple BIOS helpfully mangles the registers on resume */
+	if (is_mcp89_apple(pdev))
+		ahci_mcp89_apple_enable(pdev);
+
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_pci_reset_controller(host);
 		if (rc)
@@ -775,6 +781,46 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 	}
 }
 
+/*
+ * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID when
+ * booting in BIOS compatibility mode. We restore the registers but not ID.
+ */
+static void ahci_mcp89_apple_enable(struct pci_dev *pdev) {
+	u32 val;
+
+	printk(KERN_INFO "ahci: enabling MCP89 AHCI mode\n");
+
+	pci_read_config_dword(pdev, 0xf8, &val);
+	val |= 1<<0x1b;
+	/* the following changes the device ID, but appears not to affect function */
+	/* val = (val & ~0xf0000000) | 0x80000000; */
+	pci_write_config_dword(pdev, 0xf8, val);
+
+	pci_read_config_dword(pdev, 0x54c, &val);
+	val |= 1<<0xc;
+	pci_write_config_dword(pdev, 0x54c, val);
+
+	pci_read_config_dword(pdev, 0x4a4, &val);
+	val &= 0xff;
+	val |= 0x01060100;
+	pci_write_config_dword(pdev, 0x4a4, val);
+
+	pci_read_config_dword(pdev, 0x54c, &val);
+	val &= ~(1<<0xc);
+	pci_write_config_dword(pdev, 0x54c, val);
+
+	pci_read_config_dword(pdev, 0xf8, &val);
+	val &= ~(1<<0x1b);
+	pci_write_config_dword(pdev, 0xf8, val);
+}
+
+static inline bool is_mcp89_apple(struct pci_dev *pdev) {
+	return	pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
+			pdev->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA &&
+			pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+			pdev->subsystem_device == 0xcb89;
+}
+
 /* only some SB600 ahci controllers can do 64bit DMA */
 static bool ahci_sb600_enable_64bit(struct pci_dev *pdev)
 {
@@ -1207,15 +1253,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pdev->vendor == PCI_VENDOR_ID_MARVELL && !marvell_enable)
 		return -ENODEV;
 
-	/*
-	 * For some reason, MCP89 on MacBook 7,1 doesn't work with
-	 * ahci, use ata_generic instead.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
-	    pdev->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA &&
-	    pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    pdev->subsystem_device == 0xcb89)
-		return -ENODEV;
+    /* Apple BIOS on MCP89 prevents us using AHCI */
+    if (is_mcp89_apple(pdev))
+		ahci_mcp89_apple_enable(pdev);
 
 	/* Promise's PDC42819 is a SAS/SATA controller that has an AHCI mode.
 	 * At the moment, we can only use the AHCI mode. Let the users know
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index f8f38a0..7d19665 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -221,13 +221,6 @@ static struct pci_device_id ata_generic[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
 	  .driver_data = ATA_GEN_FORCE_DMA },
-	/*
-	 * For some reason, MCP89 on MacBook 7,1 doesn't work with
-	 * ahci, use ata_generic instead.
-	 */
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA,
-	  PCI_VENDOR_ID_APPLE, 0xcb89,
-	  .driver_data = ATA_GEN_FORCE_DMA },
 #if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
