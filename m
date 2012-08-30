From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/4] libata: acpi: set can_power_off for both ODD and HD
Date: Thu, 30 Aug 2012 14:40:16 +0800
Message-ID: <1346308818-27039-3-git-send-email-aaron.lu@intel.com>
References: <1346308818-27039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1346308818-27039-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-ide@vger.kernel.org

Hard disk may also be runtime powered off, so set can_power_off flag
for it too if condition satisfies.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b67b565..67a696f 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1024,7 +1024,7 @@ static void ata_acpi_add_pm_notifier(struct ata_device *dev)
 	if (ACPI_FAILURE(status))
 		return;
 
-	if (dev->sdev->can_power_off) {
+	if (dev->class == ATA_DEV_ATAPI && dev->sdev->can_power_off) {
 		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 			ata_acpi_wake_dev, dev);
 		device_set_run_wake(&dev->sdev->sdev_gendev, true);
@@ -1045,7 +1045,7 @@ static void ata_acpi_remove_pm_notifier(struct ata_device *dev)
 	if (ACPI_FAILURE(status))
 		return;
 
-	if (dev->sdev->can_power_off) {
+	if (dev->class == ATA_DEV_ATAPI && dev->sdev->can_power_off) {
 		device_set_run_wake(&dev->sdev->sdev_gendev, false);
 		acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 			ata_acpi_wake_dev);
@@ -1152,14 +1152,23 @@ static int ata_acpi_bind_device(struct ata_port *ap, struct scsi_device *sdev,
 
 	/*
 	 * If firmware has _PS3 or _PR3 for this device,
-	 * and this ata ODD device support device attention,
-	 * it means this device can be powered off
+	 * it means this device can be powered off runtime
 	 */
 	states = acpi_dev->power.states;
-	if ((states[ACPI_STATE_D3_HOT].flags.valid ||
-			states[ACPI_STATE_D3_COLD].flags.explicit_set) &&
-			ata_dev->flags & ATA_DFLAG_DA)
-		sdev->can_power_off = 1;
+	if (states[ACPI_STATE_D3_HOT].flags.valid ||
+			states[ACPI_STATE_D3_COLD].flags.explicit_set) {
+		/*
+		 * For ODD, it needs to support device attention or
+		 * it can't be powered up back by user
+		 */
+		if (ata_dev->class == ATA_DEV_ATAPI &&
+				ata_dev->flags & ATA_DFLAG_DA)
+			sdev->can_power_off = 1;
+
+		/* No requirement for hard disk */
+		if (ata_dev->class == ATA_DEV_ATA)
+			sdev->can_power_off = 1;
+	}
 
 	return 0;
 }
-- 
1.7.11.5

