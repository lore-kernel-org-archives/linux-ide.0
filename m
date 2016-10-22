From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 3/5] nvme: introduce nvme_dev_ops
Date: Fri, 21 Oct 2016 17:25:38 -0700
Message-ID: <147709593879.3733.14534541150070860181.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:12986 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935716AbcJVA2l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 20:28:41 -0400
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: keith.busch@intel.com, linux-ide@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org

In preparation for a platform device nvme driver, move the bus specific
portions of nvme to nvme_dev_ops, or otherwise rewrite routines to use a
generic 'struct device' instead of 'struct pci_dev'.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvme/host/pci.c |  258 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 165 insertions(+), 93 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8c4330b95be8..ea1c623ed257 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -73,6 +73,16 @@ static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
+struct nvme_dev_ops {
+	int (*enable)(struct nvme_dev *dev);
+	void (*disable)(struct nvme_dev *dev);
+	int (*map_irq)(struct nvme_dev *dev, int nr_io_queues);
+	int (*q_irq)(struct nvme_queue *q);
+	int (*is_enabled)(struct nvme_dev *dev);
+	int (*is_offline)(struct nvme_dev *dev);
+	bool (*is_present)(struct nvme_dev *dev);
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -101,6 +111,8 @@ struct nvme_dev {
 	u32 cmbsz;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
+	const struct resource *res;
+	const struct nvme_dev_ops *ops;
 };
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
@@ -201,7 +213,7 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
-static int nvmeq_irq(struct nvme_queue *nvmeq)
+static int nvme_pci_q_irq(struct nvme_queue *nvmeq)
 {
 	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector);
 }
@@ -973,7 +985,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq_irq(nvmeq);
+	vector = nvmeq->dev->ops->q_irq(nvmeq);
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1089,12 +1101,15 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 
 static int queue_request_irq(struct nvme_queue *nvmeq)
 {
+	struct nvme_dev *dev = nvmeq->dev;
+
 	if (use_threaded_interrupts)
-		return request_threaded_irq(nvmeq_irq(nvmeq), nvme_irq_check,
-				nvme_irq, IRQF_SHARED, nvmeq->irqname, nvmeq);
-	else
-		return request_irq(nvmeq_irq(nvmeq), nvme_irq, IRQF_SHARED,
+		return request_threaded_irq(dev->ops->q_irq(nvmeq),
+				nvme_irq_check, nvme_irq, IRQF_SHARED,
 				nvmeq->irqname, nvmeq);
+	else
+		return request_irq(dev->ops->q_irq(nvmeq), nvme_irq,
+				IRQF_SHARED, nvmeq->irqname, nvmeq);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -1278,7 +1293,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (dev->ops->is_offline(dev))
 		return false;
 
 	return true;
@@ -1331,7 +1346,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	return ret >= 0 ? 0 : ret;
 }
 
-static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+static void __iomem *nvme_pci_map_cmb(struct nvme_dev *dev)
 {
 	u64 szu, size, offset;
 	u32 cmbloc;
@@ -1388,10 +1403,27 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
 }
 
+static int nvme_pci_map_irq(struct nvme_dev *dev, int nr_io_queues)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct nvme_queue *adminq = dev->queues[0];
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(pci_irq_vector(pdev, 0), adminq);
+
+	/*
+	 * If we enable msix early due to not intx, disable it again before
+	 * setting up the full range we need.
+	 */
+	pci_free_irq_vectors(pdev);
+	return pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
+}
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct device *ddev = dev->dev;
 	int result, nr_io_queues, size;
 
 	nr_io_queues = num_online_cpus();
