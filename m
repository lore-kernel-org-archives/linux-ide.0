From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: reimplement port_map handling
Date: Fri, 20 Jul 2007 17:59:34 +0900
Message-ID: <20070720085934.GD22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:50120 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbXGTI7k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 04:59:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so925545wah
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 01:59:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Reimplement port_map handling such that

1. Non-zero PORTS_IMPL value is always examined and used if consistent
   with cap.n_ports.

2. When PI and cat.n_ports are inconsistent, honor cap.n_ports and
   force port_map to be ((1 << cap.n_ports) - 1).

3. There were two separate places dealing with port_map.  Unify them
   to one.

As all newer ahci chips seem to get PI correct and older ones usually
have zero PI.  Controllers with holes in PI are very unlikely to screw
up PI, so #2 makes more sense than following inconsistent PI.

Without this change, not setting ATA_FLAG_HONOR_PI when it's needed
results in weird detection failure.  This changed logic should be able
to handle all known cases correctly automatically.

Verified on ICH6 (reports 0 PI), ICH8 (with holes in port_map), ICH9,
JMB360 and JMB363.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, SIS chips seem to require HONOR_PI flag for -stable.  I'll
submit the patch as soon as it's verified.  For -upstream, I think
this is much better fix.

Thanks.

 ahci.c |   89 ++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11e4eb9..1a44ac7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -77,11 +77,10 @@ enum {
 	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
 
 	board_ahci		= 0,
-	board_ahci_pi		= 1,
-	board_ahci_vt8251	= 2,
-	board_ahci_ign_iferr	= 3,
-	board_ahci_sb600	= 4,
-	board_ahci_mv		= 5,
+	board_ahci_vt8251	= 1,
+	board_ahci_ign_iferr	= 2,
+	board_ahci_sb600	= 3,
+	board_ahci_mv		= 4,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -169,7 +168,6 @@ enum {
 	/* ap->flags bits */
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
-	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
 	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
 	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
 	AHCI_FLAG_MV_PATA		= (1 << 29), /* PATA port */
@@ -336,13 +334,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	/* board_ahci_pi */
-	{
-		.flags		= AHCI_FLAG_COMMON | AHCI_FLAG_HONOR_PI,
-		.pio_mask	= 0x1f, /* pio0-4 */
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
 	/* board_ahci_vt8251 */
 	{
 		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_HRST_TO_RESUME |
@@ -372,9 +363,8 @@ static const struct ata_port_info ahci_port_info[] = {
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_HONOR_PI |
-				  AHCI_FLAG_NO_NCQ | AHCI_FLAG_NO_MSI |
-				  AHCI_FLAG_MV_PATA,
+				  ATA_FLAG_SKIP_D2H_BSY | AHCI_FLAG_NO_NCQ |
+				  AHCI_FLAG_NO_MSI | AHCI_FLAG_MV_PATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
@@ -393,23 +383,23 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
-	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pi }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_pi }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pi }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pi }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pi }, /* ICH8M */
-	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_pi }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_pi }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_pi }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_pi }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -552,16 +542,6 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 		cap &= ~HOST_CAP_64;
 	}
 
-	/* fixup zero port_map */
-	if (!port_map) {
-		port_map = (1 << ahci_nr_ports(cap)) - 1;
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "PORTS_IMPL is zero, forcing 0x%x\n", port_map);
-
-		/* write the fixed up value to the PI register */
-		hpriv->saved_port_map = port_map;
-	}
-
 	/*
 	 * Temporary Marvell 6145 hack: PATA port presence
 	 * is asserted through the standard AHCI port
@@ -577,7 +557,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 	}
 
 	/* cross check port_map and cap.n_ports */
-	if (pi->flags & AHCI_FLAG_HONOR_PI) {
+	if (port_map) {
 		u32 tmp_port_map = port_map;
 		int n_ports = ahci_nr_ports(cap);
 
@@ -588,17 +568,26 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 			}
 		}
 
-		/* Whine if inconsistent.  No need to update cap.
-		 * port_map is used to determine number of ports.
+		/* If n_ports and port_map are inconsistent, whine and
+		 * clear port_map and let it be generated from n_ports.
 		 */
-		if (n_ports || tmp_port_map)
+		if (n_ports || tmp_port_map) {
 			dev_printk(KERN_WARNING, &pdev->dev,
 				   "nr_ports (%u) and implemented port map "
-				   "(0x%x) don't match\n",
+				   "(0x%x) don't match, using nr_ports\n",
 				   ahci_nr_ports(cap), port_map);
-	} else {
-		/* fabricate port_map from cap.nr_ports */
+			port_map = 0;
+		}
+	}
+
+	/* fabricate port_map from cap.nr_ports */
+	if (!port_map) {
 		port_map = (1 << ahci_nr_ports(cap)) - 1;
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "forcing PORTS_IMPL to 0x%x\n", port_map);
+
+		/* write the fixed up value to the PI register */
+		hpriv->saved_port_map = port_map;
 	}
 
 	/* record values to use during operation */
