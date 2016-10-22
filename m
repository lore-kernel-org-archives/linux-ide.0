From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/5] ahci: nvme remap support
Date: Fri, 21 Oct 2016 17:25:26 -0700
Message-ID: <147709592662.3733.3265729562856411328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61398 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935716AbcJVA23 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 20:28:29 -0400
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: keith.busch@intel.com, linux-ide@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org

Some Intel ahci implementations have the capability to expose another
pci-express device's memory resources through an ahci memory bar. Add
the enabling to detect these configurations and register the resources
for the nvme driver to consume. Otherwise, the nvme device is
effectively hidden from the kernel for this configuration.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/Kconfig |   10 +++
 drivers/ata/ahci.c  |  165 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci.h  |   14 ++++
 3 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2c8be74f401d..b9e46f2c69c1 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -90,6 +90,16 @@ config SATA_AHCI
 
 	  If unsure, say N.
 
+config SATA_AHCI_NVME
+	tristate "AHCI: Remapped NVMe support"
+	depends on SATA_AHCI
+	depends on BLK_DEV_NVME
+	help
+	  Support discovering remapped NVMe devices that appear in AHCI
+	  PCI memory space.
+
+	  If unsure, say N.
+
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
 	help
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11cebee2..cc2c81ae497a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
@@ -46,6 +47,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "ahci.h"
 
 #define DRV_NAME	"ahci"
@@ -1400,6 +1402,81 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 }
 #endif
 
