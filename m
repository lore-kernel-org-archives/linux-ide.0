From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 2/4] ahci: add runtime PM callbacks
Date: Thu, 15 Dec 2011 21:12:47 +0800
Message-ID: <1323954769-3918-3-git-send-email-ming.m.lin@intel.com>
References: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323954769-3918-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

Add ahci controller runtime PM callbacks.

Call pm_runtime_put_noidle() in its probe routine and 
pm_runtime_get_noresume() in its remove routine.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/ata/ahci.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c745603..7ab9b0d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -46,6 +46,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 
 #define DRV_NAME	"ahci"
@@ -79,6 +80,7 @@ enum board_ids {
 };
 
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void ahci_remove_one(struct pci_dev *pdev);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline);
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
@@ -87,6 +89,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 static int ahci_pci_device_suspend(struct device *dev);
 static int ahci_pci_device_hibernate(struct device *dev);
 static int ahci_pci_device_resume(struct device *dev);
+static int ahci_pci_device_runtime_idle(struct device *dev);
 #endif
 
 static struct scsi_host_template ahci_sht = {
@@ -405,13 +408,16 @@ static struct dev_pm_ops ahci_pci_pm_ops = {
 	.suspend		= ahci_pci_device_suspend,
 	.resume			= ahci_pci_device_resume,
 	.poweroff		= ahci_pci_device_hibernate,
+	.runtime_suspend	= ahci_pci_device_suspend,
+	.runtime_resume		= ahci_pci_device_resume,
+	.runtime_idle		= ahci_pci_device_runtime_idle,
 };
 
 static struct pci_driver ahci_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
-	.remove			= ata_pci_remove_one,
+	.remove			= ahci_remove_one,
 #ifdef CONFIG_PM
 	.driver			= {
 		.pm = &ahci_pci_pm_ops
@@ -637,6 +643,12 @@ static int ahci_pci_device_resume(struct device *dev)
 
 	return 0;
 }
+
+static int ahci_pci_device_runtime_idle(struct device *dev)
+{
+	return pm_runtime_suspend(dev);
+}
+
 #endif
 
 static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
@@ -1226,10 +1238,20 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_pci_print_info(host);
 
 	pci_set_master(pdev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
 	return ata_host_activate(host, pdev->irq, ahci_interrupt, IRQF_SHARED,
 				 &ahci_sht);
 }
 
+static void ahci_remove_one(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
+	ata_pci_remove_one(pdev);
+}
+
 static int __init ahci_init(void)
 {
 	return pci_register_driver(&ahci_pci_driver);
-- 
1.7.2.5
