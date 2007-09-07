From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Remove sync waiting code from libata
Date: Thu, 6 Sep 2007 20:46:32 -0600
Message-ID: <20070907024632.GH27404@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:60939 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbXIGCqf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 22:46:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org


By using the scsi async probing code, we can remove the 'sync' argument
from ata_scsi_scan_host():

diff -u b/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
--- b/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6362,10 +6362,15 @@
 	}
 }
 
+/*
+ * Give ourselves ten seconds to find everything.
+ * This should be more than enough time
+ */
 int ata_scsi_scan_finished(struct Scsi_Host *shost, unsigned long time)
 {
-	ata_scsi_scan_host(ata_shost_to_port(shost), 1);
-	return 1;
+	if (ata_scsi_scan_host(ata_shost_to_port(shost)))
+		return 1;
+	return time > (10 * HZ);
 }
 
 /**
diff -u b/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
--- b/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2954,17 +2954,15 @@
 	return rc;
 }
 
-void ata_scsi_scan_host(struct ata_port *ap, int sync)
+/* Returns 1 if we are done scanning, 0 if we've scheduled async scanning */
+int ata_scsi_scan_host(struct ata_port *ap)
 {
-	int tries = 5;
-	struct ata_device *last_failed_dev = NULL;
 	struct ata_device *dev;
 	unsigned int i;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
-		return;
+		return 1;
 
- repeat:
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct scsi_device *sdev;
 
@@ -2990,34 +2988,11 @@
 			break;
 	}
 	if (i == ATA_MAX_DEVICES)
-		return;
-
-	/* we're missing some SCSI devices */
-	if (sync) {
-		/* If caller requested synchrnous scan && we've made
-		 * any progress, sleep briefly and repeat.
-		 */
-		if (dev != last_failed_dev) {
-			msleep(100);
-			last_failed_dev = dev;
-			goto repeat;
-		}
-
-		/* We might be failing to detect boot device, give it
-		 * a few more chances.
-		 */
-		if (--tries) {
-			msleep(100);
-			goto repeat;
-		}
-
-		ata_port_printk(ap, KERN_ERR, "WARNING: synchronous SCSI scan "
-				"failed without making any progress,\n"
-				"                  switching to async\n");
-	}
+		return 1;
 
 	queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
 			   round_jiffies_relative(HZ));
+	return 0;
 }
 
 /**
@@ -3144,7 +3119,7 @@
 	}
 
 	/* scan for new ones */
-	ata_scsi_scan_host(ap, 0);
+	ata_scsi_scan_host(ap);
 
 	DPRINTK("EXIT\n");
 }
only in patch2:
unchanged:
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -112,7 +112,7 @@ static inline int ata_acpi_on_devcfg(struct ata_device *adev) { return 0; }
 /* libata-scsi.c */
 extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
-extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
+extern int ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
