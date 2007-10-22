From: Gerhard Dirschl <gd@spherenet.de>
Subject: BUG: sata_nv swncq cannot be disabled
Date: Mon, 22 Oct 2007 04:06:23 +0200
Message-ID: <200710220406.23790.gd@spherenet.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61732 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXJVCGd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2007 22:06:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I stumbled over a bug in the sata_nv swncq code of the current
2.6.23-git kernel. ata_port_info.flags is always initialised with the
ATA_FLAG_NCQ flag set, but nv_swncq_host_init(...) is only called
if "swncq=1" is passed to the driver (default is swncq=0).
I can can observe ata link resets under high load if I don't pass
sata_nv.swncq=1 to my kernel.

Former versions of the SWNCQ patch didn't have this problem as
ATA_FLAG_NCQ was set in nv_swncq_host_init(...). The appended patch
restores this behaviour (or was it changed for a good reason?)
We could also simply drop the option to enable/disable swncq.

I'm not subscribed to the list so please CC me on replies.

   Gerhard
---

--- linux-2.6/drivers/ata/sata_nv.c	2007-10-22 00:07:40.000000000 +0200
+++ linux-2.4.24/drivers/ata/sata_nv.c	2007-10-22 03:40:06.132619662 +0200
@@ -622,8 +622,7 @@ static const struct ata_port_info nv_por
 	/* SWNCQ */
 	{
 		.sht		= &nv_swncq_sht,
-		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_NCQ,
+		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 		.link_flags	= ATA_LFLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -1831,6 +1830,9 @@ static int nv_swncq_port_suspend(struct 
 	/* clear irq */
 	writel(~0, mmio + NV_INT_STATUS_MCP55);
 
+	if (!(ap->flags & ATA_FLAG_NCQ))
+		return 0;
+
 	/* disable irq */
 	writel(0, mmio + NV_INT_ENABLE_MCP55);
 
@@ -1850,6 +1852,9 @@ static int nv_swncq_port_resume(struct a
 	/* clear irq */
 	writel(~0, mmio + NV_INT_STATUS_MCP55);
 
+	if (!(ap->flags & ATA_FLAG_NCQ))
+		return 0;
+
 	/* enable irq */
 	writel(0x00fd00fd, mmio + NV_INT_ENABLE_MCP55);
 
@@ -1867,6 +1872,7 @@ static void nv_swncq_host_init(struct at
 	void __iomem *mmio = host->iomap[NV_MMIO_BAR];
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	u8 regval;
+	int i;
 
 	/* disable  ECO 398 */
 	pci_read_config_byte(pdev, 0x7f, &regval);
@@ -1878,6 +1884,9 @@ static void nv_swncq_host_init(struct at
 	VPRINTK("HOST_CTL:0x%X\n", tmp);
 	writel(tmp | NV_CTL_PRI_SWNCQ | NV_CTL_SEC_SWNCQ, mmio + NV_CTL_MCP55);
 
+	for (i = 0; i < host->n_ports; i++)
+		host->ports[i]->flags |= ATA_FLAG_NCQ;
+
 	/* enable irq intr */
 	tmp = readl(mmio + NV_INT_ENABLE_MCP55);
 	VPRINTK("HOST_ENABLE:0x%X\n", tmp);
