From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 358/493] ide: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:07 -0500
Message-ID: <1353349642-3677-358-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41486 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab2KSSel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2012 13:34:41 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: linux-ide@vger.kernel.org 
---
 drivers/ide/aec62xx.c         |  2 +-
 drivers/ide/alim15x3.c        |  2 +-
 drivers/ide/amd74xx.c         |  2 +-
 drivers/ide/atiixp.c          |  2 +-
 drivers/ide/cmd64x.c          |  2 +-
 drivers/ide/cs5520.c          |  2 +-
 drivers/ide/cs5530.c          |  2 +-
 drivers/ide/cs5535.c          |  2 +-
 drivers/ide/cy82c693.c        |  2 +-
 drivers/ide/hpt366.c          | 26 +++++++++++++-------------
 drivers/ide/ide-pci-generic.c |  2 +-
 drivers/ide/it8172.c          |  2 +-
 drivers/ide/it8213.c          |  2 +-
 drivers/ide/it821x.c          |  2 +-
 drivers/ide/jmicron.c         |  2 +-
 drivers/ide/ns87415.c         |  2 +-
 drivers/ide/opti621.c         |  2 +-
 drivers/ide/pdc202xx_new.c    |  2 +-
 drivers/ide/pdc202xx_old.c    |  2 +-
 drivers/ide/piix.c            |  2 +-
 drivers/ide/rz1000.c          |  2 +-
 drivers/ide/sc1200.c          |  2 +-
 drivers/ide/scc_pata.c        |  2 +-
 drivers/ide/serverworks.c     |  2 +-
 drivers/ide/sgiioc4.c         |  2 +-
 drivers/ide/siimage.c         |  2 +-
 drivers/ide/sis5513.c         |  2 +-
 drivers/ide/sl82c105.c        |  2 +-
 drivers/ide/slc90e66.c        |  2 +-
 drivers/ide/tc86c001.c        |  2 +-
 drivers/ide/triflex.c         |  2 +-
 drivers/ide/trm290.c          |  2 +-
 drivers/ide/via82cxxx.c       |  2 +-
 33 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
index c3518bf..35ffff1 100644
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -181,7 +181,7 @@ static const struct ide_port_ops atp86x_port_ops = {
 	.cable_detect		= atp86x_cable_detect,
 };
 
