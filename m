From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 3/3] libata: zpodd: eliminate odd_can_poweroff
Date: Fri, 14 Mar 2014 13:46:10 +0800
Message-ID: <1394775970-6022-4-git-send-email-aaron.lu@intel.com>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4685 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbaCNFpp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 01:45:45 -0400
In-Reply-To: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Now that we can directly get the ACPI device conterpart of the physical
ATA transport device, the odd_can_poweroff can be eliminated.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-zpodd.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 88949c6d55dd..f3a65a3140d3 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -85,21 +85,6 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 		return ODD_MECH_TYPE_UNSUPPORTED;
 }
 
-static bool odd_can_poweroff(struct ata_device *ata_dev)
-{
-	acpi_handle handle;
-	struct acpi_device *acpi_dev;
-
-	handle = ata_dev_acpi_handle(ata_dev);
-	if (!handle)
-		return false;
-
-	if (acpi_bus_get_device(handle, &acpi_dev))
-		return false;
-
-	return acpi_device_can_poweroff(acpi_dev);
-}
-
 /* Test if ODD is zero power ready by sense code */
 static bool zpready(struct ata_device *dev)
 {
@@ -267,13 +252,11 @@ static void ata_acpi_remove_pm_notifier(struct ata_device *dev)
 
 void zpodd_init(struct ata_device *dev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&dev->tdev);
 	enum odd_mech_type mech_type;
 	struct zpodd *zpodd;
 
-	if (dev->zpodd)
-		return;
-
-	if (!odd_can_poweroff(dev))
+	if (dev->zpodd || !adev || !acpi_device_can_poweroff(adev))
 		return;
 
 	mech_type = zpodd_get_mech_type(dev);
-- 
1.8.5.3