+enum {
+	AHCI_VSCAP = 0xa4,
+	AHCI_REMAP_CAP = 0x800,
+	PCI_CLASS_STORAGE_EXPRESS = 0x10802,
+	/* device class code */
+	AHCI_REMAP_N_DCC = 0x880,
+	/* remap-device base relative to ahci-bar */
+	AHCI_REMAP_N_OFFSET = SZ_16K,
+	AHCI_REMAP_N_SIZE = SZ_16K,
+};
+
+static unsigned int ahci_remap_dcc(int i)
+{
+	return AHCI_REMAP_N_DCC + i * 0x80;
+}
+
+static unsigned int ahci_remap_base(int i)
+{
+	return AHCI_REMAP_N_OFFSET + i * AHCI_REMAP_N_SIZE;
+}
+
+static int ahci_remap_init(struct pci_dev *pdev, int bar,
+		struct ahci_host_priv *hpriv)
+{
+	int i, count = 0;
+	u32 cap;
+
+	/*
+	 * Check if remapped nvme devices might be present and if so
+	 * register platform resources.
+	 */
+	if (IS_ENABLED(CONFIG_SATA_AHCI_NVME)
+			&& pdev->vendor == PCI_VENDOR_ID_INTEL
+			&& pci_resource_len(pdev, bar) == SZ_512K
+			&& bar == AHCI_PCI_BAR_STANDARD
+			&& (readl(hpriv->mmio + AHCI_VSCAP) & 1))
+		/* pass */;
+	else
+		return -ENODEV;
+
+	cap = readq(hpriv->mmio + AHCI_REMAP_CAP);
+	for (i = 0; i < AHCI_MAX_REMAP; i++) {
+		struct ahci_remap *rdev;
+
+		if ((cap & (1 << i)) == 0)
+			continue;
+		if (readl(hpriv->mmio + ahci_remap_dcc(i))
+				!= PCI_CLASS_STORAGE_EXPRESS)
+			continue;
+
+		rdev = devm_kzalloc(&pdev->dev, sizeof(*rdev), GFP_KERNEL);
+		if (!rdev)
+			return -ENOMEM;
+
+		rdev->id = i;
+		rdev->mem.start = pci_resource_start(pdev, bar)
+			+ ahci_remap_base(i);
+		rdev->mem.end = rdev->mem.start + AHCI_REMAP_N_SIZE - 1;
+		rdev->mem.flags = IORESOURCE_MEM;
+
+		/*
+		 * This will be translated to kernel irq vector after
+		 * ahci irq initialization.
+		 */
+		rdev->irq.start = 0;
+		rdev->irq.end = 0;
+		rdev->irq.flags = IORESOURCE_IRQ;
+
+		hpriv->remap[i] = rdev;
+		count++;
+	}
+
+	return count > 0 ? 0 : -ENODEV;
+}
+
 static int ahci_get_irq_vector(struct ata_host *host, int port)
 {
 	return pci_irq_vector(to_pci_dev(host->dev), port);
@@ -1410,7 +1487,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 {
 	int nvec;
 
-	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
+	if (hpriv->flags & (AHCI_HFLAG_NO_MSI | AHCI_HFLAG_REMAP))
 		return -ENODEV;
 
 	/*
@@ -1452,6 +1529,58 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_remap_restore(void *data)
+{
+	struct pci_dev *pdev = data;
+	int bar = AHCI_PCI_BAR_STANDARD;
+
+	pci_resource_end(pdev, bar) = pci_resource_start(pdev, bar) + SZ_512K - 1;
+}
+
+static void ahci_remap_unregister(void *data)
+{
+	struct platform_device *pdev = data;
+
+	platform_device_del(pdev);
+	put_device(&pdev->dev);
+}
+
+static void ahci_remap_register_devices(struct device *dev,
+		struct ahci_host_priv *hpriv)
+{
+	struct platform_device *pdev;
+	int i;
+
+	if ((hpriv->flags & AHCI_HFLAG_REMAP) == 0)
+		return;
+
+	for (i = 0; i < AHCI_MAX_REMAP; i++) {
+		struct ahci_remap *rdev = hpriv->remap[i];
+
+		if (!rdev)
+			continue;
+		pdev = platform_device_alloc("ahci_nvme", rdev->id);
+		if (!pdev)
+			continue;
+		if (platform_device_add_resources(pdev, &rdev->mem, 2) != 0) {
+			put_device(&pdev->dev);
+			continue;
+		}
+
+		pdev->dev.parent = dev;
+		if (platform_device_add(pdev) != 0) {
+			put_device(&pdev->dev);
+			continue;
+		}
+
+		if (devm_add_action_or_reset(dev, ahci_remap_unregister,
+					pdev) != 0)
+			continue;
+		dev_info(dev, "remap: %s %pR %pR\n", dev_name(&pdev->dev),
+				&rdev->mem, &rdev->irq);
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1545,6 +1674,23 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
+	/* detect remapped nvme devices */
+	if (ahci_remap_init(pdev, ahci_pci_bar, hpriv) == 0) {
+		pcim_iounmap_regions(pdev, 1 << ahci_pci_bar);
+		pci_resource_end(pdev, ahci_pci_bar)
+			= pci_resource_start(pdev, ahci_pci_bar) + SZ_16K - 1;
+		rc = devm_add_action_or_reset(dev, ahci_remap_restore, pdev);
+		if (rc)
+			return rc;
+		rc = pcim_iomap_regions(pdev, 1 << ahci_pci_bar, DRV_NAME);
+		if (rc == -EBUSY)
+			pcim_pin_device(pdev);
+		if (rc)
+			return rc;
+		hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
+		hpriv->flags |= AHCI_HFLAG_REMAP;
+	}
+
 	/* must set flag prior to save config in order to take effect */
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
@@ -1616,6 +1762,21 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
 		/* legacy intx interrupts */
 		pci_intx(pdev, 1);
+
+		/*
+		 * Don't rely on the msi-x capability in the remap case,
+		 * share the legacy interrupt across ahci and remapped
+		 * devices.
+		 */
+		if (hpriv->flags & AHCI_HFLAG_REMAP)
+			for (i = 0; i < AHCI_MAX_REMAP; i++) {
+				struct ahci_remap *rdev = hpriv->remap[i];
+
+				if (!rdev || resource_size(&rdev->irq) < 1)
+					continue;
+				rdev->irq.start = pdev->irq;
+				rdev->irq.end = rdev->irq.start;
+			}
 	}
 	hpriv->irq = pdev->irq;
 
@@ -1668,6 +1829,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	ahci_remap_register_devices(&pdev->dev, hpriv);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 }
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0cc08f892fea..859d08979497 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -248,6 +248,8 @@ enum {
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
 	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
+	AHCI_HFLAG_REMAP		= (1 << 23),
+	AHCI_MAX_REMAP			= 3,
 
 	/* ap->flags bits */
 
@@ -324,6 +326,17 @@ struct ahci_port_priv {
 	char			*irq_desc;	/* desc in /proc/interrupts */
 };
 
+struct ahci_remap {
+	int id;
+	/*
+	 * @mem and @irq must be consecutive for
+	 * platform_device_add_resources() in
+	 * ahci_remap_register_devices()
+	 */
+	struct resource mem;
+	struct resource irq;
+};
+
 struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
@@ -352,6 +365,7 @@ struct ahci_host_priv {
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
+	struct ahci_remap	*remap[AHCI_MAX_REMAP]; /* remapped devices */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
 	 * default ahci_start_engine during ahci_save_initial_config, this can

