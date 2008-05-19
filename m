From: "peerchen" <peerchen@gmail.com>
Subject: [PATCH] ahci: change the Device IDs of nvidia MCP7B AHCI controller in ahci.c
Date: Mon, 19 May 2008 14:44:57 +0800
Message-ID: <200805191444539981741@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756260AbYESGpW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Change the partial Device IDs of nvidia MCP7B AHCI controller in ahci.c

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.26-rc3/drivers/ata/ahci.c.orig	2008-05-07 13:24:19.000000000 -0400
+++ linux-2.6.26-rc3/drivers/ata/ahci.c	2008-05-07 13:25:17.000000000 -0400
@@ -502,10 +502,10 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
 	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
 	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bd0), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bd1), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bd2), board_ahci },		/* MCP7B */
-	{ PCI_VDEVICE(NVIDIA, 0x0bd3), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc4), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc5), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc6), board_ahci },		/* MCP7B */
+	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-
