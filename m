From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5/5] nvme: ahci remap support
Date: Fri, 21 Oct 2016 17:25:49 -0700
Message-ID: <147709594907.3733.13683830090106690473.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:37220 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935716AbcJVA2v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 20:28:51 -0400
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: keith.busch@intel.com, linux-ide@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org

Provide a platform driver for the nvme resources that may be hidden /
remapped behind an ahci bar. The implementation is the standard baseline
nvme driver with callouts to "ahci_nvme" specific routines to replace
"pci-express" functionality.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/Kconfig        |    1 
 drivers/nvme/host/Makefile |    2 
 drivers/nvme/host/ahci.c   |  198 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c    |   19 +++-
 drivers/nvme/host/pci.h    |    9 ++
 5 files changed, 222 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/host/ahci.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index b9e46f2c69c1..189adbcfe4d3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -92,6 +92,7 @@ config SATA_AHCI
 
 config SATA_AHCI_NVME
 	tristate "AHCI: Remapped NVMe support"
+	default SATA_AHCI
 	depends on SATA_AHCI
 	depends on BLK_DEV_NVME
 	help
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 47abcec23514..e665b6232a10 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -2,12 +2,14 @@ obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
 obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
 obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
+obj-$(CONFIG_SATA_AHCI_NVME)		+= ahci-nvme.o
 
 nvme-core-y				:= core.o
 nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
 nvme-y					+= pci.o
+ahci-nvme-y				+= ahci.o
 
 nvme-fabrics-y				+= fabrics.o
 
