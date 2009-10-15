From: peer chen <peerchen@gmail.com>
Subject: [PATCH] ahci: Add the AHCI controller Linux Device ID for NVIDIA
	chipsets.
Date: Thu, 15 Oct 2009 16:34:56 +0800
Message-ID: <cfaab6210910150134q6cc2d5ffna39cf31bf89a8e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932387AbZJOIfe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, akpm <akpm@linux-foundation.org>, pchen@nvidia.com
List-Id: linux-ide@vger.kernel.org

Add the generic device ID for NVIDIA AHCI controller.

Signed-off-by: Peer Chen<peerchen@gmail.com>
---
--- linux-2.6.32-rc4/drivers/ata/ahci.c.orig
+++ linux-2.6.32-rc4/drivers/ata/ahci.c
@@ -605,6 +605,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_yesncq },	/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_yesncq },	/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_yesncq },	/* Linux ID */
 	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_yesncq },	/* MCP73 */
 	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_yesncq },	/* MCP73 */
 	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_yesncq },	/* MCP73 */
-
