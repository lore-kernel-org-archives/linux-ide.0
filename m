From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata: improve SCSI scan failure handling
Date: Sun, 1 Jul 2007 18:53:38 +0900
Message-ID: <11832836181584-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:29394 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbXGAJxq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876619wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:45 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

SCSI scan may fail due to memory allocation failure even if EH is not
in progress.  Due to use of GFP_ATOMIC in SCSI scan path, allocation
failure isn't too rare especially while probing multiple devices at
once which is the case when a bunch of devices are connected to PMP.

This patch moves SCSI scan failure detetion logic from
ata_scsi_hotplug() to ata_scsi_scan_host() and implement synchronous
scan behavior.  The synchronous path sleeps briefly and repeats SCSI
scan if some devices aren't attached properly.  It contains robust
retry loop to minimize the chance of device misdetection during boot
and falls back to async retry if everything fails.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-scsi.c |   63 +++++++++++++++++++++++++++++++++-----------
 drivers/ata/libata.h      |    2 +-
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c0a2b6c..f776048 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6399,7 +6399,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		ata_scsi_scan_host(ap);
+		ata_scsi_scan_host(ap, 1);
 	}
 
 	return 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4ddf00c..9bf0292 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2947,17 +2947,22 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 	return rc;
 }
 
-void ata_scsi_scan_host(struct ata_port *ap)
+void ata_scsi_scan_host(struct ata_port *ap, int sync)
 {
+	int tries = 5;
+	struct ata_device *last_failed_dev = NULL;
+	struct ata_device *dev;
 	unsigned int i;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
+ repeat:
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
 		struct scsi_device *sdev;
 
+		dev = &ap->device[i];
+
 		if (!ata_dev_enabled(dev) || dev->sdev)
 			continue;
 
@@ -2967,6 +2972,45 @@ void ata_scsi_scan_host(struct ata_port *ap)
 			scsi_device_put(sdev);
 		}
 	}
+
+	/* If we scanned while EH was in progress or allocation
+	 * failure occurred, scan would have failed silently.  Check
+	 * whether all devices are attached.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+		if (ata_dev_enabled(dev) && !dev->sdev)
+			break;
+	}
+	if (i == ATA_MAX_DEVICES)
+		return;
+
+	/* we're missing some SCSI devices */
+	if (sync) {
+		/* If caller requested synchrnous scan && we've made
+		 * any progress, sleep briefly and repeat.
+		 */
+		if (dev != last_failed_dev) {
+			msleep(100);
+			last_failed_dev = dev;
+			goto repeat;
+		}
+
+		/* We might be failing to detect boot device, give it
+		 * a few more chances.
+		 */
+		if (--tries) {
+			msleep(100);
+			goto repeat;
+		}
+
+		ata_port_printk(ap, KERN_ERR, "WARNING: synchronous SCSI scan "
+				"failed without making any progress,\n"
+				"                  switching to async\n");
+	}
+
+	queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
+			   round_jiffies_relative(HZ));
 }
 
 /**
@@ -3093,20 +3137,7 @@ void ata_scsi_hotplug(struct work_struct *work)
 	}
 
 	/* scan for new ones */
-	ata_scsi_scan_host(ap);
-
-	/* If we scanned while EH was in progress, scan would have
-	 * failed silently.  Requeue if there are enabled but
-	 * unattached devices.
-	 */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_enabled(dev) && !dev->sdev) {
-			queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
-				round_jiffies_relative(HZ));
-			break;
-		}
-	}
+	ata_scsi_scan_host(ap, 0);
 
 	DPRINTK("EXIT\n");
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ba17fc5..48836b2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -112,7 +112,7 @@ static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
 /* libata-scsi.c */
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
-extern void ata_scsi_scan_host(struct ata_port *ap);
+extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
-- 
1.5.0.3


