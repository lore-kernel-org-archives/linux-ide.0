From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/13] ide: set drive->autotune in ide_pci_setup_ports()
Date: Wed, 5 Sep 2007 23:57:03 +0200
Message-ID: <200709052357.03889.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXIEV7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:59:00 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828126nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Majority of host drivers using IDE PCI layer set drive->autotune, the only
exceptions are:

generic.c
ns87415.c
rz1000.c
trm290.c
* no ->set_pio_mode method

it821x.c:
* if memory allocation fails drive->autotune won't be set
  (but there also won't be ->set_pio_mode method in such case)

piix.c:
* MPIIX controller (no ->init_hwif method so also no ->set_pio_mode method)

However if there is no ->set_pio_mode method there are no changes in behavior
w.r.t. PIO tuning so always set drive->autotune in ide_pci_setup_ports().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c      |    2 --
 drivers/ide/pci/alim15x3.c     |    3 ---
 drivers/ide/pci/amd74xx.c      |    1 -
 drivers/ide/pci/atiixp.c       |    2 --
 drivers/ide/pci/cmd64x.c       |    2 --
 drivers/ide/pci/cs5520.c       |    3 ---
 drivers/ide/pci/cs5530.c       |    3 ---
 drivers/ide/pci/cs5535.c       |    2 --
 drivers/ide/pci/cy82c693.c     |    3 ---
 drivers/ide/pci/hpt34x.c       |    3 ---
 drivers/ide/pci/hpt366.c       |    2 --
 drivers/ide/pci/it8213.c       |    3 ---
 drivers/ide/pci/it821x.c       |    3 ---
 drivers/ide/pci/jmicron.c      |    3 ---
 drivers/ide/pci/opti621.c      |    3 ---
 drivers/ide/pci/pdc202xx_new.c |    2 --
 drivers/ide/pci/pdc202xx_old.c |    2 --
 drivers/ide/pci/piix.c         |    3 ---
 drivers/ide/pci/sc1200.c       |    3 ---
 drivers/ide/pci/scc_pata.c     |    3 ---
 drivers/ide/pci/serverworks.c  |    3 ---
 drivers/ide/pci/siimage.c      |    2 --
 drivers/ide/pci/sis5513.c      |    3 ---
 drivers/ide/pci/sl82c105.c     |    6 ------
 drivers/ide/pci/slc90e66.c     |    3 ---
 drivers/ide/pci/tc86c001.c     |    2 --
 drivers/ide/pci/triflex.c      |    3 ---
 drivers/ide/pci/via82cxxx.c    |    1 -
 drivers/ide/setup-pci.c        |    3 +++
 29 files changed, 3 insertions(+), 74 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -192,8 +192,6 @@ static void __devinit init_hwif_aec62xx(
 	else
 		hwif->set_dma_mode = &aec6260_set_mode;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -668,9 +668,6 @@ static void __devinit init_hwif_common_a
 	if (m5229_revision <= 0xC4)
 		hwif->host_flags |= IDE_HFLAG_NO_LBA48_DMA;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -253,7 +253,6 @@ static void __devinit init_hwif_amd74xx(
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = 1;
-		hwif->drives[i].autotune = 1;
 	}
 
 	if (!hwif->dma_base)
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -174,8 +174,6 @@ static void __devinit init_hwif_atiixp(i
 
 	hwif->set_pio_mode = &atiixp_set_pio_mode;
 	hwif->set_dma_mode = &atiixp_set_dma_mode;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
 
 	if (!hwif->dma_base)
 		return;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -506,8 +506,6 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->set_pio_mode = &cmd64x_set_pio_mode;
 	hwif->set_dma_mode = &cmd64x_set_dma_mode;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -123,9 +123,6 @@ static void __devinit init_hwif_cs5520(i
 	hwif->set_pio_mode = &cs5520_set_pio_mode;
 	hwif->set_dma_mode = &cs5520_set_dma_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -255,9 +255,6 @@ static void __devinit init_hwif_cs5530 (
 	if (CS5530_BAD_PIO(inl(basereg + 8)))
 		outl(cs5530_pio_timings[(d0_timings >> 31) & 1][0], basereg + 8);
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -180,8 +180,6 @@ static void __devinit init_hwif_cs5535(i
 	hwif->set_pio_mode = &cs5535_set_pio_mode;
 	hwif->set_dma_mode = &cs5535_set_dma_mode;
 
-	hwif->drives[1].autotune = hwif->drives[0].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -431,9 +431,6 @@ static void __devinit init_hwif_cy82c693
 	hwif->chipset = ide_cy82c693;
 	hwif->set_pio_mode = &cy82c693_set_pio_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -127,9 +127,6 @@ static void __devinit init_hwif_hpt34x(i
 {
 	hwif->set_pio_mode = &hpt34x_set_pio_mode;
 	hwif->set_dma_mode = &hpt34x_set_mode;
-
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
 }
 
 static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1282,8 +1282,6 @@ static void __devinit init_hwif_hpt366(i
 	if (new_mcr != old_mcr)
 		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -172,9 +172,6 @@ static void __devinit init_hwif_it8213(i
 	hwif->set_dma_mode = &it8213_set_dma_mode;
 	hwif->set_pio_mode = &it8213_set_pio_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -585,9 +585,6 @@ static void __devinit init_hwif_it821x(i
 	} else
 		hwif->host_flags |= IDE_HFLAG_NO_SET_MODE;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -111,9 +111,6 @@ static void __devinit init_hwif_jmicron(
 	hwif->set_pio_mode = &jmicron_set_pio_mode;
 	hwif->set_dma_mode = &jmicron_set_dma_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -329,9 +329,6 @@ static void __devinit init_hwif_opti621 
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 
 	hwif->set_pio_mode = &opti621_set_pio_mode;
-
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
 }
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -471,8 +471,6 @@ static void __devinit init_hwif_pdc202ne
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->resetproc = &pdcnew_reset;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -317,8 +317,6 @@ static void __devinit init_hwif_pdc202xx
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc = &pdc202xx_reset;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -344,9 +344,6 @@ static void __devinit init_hwif_piix(ide
 	hwif->set_pio_mode = &piix_set_pio_mode;
 	hwif->set_dma_mode = &piix_set_dma_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -365,9 +365,6 @@ static void __devinit init_hwif_sc1200 (
 	hwif->set_pio_mode = &sc1200_set_pio_mode;
 	hwif->set_dma_mode = &sc1200_set_dma_mode;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -683,9 +683,6 @@ static void __devinit init_hwif_scc(ide_
 	hwif->ide_dma_test_irq = scc_dma_test_irq;
 	hwif->udma_filter = scc_udma_filter;
 
-	hwif->drives[0].autotune = IDE_TUNE_AUTO;
-	hwif->drives[1].autotune = IDE_TUNE_AUTO;
-
 	if (in_be32((void __iomem *)(hwif->config_data + 0xff0)) & CCKCTRL_ATACLKOEN)
 		hwif->ultra_mask = ATA_UDMA6; /* 133MHz */
 	else
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -363,9 +363,6 @@ static void __devinit init_hwif_svwks (i
 	hwif->set_dma_mode = &svwks_set_dma_mode;
 	hwif->udma_filter = &svwks_udma_filter;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -882,8 +882,6 @@ static void __devinit init_hwif_siimage(
 		}
 	}
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -570,9 +570,6 @@ static void __devinit init_hwif_sis5513 
 	if (chipset_family >= ATA_133)
 		hwif->udma_filter = sis5513_ata133_udma_filter;
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -368,12 +368,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->drives[0].io_32bit = hwif->drives[1].io_32bit = 1;
 	hwif->drives[0].unmask   = hwif->drives[1].unmask   = 1;
 
-	/*
-	 * We always autotune PIO,  this is done before DMA is checked,
-	 * so there's no risk of accidentally disabling DMA
-	 */
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -138,9 +138,6 @@ static void __devinit init_hwif_slc90e66
 
 	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
 
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
 	if (hwif->dma_base == 0)
 		return;
 
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -184,8 +184,6 @@ static void __devinit init_hwif_tc86c001
 
 	hwif->busproc	= &tc86c001_busproc;
 
-	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-
 	if (!hwif->dma_base)
 		return;
 
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -100,9 +100,6 @@ static void __devinit init_hwif_triflex(
 {
 	hwif->set_pio_mode = &triflex_set_pio_mode;
 	hwif->set_dma_mode = &triflex_set_mode;
-
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
 }
 
 static ide_pci_device_t triflex_device __devinitdata = {
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -436,7 +436,6 @@ static void __devinit init_hwif_via82cxx
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
-		hwif->drives[i].autotune = 1;
 	}
 
 	if (!hwif->dma_base)
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -577,6 +577,9 @@ void ide_pci_setup_ports(struct pci_dev 
 			hwif->ultra_mask = d->udma_mask;
 		}
 
+		hwif->drives[0].autotune = 1;
+		hwif->drives[1].autotune = 1;
+
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