-static const struct ide_port_info aec62xx_chipsets[] __devinitconst = {
+static const struct ide_port_info aec62xx_chipsets[] = {
 	{	/* 0: AEC6210 */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_aec62xx,
diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 490ca5e..1b6cb12 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -512,7 +512,7 @@ static const struct ide_dma_ops ali_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info ali15x3_chipset __devinitconst = {
+static const struct ide_port_info ali15x3_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_ali15x3,
 	.init_hwif	= init_hwif_ali15x3,
diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index eee0d1e..cbfe846 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -223,7 +223,7 @@ static const struct ide_port_ops amd_port_ops = {
 		.udma_mask	= udma,					\
 	}
 
-static const struct ide_port_info amd74xx_chipsets[] __devinitconst = {
+static const struct ide_port_info amd74xx_chipsets[] = {
 	/* 0: AMD7401 */	DECLARE_AMD_DEV(0x00, ATA_UDMA2),
 	/* 1: AMD7409 */	DECLARE_AMD_DEV(ATA_SWDMA2, ATA_UDMA4),
 	/* 2: AMD7411/7441 */	DECLARE_AMD_DEV(ATA_SWDMA2, ATA_UDMA5),
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index 03b1116..dbd0f24 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -139,7 +139,7 @@ static const struct ide_port_ops atiixp_port_ops = {
 	.cable_detect		= atiixp_cable_detect,
 };
 
-static const struct ide_port_info atiixp_pci_info[] __devinitconst = {
+static const struct ide_port_info atiixp_pci_info[] = {
 	{	/* 0: IXP200/300/400/700 */
 		.name		= DRV_NAME,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index 80778cd..b127ed6 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -327,7 +327,7 @@ static const struct ide_dma_ops cmd646_rev1_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info cmd64x_chipsets[] __devinitconst = {
+static const struct ide_port_info cmd64x_chipsets[] = {
 	{	/* 0: CMD643 */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
diff --git a/drivers/ide/cs5520.c b/drivers/ide/cs5520.c
index 8fe9e04..6250aee 100644
--- a/drivers/ide/cs5520.c
+++ b/drivers/ide/cs5520.c
@@ -94,7 +94,7 @@ static const struct ide_port_ops cs5520_port_ops = {
 	.set_dma_mode		= cs5520_set_dma_mode,
 };
 
-static const struct ide_port_info cyrix_chipset __devinitconst = {
+static const struct ide_port_info cyrix_chipset = {
 	.name		= DRV_NAME,
 	.enablebits	= { { 0x60, 0x01, 0x01 }, { 0x60, 0x02, 0x02 } },
 	.port_ops	= &cs5520_port_ops,
diff --git a/drivers/ide/cs5530.c b/drivers/ide/cs5530.c
index a8e3605..6537159 100644
--- a/drivers/ide/cs5530.c
+++ b/drivers/ide/cs5530.c
@@ -245,7 +245,7 @@ static const struct ide_port_ops cs5530_port_ops = {
 	.udma_filter		= cs5530_udma_filter,
 };
 
-static const struct ide_port_info cs5530_chipset __devinitconst = {
+static const struct ide_port_info cs5530_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_cs5530,
 	.init_hwif	= init_hwif_cs5530,
diff --git a/drivers/ide/cs5535.c b/drivers/ide/cs5535.c
index bf9612a..7453b24 100644
--- a/drivers/ide/cs5535.c
+++ b/drivers/ide/cs5535.c
@@ -170,7 +170,7 @@ static const struct ide_port_ops cs5535_port_ops = {
 	.cable_detect		= cs5535_cable_detect,
 };
 
-static const struct ide_port_info cs5535_chipset __devinitconst = {
+static const struct ide_port_info cs5535_chipset = {
 	.name		= DRV_NAME,
 	.port_ops	= &cs5535_port_ops,
 	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE,
diff --git a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
index eb4ed41..1ea2d59 100644
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -163,7 +163,7 @@ static const struct ide_port_ops cy82c693_port_ops = {
 	.set_dma_mode		= cy82c693_set_dma_mode,
 };
 
-static const struct ide_port_info cy82c693_chipset __devinitconst = {
+static const struct ide_port_info cy82c693_chipset = {
 	.name		= DRV_NAME,
 	.init_iops	= init_iops_cy82c693,
 	.port_ops	= &cy82c693_port_ops,
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index dc74440..9cf2093 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -443,7 +443,7 @@ static struct hpt_timings hpt37x_timings = {
 	}
 };
 
-static const struct hpt_info hpt36x __devinitconst = {
+static const struct hpt_info hpt36x = {
 	.chip_name	= "HPT36x",
 	.chip_type	= HPT36x,
 	.udma_mask	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? ATA_UDMA4 : ATA_UDMA3) : ATA_UDMA2,
@@ -451,7 +451,7 @@ static const struct hpt_info hpt36x __devinitconst = {
 	.timings	= &hpt36x_timings
 };
 
-static const struct hpt_info hpt370 __devinitconst = {
+static const struct hpt_info hpt370 = {
 	.chip_name	= "HPT370",
 	.chip_type	= HPT370,
 	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
@@ -459,7 +459,7 @@ static const struct hpt_info hpt370 __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt370a __devinitconst = {
+static const struct hpt_info hpt370a = {
 	.chip_name	= "HPT370A",
 	.chip_type	= HPT370A,
 	.udma_mask	= HPT370_ALLOW_ATA100_5 ? ATA_UDMA5 : ATA_UDMA4,
@@ -467,7 +467,7 @@ static const struct hpt_info hpt370a __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt374 __devinitconst = {
+static const struct hpt_info hpt374 = {
 	.chip_name	= "HPT374",
 	.chip_type	= HPT374,
 	.udma_mask	= ATA_UDMA5,
@@ -475,7 +475,7 @@ static const struct hpt_info hpt374 __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt372 __devinitconst = {
+static const struct hpt_info hpt372 = {
 	.chip_name	= "HPT372",
 	.chip_type	= HPT372,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -483,7 +483,7 @@ static const struct hpt_info hpt372 __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt372a __devinitconst = {
+static const struct hpt_info hpt372a = {
 	.chip_name	= "HPT372A",
 	.chip_type	= HPT372A,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -491,7 +491,7 @@ static const struct hpt_info hpt372a __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt302 __devinitconst = {
+static const struct hpt_info hpt302 = {
 	.chip_name	= "HPT302",
 	.chip_type	= HPT302,
 	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -499,7 +499,7 @@ static const struct hpt_info hpt302 __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt371 __devinitconst = {
+static const struct hpt_info hpt371 = {
 	.chip_name	= "HPT371",
 	.chip_type	= HPT371,
 	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -507,7 +507,7 @@ static const struct hpt_info hpt371 __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt372n __devinitconst = {
+static const struct hpt_info hpt372n = {
 	.chip_name	= "HPT372N",
 	.chip_type	= HPT372N,
 	.udma_mask	= HPT372_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -515,7 +515,7 @@ static const struct hpt_info hpt372n __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt302n __devinitconst = {
+static const struct hpt_info hpt302n = {
 	.chip_name	= "HPT302N",
 	.chip_type	= HPT302N,
 	.udma_mask	= HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -523,7 +523,7 @@ static const struct hpt_info hpt302n __devinitconst = {
 	.timings	= &hpt37x_timings
 };
 
-static const struct hpt_info hpt371n __devinitconst = {
+static const struct hpt_info hpt371n = {
 	.chip_name	= "HPT371N",
 	.chip_type	= HPT371N,
 	.udma_mask	= HPT371_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
@@ -1361,7 +1361,7 @@ static const struct ide_dma_ops hpt36x_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info hpt366_chipsets[] __devinitconst = {
+static const struct ide_port_info hpt366_chipsets[] = {
 	{	/* 0: HPT36x */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_hpt366,
@@ -1510,7 +1510,7 @@ static void __devexit hpt366_remove(struct pci_dev *dev)
 	kfree(info);
 }
 
-static const struct pci_device_id hpt366_pci_tbl[] __devinitconst = {
+static const struct pci_device_id hpt366_pci_tbl[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366),  0 },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372),  1 },
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302),  2 },
diff --git a/drivers/ide/ide-pci-generic.c b/drivers/ide/ide-pci-generic.c
index d80da09..673420d 100644
--- a/drivers/ide/ide-pci-generic.c
+++ b/drivers/ide/ide-pci-generic.c
@@ -53,7 +53,7 @@ static const struct ide_port_ops netcell_port_ops = {
 		.udma_mask	= ATA_UDMA6, \
 	}
 
-static const struct ide_port_info generic_chipsets[] __devinitconst = {
+static const struct ide_port_info generic_chipsets[] = {
 	/*  0: Unknown */
 	DECLARE_GENERIC_PCI_DEV(0),
 
diff --git a/drivers/ide/it8172.c b/drivers/ide/it8172.c
index bcae804..e304cb6 100644
--- a/drivers/ide/it8172.c
+++ b/drivers/ide/it8172.c
@@ -115,7 +115,7 @@ static const struct ide_port_ops it8172_port_ops = {
 	.set_dma_mode	= it8172_set_dma_mode,
 };
 
-static const struct ide_port_info it8172_port_info __devinitconst = {
+static const struct ide_port_info it8172_port_info = {
 	.name		= DRV_NAME,
 	.port_ops	= &it8172_port_ops,
 	.enablebits	= { {0x41, 0x80, 0x80}, {0x00, 0x00, 0x00} },
diff --git a/drivers/ide/it8213.c b/drivers/ide/it8213.c
index 2709d6e..6b92846 100644
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -156,7 +156,7 @@ static const struct ide_port_ops it8213_port_ops = {
 	.cable_detect		= it8213_cable_detect,
 };
 
-static const struct ide_port_info it8213_chipset __devinitconst = {
+static const struct ide_port_info it8213_chipset = {
 	.name		= DRV_NAME,
 	.enablebits	= { {0x41, 0x80, 0x80} },
 	.port_ops	= &it8213_port_ops,
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index 9084463..7054004 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -630,7 +630,7 @@ static const struct ide_port_ops it821x_port_ops = {
 	.cable_detect		= it821x_cable_detect,
 };
 
-static const struct ide_port_info it821x_chipset __devinitconst = {
+static const struct ide_port_info it821x_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_it821x,
 	.init_hwif	= init_hwif_it821x,
diff --git a/drivers/ide/jmicron.c b/drivers/ide/jmicron.c
index 0f37ea1..ae6480d 100644
--- a/drivers/ide/jmicron.c
+++ b/drivers/ide/jmicron.c
@@ -102,7 +102,7 @@ static const struct ide_port_ops jmicron_port_ops = {
 	.cable_detect		= jmicron_cable_detect,
 };
 
-static const struct ide_port_info jmicron_chipset __devinitconst = {
+static const struct ide_port_info jmicron_chipset = {
 	.name		= DRV_NAME,
 	.enablebits	= { { 0x40, 0x01, 0x01 }, { 0x40, 0x10, 0x10 } },
 	.port_ops	= &jmicron_port_ops,
diff --git a/drivers/ide/ns87415.c b/drivers/ide/ns87415.c
index 080fd7d..392fd10 100644
--- a/drivers/ide/ns87415.c
+++ b/drivers/ide/ns87415.c
@@ -293,7 +293,7 @@ static const struct ide_dma_ops ns87415_dma_ops = {
 	.dma_sff_read_status	= superio_dma_sff_read_status,
 };
 
-static const struct ide_port_info ns87415_chipset __devinitconst = {
+static const struct ide_port_info ns87415_chipset = {
 	.name		= DRV_NAME,
 	.init_hwif	= init_hwif_ns87415,
 	.tp_ops 	= &ns87415_tp_ops,
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
index e38eb03..26a4500 100644
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -131,7 +131,7 @@ static const struct ide_port_ops opti621_port_ops = {
 	.set_pio_mode		= opti621_set_pio_mode,
 };
 
-static const struct ide_port_info opti621_chipset __devinitconst = {
+static const struct ide_port_info opti621_chipset = {
 	.name		= DRV_NAME,
 	.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
 	.port_ops	= &opti621_port_ops,
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 322071b..0a1afa2 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -465,7 +465,7 @@ static const struct ide_port_ops pdcnew_port_ops = {
 		.udma_mask	= udma, \
 	}
 
-static const struct ide_port_info pdcnew_chipsets[] __devinitconst = {
+static const struct ide_port_info pdcnew_chipsets[] = {
 	/* 0: PDC202{68,70} */		DECLARE_PDCNEW_DEV(ATA_UDMA5),
 	/* 1: PDC202{69,71,75,76,77} */	DECLARE_PDCNEW_DEV(ATA_UDMA6),
 };
diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index 8056d22..571061b 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -270,7 +270,7 @@ static const struct ide_dma_ops pdc2026x_dma_ops = {
 		.max_sectors	= sectors, \
 	}
 
-static const struct ide_port_info pdc202xx_chipsets[] __devinitconst = {
+static const struct ide_port_info pdc202xx_chipsets[] = {
 	{	/* 0: PDC20246 */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_pdc202xx,
diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index be144c7b..a671cea 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -344,7 +344,7 @@ static const struct ide_port_ops ich_port_ops = {
 		.udma_mask	= udma, \
 	}
 
-static const struct ide_port_info piix_pci_info[] __devinitconst = {
+static const struct ide_port_info piix_pci_info[] = {
 	/* 0: MPIIX */
 	{	/*
 		 * MPIIX actually has only a single IDE channel mapped to
diff --git a/drivers/ide/rz1000.c b/drivers/ide/rz1000.c
index 2c158c7..f4b66f7 100644
--- a/drivers/ide/rz1000.c
+++ b/drivers/ide/rz1000.c
@@ -38,7 +38,7 @@ static int rz1000_disable_readahead(struct pci_dev *dev)
 	}
 }
 
-static const struct ide_port_info rz1000_chipset __devinitconst = {
+static const struct ide_port_info rz1000_chipset = {
 	.name		= DRV_NAME,
 	.host_flags	= IDE_HFLAG_NO_DMA,
 };
diff --git a/drivers/ide/sc1200.c b/drivers/ide/sc1200.c
index 9e0419b..a5b7018 100644
--- a/drivers/ide/sc1200.c
+++ b/drivers/ide/sc1200.c
@@ -291,7 +291,7 @@ static const struct ide_dma_ops sc1200_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info sc1200_chipset __devinitconst = {
+static const struct ide_port_info sc1200_chipset = {
 	.name		= DRV_NAME,
 	.port_ops	= &sc1200_port_ops,
 	.dma_ops	= &sc1200_dma_ops,
diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
index 546c7e2..a250a13 100644
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -811,7 +811,7 @@ static const struct ide_dma_ops scc_dma_ops = {
 	.dma_sff_read_status	= scc_dma_sff_read_status,
 };
 
-static const struct ide_port_info scc_chipset __devinitconst = {
+static const struct ide_port_info scc_chipset = {
 	.name		= "sccIDE",
 	.init_iops	= init_iops_scc,
 	.init_dma	= scc_init_dma,
diff --git a/drivers/ide/serverworks.c b/drivers/ide/serverworks.c
index 3e1935b..a97affc 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -337,7 +337,7 @@ static const struct ide_port_ops svwks_port_ops = {
 	.cable_detect		= svwks_cable_detect,
 };
 
-static const struct ide_port_info serverworks_chipsets[] __devinitconst = {
+static const struct ide_port_info serverworks_chipsets[] = {
 	{	/* 0: OSB4 */
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_svwks,
diff --git a/drivers/ide/sgiioc4.c b/drivers/ide/sgiioc4.c
index b5b93f2..0393e58 100644
--- a/drivers/ide/sgiioc4.c
+++ b/drivers/ide/sgiioc4.c
@@ -520,7 +520,7 @@ static const struct ide_dma_ops sgiioc4_dma_ops = {
 	.dma_lost_irq		= sgiioc4_dma_lost_irq,
 };
 
-static const struct ide_port_info sgiioc4_port_info __devinitconst = {
+static const struct ide_port_info sgiioc4_port_info = {
 	.name			= DRV_NAME,
 	.chipset		= ide_pci,
 	.init_dma		= ide_dma_sgiioc4,
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index ff2ea1e..3791333 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -719,7 +719,7 @@ static const struct ide_dma_ops sil_dma_ops = {
 		.udma_mask	= ATA_UDMA6,		\
 	}
 
-static const struct ide_port_info siimage_chipsets[] __devinitconst = {
+static const struct ide_port_info siimage_chipsets[] = {
 	/* 0: SiI680 */  DECLARE_SII_DEV(&sil_pata_port_ops),
 	/* 1: SiI3112 */ DECLARE_SII_DEV(&sil_sata_port_ops)
 };
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 3c1148d..dd33d4d 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -563,7 +563,7 @@ static const struct ide_port_ops sis_ata133_port_ops = {
 	.cable_detect		= sis_cable_detect,
 };
 
-static const struct ide_port_info sis5513_chipset __devinitconst = {
+static const struct ide_port_info sis5513_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_sis5513,
 	.enablebits	= { {0x4a, 0x02, 0x02}, {0x4a, 0x04, 0x04} },
diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index 000189a..8755df3 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -299,7 +299,7 @@ static const struct ide_dma_ops sl82c105_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info sl82c105_chipset __devinitconst = {
+static const struct ide_port_info sl82c105_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_sl82c105,
 	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
index 2db61eb..7a36612 100644
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -132,7 +132,7 @@ static const struct ide_port_ops slc90e66_port_ops = {
 	.cable_detect		= slc90e66_cable_detect,
 };
 
-static const struct ide_port_info slc90e66_chipset __devinitconst = {
+static const struct ide_port_info slc90e66_chipset = {
 	.name		= DRV_NAME,
 	.enablebits	= { {0x41, 0x80, 0x80}, {0x43, 0x80, 0x80} },
 	.port_ops	= &slc90e66_port_ops,
diff --git a/drivers/ide/tc86c001.c b/drivers/ide/tc86c001.c
index 583891a..d364319b8 100644
--- a/drivers/ide/tc86c001.c
+++ b/drivers/ide/tc86c001.c
@@ -192,7 +192,7 @@ static const struct ide_dma_ops tc86c001_dma_ops = {
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 
-static const struct ide_port_info tc86c001_chipset __devinitconst = {
+static const struct ide_port_info tc86c001_chipset = {
 	.name		= DRV_NAME,
 	.init_hwif	= init_hwif_tc86c001,
 	.port_ops	= &tc86c001_port_ops,
diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
index 2ff94c7..d6c3243 100644
--- a/drivers/ide/triflex.c
+++ b/drivers/ide/triflex.c
@@ -92,7 +92,7 @@ static const struct ide_port_ops triflex_port_ops = {
 	.set_dma_mode		= triflex_set_mode,
 };
 
-static const struct ide_port_info triflex_device __devinitconst = {
+static const struct ide_port_info triflex_device = {
 	.name		= DRV_NAME,
 	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
 	.port_ops	= &triflex_port_ops,
diff --git a/drivers/ide/trm290.c b/drivers/ide/trm290.c
index b720d89..0069f6c 100644
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -324,7 +324,7 @@ static struct ide_dma_ops trm290_dma_ops = {
 	.dma_check		= trm290_dma_check,
 };
 
-static const struct ide_port_info trm290_chipset __devinitconst = {
+static const struct ide_port_info trm290_chipset = {
 	.name		= DRV_NAME,
 	.init_hwif	= init_hwif_trm290,
 	.tp_ops 	= &trm290_tp_ops,
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index dada555..b73d5fc 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -403,7 +403,7 @@ static const struct ide_port_ops via_port_ops = {
 	.cable_detect		= via82cxxx_cable_detect,
 };
 
-static const struct ide_port_info via82cxxx_chipset __devinitconst = {
+static const struct ide_port_info via82cxxx_chipset = {
 	.name		= DRV_NAME,
 	.init_chipset	= init_chipset_via82cxxx,
 	.enablebits	= { { 0x40, 0x02, 0x02 }, { 0x40, 0x01, 0x01 } },
-- 
1.8.0

