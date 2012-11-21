From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 08/10] PM / BLOCK: add PM_QOS_FLAG_NO_POLL to skip events checking
Date: Wed, 21 Nov 2012 19:50:37 +0800
Message-ID: <1353498639-27631-9-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Some device may enter into a power state when events checking is no
longer necessary, this patch introduces the PM_QOS_FLAG_NO_POLL flag
and once set, events checking work function in block layer will skip
invoke the disk's check_events callback.

This will be used by ZPODD, when ODD is powered off, it doesn't make
sense to poll for media change events anymore.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 block/genhd.c          | 8 +++++++-
 include/linux/pm_qos.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 6cace66..b0092bb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/log2.h>
+#include <linux/pm_qos.h>
 
 #include "blk.h"
 
@@ -1595,9 +1596,14 @@ static void disk_events_workfn(struct work_struct *work)
 	unsigned int events;
 	unsigned long intv;
 	int nr_events = 0, i;
+	enum pm_qos_flags_status stat;
 
 	/* check events */
-	events = disk->fops->check_events(disk, clearing);
+	stat = dev_pm_qos_flags(disk->driverfs_dev, PM_QOS_FLAG_NO_POLL);
+	if (stat == PM_QOS_FLAGS_ALL)
+		events = 0;
+	else
+		events = disk->fops->check_events(disk, clearing);
 
 	/* accumulate pending events and schedule next poll if necessary */
 	spin_lock_irq(&ev->lock);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 5a95013..318a422 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -36,6 +36,7 @@ enum pm_qos_flags_status {
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
 #define PM_QOS_FLAG_REMOTE_WAKEUP	(1 << 1)
+#define PM_QOS_FLAG_NO_POLL		(1 << 3)
 
 struct pm_qos_request {
 	struct plist_node node;
-- 
1.7.12.4

