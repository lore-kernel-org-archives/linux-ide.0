From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Tue, 28 Jul 2009 14:29:26 +0800
Message-ID: <1248762566.3437.7.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sg2ehsobe002.messaging.microsoft.com ([207.46.51.76]:8395 "EHLO
	SG2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751104AbZG1Gop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2009 02:44:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Add AMD SB900 SATA/IDE controller device IDs.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2009-07-27 18:55:43.000000000 +0800
+++ b/drivers/ata/ahci.c	2009-07-27 18:55:47.000000000 +0800
@@ -533,6 +533,11 @@
 	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800 */
 	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */
 
+	/* AMD */
+	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
+	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci }, /* AMD RAID */
+
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
 	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
diff -ruN a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
--- a/drivers/ata/pata_atiixp.c	2009-07-27 18:55:56.000000000 +0800
+++ b/drivers/ata/pata_atiixp.c	2009-07-27 18:56:01.000000000 +0800
@@ -245,6 +245,7 @@
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_SB900_IDE), },
 
 	{ },
 };
diff -ruN a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
--- a/drivers/ide/atiixp.c	2009-07-27 18:57:07.000000000 +0800
+++ b/drivers/ide/atiixp.c	2009-07-27 18:57:12.000000000 +0800
@@ -177,6 +177,7 @@
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), 0 },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), 1 },
 	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), 0 },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_SB900_IDE), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff -ruN a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2009-07-27 18:56:41.000000000 +0800
+++ b/drivers/pci/quirks.c	2009-07-27 18:56:46.000000000 +0800
@@ -992,7 +992,7 @@
 
 static void __devinit quirk_amd_ide_mode(struct pci_dev *pdev)
 {
-	/* set sb600/sb700/sb800 sata to ahci mode */
+	/* set SBX00 SATA in IDE mode to AHCI mode */
 	u8 tmp;
 
 	pci_read_config_byte(pdev, PCI_CLASS_DEVICE, &tmp);
@@ -1011,6 +1011,8 @@
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SATA_IDE, quirk_amd_ide_mode);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SATA_IDE, quirk_amd_ide_mode);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
diff -ruN a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2009-07-27 18:54:41.000000000 +0800
+++ b/include/linux/pci_ids.h	2009-07-27 18:55:17.000000000 +0800
@@ -376,6 +376,9 @@
 #define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
 #define PCI_DEVICE_ID_ATI_IXP700_SATA	0x4390
 #define PCI_DEVICE_ID_ATI_IXP700_IDE	0x439c
+/* AMD SB Chipset */
+#define PCI_DEVICE_ID_AMD_SB900_IDE	 0x780c
+#define PCI_DEVICE_ID_AMD_SB900_SATA_IDE 0x7800
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005


