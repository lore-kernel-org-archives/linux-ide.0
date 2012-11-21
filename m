From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 07/10] libata: expose pm qos flags to user space for ata device
Date: Wed, 21 Nov 2012 19:50:36 +0800
Message-ID: <1353498639-27631-8-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33823 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541Ab2KULum (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2012 06:50:42 -0500
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Expose pm qos flags to user space so that user has a chance to disable
pm features like power off, if he/she has a broken platform or devices
or simply does not like this pm feature.

This flag is exposed to user space only for ata device or atapi device
that is zero power capable. For normal atapi device, it will never be
powered off.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 3a82177..27a84de 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1025,6 +1025,8 @@ void ata_acpi_bind(struct ata_device *dev)
 	ata_acpi_register_power_resource(dev);
 	dev_pm_qos_add_request(&dev->sdev->sdev_gendev, &dev->pm_qos_req,
 			       DEV_PM_QOS_FLAGS, value);
+	if (dev->class == ATA_DEV_ATA || zpodd_dev_enabled(dev))
+		dev_pm_qos_expose_flags(&dev->sdev->sdev_gendev, 0);
 }
 
 void ata_acpi_unbind(struct ata_device *dev)
-- 
1.7.12.4

