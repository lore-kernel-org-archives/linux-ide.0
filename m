From: "Peer Chen" <peerchen@gmail.com>
Subject: [PATCH] ahci: Add MCP79 support to AHCI driver
Date: Fri, 21 Sep 2007 14:06:10 +0800
Message-ID: <200709211406065332552@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:56605 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXIUGGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 02:06:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so872099wah
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 23:06:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Add the MCP79 support to ahci driver.
The patch base on kernel 2.6.23-rc7
 
Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.000000000 -0400
+++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-21 13:54:58.000000000 -0400
@@ -472,6 +472,18 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-

