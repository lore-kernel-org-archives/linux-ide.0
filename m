From: Rob Punkunus <rpunkunus@nvidia.com>
Subject: [PATCH][2.4.31] amd74xx patch for new NVIDIA device IDs
Date: Wed, 22 Jun 2005 20:19:56 -0700
Message-ID: <1119496571.2068.12.camel@dhcp-174-26.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.112.143]:11277 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261930AbVFWBRK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2005 21:17:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rpunkunus@nvidia.com, blazara@nvidia.com, acurrid@nvidia.com, achew@nvidia.com, amartin@nvidia.com, bzolnier@gmail.com, vojtech@suse.cz, gregkh@suse.de, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Rob Punkunus <rpunkunus@nvidia.com>
---

diff -pur linux-2.4.31/drivers/ide/pci/amd74xx.c patch-linux-2.4.31/drivers/ide/pci/amd74xx.c
--- linux-2.4.31/drivers/ide/pci/amd74xx.c	2004-11-17 03:54:21.000000000 -0800
+++ patch-linux-2.4.31/drivers/ide/pci/amd74xx.c	2005-06-20 05:43:13.000000000 -0700
@@ -71,6 +71,8 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE, 	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -473,6 +475,8 @@ static struct pci_device_id amd74xx_pci_
 #endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
 	{ 0, },
 };
 
diff -pur linux-2.4.31/drivers/ide/pci/amd74xx.h patch-linux-2.4.31/drivers/ide/pci/amd74xx.h
--- linux-2.4.31/drivers/ide/pci/amd74xx.h	2004-11-17 03:54:21.000000000 -0800
+++ patch-linux-2.4.31/drivers/ide/pci/amd74xx.h	2005-06-17 08:19:22.000000000 -0700
@@ -197,6 +197,31 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},
+
+	{
+		/* 15 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,
+		.name		= "NFORCE-MCP51",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
+	{
+		/* 16 */
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,
+		.name		= "NFORCE-MCP55",
+		.init_chipset	= init_chipset_amd74xx,
+		.init_hwif	= init_hwif_amd74xx,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
+		.bootable	= ON_BOARD,
+	},
 	{
 		.vendor		= 0,
 		.device		= 0,
Only in patch-linux-2.4.31/include: asm
Only in patch-linux-2.4.31/include/linux: modules
diff -pur linux-2.4.31/include/linux/pci_ids.h patch-linux-2.4.31/include/linux/pci_ids.h
--- linux-2.4.31/include/linux/pci_ids.h	2005-05-31 17:56:56.000000000 -0700
+++ patch-linux-2.4.31/include/linux/pci_ids.h	2005-06-20 05:49:07.000000000 -0700
@@ -1034,6 +1034,8 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_DDC		0x0203
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE   0x036E
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849



