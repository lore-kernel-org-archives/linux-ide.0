From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v5 7/7] libata: acpi: respect may_power_off flag
Date: Fri, 31 Aug 2012 17:42:35 +0800
Message-ID: <1346406155-4768-8-git-send-email-aaron.lu@intel.com>
References: <1346406155-4768-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64686 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2HaJnZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2012 05:43:25 -0400
In-Reply-To: <1346406155-4768-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>

If user does not want the device being powered off when runtime
suspended by setting may_power_off flag to 0, we will not choose D3 cold
ACPI D-State for it.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 6c8f89c..774180d 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -869,7 +869,9 @@ void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 
 		if (state.event != PM_EVENT_ON) {
 			acpi_state = acpi_pm_device_sleep_state(
-				&dev->sdev->sdev_gendev, NULL, ACPI_STATE_D3);
+				&dev->sdev->sdev_gendev, NULL,
+				dev->sdev->may_power_off ?
+				ACPI_STATE_D3_COLD : ACPI_STATE_D3_HOT);
 			if (acpi_state > 0)
 				acpi_bus_set_power(handle, acpi_state);
 			/* TBD: need to check if it's runtime pm request */
-- 
1.7.11.5

