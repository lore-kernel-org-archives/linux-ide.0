From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH] ata: set ncq_prio_enabled if device has support
Date: Wed, 19 Oct 2016 20:40:19 -0700
Message-ID: <1476934819-3084-1-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Manzanares <adam.manzanares@hgst.com>, Adam Manzanares <adam.manzanares@wdc.com>
List-Id: linux-ide@vger.kernel.org

We previously had a check to see if the device has support for
prioritized ncq commands and a check to see if a device flag
is set, through a sysfs variable, in order to send a prioritized
command.

This patch only allows the sysfs variable to be set if the device
supports prioritized commands enabling one check in ata_build_rw_tf
in order to determine whether or not to send a prioritized command.

This patch depends on ata: ATA Command Priority Disabled By Default

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 drivers/ata/libata-core.c | 3 +--
 drivers/ata/libata-scsi.c | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b294339..43842fd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -787,8 +787,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 		if (tf->flags & ATA_TFLAG_FUA)
 			tf->device |= 1 << 7;
 
-		if ((dev->flags & ATA_DFLAG_NCQ_PRIO) &&
-		    (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE)) {
+		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE) {
 			if (class == IOPRIO_CLASS_RT)
 				tf->hob_nsect |= ATA_PRIO_HIGH <<
 						 ATA_SHIFT_PRIO;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 87597a3..831beea 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -323,8 +323,14 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
 		goto unlock;
 	}
 
-	if (input)
+	if (input) {
+		if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
+			rc = -EOPNOTSUPP;
+			goto unlock;
+		}
+
 		dev->flags |= ATA_DFLAG_NCQ_PRIO_ENABLE;
+	}
 	else
 		dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
 
-- 
2.1.4
