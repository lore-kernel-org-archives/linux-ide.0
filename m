From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] amd74xx: Support MCP55 device IDs
Date: Sun, 03 Jul 2005 13:44:31 +0100
Message-ID: <42C7DDAF.8000906@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060606070900070408080509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:19996 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261412AbVGCMns (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 08:43:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, rpunkunus@nvidia.com

This is a multi-part message in MIME format.
--------------060606070900070408080509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Rob Punkunus <rpunkunus@nvidia.com>

Rob Punkunus recently submitted a patch to enable support for MCP51/MCP55 in
the amd74xx driver. This patch was whitespace-corrupted and didn't apply to
2.6.12 since MCP51 support was merged in the 2.6.12-rc series.

Gentoo would like to support this hardware for our upcoming release media, so
I fixed the patch, and here it is :)

Jeff, since the next patch I'm sending (a libata patch) depends on the
pci_ids.h change in this patch, it probably makes sense to include both in
your tree..?

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------060606070900070408080509
Content-Type: text/x-patch;
 name="4335_amd74xx-mcp55.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4335_amd74xx-mcp55.patch"

--- linux-2.6.12/drivers/ide/pci/amd74xx.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-dsd/drivers/ide/pci/amd74xx.c	2005-06-27 18:45:26.000000000 +0100
@@ -73,6 +73,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	0x50, AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -489,6 +490,7 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
 	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
+	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -524,6 +526,7 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
--- linux-2.6.12/include/linux/pci_ids.h	2005-06-17 20:48:29.000000000 +0100
+++ linux-dsd/include/linux/pci_ids.h	2005-06-27 18:47:12.000000000 +0100
@@ -1234,6 +1234,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE	0x0265
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
 #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
 #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B

--------------060606070900070408080509--
