From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: drivers/ide/pci/adma100.c obsolete?
Date: Wed, 17 Dec 2003 16:56:19 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031217165619.5b25fe2b.rddunlap@osdl.org>
References: <20031109081426.GA1287@gondor.apana.org.au>
	<200311091747.52183.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:64173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264886AbTLRA5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Dec 2003 19:57:38 -0500
In-Reply-To: <200311091747.52183.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: herbert@gondor.apana.org.au, linux-ide@vger.kernel.org

On Sun, 9 Nov 2003 17:47:52 +0100 Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

| On Sunday 09 of November 2003 09:14, Herbert Xu wrote:
| > Hi Bart:
| >
| > Could you please tell me whether adma100.[ch] is still needed? Nothing
| > else seems to refer to them anymore.
| 
| Hi,
| 
| It is needed, somebody should forward port 2.4.x fixes to make it useful.


Herbert, did you do this forward port of adma100 yet?

If not, below is forward port of 2.4.23 driver to 2.6.0-test11.

Is this useful?

--
~Randy


description:	update ide/pci/adma100 driver
product_versions: Linux 2.6.0-test11
changelog:	forward port the adma100 2.4.x changes to 2.6.0-test11
maintainer:	Bart <B.Zolnierkiewicz@elka.pw.edu.pl>

diffstat:=
 drivers/ide/Kconfig       |    5 +---
 drivers/ide/pci/adma100.c |   51 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/ide/pci/adma100.h |   19 +++++++----------
 include/linux/pci_ids.h   |    2 -
 4 files changed, 60 insertions(+), 17 deletions(-)

diff -Naurp ./drivers/ide/pci/adma100.h~adma ./drivers/ide/pci/adma100.h
--- ./drivers/ide/pci/adma100.h~adma	2003-11-26 12:45:28.000000000 -0800
+++ ./drivers/ide/pci/adma100.h	2003-12-17 16:46:54.000000000 -0800
@@ -5,21 +5,18 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-extern void init_setup_pdcadma(struct pci_dev *, ide_pci_device_t *);
-extern unsigned int init_chipset_pdcadma(struct pci_dev *, const char *);
-extern void init_hwif_pdcadma(ide_hwif_t *);
-extern void init_dma_pdcadma(ide_hwif_t *, unsigned long);
+extern void init_hwif_adma100(ide_hwif_t *);
 
-static ide_pci_device_t pdcadma_chipsets[] __devinitdata = {
+static ide_pci_device_t adma100_chipsets[] __devinitdata = {
 	{
 		.vendor		= PCI_VENDOR_ID_PDC,
-		.device		= PCI_DEVICE_ID_PDC_1841,
+		.device		= PCI_DEVICE_ID_PDC_ADMA100,
 		.name		= "ADMA100",
-		.init_setup	= init_setup_pdcadma,
-		.init_chipset	= init_chipset_pdcadma,
+		.init_setup	= NULL,
+		.init_chipset	= NULL,
 		.init_iops	= NULL,
-		.init_hwif	= init_hwif_pdcadma,
-		.init_dma	= init_dma_pdcadma,
+		.init_hwif	= init_hwif_adma100,
+		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -31,6 +28,6 @@ static ide_pci_device_t pdcadma_chipsets
 		.channels	= 0,
 		.bootable	= EOL,
 	}
-}
+};
 
 #endif /* ADMA_100_H */
diff -Naurp ./drivers/ide/pci/adma100.c~adma ./drivers/ide/pci/adma100.c
--- ./drivers/ide/pci/adma100.c~adma	2003-11-26 12:43:35.000000000 -0800
+++ ./drivers/ide/pci/adma100.c	2003-12-17 16:48:09.000000000 -0800
@@ -8,6 +8,9 @@
  *  more details.
  */
 
+#include <linux/config.h> /* for CONFIG_BLK_DEV_IDEPCI */
+#include <linux/types.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
@@ -16,15 +19,59 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
-void __init ide_init_adma100 (ide_hwif_t *hwif)
+#include "adma100.h"
+
+void __init init_hwif_adma100 (ide_hwif_t *hwif)
 {
 	unsigned long  phy_admctl = pci_resource_start(hwif->pci_dev, 4) + 0x80 + (hwif->channel * 0x20);
 	void *v_admctl;
 
-	hwif->autodma = 0;		// not compatible with normal IDE DMA transfers
+	hwif->autodma  = 0;		// not compatible with normal IDE DMA transfers
 	hwif->dma_base = 0;		// disable DMA completely
 	hwif->io_ports[IDE_CONTROL_OFFSET] += 4;	// chip needs offset of 6 instead of 2
 	v_admctl = ioremap_nocache(phy_admctl, 1024);	// map config regs, so we can turn on drive IRQs
 	*((unsigned short *)v_admctl) &= 3;		// enable aIEN; preserve PIO mode
 	iounmap(v_admctl);				// all done; unmap config regs
+	printk("ADMA100: initialized %s for basic PIO-only operation\n", hwif->name);
+}
+
+extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
+
+static int __devinit adma100_init_one (struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_pci_device_t *d = &adma100_chipsets[id->driver_data];
+
+	if (dev->device != d->device)
+		BUG();
+	ide_setup_pci_device(dev, d);
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static struct pci_device_id adma100_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_PDC, PCI_DEVICE_ID_PDC_ADMA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+static struct pci_driver driver = {
+	.name		= "ADMA100 IDE",
+	.id_table	= adma100_pci_tbl,
+	.probe		= adma100_init_one,
+};
+
+static int adma100_ide_init (void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+static void adma100_ide_exit (void)
+{
+	ide_pci_unregister_driver(&driver);
 }
+
+module_init(adma100_ide_init);
+module_exit(adma100_ide_exit);
+
+MODULE_AUTHOR("Mark Lord");
+MODULE_DESCRIPTION("Basic PIO support for ADMA100 IDE");
+MODULE_LICENSE("GPL");
diff -Naurp ./drivers/ide/Kconfig~adma ./drivers/ide/Kconfig
--- ./drivers/ide/Kconfig~adma	2003-11-26 12:43:56.000000000 -0800
+++ ./drivers/ide/Kconfig	2003-12-17 16:03:09.000000000 -0800
@@ -526,10 +526,9 @@ config IDEDMA_NEW_DRIVE_LISTINGS
 
 	  If in doubt, say N.
 
-config BLK_DEV_ADMA
-	bool
+config BLK_DEV_ADMA100
+	tristate "Pacific Digital ADMA-100 basic support"
 	depends on PCI && BLK_DEV_IDEPCI
-	default BLK_DEV_IDEDMA_PCI
 
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
diff -Naurp ./include/linux/pci_ids.h~adma ./include/linux/pci_ids.h
--- ./include/linux/pci_ids.h~adma	2003-11-26 12:43:39.000000000 -0800
+++ ./include/linux/pci_ids.h	2003-12-17 16:05:27.000000000 -0800
@@ -1811,7 +1811,7 @@
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0 
 
 #define PCI_VENDOR_ID_PDC		0x15e9
-#define PCI_DEVICE_ID_PDC_1841		0x1841
+#define PCI_DEVICE_ID_PDC_ADMA100	0x1841
 
 #define PCI_VENDOR_ID_MACROLINK		0x15ed
 #define PCI_DEVICE_ID_MACROLINK_MCCS8	0x1000
