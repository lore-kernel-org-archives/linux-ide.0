From: "peerchen" <peerchen@gmail.com>
Subject: [PATCH] ahci: add the Device IDs of nvidia MCP7B AHCI controller to ahci.c
Date: Thu, 6 Mar 2008 21:22:41 +0800
Message-ID: <200803062122359218883@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:3652 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760273AbYCFNWs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 08:22:48 -0500
Received: by rn-out-0910.google.com with SMTP id v46so970852rnb.15
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 05:22:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Add the device IDs of nvidia MCP79 AHCI controller to ahci.c

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.25-rc4/drivers/ata/ahci.c.orig	2008-03-04 21:46:30.000000000 -0500
+++ linux-2.6.25-rc4/drivers/ata/ahci.c	2008-03-04 21:50:42.000000000 -0500
@@ -563,6 +563,18 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
 	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc8), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc9), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bca), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bcb), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bcc), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bd0), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bd1), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bd2), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bd3), board_ahci },		/* MCP7B */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-

