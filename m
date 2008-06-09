From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Mon, 09 Jun 2008 18:43:10 +0900
Message-ID: <484CFB2E.30202@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de> <483F804F.1@gmail.com> <200805301243.39751.volker.armin.hemmann@tu-clausthal.de> <4840A085.2080101@gmail.com> <15F501D1A78BD343BE8F4D8DB854566B2AA19253@hkemmail01.nvidia.com> <484CF531.30804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010700080500010502070206"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:42094 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294AbYFIJnT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 05:43:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2033790wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 02:43:16 -0700 (PDT)
In-Reply-To: <484CF531.30804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

This is a multi-part message in MIME format.
--------------010700080500010502070206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Volker, can you please test the attached patch?

Thanks.

-- 
tejun

--------------010700080500010502070206
Content-Type: text/x-patch;
 name="mcp65-ahci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcp65-ahci.patch"

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
 

--------------010700080500010502070206--
