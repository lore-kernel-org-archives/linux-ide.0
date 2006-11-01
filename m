From: "Peer Chen" <pchen@nvidia.com>
Subject: [PATCH 2/2] sata_nv: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Date: Wed, 1 Nov 2006 17:01:15 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C54F5CF@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:32313 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1423959AbWKAJBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 04:01:40 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Add device IDs of SATA controllers of MCP67 to pci_ids.h.
The patch will be applied to kernel 2.6.19-rc4-git1.

Signed-off-by: Peer Chen <pchen@nvidia.com>

=============================================
--- linux-2.6.19-rc4-git1/include/linux/pci_ids.h.orig
+++ linux-2.6.19-rc4-git1/include/linux/pci_ids.h
@@ -1213,6 +1213,15 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
 #define PCI_DEVICE_ID_NVIDIA_NVENET_23              0x0453
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA      0x045C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2     0x045D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3     0x045E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4     0x045F
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA      0x0550
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA2     0x0551
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA3     0x0552
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA4     0x0553
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE       0x0560
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
