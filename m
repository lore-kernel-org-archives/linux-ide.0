From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 09/10] libata: use PM_QOS_FLAG_NO_POLL to avoid events checking for ZPODD
Date: Wed, 21 Nov 2012 19:50:38 +0800
Message-ID: <1353498639-27631-10-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

When ODD is powered off, there is no need to do events checking, so
set the PM_QOS_FLAG_NO_POLL flag. And the flag is cleared on power on.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c  | 3 ++-
 drivers/ata/libata-zpodd.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 27a84de..61a90de 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -840,7 +840,8 @@ static int ata_acpi_choose_state(struct ata_device *dev)
 
 	if (zpodd_dev_enabled(dev)) {
 		if (zpodd_poweroff_ready(dev))
-			dev_pm_qos_update_request(&dev->pm_qos_req, 0);
+			dev_pm_qos_update_request(&dev->pm_qos_req,
+						  PM_QOS_FLAG_NO_POLL);
 		else
 			dev_pm_qos_update_request(&dev->pm_qos_req,
 						  PM_QOS_FLAG_NO_POWER_OFF);
diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index d4dbe42..a37833f 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -2,6 +2,7 @@
 #include <linux/cdrom.h>
 #include <linux/pm_runtime.h>
 #include <scsi/scsi_device.h>
+#include <linux/pm_qos.h>
 
 #include "libata.h"
 
@@ -215,6 +216,8 @@ void zpodd_post_resume(struct ata_device *dev)
 
 	zpodd->last_ready = 0;
 	zpodd->zp_ready = false;
+
+	dev_pm_qos_update_request(&dev->pm_qos_req, 0);
 }
 
 static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
-- 
1.7.12.4

