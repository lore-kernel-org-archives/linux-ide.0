From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] ide: use PCI_VDEVICE() macro
Date: Sat, 18 Aug 2007 20:47:25 +0200
Message-ID: <200708182047.25528.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:65378 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbXHRTTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:05 -0400
Received: by fk-out-0910.google.com with SMTP id z23so797152fkz
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


While at it:
- make struct pci_device_id tables const
- use PCI_DEVICE_ID_ITE_8213 define in it8213.c
- fix comment in generic.c

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c      |   12 ++++-----
 drivers/ide/pci/alim15x3.c     |    6 ++--
 drivers/ide/pci/amd74xx.c      |   48 ++++++++++++++++++-------------------
 drivers/ide/pci/atiixp.c       |   12 ++++-----
 drivers/ide/pci/cmd64x.c       |   10 +++----
 drivers/ide/pci/cs5520.c       |    6 ++--
 drivers/ide/pci/cs5530.c       |    4 +--
 drivers/ide/pci/cs5535.c       |    6 +---
 drivers/ide/pci/cy82c693.c     |    4 +--
 drivers/ide/pci/generic.c      |   37 +++++++++++++++--------------
 drivers/ide/pci/hpt34x.c       |    4 +--
 drivers/ide/pci/hpt366.c       |   14 +++++------
 drivers/ide/pci/it8213.c       |    5 +--
 drivers/ide/pci/it821x.c       |    6 ++--
 drivers/ide/pci/ns87415.c      |    4 +--
 drivers/ide/pci/opti621.c      |    6 ++--
 drivers/ide/pci/pdc202xx_new.c |   16 ++++++------
 drivers/ide/pci/pdc202xx_old.c |   12 ++++-----
 drivers/ide/pci/piix.c         |   52 ++++++++++++++++++++---------------------
 drivers/ide/pci/rz1000.c       |    6 ++--
 drivers/ide/pci/sc1200.c       |    4 +--
 drivers/ide/pci/scc_pata.c     |    4 +--
 drivers/ide/pci/serverworks.c  |   12 ++++-----
 drivers/ide/pci/siimage.c      |    8 +++---
 drivers/ide/pci/sis5513.c      |    8 +++---
 drivers/ide/pci/sl82c105.c     |    4 +--
 drivers/ide/pci/slc90e66.c     |    4 +--
 drivers/ide/pci/tc86c001.c     |    5 +--
 drivers/ide/pci/triflex.c      |    5 +--
 drivers/ide/pci/trm290.c       |    4 +--
 drivers/ide/pci/via82cxxx.c    |   10 +++----
 drivers/ide/ppc/pmac.c         |   17 ++++---------
 32 files changed, 174 insertions(+), 181 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -313,12 +313,12 @@ static int __devinit aec62xx_init_one(st
 	return d.init_setup(dev, &d);
 }
 
-static struct pci_device_id aec62xx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+static const struct pci_device_id aec62xx_pci_tbl[] = {
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860),   1 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R),  2 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865),   3 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R),  4 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -808,9 +808,9 @@ static int __devinit alim15x3_init_one(s
 }
 
 
-static struct pci_device_id alim15x3_pci_tbl[] = {
-	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5228, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+static const struct pci_device_id alim15x3_pci_tbl[] = {
+	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5229), 0 },
+	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -478,34 +478,34 @@ static int __devinit amd74xx_probe(struc
 	return ide_setup_pci_device(dev, amd_chipset);
 }
 
-static struct pci_device_id amd74xx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_COBRA_7401,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  0 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7409,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  1 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7411,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  2 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_OPUS_7441,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  3 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8111_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  4 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  5 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  6 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  7 },
+static const struct pci_device_id amd74xx_pci_tbl[] = {
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		 0 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		 1 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),		 2 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),		 3 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),		 4 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),	 5 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),	 6 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),	 7 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA),	 8 },
 #endif
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  9 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),	 9 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),	10 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA),	11 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2),	12 },
 #endif
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),	13 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),	14 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	15 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	16 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	17 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	18 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	19 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	20 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	21 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		22 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -239,12 +239,12 @@ static int __devinit atiixp_init_one(str
 	return ide_setup_pci_device(dev, &atiixp_pci_info[id->driver_data]);
 }
 
