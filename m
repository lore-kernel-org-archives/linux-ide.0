From: Rob Punkunus <rpunkunus@nvidia.com>
Subject: [PATCH][2.6.11.12] amd74xx patch for new NVIDIA device IDs
Date: Thu, 23 Jun 2005 15:39:26 -0700
Message-ID: <1119566365.1819.11.camel@dhcp-174-26.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:33356 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262986AbVFWUg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2005 16:36:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rpunkunus@nvidia.com, blazara@nvidia.com, acurrid@nvidia.com, amartin@nvidia.com, achew@nvidia.com, bzolnier@gmail.com, vojtech@suse.cz, gregkh@suse.de, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Rob Punkunus <rpunkunus@nvidia.com>
---

diff -pur linux-2.6.11.12/drivers/ide/pci/amd74xx.c patch-linux-2.6.11.12/drivers/ide/pci/amd74xx.c
--- linux-2.6.11.12/drivers/ide/pci/amd74xx.c	2005-06-11 19:45:37.000000000 -0700
+++ patch-linux-2.6.11.12/drivers/ide/pci/amd74xx.c	2005-06-17 09:55:21.000000000 -0700
@@ -72,6 +72,8 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE, 	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -487,6 +489,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
 	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
+	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
+	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -521,6 +525,8 @@ static struct pci_device_id amd74xx_pci_
 #endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -pur linux-2.6.11.12/include/linux/pci_ids.h patch-linux-2.6.11.12/include/linux/pci_ids.h
--- linux-2.6.11.12/include/linux/pci_ids.h	2005-06-11 19:45:37.000000000 -0700
+++ patch-linux-2.6.11.12/include/linux/pci_ids.h	2005-06-20 05:56:05.000000000 -0700
@@ -1166,6 +1166,8 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0



