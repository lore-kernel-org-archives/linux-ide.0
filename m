From: "Peer Chen" <pchen@nvidia.com>
Subject: [Patch] IDE: Add nvidia IDE controller of MCP67 support to amd74xx.c
Date: Tue, 31 Oct 2006 16:03:35 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D5A1@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:528 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422925AbWJaIGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 03:06:36 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Add the support for IDE controller of MCP67.
The following amd74xx.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- amd74xx.c.orig	2006-10-30 14:13:08.000000000 +0800
+++ amd74xx.c	2006-10-31 13:44:36.000000000 +0800
@@ -75,6 +75,7 @@ static struct amd_ide_chip {
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	0x50,
AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	0x50,
AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	0x50,
AMD_UDMA_133 },
+	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE,	0x50,
AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_AMD_CS5536_IDE,			0x40,
AMD_UDMA_100 },
 	{ 0 }
 };
@@ -491,7 +492,8 @@ static ide_pci_device_t amd74xx_chipsets
 	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
 	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61"),
 	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP65"),
-	/* 19 */ DECLARE_AMD_DEV("AMD5536"),
+	/* 19 */ DECLARE_NV_DEV("NFORCE-MCP67"),
+	/* 20 */ DECLARE_AMD_DEV("AMD5536"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct
pci_device_id *id)
@@ -530,7 +532,8 @@ static struct pci_device_id amd74xx_pci_
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19 },
+	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
