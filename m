From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [Ubuntu PATCH] add some NVIDIA chipset IDs
Date: Tue, 20 Jun 2006 22:32:45 -0700
Message-ID: <4498D9FD.6040900@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:63591 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751096AbWFUFbj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 01:31:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add some nVidia chipset ID's support.

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=b407680553280f9999a20706d5ab2a3be65312c1;hp=ce4cb48010ab2cca537432b5ccb47d4b1fb489e5

Snagged from lkml.


---
 drivers/ide/pci/amd74xx.c |    7 +++++--
 drivers/scsi/ahci.c       |   12 ++++++++++++
 drivers/scsi/sata_nv.c    |   11 ++++++++---
 include/linux/pci_ids.h   |    9 +++++++++
 4 files changed, 34 insertions(+), 5 deletions(-)

--- linux-2617-pv.orig/drivers/ide/pci/amd74xx.c
+++ linux-2617-pv/drivers/ide/pci/amd74xx.c
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40, AMD_UDMA_100 },
 	{ 0 }
 };
@@ -488,7 +489,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
-	/* 17 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP65"),
+	/* 18 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -525,7 +527,8 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
+	{ PCI_VENDOR_ID_AMD,    PCI_DEVICE_ID_AMD_CS5536_IDE,           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
--- linux-2617-pv.orig/drivers/scsi/sata_nv.c
+++ linux-2617-pv/drivers/scsi/sata_nv.c
@@ -140,12 +140,17 @@ static const struct pci_device_id nv_pci
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
--- linux-2617-pv.orig/drivers/scsi/ahci.c
+++ linux-2617-pv/drivers/scsi/ahci.c
@@ -296,6 +296,18 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		board_ahci }, /* MCP65 */
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* MCP65 */
 	{ }	/* terminate list */
 };
 
--- linux-2617-pv.orig/include/linux/pci_ids.h
+++ linux-2617-pv/include/linux/pci_ids.h
@@ -1182,6 +1182,15 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_14              0x0372
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE       0x0448
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI      0x044C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI2     0x044D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI3     0x044E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_AHCI4     0x044F
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA      0x045C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2     0x045D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3     0x045E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4     0x045F
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128



