From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] ide/serverworks: fix section references
Date: Thu, 3 Mar 2005 19:49:33 -0800
Message-ID: <20050303194933.4bb19d69.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from fire.osdl.org ([65.172.181.4]:21391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262565AbVCDEBg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2005 23:01:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart <B.Zolnierkiewicz@elka.pw.edu.pl>, akpm <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org


ide/pci/serverworks:  data structs point to __init text
  which should be __devinit;
unless (a) these are going away real soon,
or (b) this just can't happen, isn't a real problem,
or (c) other ?

Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000001e8 R_X86_64_64       .init.text+0x000000000000020e
Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000001f8 R_X86_64_64       .init.text+0x000000000000024c
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000208 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000248 R_X86_64_64       .init.text+0x000000000000020e
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000258 R_X86_64_64       .init.text+0x000000000000024c
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000268 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000270 R_X86_64_64       .init.text+0x0000000000000213
Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000002a8 R_X86_64_64       .init.text+0x00000000000001c3
Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000002b8 R_X86_64_64       .init.text+0x000000000000024c
Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000002c8 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/serverworks.o .data refers to 00000000000002d0 R_X86_64_64       .init.text+0x0000000000000213
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000308 R_X86_64_64       .init.text+0x00000000000001c3
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000318 R_X86_64_64       .init.text+0x000000000000024c
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000328 R_X86_64_64       .init.text
Error: ./drivers/ide/pci/serverworks.o .data refers to 0000000000000330 R_X86_64_64       .init.text+0x0000000000000213

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/ide/pci/serverworks.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -Naurp ./drivers/ide/pci/serverworks.c~serverworks_ide_sections ./drivers/ide/pci/serverworks.c
--- ./drivers/ide/pci/serverworks.c~serverworks_ide_sections	2005-03-01 23:37:47.000000000 -0800
+++ ./drivers/ide/pci/serverworks.c	2005-03-03 19:29:35.000000000 -0800
@@ -341,7 +341,7 @@ static int svwks_ide_dma_end (ide_drive_
 	return __ide_dma_end(drive);
 }
 
-static unsigned int __init init_chipset_svwks (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_svwks (struct pci_dev *dev, const char *name)
 {
 	unsigned int reg;
 	u8 btr;
@@ -442,7 +442,7 @@ static unsigned int __init init_chipset_
 	return (dev->irq) ? dev->irq : 0;
 }
 
-static unsigned int __init ata66_svwks_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_svwks (ide_hwif_t *hwif)
 {
 	return 1;
 }
@@ -454,7 +454,7 @@ static unsigned int __init ata66_svwks_s
  * Bit 14 clear = primary IDE channel does not have 80-pin cable.
  * Bit 14 set   = primary IDE channel has 80-pin cable.
  */
-static unsigned int __init ata66_svwks_dell (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_dell (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
@@ -472,7 +472,7 @@ static unsigned int __init ata66_svwks_d
  *
  * WARNING: this only works on Alpine hardware!
  */
-static unsigned int __init ata66_svwks_cobalt (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_cobalt (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
@@ -483,7 +483,7 @@ static unsigned int __init ata66_svwks_c
 	return 0;
 }
 
-static unsigned int __init ata66_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -508,7 +508,7 @@ static unsigned int __init ata66_svwks (
 }
 
 #undef CAN_SW_DMA
-static void __init init_hwif_svwks (ide_hwif_t *hwif)
+static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
 	u8 dma_stat = 0;
 
@@ -556,7 +556,7 @@ static void __init init_hwif_svwks (ide_
 /*
  * We allow the BM-DMA driver to only work on enabled interfaces.
  */
-static void __init init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
+static void __devinit init_dma_svwks (ide_hwif_t *hwif, unsigned long dmabase)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -568,12 +568,12 @@ static void __init init_dma_svwks (ide_h
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static int __init init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
 }
 
-static int __init init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if (!(PCI_FUNC(dev->devfn) & 1)) {
 		d->bootable = NEVER_BOARD;

---
