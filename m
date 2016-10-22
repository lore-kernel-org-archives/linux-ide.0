From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4/5] nvme: move common definitions to pci.h
Date: Fri, 21 Oct 2016 17:25:44 -0700
Message-ID: <147709594393.3733.9930397374718830592.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46412 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935716AbcJVA2q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 21 Oct 2016 20:28:46 -0400
In-Reply-To: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: keith.busch@intel.com, linux-ide@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org

A platform-driver for nvme resources needs access to struct nvme_dev and
other definitions that are currently local to pci.c.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvme/host/pci.c |   69 +-----------------------------------
 drivers/nvme/host/pci.h |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 68 deletions(-)
 create mode 100644 drivers/nvme/host/pci.h

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ea1c623ed257..418ccc1c0cf7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -45,6 +45,7 @@
 #include <asm/unaligned.h>
 
 #include "nvme.h"
+#include "pci.h"
 
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
@@ -66,86 +67,18 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static struct workqueue_struct *nvme_workq;
 
-struct nvme_dev;
 struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
-struct nvme_dev_ops {
-	int (*enable)(struct nvme_dev *dev);
-	void (*disable)(struct nvme_dev *dev);
-	int (*map_irq)(struct nvme_dev *dev, int nr_io_queues);
-	int (*q_irq)(struct nvme_queue *q);
-	int (*is_enabled)(struct nvme_dev *dev);
-	int (*is_offline)(struct nvme_dev *dev);
-	bool (*is_present)(struct nvme_dev *dev);
-};
-
-/*
- * Represents an NVM Express device.  Each nvme_dev is a PCI function.
- */
-struct nvme_dev {
-	struct nvme_queue **queues;
-	struct blk_mq_tag_set tagset;
-	struct blk_mq_tag_set admin_tagset;
-	u32 __iomem *dbs;
-	struct device *dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
-	unsigned queue_count;
-	unsigned online_queues;
-	unsigned max_qid;
-	int q_depth;
-	u32 db_stride;
-	void __iomem *bar;
-	struct work_struct reset_work;
-	struct work_struct remove_work;
-	struct timer_list watchdog_timer;
-	struct mutex shutdown_lock;
-	bool subsystem;
-	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
-	u64 cmb_size;
-	u32 cmbsz;
-	struct nvme_ctrl ctrl;
-	struct completion ioq_wait;
-	const struct resource *res;
-	const struct nvme_dev_ops *ops;
-};
-
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 {
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
 /*
- * An NVM Express queue.  Each device has at least two (one for admin
- * commands and one for I/O commands).
- */
-struct nvme_queue {
-	struct device *q_dmadev;
-	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
-	spinlock_t q_lock;
-	struct nvme_command *sq_cmds;
-	struct nvme_command __iomem *sq_cmds_io;
-	volatile struct nvme_completion *cqes;
-	struct blk_mq_tags **tags;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
-	u16 q_depth;
-	s16 cq_vector;
-	u16 sq_tail;
-	u16 cq_head;
-	u16 qid;
-	u8 cq_phase;
-	u8 cqe_seen;
-};
-
-/*
  * The nvme_iod describes the data in an I/O, including the list of PRP
  * entries.  You can't see it in this data structure because C doesn't let
  * me express that.  Use nvme_init_iod to ensure there's enough space
diff --git a/drivers/nvme/host/pci.h b/drivers/nvme/host/pci.h
new file mode 100644
index 000000000000..62b658abb886
--- /dev/null
+++ b/drivers/nvme/host/pci.h
@@ -0,0 +1,89 @@
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
+
+#ifndef __NVME_PCI_H__
+#define __NVME_PCI_H__
+#include <linux/blk-mq.h>
+
+struct nvme_queue;
+struct nvme_dev;
+struct resource;
+struct device;
+
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
+/*
+ * Represents an NVM Express device.  Each nvme_dev is a PCI function.
+ */
+struct nvme_dev {
+	struct nvme_queue **queues;
+	struct blk_mq_tag_set tagset;
+	struct blk_mq_tag_set admin_tagset;
+	u32 __iomem *dbs;
+	struct device *dev;
+	struct dma_pool *prp_page_pool;
+	struct dma_pool *prp_small_pool;
+	unsigned queue_count;
+	unsigned online_queues;
+	unsigned max_qid;
+	int q_depth;
+	u32 db_stride;
+	void __iomem *bar;
+	struct work_struct reset_work;
+	struct work_struct remove_work;
+	struct timer_list watchdog_timer;
+	struct mutex shutdown_lock;
+	bool subsystem;
+	void __iomem *cmb;
+	dma_addr_t cmb_dma_addr;
+	u64 cmb_size;
+	u32 cmbsz;
+	struct nvme_ctrl ctrl;
+	struct completion ioq_wait;
+	const struct resource *res;
+	const struct nvme_dev_ops *ops;
+};
+
+/*
+ * An NVM Express queue.  Each device has at least two (one for admin
+ * commands and one for I/O commands).
+ */
+struct nvme_queue {
+	struct device *q_dmadev;
+	struct nvme_dev *dev;
+	char irqname[24];	/* nvme4294967295-65535\0 */
+	spinlock_t q_lock;
+	struct nvme_command *sq_cmds;
+	struct nvme_command __iomem *sq_cmds_io;
+	volatile struct nvme_completion *cqes;
+	struct blk_mq_tags **tags;
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
+	u32 __iomem *q_db;
+	u16 q_depth;
+	s16 cq_vector;
+	u16 sq_tail;
+	u16 cq_head;
+	u16 qid;
+	u8 cq_phase;
+	u8 cqe_seen;
+};
+#endif /* __NVME_PCI_H__ */