@@ -1413,9 +1445,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	size = db_bar_size(dev, nr_io_queues);
 	if (size > 8192) {
-		iounmap(dev->bar);
+		devm_iounmap(ddev, dev->bar);
 		do {
-			dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+			dev->bar = devm_ioremap(ddev, dev->res->start, size);
 			if (dev->bar)
 				break;
 			if (!--nr_io_queues)
@@ -1426,19 +1458,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		adminq->q_db = dev->dbs;
 	}
 
-	/* Deregister the admin queue's interrupt */
-	free_irq(pci_irq_vector(pdev, 0), adminq);
-
-	/*
-	 * If we enable msix early due to not intx, disable it again before
-	 * setting up the full range we need.
-	 */
-	pci_free_irq_vectors(pdev);
-	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
-			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
-	if (nr_io_queues <= 0)
+	dev->max_qid = dev->ops->map_irq(dev, nr_io_queues);
+	if (dev->max_qid <= 0)
 		return -EIO;
-	dev->max_qid = nr_io_queues;
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -1570,9 +1592,24 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_pci_enable(struct nvme_dev *dev)
+static int nvme_enable(struct nvme_dev *dev)
 {
 	u64 cap;
+
+	if (readl(dev->bar + NVME_REG_CSTS) == -1)
+		return -ENODEV;
+
+	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
+	dev->dbs = dev->bar + 4096;
+
+	return 0;
+}
+
+static int nvme_pci_enable(struct nvme_dev *dev)
+{
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
@@ -1581,15 +1618,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
-		goto disable;
-
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
-		result = -ENODEV;
-		goto disable;
-	}
-
 	/*
 	 * Some devices and/or platforms don't advertise or work with INTx
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
@@ -1599,11 +1627,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
+		return -ENXIO;
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
-	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-	dev->dbs = dev->bar + 4096;
+	result = nvme_enable(dev);
+	if (result)
+		goto disable;
 
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
@@ -1617,7 +1647,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	}
 
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
-		dev->cmb = nvme_map_cmb(dev);
+		dev->cmb = nvme_pci_map_cmb(dev);
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
@@ -1628,13 +1658,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_dev_unmap(struct nvme_dev *dev)
-{
-	if (dev->bar)
-		iounmap(dev->bar);
-	pci_release_mem_regions(to_pci_dev(dev->dev));
-}
-
 static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -1647,6 +1670,21 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static int nvme_pci_is_enabled(struct nvme_dev *dev)
+{
+	return pci_is_enabled(to_pci_dev(dev->dev));
+}
+
+static int nvme_pci_is_offline(struct nvme_dev *dev)
+{
+	return pci_channel_offline(to_pci_dev(dev->dev));
+}
+
+static bool nvme_pci_is_present(struct nvme_dev *dev)
+{
+	return pci_device_is_present(to_pci_dev(dev->dev));
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
@@ -1655,7 +1693,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(to_pci_dev(dev->dev))) {
+	if (dev->ops->is_enabled(dev)) {
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
@@ -1674,7 +1712,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-	nvme_pci_disable(dev);
+	dev->ops->disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
@@ -1745,7 +1783,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
 		goto out;
 
-	result = nvme_pci_enable(dev);
+	result = dev->ops->enable(dev);
 	if (result)
 		goto out;
 
@@ -1806,11 +1844,11 @@ static void nvme_reset_work(struct work_struct *work)
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct device *ddev = dev->dev;
 
 	nvme_kill_queues(&dev->ctrl);
-	if (pci_get_drvdata(pdev))
-		device_release_driver(&pdev->dev);
+	if (dev_get_drvdata(ddev))
+		device_release_driver(ddev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
@@ -1860,31 +1898,34 @@ static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
 	.submit_async_event	= nvme_mmio_submit_async_event,
 };
 
-static int nvme_dev_map(struct nvme_dev *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pci_request_mem_regions(pdev, "nvme"))
-		return -ENODEV;
-
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar)
-		goto release;
-
-       return 0;
-  release:
-       pci_release_mem_regions(pdev);
-       return -ENODEV;
-}
+static const struct nvme_dev_ops nvme_pci_dev_ops = {
+	.enable			= nvme_pci_enable,
+	.disable		= nvme_pci_disable,
+	.map_irq		= nvme_pci_map_irq,
+	.q_irq			= nvme_pci_q_irq,
+	.is_enabled		= nvme_pci_is_enabled,
+	.is_offline		= nvme_pci_is_offline,
+	.is_present		= nvme_pci_is_present,
+};
 
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int nvme_probe(struct device *ddev, struct resource *res,
+		const struct nvme_dev_ops *ops, unsigned long quirks)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
 
-	node = dev_to_node(&pdev->dev);
+	if (!ops || !ops->enable
+		 || !ops->disable
+		 || !ops->map_irq
+		 || !ops->q_irq
+		 || !ops->is_enabled
+		 || !ops->is_offline
+		 || !ops->is_present)
+		return -EINVAL;
+
+	node = dev_to_node(ddev);
 	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
+		set_dev_node(ddev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
@@ -1894,12 +1935,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev->queues)
 		goto free;
 
-	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
+	dev->ops = ops;
+	dev->res = res;
+	dev->dev = get_device(ddev);
+	dev_set_drvdata(ddev, dev);
 
-	result = nvme_dev_map(dev);
-	if (result)
+	dev->bar = devm_ioremap(ddev, dev->res->start, 8192);
+	if (!dev->bar) {
+		result = -ENODEV;
 		goto free;
+	}
 
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
@@ -1910,29 +1955,53 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto put_pci;
+		goto put_dev;
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_mmio_ctrl_ops,
-			id->driver_data);
+	result = nvme_init_ctrl(&dev->ctrl, ddev, &nvme_mmio_ctrl_ops,
+			quirks);
 	if (result)
 		goto release_pools;
 
-	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+	dev_info(dev->ctrl.device, "%s function %s\n",
+			ddev->bus ? ddev->bus->name : "", dev_name(ddev));
 
 	queue_work(nvme_workq, &dev->reset_work);
 	return 0;
 
  release_pools:
 	nvme_release_prp_pools(dev);
- put_pci:
+ put_dev:
 	put_device(dev->dev);
-	nvme_dev_unmap(dev);
  free:
 	kfree(dev->queues);
 	kfree(dev);
 	return result;
 }
 
+static void nvme_pci_release_regions(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_release_mem_regions(pdev);
+}
+
+static int nvme_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int rc;
+
+	rc = pci_request_mem_regions(pdev, "nvme");
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&pdev->dev, nvme_pci_release_regions,
+			pdev);
+	if (rc)
+		return rc;
+
+	return nvme_probe(&pdev->dev, &pdev->resource[0], &nvme_pci_dev_ops,
+			id->driver_data);
+}
+
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
@@ -1943,9 +2012,10 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 		queue_work(nvme_workq, &dev->reset_work);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_pci_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
 	nvme_dev_disable(dev, true);
 }
 
@@ -1954,15 +2024,15 @@ static void nvme_shutdown(struct pci_dev *pdev)
  * state. This function must not have any dependencies on the device state in
  * order to proceed.
  */
-static void nvme_remove(struct pci_dev *pdev)
+static void nvme_remove(struct device *ddev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = dev_get_drvdata(ddev);
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
-	pci_set_drvdata(pdev, NULL);
+	dev_set_drvdata(ddev, NULL);
 
-	if (!pci_device_is_present(pdev))
+	if (!dev->ops->is_present(dev))
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 
 	flush_work(&dev->reset_work);
@@ -1972,10 +2042,14 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
-	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static void nvme_pci_remove(struct pci_dev *pdev)
+{
+	nvme_remove(&pdev->dev);
+}
+
 static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
 {
 	int ret = 0;
@@ -1997,8 +2071,7 @@ static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_dev_disable(ndev, true);
 	return 0;
@@ -2006,8 +2079,7 @@ static int nvme_suspend(struct device *dev)
 
 static int nvme_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	queue_work(nvme_workq, &ndev->reset_work);
 	return 0;
@@ -2092,9 +2164,9 @@ MODULE_DEVICE_TABLE(pci, nvme_id_table);
 static struct pci_driver nvme_driver = {
 	.name		= "nvme",
 	.id_table	= nvme_id_table,
-	.probe		= nvme_probe,
-	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
+	.probe		= nvme_pci_probe,
+	.remove		= nvme_pci_remove,
+	.shutdown	= nvme_pci_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},

