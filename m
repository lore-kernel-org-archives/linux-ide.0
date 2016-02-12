From: <tchalamarla@caviumnetworks.com>
Subject: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Fri, 12 Feb 2016 15:20:30 -0800
Message-ID: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tchalamarla@caviumnetworks.com
List-Id: linux-ide@vger.kernel.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Due to Errata in ThunderX, HOST_IRQ_STAT should be
cleared before leaving the interrupt handler.
The patch attempts to satisfy the need.

Changes from V1:
	- Rebased on top of libata/for-4.6
        - Moved ThunderX intr handler to new file

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 drivers/ata/Makefile        |  2 +-
 drivers/ata/ahci.c          |  3 ++
 drivers/ata/ahci.h          |  1 +
 drivers/ata/ahci_thunderx.c | 73 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ata/ahci_thunderx.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 1857952..a36e70d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_ATA)		+= libata.o
 
 # non-SFF interface
-obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
+obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o ahci_thunderx.o
 obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o libahci_platform.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 546a369..76e310e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1560,6 +1560,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
 
+	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
+		ahci_thunderx_init(&pdev->dev, hpriv);
+
 	/* save initial config */
 	ahci_pci_save_initial_config(pdev, hpriv);
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 167ba7e..77ae20d 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -425,6 +425,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
 u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
+void ahci_thunderx_init(struct device *dev, struct ahci_host_priv *hpriv);
 
 static inline void __iomem *__ahci_port_base(struct ata_host *host,
 					     unsigned int port_no)
diff --git a/drivers/ata/ahci_thunderx.c b/drivers/ata/ahci_thunderx.c
new file mode 100644
index 0000000..223e170
--- /dev/null
+++ b/drivers/ata/ahci_thunderx.c
@@ -0,0 +1,73 @@
+/*
+ * SATA glue for Cavium Thunder SOCs.
+ *
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2016 Cavium Networks
+ *
+ */
+
+#include <linux/module.h>
+#include "ahci.h"
+#include "libata.h"
+
+static irqreturn_t ahci_thunderx_irq_intr(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int rc = 0;
+	void __iomem *mmio;
+	u32 irq_stat, irq_masked;
+	unsigned int handled = 1;
+
+	VPRINTK("ENTER\n");
+
+	hpriv = host->private_data;
+	mmio = hpriv->mmio;
+
+	/* sigh.  0xffffffff is a valid return from h/w */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_stat)
+		return IRQ_NONE;
+redo:
+
+	irq_masked = irq_stat & hpriv->port_map;
+
+	spin_lock(&host->lock);
+
+	rc = ahci_handle_port_intr(host, irq_masked);
+
+	if (!rc)
+		handled = 0;
+
+	writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+	/* Due to ERRATA#22536, ThunderX need to handle
+	 * HOST_IRQ_STAT differently.
+	 * Work around is to make sure all pending IRQs
+	 * are served before leaving handler
+	 */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+
+	spin_unlock(&host->lock);
+
+	if (irq_stat)
+		goto redo;
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+void ahci_thunderx_init(struct device *dev, struct ahci_host_priv *hpriv)
+{
+	hpriv->irq_handler = ahci_thunderx_irq_intr;
+}
+EXPORT_SYMBOL_GPL(ahci_thunderx_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium Inc. ThunderX sata config.");
-- 
2.1.0
