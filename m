From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH] Intel device IDs SATA
Date: Tue,  3 Nov 2015 11:09:51 -0800
Message-ID: <1446577791-3087-1-git-send-email-alexandra.yates@linux.intel.com>
References: <Intel device IDs SATA>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52162 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303AbbKCTHK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2015 14:07:10 -0500
In-Reply-To: <Intel device IDs SATA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename Lewisburg platform device IDs for SATA.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/ata/ahci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a466602..8c7a04a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -68,6 +68,7 @@ enum board_ids {
 	board_ahci_yes_fbs,
 
 	/* board IDs for specific chipsets in alphabetical order */
+	board_ahci_lbg,
 	board_ahci_avn,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
@@ -161,6 +162,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	/* by chipsets */
+	[board_ahci_lbg] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
+
 	[board_ahci_avn] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -314,6 +322,16 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci_lbg }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci_lbg }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci_lbg }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci_lbg }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
-- 
1.9.1