-static struct pci_device_id atiixp_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+static const struct pci_device_id atiixp_pci_tbl[] = {
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP200_IDE), 0 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP300_IDE), 0 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), 0 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), 1 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), 1 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -641,11 +641,11 @@ static int __devinit cmd64x_init_one(str
 	return d.init_setup(dev, &d);
 }
 
-static struct pci_device_id cmd64x_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_643, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_648, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
+static const struct pci_device_id cmd64x_pci_tbl[] = {
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 2 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 3 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -224,9 +224,9 @@ static int __devinit cs5520_init_one(str
 	return 0;
 }
 
-static struct pci_device_id cs5520_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+static const struct pci_device_id cs5520_pci_tbl[] = {
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5510), 0 },
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5520), 1 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, cs5520_pci_tbl);
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -292,8 +292,8 @@ static int __devinit cs5530_init_one(str
 	return ide_setup_pci_device(dev, &cs5530_chipset);
 }
 
-static struct pci_device_id cs5530_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id cs5530_pci_tbl[] = {
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, cs5530_pci_tbl);
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -214,10 +214,8 @@ static int __devinit cs5535_init_one(str
 	return ide_setup_pci_device(dev, &cs5535_chipset);
 }
 
-static struct pci_device_id cs5535_pci_tbl[] =
-{
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_IDE, PCI_ANY_ID,
-		PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id cs5535_pci_tbl[] = {
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_CS5535_IDE), 0 },
 	{ 0, },
 };
 
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -489,8 +489,8 @@ static int __devinit cy82c693_init_one(s
 	return ret;
 }
 
-static struct pci_device_id cy82c693_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id cy82c693_pci_tbl[] = {
+	{ PCI_VDEVICE(CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, cy82c693_pci_tbl);
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -241,25 +241,28 @@ out:
 	return ret;
 }
 
-static struct pci_device_id generic_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF,        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
-	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
-	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
-	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+static const struct pci_device_id generic_pci_tbl[] = {
+	{ PCI_VDEVICE(NS,	PCI_DEVICE_ID_NS_87410),		 1 },
+	{ PCI_VDEVICE(PCTECH,	PCI_DEVICE_ID_PCTECH_SAMURAI_IDE),	 2 },
+	{ PCI_VDEVICE(HOLTEK,	PCI_DEVICE_ID_HOLTEK_6565),		 3 },
+	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8673F),		 4 },
+	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886A),		 5 },
+	{ PCI_VDEVICE(UMC,	PCI_DEVICE_ID_UMC_UM8886BF),		 6 },
+	{ PCI_VDEVICE(HINT,	PCI_DEVICE_ID_HINT_VXPROII_IDE),	 7 },
+	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_82C561),		 8 },
+	{ PCI_VDEVICE(OPTI,	PCI_DEVICE_ID_OPTI_82C558),		 9 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
+	{ PCI_VDEVICE(VIA,	PCI_DEVICE_ID_VIA_8237_SATA),		10 },
 #endif
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
-	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
-	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
-	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
-	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
+	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO),		11 },
+	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_1),	12 },
+	{ PCI_VDEVICE(TOSHIBA,	PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),	13 },
+	{ PCI_VDEVICE(NETCELL,	PCI_DEVICE_ID_REVOLUTION),		14 },
+	/*
+	 * Must come last.  If you add entries adjust
+	 * this table and generic_chipsets[] appropriately.
+	 */
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -176,8 +176,8 @@ static int __devinit hpt34x_init_one(str
 	return ide_setup_pci_device(dev, d);
 }
 
