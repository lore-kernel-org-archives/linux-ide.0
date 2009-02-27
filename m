From: "peerchen" <peerchen@gmail.com>
Subject: [PATCH] ahci: Add the Device IDs for MCP89 and remove IDs of MCP7B to/from ahci.c
Date: Fri, 27 Feb 2009 16:58:41 +0800
Message-ID: <200902271658395061296@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:21908 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZB0I62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 03:58:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Added the Device IDs for MCP89 AHCI controller.
Removed the IDs of MCP7B cause this chipset had been cancel.

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.29-rc6/drivers/ata/ahci.c.orig	2009-02-26 08:42:03.000000000 -0500
+++ linux-2.6.29-rc6/drivers/ata/ahci.c	2009-02-26 08:44:13.000000000 -0500
@@ -582,18 +582,18 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc8), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc9), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bca), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bcb), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bcc), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc4), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc5), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc6), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0d84), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d85), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d86), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d87), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d88), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d89), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8a), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8b), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8c), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8d), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8e), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8f), board_ahci },		/* MCP89 */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci },		/* SiS 966 */
-

