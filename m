From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/3] ahci: add missing nv IDs
Date: Thu, 11 Mar 2010 11:37:16 +0900
Message-ID: <4B98575C.5050508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46272 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab0CKCh3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 21:37:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

bko#15481 shows that we're missing some NVIDIA ahci PCI IDs.  Peer
Chen confirms that IDs 0x580-0x58f are reserved for cases where Linux
ID option is selected in the BIOS and are only used for mcp65-73.  Add
0x0581-0x058f.

  http://bugzilla.kernel.org/show_bug.cgi?id=15481

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
---
 drivers/ata/ahci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -641,6 +641,21 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_yesncq },	/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_yesncq },	/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0581), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0582), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0583), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0584), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0585), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0586), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0587), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0588), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0589), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058a), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058b), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058c), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058d), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058e), board_ahci_yesncq },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058f), board_ahci_yesncq },	/* Linux ID */
 	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_yesncq },	/* MCP73 */
 	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_yesncq },	/* MCP73 */
 	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_yesncq },	/* MCP73 */