-static struct pci_device_id hpt34x_pci_tbl[] = {
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id hpt34x_pci_tbl[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, hpt34x_pci_tbl);
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1625,13 +1625,13 @@ static int __devinit hpt366_init_one(str
 	return d.init_setup(dev, &d);
 }
 
-static struct pci_device_id hpt366_pci_tbl[] = {
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372N, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
+static const struct pci_device_id hpt366_pci_tbl[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366),  0 },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372),  1 },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302),  2 },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT371),  3 },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT374),  4 },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372N), 5 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -234,9 +234,8 @@ static int __devinit it8213_init_one(str
 	return 0;
 }
 
-
-static struct pci_device_id it8213_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ITE, 0x8213, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+static const struct pci_device_id it8213_pci_tbl[] = {
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8213), 0 },
 	{ 0, },
 };
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -675,9 +675,9 @@ static int __devinit it821x_init_one(str
 	return 0;
 }
 
-static struct pci_device_id it821x_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8211,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id it821x_pci_tbl[] = {
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), 0 },
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), 0 },
 	{ 0, },
 };
 
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -282,8 +282,8 @@ static int __devinit ns87415_init_one(st
 	return ide_setup_pci_device(dev, &ns87415_chipset);
 }
 
-static struct pci_device_id ns87415_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87415, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id ns87415_pci_tbl[] = {
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_87415), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, ns87415_pci_tbl);
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -372,9 +372,9 @@ static int __devinit opti621_init_one(st
 	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
 }
 
-static struct pci_device_id opti621_pci_tbl[] = {
-	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C621, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+static const struct pci_device_id opti621_pci_tbl[] = {
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), 0 },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 1 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -634,14 +634,14 @@ static int __devinit pdc202new_init_one(
 	return d->init_setup(dev, d);
 }
 
-static struct pci_device_id pdc202new_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20271, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
+static const struct pci_device_id pdc202new_pci_tbl[] = {
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20268), 0 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20269), 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20270), 2 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20271), 3 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20275), 4 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20276), 5 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20277), 6 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, pdc202new_pci_tbl);
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -496,12 +496,12 @@ static int __devinit pdc202xx_init_one(s
 	return d->init_setup(dev, d);
 }
 
-static struct pci_device_id pdc202xx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+static const struct pci_device_id pdc202xx_pci_tbl[] = {
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20263), 2 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20265), 3 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20267), 4 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, pdc202xx_pci_tbl);
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -520,34 +520,34 @@ static void __devinit piix_check_450nx(v
 		printk(KERN_WARNING "piix: A BIOS update may resolve this.\n");
 }		
 
-static struct pci_device_id piix_pci_tbl[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82372FB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+static const struct pci_device_id piix_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371FB_0),   0 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371FB_1),   1 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371MX),     2 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371SB_1),   3 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371AB),     4 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801AB_1),   5 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82443MX_1),   6 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801AA_1),   7 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82372FB_1),   8 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82451NX),     9 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801BA_9),  10 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801BA_8),  11 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801CA_10), 12 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801CA_11), 13 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_11), 14 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801EB_11), 15 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801E_11),  16 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_10), 17 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
- 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801EB_1),  18 },
 #endif
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 23},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 24},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB_2),      19 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH6_19),    20 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH7_21),    21 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_1),  22 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB2_18),    23 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH8_6),     24 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -61,9 +61,9 @@ static int __devinit rz1000_init_one(str
 	return ide_setup_pci_device(dev, &rz1000_chipset);
 }
 
-static struct pci_device_id rz1000_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id rz1000_pci_tbl[] = {
+	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), 0 },
+	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -403,8 +403,8 @@ static int __devinit sc1200_init_one(str
 	return ide_setup_pci_device(dev, &sc1200_chipset);
 }
 
-static struct pci_device_id sc1200_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE), 0},
+static const struct pci_device_id sc1200_pci_tbl[] = {
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_SCx200_IDE), 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -770,8 +770,8 @@ static void __devexit scc_remove(struct 
 	memset(ports, 0, sizeof(*ports));
 }
 
