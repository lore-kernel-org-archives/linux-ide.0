From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide: remove write-only hwif->hw
Date: Mon, 24 Sep 2007 22:37:11 +0200
Message-ID: <200709242237.11449.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29604 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbXIXUqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485932nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c          |    5 -----
 drivers/ide/arm/rapide.c          |    4 +---
 drivers/ide/ide.c                 |   15 ++++++++-------
 drivers/ide/legacy/ide_platform.c |   11 +++++------
 drivers/ide/mips/au1xxx-ide.c     |   10 +++++-----
 drivers/ide/mips/swarm.c          |    9 +++------
 drivers/ide/pci/sgiioc4.c         |    8 +++++---
 drivers/ide/pci/siimage.c         |   11 +++--------
 drivers/ide/ppc/pmac.c            |    6 ++++--
 drivers/ide/setup-pci.c           |   11 ++++++-----
 include/linux/ide.h               |    1 -
 11 files changed, 40 insertions(+), 51 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -450,8 +450,6 @@ icside_setup(void __iomem *base, struct 
 	if (hwif) {
 		int i;
 
-		memset(&hwif->hw, 0, sizeof(hw_regs_t));
-
 		/*
 		 * Ensure we're using MMIO
 		 */
@@ -459,13 +457,10 @@ icside_setup(void __iomem *base, struct 
 		hwif->mmio = 1;
 
 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-			hwif->hw.io_ports[i] = port;
 			hwif->io_ports[i] = port;
 			port += 1 << info->stepping;
 		}
-		hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)base + info->ctrloffset;
 		hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)base + info->ctrloffset;
-		hwif->hw.irq  = ec->irq;
 		hwif->irq     = ec->irq;
 		hwif->noprobe = 0;
 		hwif->chipset = ide_acorn;
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -24,13 +24,11 @@ rapide_locate_hwif(void __iomem *base, v
 		goto out;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hwif->hw.io_ports[i] = port;
 		hwif->io_ports[i] = port;
 		port += sz;
 	}
-	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
 	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
-	hwif->hw.irq = hwif->irq = irq;
+	hwif->irq = irq;
 	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
 out:
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -170,7 +170,6 @@ static void init_hwif_default(ide_hwif_t
 
 	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
 
-	memcpy(&hwif->hw, &hw, sizeof(hw));
 	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
 
 	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
@@ -216,7 +215,7 @@ static void __init init_ide_data (void)
 		init_hwif_data(hwif, index);
 		init_hwif_default(hwif, index);
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
-		hwif->irq = hwif->hw.irq =
+		hwif->irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 #endif
 	}
@@ -732,8 +731,7 @@ found:
 	}
 	if (hwif->present)
 		return -1;
-	memcpy(&hwif->hw, hw, sizeof(*hw));
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
+	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
 	hwif->fixup = fixup;
@@ -1418,6 +1416,9 @@ static int __init ide_setup(char *s)
 			"reset", "minus6", "ata66", "minus8", "minus9",
 			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
 			"dtc2278", "umc8672", "ali14xx", NULL };
+
+		hw_regs_t hwregs;
+
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
@@ -1527,9 +1528,9 @@ static int __init ide_setup(char *s)
 			case 2: /* base,ctl */
 				vals[2] = 0;	/* default irq = probe for it */
 			case 3: /* base,ctl,irq */
-				hwif->hw.irq = vals[2];
-				ide_init_hwif_ports(&hwif->hw, (unsigned long) vals[0], (unsigned long) vals[1], &hwif->irq);
-				memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
+				memset(&hwregs, 0, sizeof(hwregs));
+				ide_init_hwif_ports(&hwregs, vals[0], vals[1], &hwif->irq);
+				memcpy(hwif->io_ports, hwregs.io_ports, sizeof(hwif->io_ports));
 				hwif->irq      = vals[2];
 				hwif->noprobe  = 0;
 				hwif->chipset  = ide_forced;
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -39,19 +39,18 @@ static ide_hwif_t *__devinit plat_ide_lo
 	if (hwif == NULL)
 		goto out;
 
-	hwif->hw.io_ports[IDE_DATA_OFFSET] = port;
+	hwif->io_ports[IDE_DATA_OFFSET] = port;
 
 	port += (1 << pdata->ioport_shift);
 	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET;
 	     i++, port += (1 << pdata->ioport_shift))
-		hwif->hw.io_ports[i] = port;
+		hwif->io_ports[i] = port;
 
-	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
+	hwif->io_ports[IDE_CONTROL_OFFSET] = (unsigned long)ctrl;
 
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
-	hwif->hw.irq = hwif->irq = irq;
+	hwif->irq = irq;
 
