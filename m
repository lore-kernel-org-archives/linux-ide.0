From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/9] make ata_pci_init_one() not use ops->irq_handler and pi->sht
Date: Wed, 30 Jan 2008 18:29:00 +0900
Message-ID: <12016853443940-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:38461 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbYA3J3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277510wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:18 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

ata_pci_init_one() is the only function which uses ops->irq_handler
and pi->sht.  Other initialization functions take the same information
as arguments.  This causes confusion and duplicate unused entries in
structures.

Make ata_pci_init_one() take sht as an argument and use ata_interrupt
implicitly.  All current users use ata_interrupt and if different irq
handler is necessary open coding ata_pci_init_one() using
ata_prepare_sff_host() and ata_activate_sff_host can be done under ten
lines including error handling and driver which requires custom
interrupt handler is likely to require custom initialization anyway.

As ata_pci_init_one() was the last user of ops->irq_handler, this
patch also kills the field.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_generic.c       |    3 +--
 drivers/ata/libata-core.c       |    1 -
 drivers/ata/libata-sff.c        |    7 ++++---
 drivers/ata/pata_acpi.c         |    3 +--
 drivers/ata/pata_ali.c          |    9 +--------
 drivers/ata/pata_amd.c          |   12 +-----------
 drivers/ata/pata_artop.c        |    6 +-----
 drivers/ata/pata_atiixp.c       |    3 +--
 drivers/ata/pata_cmd640.c       |    3 +--
 drivers/ata/pata_cmd64x.c       |    8 +-------
 drivers/ata/pata_cs5530.c       |    4 +---
 drivers/ata/pata_cs5535.c       |    3 +--
 drivers/ata/pata_cs5536.c       |    3 +--
 drivers/ata/pata_cypress.c      |    3 +--
 drivers/ata/pata_efar.c         |    3 +--
 drivers/ata/pata_hpt366.c       |    3 +--
 drivers/ata/pata_hpt37x.c       |    8 +-------
 drivers/ata/pata_hpt3x2n.c      |    3 +--
 drivers/ata/pata_it8213.c       |    3 +--
 drivers/ata/pata_it821x.c       |    4 +---
 drivers/ata/pata_jmicron.c      |    3 +--
 drivers/ata/pata_marvell.c      |    4 +---
 drivers/ata/pata_netcell.c      |    3 +--
 drivers/ata/pata_ns87410.c      |    3 +--
 drivers/ata/pata_ns87415.c      |    4 +---
 drivers/ata/pata_oldpiix.c      |    3 +--
 drivers/ata/pata_opti.c         |    3 +--
 drivers/ata/pata_optidma.c      |    4 +---
 drivers/ata/pata_pdc202xx_old.c |    5 +----
 drivers/ata/pata_radisys.c      |    3 +--
 drivers/ata/pata_rz1000.c       |    3 +--
 drivers/ata/pata_sc1200.c       |    3 +--
 drivers/ata/pata_serverworks.c  |    6 +-----
 drivers/ata/pata_sil680.c       |    4 +---
 drivers/ata/pata_sis.c          |   10 +---------
 drivers/ata/pata_sl82c105.c     |    4 +---
 drivers/ata/pata_triflex.c      |    3 +--
 drivers/ata/pata_via.c          |    8 +-------
 include/linux/libata.h          |    4 ++--
 39 files changed, 42 insertions(+), 130 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 0b5b515..a912ee0 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -120,7 +120,6 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 {
 	u16 command;
 	static const struct ata_port_info info = {
-		.sht = &generic_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -153,7 +152,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	if (dev->vendor == PCI_VENDOR_ID_AL)
 	    	ata_pci_clear_simplex(dev);
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &generic_sht);
 }
 
 static struct pci_device_id ata_generic[] = {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0a55405..65d082c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -109,7 +109,6 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.irq_on			= ata_irq_on,
 
 	.port_start		= ata_sff_port_start,
-	.irq_handler		= ata_interrupt,
 };
 
 const struct ata_port_operations ata_bmdma_port_ops = {
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 34cdab0..24f6dc5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -818,6 +818,7 @@ int ata_pci_activate_sff_host(struct ata_host *host,
  *	ata_pci_init_one - Initialize/register PCI IDE host controller
  *	@pdev: Controller to be initialized
  *	@ppi: array of port_info, must be enough for two ports
+ *	@sht: scsi_host_template to use when registering the host
  *
  *	This is a helper function which can be called from a driver's
  *	xxx_init_one() probe function if the hardware uses traditional
@@ -838,7 +839,8 @@ int ata_pci_activate_sff_host(struct ata_host *host,
  *	Zero on success, negative on errno-based value on error.
  */
 int ata_pci_init_one(struct pci_dev *pdev,
-		     const struct ata_port_info * const * ppi)
+		     const struct ata_port_info * const * ppi,
+		     struct scsi_host_template *sht)
 {
 	struct device *dev = &pdev->dev;
 	const struct ata_port_info *pi = NULL;
@@ -874,8 +876,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		goto out;
 
 	pci_set_master(pdev);
-	rc = ata_pci_activate_sff_host(host, pi->port_ops->irq_handler,
-				       pi->sht);
+	rc = ata_pci_activate_sff_host(host, ata_interrupt, sht);
  out:
 	if (rc == 0)
 		devres_remove_group(&pdev->dev, NULL);
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 2810488..d55778a 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -264,7 +264,6 @@ static struct ata_port_operations pacpi_ops = {
 static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht		= &pacpi_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 
 		.pio_mask	= 0x1f,
@@ -274,7 +273,7 @@ static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &pacpi_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &pacpi_sht);
 }
 
 static const struct pci_device_id pacpi_pci_tbl[] = {
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index ad9dce9..d29578b 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -423,14 +423,12 @@ static void ali_init_chipset(struct pci_dev *pdev)
 static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info_early = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &ali_early_port_ops
 	};
 	/* Revision 0x20 added DMA */
 	static const struct ata_port_info info_20 = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -438,7 +436,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Revision 0x20 with support logic added UDMA */
 	static const struct ata_port_info info_20_udma = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -447,7 +444,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Revision 0xC2 adds UDMA66 */
 	static const struct ata_port_info info_c2 = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -456,7 +452,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Revision 0xC3 is UDMA66 for now */
 	static const struct ata_port_info info_c3 = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -465,7 +460,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Revision 0xC4 is UDMA100 */
 	static const struct ata_port_info info_c4 = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -474,7 +468,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static const struct ata_port_info info_c5 = {
-		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -519,7 +512,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	        	ppi[0] = &info_20_udma;
 		pci_dev_put(isa_bridge);
 	}
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &ali_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 0f317e0..9ce6cd9 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -414,7 +414,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info[10] = {
 		{	/* 0: AMD 7401 */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,	/* No SWDMA */
@@ -422,7 +421,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd33_port_ops
 		},
 		{	/* 1: Early AMD7409 - no swdma */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -430,7 +428,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd66_port_ops
 		},
 		{	/* 2: AMD 7409, no swdma errata */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -438,7 +435,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd66_port_ops
 		},
 		{	/* 3: AMD 7411 */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -446,7 +442,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd100_port_ops
 		},
 		{	/* 4: AMD 7441 */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -454,7 +449,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd100_port_ops
 		},
 		{	/* 5: AMD 8111*/
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -462,7 +456,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd133_port_ops
 		},
 		{	/* 6: AMD 8111 UDMA 100 (Serenade) */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -470,7 +463,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd133_port_ops
 		},
 		{	/* 7: Nvidia Nforce */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -478,7 +470,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &nv100_port_ops
 		},
 		{	/* 8: Nvidia Nforce2 and later */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -486,7 +477,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &nv133_port_ops
 		},
 		{	/* 9: AMD CS5536 (Geode companion) */
-			.sht = &amd_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -545,7 +535,7 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* And fire it up */
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &amd_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 0101e5a..698a53c 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -352,7 +352,6 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static int printed_version;
 	static const struct ata_port_info info_6210 = {
-		.sht		= &artop_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -360,7 +359,6 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &artop6210_ops,
 	};
 	static const struct ata_port_info info_626x = {
-		.sht		= &artop_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -368,7 +366,6 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &artop6260_ops,
 	};
 	static const struct ata_port_info info_628x = {
-		.sht		= &artop_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -376,7 +373,6 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &artop6260_ops,
 	};
 	static const struct ata_port_info info_628x_fast = {
-		.sht		= &artop_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -434,7 +430,7 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 
 	BUG_ON(ppi[0] == NULL);
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &artop_sht);
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 5bc2040..a098f69 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -239,7 +239,6 @@ static struct ata_port_operations atiixp_port_ops = {
 static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &atiixp_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x06,	/* No MWDMA0 support */
@@ -247,7 +246,7 @@ static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &atiixp_sht);
 }
 
 static const struct pci_device_id atiixp[] = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 061c891..efd2bb5 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -211,7 +211,6 @@ static void cmd640_hardware_init(struct pci_dev *pdev)
 static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &cmd640_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &cmd640_port_ops
@@ -225,7 +224,7 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cmd640_hardware_init(pdev);
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &cmd640_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 1ac8ecf..bfd72ef 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -298,21 +298,18 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	static const struct ata_port_info cmd_info[6] = {
 		{	/* CMD 643 - no UDMA */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 with broken UDMA */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 with working UDMA */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -320,14 +317,12 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 rev 1  */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.port_ops = &cmd646r1_port_ops
 		},
 		{	/* CMD 648 */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -335,7 +330,6 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &cmd648_port_ops
 		},
 		{	/* CMD 649 */
-			.sht = &cmd64x_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -379,7 +373,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &cmd64x_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index e4a16a5..c632ce4 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -298,7 +298,6 @@ fail_put:
 static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &cs5530_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -307,7 +306,6 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* The docking connector doesn't do UDMA, and it seems not MWDMA */
 	static const struct ata_port_info info_palmax_secondary = {
-		.sht = &cs5530_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &cs5530_port_ops
@@ -327,7 +325,7 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[1] = &info_palmax_secondary;
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &cs5530_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index f910a8a..d78cf95 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -181,7 +181,6 @@ static struct ata_port_operations cs5535_port_ops = {
 static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &cs5535_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -200,7 +199,7 @@ static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rdmsr(ATAC_CH0D1_PIO, timings, dummy);
 	if (CS5535_BAD_PIO(timings))
 		wrmsr(ATAC_CH0D1_PIO, 0xF7F4F7F4UL, 0);
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &cs5535_sht);
 }
 
 static const struct pci_device_id cs5535[] = {
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 69d63aa..12a1f68 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -241,7 +241,6 @@ static struct ata_port_operations cs5536_port_ops = {
 static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &cs5536_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -262,7 +261,7 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &cs5536_sht);
 }
 
 static const struct pci_device_id cs5536[] = {
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index c459553..cbd6670 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -123,7 +123,6 @@ static struct ata_port_operations cy82c693_port_ops = {
 static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &cy82c693_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -137,7 +136,7 @@ static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *i
 	if (PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &cy82c693_sht);
 }
 
 static const struct pci_device_id cy82c693[] = {
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index a6129bd..029d57a 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -263,7 +263,6 @@ static int efar_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &efar_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
@@ -276,7 +275,7 @@ static int efar_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &efar_sht);
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 9fa47d4..512cba5 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -350,7 +350,6 @@ static void hpt36x_init_chipset(struct pci_dev *dev)
 static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info_hpt366 = {
-		.sht = &hpt36x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -394,7 +393,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 			break;
 	}
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &hpt36x_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index a9d10c6..97fc5dc 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -783,7 +783,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	/* HPT370 - UDMA100 */
 	static const struct ata_port_info info_hpt370 = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -792,7 +791,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	/* HPT370A - UDMA100 */
 	static const struct ata_port_info info_hpt370a = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -801,7 +799,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	/* HPT370 - UDMA100 */
 	static const struct ata_port_info info_hpt370_33 = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -810,7 +807,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	/* HPT370A - UDMA100 */
 	static const struct ata_port_info info_hpt370a_33 = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -819,7 +815,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	/* HPT371, 372 and friends - UDMA133 */
 	static const struct ata_port_info info_hpt372 = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -828,7 +823,6 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	/* HPT374 - UDMA100 */
 	static const struct ata_port_info info_hpt374 = {
-		.sht = &hpt37x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -1051,7 +1045,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	port_info = *port;
 	port_info.private_data = private_data;
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &hpt37x_sht);
 }
 
 static const struct pci_device_id hpt37x[] = {
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index b77b127..2c178c3 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -452,7 +452,6 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	/* HPT372N and friends - UDMA133 */
 	static const struct ata_port_info info = {
-		.sht = &hpt3x2n_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -568,7 +567,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &hpt3x2n_sht);
 }
 
 static const struct pci_device_id hpt3x2n[] = {
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 50977b7..42e1b5a 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -274,7 +274,6 @@ static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &it8213_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -288,7 +287,7 @@ static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &it8213_sht);
 }
 
 static const struct pci_device_id it8213_pci_tbl[] = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index f7ac52e..1a8bec8 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -687,14 +687,12 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	u8 conf;
 
 	static const struct ata_port_info info_smart = {
-		.sht = &it821x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &it821x_smart_port_ops
 	};
 	static const struct ata_port_info info_passthru = {
-		.sht = &it821x_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -724,7 +722,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		ppi[0] = &info_smart;
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &it821x_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index dbfb368..d76620e 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -147,7 +147,6 @@ static struct ata_port_operations jmicron_ops = {
 static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht		= &jmicron_sht,
 		.flags	= ATA_FLAG_SLAVE_POSS,
 
 		.pio_mask	= 0x1f,
@@ -158,7 +157,7 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &jmicron_sht);
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index bbc9985..4f3b4dc 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -119,7 +119,6 @@ static struct ata_port_operations marvell_ops = {
 static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht		= &marvell_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 
 		.pio_mask	= 0x1f,
@@ -129,7 +128,6 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 		.port_ops	= &marvell_ops,
 	};
 	static const struct ata_port_info info_sata = {
-		.sht		= &marvell_sht,
 		/* Slave possible as its magically mapped not real */
 		.flags		= ATA_FLAG_SLAVE_POSS,
 
@@ -144,7 +142,7 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	if (pdev->device == 0x6101)
 		ppi[1] = &ata_dummy_port_info;
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &marvell_sht);
 }
 
 static const struct pci_device_id marvell_pci_tbl[] = {
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 65389d1..ae50a5e 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -48,7 +48,6 @@ static int netcell_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &netcell_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		/* Actually we don't really care about these as the
 		   firmware deals with it */
@@ -72,7 +71,7 @@ static int netcell_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	ata_pci_clear_simplex(pdev);
 
 	/* And let the library code do the work */
-	return ata_pci_init_one(pdev, port_info);
+	return ata_pci_init_one(pdev, port_info, &netcell_sht);
 }
 
 static const struct pci_device_id netcell_pci_tbl[] = {
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 5b1982f..1bdca8f 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -158,13 +158,12 @@ static struct ata_port_operations ns87410_port_ops = {
 static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &ns87410_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x0F,
 		.port_ops = &ns87410_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &ns87410_sht);
 }
 
 static const struct pci_device_id ns87410[] = {
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 38d86a2..4250894 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -345,7 +345,6 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &ns87415_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -355,7 +354,6 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	int rc;
 #if defined(CONFIG_SUPERIO)
 	static const struct ata_port_info info87560 = {
-		.sht		= &ns87415_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -377,7 +375,7 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	pci_write_config_byte(pdev, 0x55, 0xEE);
 	/* Select PIO0 8bit clocking */
 	pci_write_config_byte(pdev, 0x54, 0xB7);
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &ns87415_sht);
 }
 
 static const struct pci_device_id ns87415_pci_tbl[] = {
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index f6062b3..9e3afad 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -252,7 +252,6 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &oldpiix_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
@@ -264,7 +263,7 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &oldpiix_sht);
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 3787d39..3286783 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -178,7 +178,6 @@ static struct ata_port_operations opti_port_ops = {
 static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &opti_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &opti_port_ops
@@ -189,7 +188,7 @@ static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &opti_sht);
 }
 
 static const struct pci_device_id opti[] = {
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index eb4b081..c376f9e 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -414,14 +414,12 @@ done_nomsg:		/* Wrong chip revision */
 static int optidma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info_82c700 = {
-		.sht = &optidma_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &optidma_port_ops
 	};
 	static const struct ata_port_info info_82c700_udma = {
-		.sht = &optidma_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -447,7 +445,7 @@ static int optidma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (optiplus_with_udma(dev))
 		ppi[0] = &info_82c700_udma;
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &optidma_sht);
 }
 
 static const struct pci_device_id optidma[] = {
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 4daac20..5545fba 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -290,7 +290,6 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 {
 	static const struct ata_port_info info[3] = {
 		{
-			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -298,7 +297,6 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 			.port_ops = &pdc2024x_port_ops
 		},
 		{
-			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -306,7 +304,6 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 			.port_ops = &pdc2026x_port_ops
 		},
 		{
-			.sht = &pdc202xx_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -327,7 +324,7 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 				return -ENODEV;
 		}
 	}
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &pdc202xx_sht);
 }
 
 static const struct pci_device_id pdc202xx[] = {
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 94e60b3..145d5ba 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -216,7 +216,6 @@ static int radisys_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht		= &radisys_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma1-2 */
@@ -229,7 +228,7 @@ static int radisys_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &radisys_sht);
 }
 
 static const struct pci_device_id radisys_pci_tbl[] = {
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index f9d40be..cf7764d 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -89,7 +89,6 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht = &rz1000_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &rz1000_port_ops
@@ -100,7 +99,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
 	if (rz1000_fifo_disable(pdev) == 0)
-		return ata_pci_init_one(pdev, ppi);
+		return ata_pci_init_one(pdev, ppi, &rz1000_sht);
 
 	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
 	/* Not safe to use so skip */
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 362b7f8..38c7fb0 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -204,7 +204,6 @@ static struct ata_port_operations sc1200_port_ops = {
 static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &sc1200_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -214,7 +213,7 @@ static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Can't enable port 2 yet, see top comments */
 	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &sc1200_sht);
 }
 
 static const struct pci_device_id sc1200[] = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index a5ce863..78b1a46 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -399,28 +399,24 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 {
 	static const struct ata_port_info info[4] = {
 		{ /* OSB4 */
-			.sht = &serverworks_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x07,
 			.port_ops = &serverworks_osb4_port_ops
 		}, { /* OSB4 no UDMA */
-			.sht = &serverworks_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = 0x00,
 			.port_ops = &serverworks_osb4_port_ops
 		}, { /* CSB5 */
-			.sht = &serverworks_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
 			.udma_mask = ATA_UDMA4,
 			.port_ops = &serverworks_csb_port_ops
 		}, { /* CSB5 - later revisions*/
-			.sht = &serverworks_sht,
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
@@ -465,7 +461,7 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
 		ata_pci_clear_simplex(pdev);
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &serverworks_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index bc3253d..1b39646 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -278,7 +278,6 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 				     const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &sil680_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -286,7 +285,6 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 		.port_ops = &sil680_port_ops
 	};
 	static const struct ata_port_info info_slow = {
-		.sht = &sil680_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -360,7 +358,7 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 				 &sil680_sht);
 
 use_ioports:
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &sil680_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index f155a55..1d8cf11 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -565,7 +565,6 @@ static struct ata_port_operations sis_old_ops = {
 };
 
 static const struct ata_port_info sis_info = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
@@ -573,7 +572,6 @@ static const struct ata_port_info sis_info = {
 	.port_ops	= &sis_old_ops,
 };
 static const struct ata_port_info sis_info33 = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
@@ -581,42 +579,36 @@ static const struct ata_port_info sis_info33 = {
 	.port_ops	= &sis_old_ops,
 };
 static const struct ata_port_info sis_info66 = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA4,	/* UDMA 66 */
 	.port_ops	= &sis_66_ops,
 };
 static const struct ata_port_info sis_info100 = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA5,
 	.port_ops	= &sis_100_ops,
 };
 static const struct ata_port_info sis_info100_early = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.udma_mask	= ATA_UDMA5,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.port_ops	= &sis_66_ops,
 };
 static const struct ata_port_info sis_info133 = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
 const struct ata_port_info sis_info133_for_sata = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_for_sata_ops,
 };
 static const struct ata_port_info sis_info133_early = {
-	.sht		= &sis_sht,
 	.flags		= ATA_FLAG_SLAVE_POSS,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
@@ -844,7 +836,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	sis_fixup(pdev, chipset);
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &sis_sht);
 }
 
 static const struct pci_device_id sis_pci_tbl[] = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 04fd30b..9c1de56 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -260,14 +260,12 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
 static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info_dma = {
-		.sht = &sl82c105_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &sl82c105_port_ops
 	};
 	static const struct ata_port_info info_early = {
-		.sht = &sl82c105_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.port_ops = &sl82c105_port_ops
@@ -296,7 +294,7 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &sl82c105_sht);
 }
 
 static const struct pci_device_id sl82c105[] = {
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index bc4956e..86dc66c 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -195,7 +195,6 @@ static struct ata_port_operations triflex_port_ops = {
 static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
-		.sht = &triflex_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -207,7 +206,7 @@ static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi);
+	return ata_pci_init_one(dev, ppi, &triflex_sht);
 }
 
 static const struct pci_device_id triflex[] = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index c941d5a..affb665 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -394,7 +394,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	/* Early VIA without UDMA support */
 	static const struct ata_port_info via_mwdma_info = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -402,7 +401,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* Ditto with IRQ masking required */
 	static const struct ata_port_info via_mwdma_info_borked = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -410,7 +408,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* VIA UDMA 33 devices (and borked 66) */
 	static const struct ata_port_info via_udma33_info = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -419,7 +416,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* VIA UDMA 66 devices */
 	static const struct ata_port_info via_udma66_info = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -428,7 +424,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* VIA UDMA 100 devices */
 	static const struct ata_port_info via_udma100_info = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -437,7 +432,6 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	/* UDMA133 with bad AST (All current 133) */
 	static const struct ata_port_info via_udma133_info = {
-		.sht = &via_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
@@ -528,7 +522,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* We have established the device type, now fire it up */
 	type.private_data = (void *)config;
 
-	return ata_pci_init_one(pdev, ppi);
+	return ata_pci_init_one(pdev, ppi, &via_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 27ceed7..42d31cd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -747,7 +747,6 @@ struct ata_port_operations {
 	 */
 	void (*phy_reset)(struct ata_port *ap);
 	void (*eng_timeout)(struct ata_port *ap);
-	irq_handler_t irq_handler;
 
 	/*
 	 * ->inherits must be the last field and all the preceding
@@ -1027,7 +1026,8 @@ static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
 struct pci_dev;
 
 extern int ata_pci_init_one(struct pci_dev *pdev,
-			     const struct ata_port_info * const * ppi);
+			    const struct ata_port_info * const * ppi,
+			    struct scsi_host_template *sht);
 extern void ata_pci_remove_one(struct pci_dev *pdev);
 #ifdef CONFIG_PM
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-- 
1.5.2.4

