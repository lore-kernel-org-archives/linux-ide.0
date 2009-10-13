From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH #upstream-fixes] ata: rename AMD SB900 into Hudson-2
Date: Tue, 13 Oct 2009 11:14:00 +0800
Message-ID: <1255403640.3625.6.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:27294 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbZJMFmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Oct 2009 01:42:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

This patch renames the code name SB900 into Hudson-2

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/ahci.c        |    2 +-
 drivers/ata/pata_atiixp.c |    2 +-
 drivers/ide/atiixp.c      |    2 +-
 drivers/pci/quirks.c      |    6 +++---
 include/linux/pci_ids.h   |    6 ++----
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b1a2577..b6fdacb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -575,7 +575,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */
 
 	/* AMD */
-	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
+	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index aa4b3f6..ae4454d 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -246,7 +246,7 @@ static const struct pci_device_id atiixp[] = {
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_SB900_IDE), },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_IDE), },
 
 	{ },
 };
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index 6396c3a..837322b 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -177,7 +177,7 @@ static const struct pci_device_id atiixp_pci_tbl[] = {
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), 0 },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), 1 },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), 0 },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_SB900_IDE), 0 },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_IDE), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index efa6534..62ddb43 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1009,7 +1009,7 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,
 
 static void __devinit quirk_amd_ide_mode(struct pci_dev *pdev)
 {
-	/* set SBX00 SATA in IDE mode to AHCI mode */
+	/* set SBX00/Hudson-2 SATA in IDE mode to AHCI mode */
 	u8 tmp;
 
 	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &tmp);
@@ -1028,8 +1028,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SATA_IDE, quirk_amd_ide_mode);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE, quirk_amd_ide_mode);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f490e7a..86257a4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -379,9 +379,6 @@
 #define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
 #define PCI_DEVICE_ID_ATI_IXP700_SATA	0x4390
 #define PCI_DEVICE_ID_ATI_IXP700_IDE	0x439c
-/* AMD SB Chipset */
-#define PCI_DEVICE_ID_AMD_SB900_IDE	 0x780c
-#define PCI_DEVICE_ID_AMD_SB900_SATA_IDE 0x7800
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
@@ -553,9 +550,10 @@
 #define PCI_DEVICE_ID_AMD_CS5536_UDC    0x2096
 #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
 #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
-
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
+#define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
+#define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000


