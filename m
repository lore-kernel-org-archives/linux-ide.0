From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 2/2] ahci: implement AHCI_HFLAG_NO_FPDMA_AA and
 update NV quirks
Date: Mon, 29 Mar 2010 10:33:24 +0900
Message-ID: <4BB00364.40701@kernel.org>
References: <4BB00337.1030302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51177 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab0C2Bda (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2010 21:33:30 -0400
In-Reply-To: <4BB00337.1030302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

It turns out different generations of MCPs have differing quirks.

* MCP 65-73 : FPDMA AA broken, lies about PMP support, forgets to report NCQ
* MCP 77-79 : FPDMA AA broken, lies about PMP support
* MCP 89    : FPDMA AA broken

Instead of turngin off FPDMA AA on all NVIDIAs, implement
HFLAG_NO_FPDMA_AA, define additional board IDs and apply necessary
quirks.

This fixes bko#15481 and the list of quirks is verified by Peer Chen.

  http://bugzilla.kernel.org/show_bug.cgi?id=15481

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
---
 drivers/ata/ahci.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -62,6 +62,8 @@ enum board_ids {

 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_mcp65,
+	board_ahci_mcp77,
+	board_ahci_mcp89,
 	board_ahci_mv,
 	board_ahci_sb600,
 	board_ahci_sb700,	/* for SB700 and SB800 */
@@ -71,9 +73,7 @@ enum board_ids {
 	board_ahci_mcp_linux	= board_ahci_mcp65,
 	board_ahci_mcp67	= board_ahci_mcp65,
 	board_ahci_mcp73	= board_ahci_mcp65,
-	board_ahci_mcp77	= board_ahci,
-	board_ahci_mcp79	= board_ahci,
-	board_ahci_mcp89	= board_ahci,
+	board_ahci_mcp79	= board_ahci_mcp77,
 };

 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -134,7 +134,24 @@ static const struct ata_port_info ahci_p
 	/* by chipsets */
 	[board_ahci_mcp65] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
+				 AHCI_HFLAG_YES_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
+	[board_ahci_mcp77] =
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
+	[board_ahci_mcp89] =
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -1102,12 +1119,13 @@ static int ahci_init_one(struct pci_dev
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ) {
 		pi.flags |= ATA_FLAG_NCQ;
-		/* Auto-activate optimization is supposed to be supported on
-		   all AHCI controllers indicating NCQ support, but it seems
-		   to be broken at least on some NVIDIA MCP79 chipsets.
-		   Until we get info on which NVIDIA chipsets don't have this
-		   issue, if any, disable AA on all NVIDIA AHCIs. */
-		if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+		/*
+		 * Auto-activate optimization is supposed to be
+		 * supported on all AHCI controllers indicating NCQ
+		 * capability, but it seems to be broken on some
+		 * chipsets including NVIDIAs.
+		 */
+		if (!(hpriv->flags & AHCI_HFLAG_NO_FPDMA_AA))
 			pi.flags |= ATA_FLAG_FPDMA_AA;
 	}

