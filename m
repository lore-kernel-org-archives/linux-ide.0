From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 01/12] iommu-common: move to arch/sparc
Date: Sun, 15 Apr 2018 16:59:36 +0200
Message-ID: <20180415145947.1248-2-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180415145947.1248-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

This code is only used by sparc, and all new iommu drivers should use the
drivers/iommu/ framework.  Also remove the unused exports.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 {include/linux => arch/sparc/include/asm}/iommu-common.h | 0
 arch/sparc/include/asm/iommu_64.h                        | 2 +-
 arch/sparc/kernel/Makefile                               | 2 +-
 {lib => arch/sparc/kernel}/iommu-common.c                | 5 +----
 arch/sparc/kernel/iommu.c                                | 2 +-
 arch/sparc/kernel/ldc.c                                  | 2 +-
 arch/sparc/kernel/pci_sun4v.c                            | 2 +-
 lib/Makefile                                             | 2 +-
 8 files changed, 7 insertions(+), 10 deletions(-)
 rename {include/linux => arch/sparc/include/asm}/iommu-common.h (100%)
 rename {lib => arch/sparc/kernel}/iommu-common.c (98%)

diff --git a/include/linux/iommu-common.h b/arch/sparc/include/asm/iommu-common.h
similarity index 100%
rename from include/linux/iommu-common.h
rename to arch/sparc/include/asm/iommu-common.h
diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 9ed6b54caa4b..0ef6dedf747e 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -17,7 +17,7 @@
 #define IOPTE_WRITE   0x0000000000000002UL
 
 #define IOMMU_NUM_CTXS	4096
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 struct iommu_arena {
 	unsigned long	*map;
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 76cb57750dda..a284662b0e4c 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_SPARC32)   += leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
-obj-$(CONFIG_SPARC64)   += iommu.o
+obj-$(CONFIG_SPARC64)   += iommu.o iommu-common.o
 obj-$(CONFIG_SPARC64)   += central.o
 obj-$(CONFIG_SPARC64)   += starfire.o
 obj-$(CONFIG_SPARC64)   += power.o
diff --git a/lib/iommu-common.c b/arch/sparc/kernel/iommu-common.c
similarity index 98%
rename from lib/iommu-common.c
rename to arch/sparc/kernel/iommu-common.c
index 55b00de106b5..59cb16691322 100644
--- a/lib/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -8,9 +8,9 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/iommu-helper.h>
-#include <linux/iommu-common.h>
 #include <linux/dma-mapping.h>
 #include <linux/hash.h>
+#include <asm/iommu-common.h>
 
 static unsigned long iommu_large_alloc = 15;
 
@@ -93,7 +93,6 @@ void iommu_tbl_pool_init(struct iommu_map_table *iommu,
 	p->hint = p->start;
 	p->end = num_entries;
 }
-EXPORT_SYMBOL(iommu_tbl_pool_init);
 
 unsigned long iommu_tbl_range_alloc(struct device *dev,
 				struct iommu_map_table *iommu,
@@ -224,7 +223,6 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 
 	return n;
 }
-EXPORT_SYMBOL(iommu_tbl_range_alloc);
 
 static struct iommu_pool *get_pool(struct iommu_map_table *tbl,
 				   unsigned long entry)
@@ -264,4 +262,3 @@ void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
 	bitmap_clear(iommu->map, entry, npages);
 	spin_unlock_irqrestore(&(pool->lock), flags);
 }
-EXPORT_SYMBOL(iommu_tbl_range_free);
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index b08dc3416f06..40d008b0bd3e 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -14,7 +14,7 @@
 #include <linux/errno.h>
 #include <linux/iommu-helper.h>
 #include <linux/bitmap.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 86b625f9d8dc..c0fa3ef6cf01 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -16,7 +16,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #include <asm/hypervisor.h>
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 249367228c33..565d9ac883d0 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -16,7 +16,7 @@
 #include <linux/export.h>
 #include <linux/log2.h>
 #include <linux/of_device.h>
-#include <linux/iommu-common.h>
+#include <asm/iommu-common.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
diff --git a/lib/Makefile b/lib/Makefile
index ce20696d5a92..94203b5eecd4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,7 +147,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
-obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
-- 
2.17.0