diff --git a/drivers/nvme/host/ahci.c b/drivers/nvme/host/ahci.c
new file mode 100644
index 000000000000..ee2aaadc5213
--- /dev/null
+++ b/drivers/nvme/host/ahci.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (c) 2011-2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include "pci.h"
+
+struct ahci_nvme_data {
+	atomic_t enabled;
+};
+
+static struct ahci_nvme_data *to_ahci_nvme_data(struct nvme_dev *dev)
+{
+	return dev->dev->platform_data;
+}
+
+static int ahci_nvme_enable(struct nvme_dev *dev)
+{
+	int rc;
+	struct resource *res;
+	struct device *ddev = dev->dev;
+	struct device *parent = ddev->parent;
+	struct ahci_nvme_data *adata = to_ahci_nvme_data(dev);
+	struct platform_device *pdev = to_platform_device(ddev);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res)
+		return -ENXIO;
+
+	/* parent ahci device determines the dma mask */
+	if (dma_supported(parent, DMA_BIT_MASK(64)))
+		rc = dma_coerce_mask_and_coherent(ddev, DMA_BIT_MASK(64));
+	else if (dma_supported(parent, DMA_BIT_MASK(32)))
+		rc = dma_coerce_mask_and_coherent(ddev, DMA_BIT_MASK(32));
+	else
+		rc = -ENXIO;
+	if (rc)
+		return rc;
+
+	rc = nvme_enable(dev);
+	if (rc)
+		return rc;
+
+	atomic_inc(&adata->enabled);
+
+	return 0;
+}
+
+static int ahci_nvme_is_enabled(struct nvme_dev *dev)
+{
+	struct ahci_nvme_data *adata = to_ahci_nvme_data(dev);
+
+	return atomic_read(&adata->enabled) > 0;
+}
+
+static void ahci_nvme_disable(struct nvme_dev *dev)
+{
+	struct ahci_nvme_data *adata = to_ahci_nvme_data(dev);
+
+	/*
+	 * bug compatible with nvme_pci_disable() which also has this
+	 * potential disable race
+	 */
+	if (ahci_nvme_is_enabled(dev))
+		atomic_dec(&adata->enabled);
+}
+
+static int ahci_nvme_is_offline(struct nvme_dev *dev)
+{
+	return 0;
+}
+
+static bool ahci_nvme_is_present(struct nvme_dev *dev)
+{
+	return true;
+}
+
+static int ahci_nvme_map_irq(struct nvme_dev *dev, int nr_io_queues)
+{
+	struct platform_device *pdev = to_platform_device(dev->dev);
+	struct nvme_queue *adminq = dev->queues[0];
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res)
+		return -ENXIO;
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(res->start, adminq);
+
+	return min_t(int, resource_size(res), nr_io_queues);
+}
+
+static int ahci_nvme_q_irq(struct nvme_queue *nvmeq)
+{
+	struct resource *res;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct platform_device *pdev = to_platform_device(dev->dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res)
+		return -ENXIO;
+
+	if (resource_size(res) > nvmeq->qid)
+		return res->start + nvmeq->qid;
+	return res->start;
+}
+
+static const struct nvme_dev_ops ahci_nvme_dev_ops = {
+	.enable			= ahci_nvme_enable,
+	.disable		= ahci_nvme_disable,
+	.map_irq		= ahci_nvme_map_irq,
+	.q_irq			= ahci_nvme_q_irq,
+	.is_enabled		= ahci_nvme_is_enabled,
+	.is_offline		= ahci_nvme_is_offline,
+	.is_present		= ahci_nvme_is_present,
+};
+
+static void ahci_nvme_shutdown(struct platform_device *pdev)
+{
+	struct nvme_dev *dev = platform_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, true);
+}
+
+static int ahci_nvme_remove(struct platform_device *pdev)
+{
+	nvme_remove(&pdev->dev);
+	pdev->dev.platform_data = NULL;
+	return 0;
+}
+
+static struct platform_device_id ahci_nvme_id_table[] = {
+	{ .name = "ahci_nvme", },
+	{},
+};
+
+static int ahci_nvme_probe(struct platform_device *pdev)
+{
+	struct device *ddev = &pdev->dev;
+	struct ahci_nvme_data *adata;
+	struct resource *res;
+
+	adata = devm_kzalloc(ddev, sizeof(*adata), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	if (!devm_request_mem_region(ddev, res->start, resource_size(res),
+				dev_name(ddev)))
+		return -EBUSY;
+
+	ddev->platform_data = adata;
+	return nvme_probe(ddev, res, &ahci_nvme_dev_ops, 0);
+}
+
+static SIMPLE_DEV_PM_OPS(ahci_nvme_dev_pm_ops, nvme_suspend, nvme_resume);
+
+static struct platform_driver ahci_nvme_driver = {
+	.driver		= {
+		.name	= "ahci_nvme",
+		.pm     = &ahci_nvme_dev_pm_ops,
+	},
+	.id_table	= ahci_nvme_id_table,
+	.probe		= ahci_nvme_probe,
+	.remove		= ahci_nvme_remove,
+	.shutdown	= ahci_nvme_shutdown,
+};
+
+static __init int ahci_nvme_init(void)
+{
+	return platform_driver_register(&ahci_nvme_driver);
+}
+
+static __exit void ahci_nvme_exit(void)
+{
+	platform_driver_unregister(&ahci_nvme_driver);
+}
+
+MODULE_DEVICE_TABLE(platform, ahci_nvme_id_table);
+module_init(ahci_nvme_init);
+module_exit(ahci_nvme_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 418ccc1c0cf7..2814caba9e2e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -71,7 +71,6 @@ struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 {
@@ -1525,7 +1524,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_enable(struct nvme_dev *dev)
+int nvme_enable(struct nvme_dev *dev)
 {
 	u64 cap;
 
@@ -1540,6 +1539,7 @@ static int nvme_enable(struct nvme_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_enable);
 
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
@@ -1618,7 +1618,7 @@ static bool nvme_pci_is_present(struct nvme_dev *dev)
 	return pci_device_is_present(to_pci_dev(dev->dev));
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
 	u32 csts = -1;
@@ -1651,6 +1651,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
+EXPORT_SYMBOL_GPL(nvme_dev_disable);
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
@@ -1841,7 +1842,7 @@ static const struct nvme_dev_ops nvme_pci_dev_ops = {
 	.is_present		= nvme_pci_is_present,
 };
 
-static int nvme_probe(struct device *ddev, struct resource *res,
+int nvme_probe(struct device *ddev, struct resource *res,
 		const struct nvme_dev_ops *ops, unsigned long quirks)
 {
 	int node, result = -ENOMEM;
@@ -1910,6 +1911,7 @@ static int nvme_probe(struct device *ddev, struct resource *res,
 	kfree(dev);
 	return result;
 }
+EXPORT_SYMBOL_GPL(nvme_probe);
 
 static void nvme_pci_release_regions(void *data)
 {
@@ -1957,7 +1959,7 @@ static void nvme_pci_shutdown(struct pci_dev *pdev)
  * state. This function must not have any dependencies on the device state in
  * order to proceed.
  */
-static void nvme_remove(struct device *ddev)
+void nvme_remove(struct device *ddev)
 {
 	struct nvme_dev *dev = dev_get_drvdata(ddev);
 
@@ -1977,6 +1979,7 @@ static void nvme_remove(struct device *ddev)
 	nvme_release_prp_pools(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_remove);
 
 static void nvme_pci_remove(struct pci_dev *pdev)
 {
@@ -2002,21 +2005,23 @@ static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int nvme_suspend(struct device *dev)
+int nvme_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_dev_disable(ndev, true);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_suspend);
 
-static int nvme_resume(struct device *dev)
+int nvme_resume(struct device *dev)
 {
 	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	queue_work(nvme_workq, &ndev->reset_work);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_resume);
 #endif
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
diff --git a/drivers/nvme/host/pci.h b/drivers/nvme/host/pci.h
index 62b658abb886..f1a3e928ed80 100644
--- a/drivers/nvme/host/pci.h
+++ b/drivers/nvme/host/pci.h
@@ -14,6 +14,7 @@
 #ifndef __NVME_PCI_H__
 #define __NVME_PCI_H__
 #include <linux/blk-mq.h>
+#include "nvme.h"
 
 struct nvme_queue;
 struct nvme_dev;
@@ -86,4 +87,12 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 };
+
+int nvme_probe(struct device *ddev, struct resource *res,
+		const struct nvme_dev_ops *ops, unsigned long quirks);
+void nvme_remove(struct device *ddev);
+int nvme_enable(struct nvme_dev *dev);
+void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+int nvme_suspend(struct device *dev);
+int nvme_resume(struct device *dev);
 #endif /* __NVME_PCI_H__ */

