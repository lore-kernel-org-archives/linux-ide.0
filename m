From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] add pci_get_legacy_ide_irq()
Date: Tue, 26 Oct 2004 12:23:51 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098757431.17904.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33495 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262223AbUJZC0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 22:26:55 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Bart !

This patch, as discussed earlier, adds pci_get_legacy_ide_irq() with a generic
implementation and a ppc64 specific one. I only fixed the amd7xxx.c driver for now,
I expect people using this interface will slowly fix their drivers (I will fix via
soon as I'll need it too, and maybe a few others).

This version uses "0" as no-irq to be compatible with the rest of IDE. A patch
teaching IDE about NO_IRQ is on the work, I'll post a version for comment soon,
but it's not simple, so let's do things separately for now, this is more urgent.

If you are happy with this one, can you please fwd to Linus & Andrew for meging ?

Thanks,
Ben.


This patch adds pci_get_legacy_ide_irq() to the PCI layer for dealing with PCI IDE
chipsets that use the "legacy mode" IRQ routing, thus violating the normal PCI routing.
The generic implementation provides IRQ numbers 14 and 15, and it adds a ppc64 specific
one with platform callbacks so that a plaform can provide different IRQ numbers for
"legacy" IDE. I only fixed the amd7xxx.c driver for now, I expect people using this
interface will slowly fix their drivers (I will fix via soon as I'll need it too,
and maybe a few others).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch adds a pci_get_legacy_ide_irq() function to
include/asm-generic/pci.h that returns the interrupt to use for a PCI
IDE controller that is set to "legacy mode". It also adds a ppc64 specific
implementation that allows the platform code to provide it's own number.
Finally, it adds a call to this routine to the amd7xxx driver (instead
of hard coding the numbers) when no interrupt was found.
I decided to fix individual drivers rather 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/pci/amd74xx.c
===================================================================
--- linux-work.orig/drivers/ide/pci/amd74xx.c	2004-09-24 14:33:56.000000000 +1000
+++ linux-work/drivers/ide/pci/amd74xx.c	2004-10-26 12:18:38.441732952 +1000
@@ -416,8 +416,8 @@
 {
 	int i;
 
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+	if (hwif->irq == 0) /* 0 is bogus but will do for now */
+		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
 	hwif->autodma = 0;
 
Index: linux-work/include/asm-ppc64/pci.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci.h	2004-10-26 08:30:21.000000000 +1000
+++ linux-work/include/asm-ppc64/pci.h	2004-10-26 12:18:38.442732800 +1000
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
Index: linux-work/include/asm-generic/pci.h
===================================================================
--- linux-work.orig/include/asm-generic/pci.h	2004-09-24 14:35:38.000000000 +1000
+++ linux-work/include/asm-generic/pci.h	2004-10-26 12:18:38.443732648 +1000
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
Index: linux-work/include/asm-ppc64/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc64/machdep.h	2004-10-26 08:30:21.000000000 +1000
+++ linux-work/include/asm-ppc64/machdep.h	2004-10-26 12:18:38.444732496 +1000
@@ -119,6 +119,9 @@
 	/* Check availability of legacy devices like i8042 */
 	int 		(*check_legacy_ioport)(unsigned int baseport);
 
+	/* Get legacy PCI/IDE interrupt mapping */ 
+	int		(*pci_get_legacy_ide_irq)(struct pci_dev *dev, int channel);
+	
 };
 
 extern struct machdep_calls ppc_md;


