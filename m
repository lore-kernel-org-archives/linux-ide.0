From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: sis can't do PMP
Date: Mon, 16 Jun 2008 11:38:22 +0900
Message-ID: <4855D21E.5020706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46104 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbYFPCig (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jun 2008 22:38:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, piterpunk@slackware.com

From: Piter PUNK <piterpunk@slackware.com>

SiS AHCIs say they can do PMP but can't and fail detection if SRST w/
pmp==15 is used.  Turn off PMP support.

tj: added patch description, adapted patch to #upstream-fixes and
    renamed board_ahci_sis to board_ahci_nopmp.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 544b7d6..c81f09c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -89,6 +89,7 @@ enum {
 	board_ahci_sb600	= 3,
 	board_ahci_mv		= 4,
 	board_ahci_sb700	= 5,
+	board_ahci_nopmp	= 6,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -384,6 +385,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_nopmp */
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -508,9 +517,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */
 
 	/* SiS */
-	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
+	{ PCI_VDEVICE(SI, 0x1184), board_ahci_nopmp },		/* SiS 966 */
+	{ PCI_VDEVICE(SI, 0x1185), board_ahci_nopmp },		/* SiS 968 */
+	{ PCI_VDEVICE(SI, 0x0186), board_ahci_nopmp },		/* SiS 968 */
 
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
