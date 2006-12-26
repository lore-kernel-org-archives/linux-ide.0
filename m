From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/12] devres: implement managed iomap interface
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-ID: <11671463141693-git-send-email-htejun@gmail.com>
References: <1167146313307-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:58150 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932683AbWLZPSv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Dec 2006 10:18:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3665157uga
        for <linux-ide@vger.kernel.org>; Tue, 26 Dec 2006 07:18:50 -0800 (PST)
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement managed iomap interface - pcim_iomap_table(), pcim_iomap()
and pcim_iounmap().  Except for being managed, pcim_iomap() and
pcim_iounmap() take the same arguments and have the same effect as
non-managed coutnerparts.

pcim_iomap_table() returns pointer to constant array of void __iomem *
which record addresses for all mapped BARs.  This function is
guaranteed to succeed after successful pcim_iomap() and drivers are
free to reference the returned iomap table.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/io.h |    7 +++
 lib/Makefile       |    3 +-
 lib/iomap.c        |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 81877ea..4266638 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -28,6 +28,13 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       unsigned long phys_addr, pgprot_t prot);
 
+/*
+ * Managed PCI iomap interface
+ */
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev);
+
 /**
  *	check_signature		-	find BIOS signatures
  *	@io_addr: mmio address to check
diff --git a/lib/Makefile b/lib/Makefile
index 77b4bad..29b2e99 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o reciprocal_div.o
+	 sha1.o irq_regs.o reciprocal_div.o iomap.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -41,7 +41,6 @@ obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
-obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff --git a/lib/iomap.c b/lib/iomap.c
index d6ccdd8..2e058b6 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -4,8 +4,10 @@
  * (C) Copyright 2004 Linus Torvalds
  */
 #include <linux/pci.h>
+#include <linux/io.h>
+
+#ifdef CONFIG_GENERIC_IOMAP
 #include <linux/module.h>
-#include <asm/io.h>
 
 /*
  * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
@@ -254,3 +256,104 @@ void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 }
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
+
+#endif /* CONFIG_GENERIC_IOMAP */
+
+/*
+ * PCI iomap devres.
+ */
+#define PCIM_IOMAP_MAX	PCI_ROM_RESOURCE
+
+struct pcim_iomap_devres {
+	void __iomem *table[PCIM_IOMAP_MAX];
+};
+
+static void pcim_iomap_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pcim_iomap_devres *this = res;
+	int i;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (this->table[i])
+			pci_iounmap(dev, this->table[i]);
+}
+
+/**
+ * pcim_iomap_table - access iomap allocation table
+ * @pdev: PCI device to access iomap table for
+ *
+ * Access iomap allocation table for @dev.  If iomap table doesn't
+ * exist and @pdev is managed, it will be allocated.  All iomaps
+ * recorded in the iomap table are automatically unmapped on driver
+ * detach.
+ *
+ * This function might sleep when the table is first allocated but can
+ * be safely called without context and guaranteed to succed once
+ * allocated.
+ */
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev)
+{
+	struct pcim_iomap_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
+	if (dr)
+		return dr->table;
+
+	new_dr = devres_alloc(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
+	return dr->table;
+}
+EXPORT_SYMBOL(pcim_iomap_table);
+
+/**
+ * pcim_iomap - Managed pcim_iomap()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL(pcim_iomap);
+
+/**
+ * pcim_iounmap - Managed pci_iounmap()
+ * @pdev: PCI device to iounmap for
+ * @addr: Address to unmap
+ *
+ * Managed pci_iounmap().  @addr must be mapped using pcim_iomap().
+ */
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
+{
+	void __iomem **tbl;
+	int i;
+
+	pci_iounmap(pdev, addr);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	BUG_ON(!tbl);
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (tbl[i] == addr) {
+			tbl[i] = NULL;
+			return;
+		}
+	WARN_ON(1);
+}
+EXPORT_SYMBOL(pcim_iounmap);
-- 
1.4.4.2


