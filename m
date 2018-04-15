From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/12] PCI: remove CONFIG_PCI_BUS_ADDR_T_64BIT
Date: Sun, 15 Apr 2018 16:59:44 +0200
Message-ID: <20180415145947.1248-10-hch@lst.de>
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

This symbol is now always identical to CONFIG_ARCH_DMA_ADDR_T_64BIT, so
remove it.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/pci/Kconfig | 4 ----
 drivers/pci/bus.c   | 4 ++--
 include/linux/pci.h | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 34b56a8f8480..29a487f31dae 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -5,10 +5,6 @@
 
 source "drivers/pci/pcie/Kconfig"
 
-config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
-	depends on PCI
-
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc2ded4c451f..35b7fc87eac5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -120,7 +120,7 @@ int devm_request_pci_bus_resources(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
 
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
 				(pci_bus_addr_t) 0xffffffffffffffffULL};
 static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
@@ -230,7 +230,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	int rc;
 
 	if (res->flags & IORESOURCE_MEM_64) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..55371cb827ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -670,7 +670,7 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 		  int reg, int len, u32 val);
 
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 pci_bus_addr_t;
 #else
 typedef u32 pci_bus_addr_t;
-- 
2.17.0
