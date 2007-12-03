From: "peerchen" <peerchen@gmail.com>
Subject: [PATCH] ahci: add the Device IDs of MCP79 AHCI controller to ahci.c
Date: Mon, 3 Dec 2007 22:20:37 +0800
Message-ID: <200712032220233286345@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:38203 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbXLCOUr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 09:20:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5202569wah
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 06:20:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Add the device IDs of legacy mode of MCP79 AHCI controller to ahci.c

The patch base on kernel 2.6.24-rc3

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.24-rc3/drivers/ata/ahci.c.orig	2007-12-03 16:20:15.000000000 -0500
+++ linux-2.6.24-rc3/drivers/ata/ahci.c	2007-12-03 16:32:11.000000000 -0500
@@ -536,6 +536,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
-

