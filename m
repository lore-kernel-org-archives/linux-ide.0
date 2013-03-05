From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] libata: acpi: remove redundent code for power resource handling
Date: Tue,  5 Mar 2013 12:12:04 +0800
Message-ID: <1362456724-21257-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15981 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462Ab3CEELR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Mar 2013 23:11:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>

With commit:
bc9b6407bd6df3ab7189e5622816bbc11ae9d2d8
ACPI / PM: Rework the handling of devices depending on power resources

The ACPI core now takes care of the power resources an acpi device
depends on in that when the power resources are turned on, any devices
that are bound to or in the dependent list of this acpi device will be
runtime resumed. So there is no need for ata acpi code to duplicate this
effort, and thus, the ata_acpi_(un)register_power_resource functions are
no longer needed.

The above commit thinks the scsi device is not bound to the acpi device,
so needs to be added to the dependent list. But actually, it is. So
there is no need to add it to the dependent list, or it will be runtime
resumed twice(though this wouldn't cause any problem).

This patch fixes it, and as a result, the
ata_acpi_(un)register_power_resource and ata_acpi_(un)bind functions
are removed.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 33 ---------------------------------
 drivers/ata/libata-scsi.c |  6 ++++--
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index cb3eab6d..5be0ed0 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -17,7 +17,6 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
-#include <linux/pm_qos.h>
 #include <scsi/scsi_device.h>
 #include "libata.h"
 
@@ -1020,38 +1019,6 @@ void ata_acpi_on_disable(struct ata_device *dev)
 	ata_acpi_clear_gtf(dev);
 }
 
-static void ata_acpi_register_power_resource(struct ata_device *dev)
-{
-	struct scsi_device *sdev = dev->sdev;
-	acpi_handle handle;
-
-	handle = ata_dev_acpi_handle(dev);
-	if (handle)
-		acpi_dev_pm_add_dependent(handle, &sdev->sdev_gendev);
-}
-
-static void ata_acpi_unregister_power_resource(struct ata_device *dev)
-{
-	struct scsi_device *sdev = dev->sdev;
-	acpi_handle handle;
-
-	handle = ata_dev_acpi_handle(dev);
-	if (handle)
-		acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);
-}
-
-void ata_acpi_bind(struct ata_device *dev)
-{
-	ata_acpi_register_power_resource(dev);
-	if (zpodd_dev_enabled(dev))
-		dev_pm_qos_expose_flags(&dev->sdev->sdev_gendev, 0);
-}
-
-void ata_acpi_unbind(struct ata_device *dev)
-{
-	ata_acpi_unregister_power_resource(dev);
-}
-
 static int compat_pci_ata(struct ata_port *ap)
 {
 	struct device *dev = ap->tdev.parent;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 318b413..8b05c68 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -49,6 +49,7 @@
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
 #include "libata.h"
@@ -3668,7 +3669,9 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 			if (!IS_ERR(sdev)) {
 				dev->sdev = sdev;
 				scsi_device_put(sdev);
-				ata_acpi_bind(dev);
+				if (zpodd_dev_enabled(dev))
+					dev_pm_qos_expose_flags(
+							&sdev->sdev_gendev, 0);
 			} else {
 				dev->sdev = NULL;
 			}
@@ -3767,7 +3770,6 @@ static void ata_scsi_remove_dev(struct ata_device *dev)
 
 	if (zpodd_dev_enabled(dev))
 		zpodd_exit(dev);
-	ata_acpi_unbind(dev);
 
 	/* clearing dev->sdev is protected by host lock */
 	sdev = dev->sdev;
-- 
1.8.1.4