-static struct pci_device_id scc_pci_tbl[] = {
-	{ PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_SCC_ATA,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id scc_pci_tbl[] = {
+	{ PCI_VDEVICE(TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_SCC_ATA), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, scc_pci_tbl);
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -476,12 +476,12 @@ static int __devinit svwks_init_one(stru
 	return d->init_setup(dev, d);
 }
 
-static struct pci_device_id svwks_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+static const struct pci_device_id svwks_pci_tbl[] = {
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE),   0 },
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE),   1 },
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE),   2 },
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2),  3 },
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 4 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -955,11 +955,11 @@ static int __devinit siimage_init_one(st
 	return ide_setup_pci_device(dev, &siimage_chipsets[id->driver_data]);
 }
 
-static struct pci_device_id siimage_pci_tbl[] = {
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id siimage_pci_tbl[] = {
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680),    0 },
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_3112),   1 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_1210SA), 2 },
 #endif
 	{ 0, },
 };
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -611,10 +611,10 @@ static int __devinit sis5513_init_one(st
 	return ide_setup_pci_device(dev, &sis5513_chipset);
 }
 
-static struct pci_device_id sis5513_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id sis5513_pci_tbl[] = {
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_5513), 0 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_5518), 0 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_1180), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -420,8 +420,8 @@ static int __devinit sl82c105_init_one(s
 	return ide_setup_pci_device(dev, &sl82c105_chipset);
 }
 
-static struct pci_device_id sl82c105_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105), 0},
+static const struct pci_device_id sl82c105_pci_tbl[] = {
+	{ PCI_VDEVICE(WINBOND, PCI_DEVICE_ID_WINBOND_82C105), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -178,8 +178,8 @@ static int __devinit slc90e66_init_one(s
 	return ide_setup_pci_device(dev, &slc90e66_chipset);
 }
 
-static struct pci_device_id slc90e66_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1), 0},
+static const struct pci_device_id slc90e66_pci_tbl[] = {
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -244,9 +244,8 @@ static int __devinit tc86c001_init_one(s
 	return ide_setup_pci_device(dev, &tc86c001_chipset);
 }
 
-static struct pci_device_id tc86c001_pci_tbl[] = {
-	{ PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id tc86c001_pci_tbl[] = {
+	{ PCI_VDEVICE(TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_IDE), 0 },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, tc86c001_pci_tbl);
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -129,9 +129,8 @@ static int __devinit triflex_init_one(st
 	return ide_setup_pci_device(dev, &triflex_device);
 }
 
-static struct pci_device_id triflex_pci_tbl[] = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+static const struct pci_device_id triflex_pci_tbl[] = {
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -337,8 +337,8 @@ static int __devinit trm290_init_one(str
 	return ide_setup_pci_device(dev, &trm290_chipset);
 }
 
-static struct pci_device_id trm290_pci_tbl[] = {
-	{ PCI_VENDOR_ID_TEKRAM, PCI_DEVICE_ID_TEKRAM_DC290, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id trm290_pci_tbl[] = {
+	{ PCI_VDEVICE(TEKRAM, PCI_DEVICE_ID_TEKRAM_DC290), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, trm290_pci_tbl);
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -495,11 +495,11 @@ static int __devinit via_init_one(struct
 	return ide_setup_pci_device(dev, &via82cxxx_chipsets[id->driver_data]);
 }
 
-static struct pci_device_id via_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_SATA_EIDE,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+static const struct pci_device_id via_pci_tbl[] = {
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1),  0 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1),  0 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_6410),      1 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_SATA_EIDE), 1 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1421,17 +1421,12 @@ static struct macio_driver pmac_ide_maci
 	.resume		= pmac_ide_macio_resume,
 };
 
-static struct pci_device_id pmac_ide_pci_match[] = {
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+static const struct pci_device_id pmac_ide_pci_match[] = {
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA),	0 },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100),	0 },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100),	0 },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_SH_ATA),	0 },
+	{ PCI_VDEVICE(APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA),	0 },
 };
 
 static struct pci_driver pmac_ide_pci_driver = {
