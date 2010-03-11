From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 2/3] ahci: clean up board IDs
Date: Thu, 11 Mar 2010 11:39:38 +0900
Message-ID: <4B9857EA.5090101@kernel.org>
References: <4B98575C.5050508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35373 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab0CKCjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 21:39:48 -0500
In-Reply-To: <4B98575C.5050508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, pchen@nvidia.com, kernel-bugzilla.20.drkshadow@spamgourmet.com

ahci over time has grown a number of board IDs and it's a bit of mess
right now.  Clean it up such that,

* board_id_* now live in a separate enum board_ids and numbers are
  assigned automatically.

* Board IDs assigned to features are separated from the ones assigned
  to specific implementations and both are ordered alphabetically.

* For NV MCPs, define per-generation alias board_ids and assign
  matching aliases in the pci id table.  This makes mcp_linux, 67-73
  use board_ahci_mcp65 instead of board_ahci_yesncq.  Both are
  identical in content.

* Kill now unused board_ahci_nopmp and board_ahci_yesncq.

This patch doesn't cause any functional change but will make future
changes to board_ids and quirks much less painful.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
---
This might seem a bit too much for #upstream-fixes but it contains no
functional changes and will ease future fixes, so I think including it
in -fixes would be better.

Thanks.

 drivers/ata/ahci.c |  239 ++++++++++++++++++++++++++---------------------------
 1 file changed, 118 insertions(+), 121 deletions(-)

Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -107,17 +107,6 @@ enum {
 	RX_FIS_SDB		= 0x58, /* offset of SDB FIS data */
 	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
-	board_ahci		= 0,
-	board_ahci_vt8251	= 1,
-	board_ahci_ign_iferr	= 2,
-	board_ahci_sb600	= 3,
-	board_ahci_mv		= 4,
-	board_ahci_sb700	= 5, /* for SB700 and SB800 */
-	board_ahci_mcp65	= 6,
-	board_ahci_nopmp	= 7,
-	board_ahci_yesncq	= 8,
-	board_ahci_nosntf	= 9,
-
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
 	HOST_CTL		= 0x04, /* global host control */
@@ -270,6 +259,28 @@ enum {
 	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
 };
 
+enum board_ids {
+	/* board IDs by feature in alphabetical order */
+	board_ahci,
+	board_ahci_ign_iferr,
+	board_ahci_nosntf,
+
+	/* board IDs for specific chipsets in alphabetical order */
+	board_ahci_mcp65,
+	board_ahci_mv,
+	board_ahci_sb600,
+	board_ahci_sb700,	/* for SB700 and SB800 */
+	board_ahci_vt8251,
+
+	/* aliases */
+	board_ahci_mcp_linux	= board_ahci_mcp65,
+	board_ahci_mcp67	= board_ahci_mcp65,
+	board_ahci_mcp73	= board_ahci_mcp65,
+	board_ahci_mcp77	= board_ahci,
+	board_ahci_mcp79	= board_ahci,
+	board_ahci_mcp89	= board_ahci,
+};
+
 struct ahci_cmd_hdr {
 	__le32			opts;
 	__le32			status;
@@ -462,6 +473,7 @@ static struct ata_port_operations ahci_s
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
 
 static const struct ata_port_info ahci_port_info[] = {
+	/* by features */
 	[board_ahci] =
 	{
 		.flags		= AHCI_FLAG_COMMON,
@@ -469,31 +481,30 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_vt8251] =
+	[board_ahci_ign_iferr] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_vt8251_ops,
+		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_ign_iferr] =
+	[board_ahci_nosntf] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_sb600] =
+	/* by chipsets */
+	[board_ahci_mcp65] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255 |
-				 AHCI_HFLAG_32BIT_ONLY),
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_sb600_ops,
+		.port_ops	= &ahci_ops,
 	},
 	[board_ahci_mv] =
 	{
@@ -505,45 +516,31 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_sb700] =	/* for SB700 and SB800 */
+	[board_ahci_sb600] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
+				 AHCI_HFLAG_NO_MSI | AHCI_HFLAG_SECT255 |
+				 AHCI_HFLAG_32BIT_ONLY),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_sb600_ops,
 	},
-	[board_ahci_mcp65] =
-	{
-		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
-	[board_ahci_nopmp] =
-	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
-	[board_ahci_yesncq] =
+	[board_ahci_sb700] =	/* for SB700 and SB800 */
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_sb600_ops,
 	},
-	[board_ahci_nosntf] =
+	[board_ahci_vt8251] =
 	{
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
+		.port_ops	= &ahci_vt8251_ops,
 	},
 };
 
@@ -628,82 +625,82 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci_mcp65 },	/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci_mcp65 },	/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci_mcp65 },	/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_yesncq },	/* MCP67 */
-	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0581), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0582), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0583), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0584), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0585), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0586), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0587), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0588), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x0589), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058a), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058b), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058c), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058d), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058e), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x058f), board_ahci_yesncq },	/* Linux ID */
-	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci_yesncq },	/* MCP73 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad3), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad4), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad5), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad6), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad7), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad8), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d84), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d85), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d86), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d87), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d88), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d89), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8a), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8b), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8c), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8d), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8e), board_ahci },		/* MCP89 */
-	{ PCI_VDEVICE(NVIDIA, 0x0d8f), board_ahci },		/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_mcp67 },	/* MCP67 */
+	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0581), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0582), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0583), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0584), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0585), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0586), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0587), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0588), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x0589), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058a), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058b), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058c), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058d), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058e), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x058f), board_ahci_mcp_linux },	/* Linux ID */
+	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci_mcp73 },	/* MCP73 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad3), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad4), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad5), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad6), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad7), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad8), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci_mcp77 },	/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci_mcp79 },	/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d84), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d85), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d86), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d87), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d88), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d89), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8a), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8b), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8c), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8d), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8e), board_ahci_mcp89 },	/* MCP89 */
+	{ PCI_VDEVICE(NVIDIA, 0x0d8f), board_ahci_mcp89 },	/* MCP89 */
 
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci },		/* SiS 966 */
