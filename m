From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC] pci_get_legacy_ide_irq()
Date: Tue, 19 Oct 2004 17:04:48 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098169487.15029.58.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:27793 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268053AbUJSHJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2004 03:09:46 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Hi !

As discussed earlier, this is a proposed patch that adds the function
to include/asm-generic/pci.h and ppc64's own pci.h. I also only call
it from the amd7xxx.c driver for now, I want to let Bart decide if we
should add a call to it from every driver that don't see an irq when
we sort-of know what we are doing, or if we could just call it from the
generic pci-ide code when the controller is in legacy mode ... maybe
after a probe pass ? (thoug archs like ppc don't do irq probe).

The patch also uses NO_IRQ which is currently not defined on a lot of
archs. This is ok as I'm currently collecting definitions for it and
will send a patch adding those before this patch gets submited.

This patch adds a pci_get_legacy_ide_irq() function to
include/asm-generic/pci.h that returns the interrupt to use for a PCI
IDE controller that is set to "legacy mode". It also adds a ppc64 specific
implementation that allows the platform code to provide it's own number.
Finally, it adds a call to this routine to the amd7xxx driver (instead
of hard coding the numbers) when no interrupt was found.
I decided to fix individual drivers rather 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-maple/drivers/ide/pci/amd74xx.c
===================================================================
--- linux-maple.orig/drivers/ide/pci/amd74xx.c	2004-10-19 13:38:08.000000000 +1000
+++ linux-maple/drivers/ide/pci/amd74xx.c	2004-10-19 17:04:20.243498048 +1000
@@ -416,8 +416,8 @@
 {
 	int i;
 
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+	if (hwif->irq == NO_IRQ)
+		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
 	hwif->autodma = 0;
 
Index: linux-maple/include/asm-ppc64/pci.h
===================================================================
--- linux-maple.orig/include/asm-ppc64/pci.h	2004-10-19 13:37:31.000000000 +1000
+++ linux-maple/include/asm-ppc64/pci.h	2004-10-19 17:03:43.151545320 +1000
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
+#include <asm/machdep.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -20,6 +21,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+struct pci_dev;
+
 #ifdef CONFIG_PPC_ISERIES
 #define pcibios_scan_all_fns(a, b)	0
 #else
@@ -36,7 +39,13 @@
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-struct pci_dev;
+#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	if (ppc_md.pci_get_legacy_ide_irq)
+		return ppc_md.pci_get_legacy_ide_irq(dev, channel);
+	return channel ? 15 : 14;
+}
 
 #define HAVE_ARCH_PCI_MWI 1
 static inline int pcibios_prep_mwi(struct pci_dev *dev)
Index: linux-maple/include/asm-generic/pci.h
===================================================================
--- linux-maple.orig/include/asm-generic/pci.h	2004-10-19 13:37:39.000000000 +1000
+++ linux-maple/include/asm-generic/pci.h	2004-10-19 17:03:43.152545168 +1000
@@ -24,4 +24,11 @@
 
 #define pcibios_scan_all_fns(a, b)	0
 
+#ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+#endif /* HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ */
+
 #endif
Index: linux-maple/include/asm-ppc64/machdep.h
===================================================================
--- linux-maple.orig/include/asm-ppc64/machdep.h	2004-10-19 16:44:18.907474272 +1000
+++ linux-maple/include/asm-ppc64/machdep.h	2004-10-19 17:03:43.152545168 +1000
@@ -117,6 +117,9 @@
 	/* Check availability of legacy devices like i8042 */
 	int 		(*check_legacy_ioport)(unsigned int baseport);
 
+	/* Get legacy PCI/IDE interrupt mapping */ 
+	int		(*pci_get_legacy_ide_irq)(struct pci_dev *dev, int channel);
+	
 };
 
 extern struct machdep_calls ppc_md;


