From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: workarounds for mcp65
Date: Tue, 10 Jun 2008 00:13:04 +0900
Message-ID: <484D4880.2050103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:32909 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYFIPNL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 11:13:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so359934rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 08:13:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>, Peer Chen <pchen@nvidia.com>

MCP65 ahci can do NCQ but doesn't set the CAP bit and rev A0 and A1
can't do MSI but have MSI capability.  Implement AHCI_HFLAG_YES_NCQ
and apply appropriate workarounds.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>
---
 drivers/ata/ahci.c |   40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 544b7d6..1c62b8e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -89,6 +89,7 @@ enum {
 	board_ahci_sb600	= 3,
 	board_ahci_mv		= 4,
 	board_ahci_sb700	= 5,
+	board_ahci_mcp65	= 6,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -190,6 +191,7 @@ enum {
 	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
 	AHCI_HFLAG_NO_HOTPLUG		= (1 << 7), /* ignore PxSERR.DIAG.N */
 	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
 
 	/* ap->flags bits */
 
@@ -384,6 +386,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_mcp65 */
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -438,14 +448,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
 
 	/* NVIDIA */
-	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci },		/* MCP65 */
-	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci_mcp65 },	/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci_mcp65 },	/* MCP65 */
 	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci },		/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci },		/* MCP67 */
 	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci },		/* MCP67 */
@@ -624,6 +634,12 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 		cap &= ~HOST_CAP_NCQ;
 	}
 
+	if (!(cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_YES_NCQ)) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			   "controller can do NCQ, turning on CAP_NCQ\n");
+		cap |= HOST_CAP_NCQ;
+	}
+
 	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "controller can't do PMP, turning off CAP_PMP\n");
@@ -2118,7 +2134,8 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info pi = ahci_port_info[ent->driver_data];
+	unsigned int board_id = ent->driver_data;
+	struct ata_port_info pi = ahci_port_info[board_id];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
@@ -2167,6 +2184,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	hpriv->flags |= (unsigned long)pi.private_data;
 
+	/* MCP65 revision A1 and A2 can't do MSI */
+	if (board_id == board_ahci_mcp65 &&
+	    (pdev->revision == 0xa1 || pdev->revision == 0xa2))
+		hpriv->flags |= AHCI_HFLAG_NO_MSI;
+
 	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
 
