From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: force CAP_NCQ for earlier NV MCPs
Date: Wed, 08 Apr 2009 14:25:31 -0700
Message-ID: <49DD164B.6000809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39124 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbZDHVZ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 17:25:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, zaceni2@yandex.ru

Along with MCP65, MCP67 and 73 also don't set CAP_NCQ.  Force it.
Reported by zaceni@yandex.ru on bko#13014 and confirmed by Peer Chen.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: NightFox <zaceni2@yandex.ru>
Cc: Peer Chen <pchen@nvidia.com>
---
 drivers/ata/ahci.c |   57 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

 drivers/ata/ahci.c |   57 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 788bba2..4c43a1d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -113,6 +113,7 @@ enum {
 	board_ahci_sb700	= 5, /* for SB700 and SB800 */
 	board_ahci_mcp65	= 6,
 	board_ahci_nopmp	= 7,
+	board_ahci_yesncq	= 8,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -468,6 +469,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_yesncq */
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -534,30 +543,30 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci_mcp65 },	/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci_mcp65 },	/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci },		/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci },		/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci },		/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_yesncq },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci_yesncq },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci_yesncq },	/* MCP73 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci },		/* MCP77 */