-	hwif->chipset = hwif->hw.chipset = ide_generic;
+	hwif->chipset = ide_generic;
 
 	if (mmio) {
 		hwif->mmio = 1;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -601,9 +601,9 @@ static int au_ide_probe(struct device *d
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
 	struct resource *res;
-	hw_regs_t *hw;
 	int ret = 0;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA)
 	char *mode = "MWDMA2";
@@ -645,12 +645,12 @@ static int au_ide_probe(struct device *d
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw 				= &hwif->hw;
-	hwif->irq = hw->irq             = ahwif->irq;
+	hwif->irq			= ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
 
-	auide_setup_ports(hw, ahwif);
-	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
+	memset(&hw, 0, sizeof(hw));
+	auide_setup_ports(&hw, ahwif);
+	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
 
 	hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
Index: b/drivers/ide/mips/swarm.c
===================================================================
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -120,14 +120,11 @@ static int __devinit swarm_ide_probe(str
 	hwif->noprobe = 0;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hwif->hw.io_ports[i] =
+		hwif->io_ports[i] =
 				(unsigned long)(base + ((0x1f0 + i) << 5));
-	hwif->hw.io_ports[IDE_CONTROL_OFFSET] =
+	hwif->io_ports[IDE_CONTROL_OFFSET] =
 				(unsigned long)(base + (0x3f6 << 5));
-	hwif->hw.irq = K_INT_GB_IDE;
-
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
-	hwif->irq = hwif->hw.irq;
+	hwif->irq = K_INT_GB_IDE;
 
 	idx[0] = hwif->index;
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -654,10 +654,12 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	}
 
 	if (hwif->io_ports[IDE_DATA_OFFSET] != cmd_base) {
+		hw_regs_t hw;
+
 		/* Initialize the IO registers */
-		sgiioc4_init_hwif_ports(&hwif->hw, cmd_base, ctl, irqport);
-		memcpy(hwif->io_ports, hwif->hw.io_ports,
-		       sizeof (hwif->io_ports));
+		memset(&hw, 0, sizeof(hw));
+		sgiioc4_init_hwif_ports(&hw, cmd_base, ctl, irqport);
+		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 	}
 
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -754,16 +754,11 @@ static void __devinit init_mmio_iops_sii
 		hwif->sata_misc[SATA_IEN_OFFSET]	= base + 0x148;
 	}
 
-	hw.irq				= hwif->pci_dev->irq;
+	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
 
-	memcpy(&hwif->hw, &hw, sizeof(hw));
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
+	hwif->irq = dev->irq;
 
-	hwif->irq			= hw.irq;
-
-       	base = (unsigned long) addr;
-
-	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
+	hwif->dma_base = (unsigned long)addr + (ch ? 0x08 : 0x00);
 
 	hwif->mmio = 1;
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1040,6 +1040,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	struct device_node *np = pmif->node;
 	const int *bidp;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1125,8 +1126,9 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	/* Tell common code _not_ to mess with resources */
 	hwif->mmio = 1;
 	hwif->hwif_data = pmif;
-	pmac_ide_init_hwif_ports(&hwif->hw, pmif->regbase, 0, &hwif->irq);
-	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
+	memset(&hw, 0, sizeof(hw));
+	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, &hwif->irq);
+	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
 	hwif->chipset = ide_pmac;
 	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || pmif->mediabay;
 	hwif->hold = pmif->mediabay;
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -387,14 +387,15 @@ static ide_hwif_t *ide_hwif_configure(st
 		return NULL;	/* no room in ide_hwifs[] */
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
 	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
-		memset(&hwif->hw, 0, sizeof(hwif->hw));
+		hw_regs_t hw;
+
+		memset(&hw, 0, sizeof(hw));
 #ifndef CONFIG_IDE_ARCH_OBSOLETE_INIT
-		ide_std_init_ports(&hwif->hw, base, (ctl | 2));
-		hwif->hw.io_ports[IDE_IRQ_OFFSET] = 0;
+		ide_std_init_ports(&hw, base, ctl | 2);
 #else
-		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
+		ide_init_hwif_ports(&hw, base, ctl | 2, NULL);
 #endif
-		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
+		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 	}
 	hwif->chipset = d->chipset ? d->chipset : ide_pci;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -659,7 +659,6 @@ typedef struct hwif_s {
 	unsigned long	sata_scr[SATA_NR_PORTS];
 	unsigned long	sata_misc[SATA_NR_PORTS];
 
-	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
 
 	u8 major;	/* our major number */
