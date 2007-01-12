From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/19] ia64: add pci_get_legacy_ide_irq()
Date: Fri, 12 Jan 2007 05:26:34 +0100
Message-ID: <20070112042634.28794.88254.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751599AbXALE2G@vger.kernel.org>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[PATCH] ia64: add pci_get_legacy_ide_irq()

Add pci_get_legacy_ide_irq() identical to the one used by i386/x86_64.
Fixes amd74xx driver build on ia64 (bugzilla bug #6644).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 include/asm-ia64/pci.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: a/include/asm-ia64/pci.h
===================================================================
--- a.orig/include/asm-ia64/pci.h
+++ a/include/asm-ia64/pci.h
@@ -167,4 +167,10 @@ pcibios_select_root(struct pci_dev *pdev
 
 #define pcibios_scan_all_fns(a, b)	0
 
+#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+
 #endif /* _ASM_IA64_PCI_H */
