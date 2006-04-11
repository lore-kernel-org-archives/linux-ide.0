From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/15] libata-ncq: implement NCQ device configuration
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636172294-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:55716 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751001AbWDKNxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:49 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097574nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:49 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that all NCQ related issue, processing and EH stuff are in place,
implement NCQ device configuration and bump ATA_MAX_QUEUE to 32 thus
activating NCQ support.

Original implementation if from Jens Axboe.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 ++++++++++++++++++++++++++--
 drivers/scsi/libata-scsi.c |   48 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 +++-
 3 files changed, 79 insertions(+), 3 deletions(-)

7b8a0fd4e490e83258185c96e2ec80aa9657f097
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8e90aa0..0158b5f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1258,6 +1258,27 @@ static inline u8 ata_dev_knobble(const s
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
+static void ata_dev_config_ncq(struct ata_port *ap, struct ata_device *dev,
+			       char *desc, size_t desc_sz)
+{
+	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
+
+	if (!ata_id_has_ncq(dev->id)) {
+		desc[0] = '\0';
+		return;
+	}
+
+	if (ap->flags & ATA_FLAG_NCQ) {
+		hdepth = min(ap->host->can_queue, ATA_MAX_QUEUE - 1);
+		dev->flags |= ATA_DFLAG_NCQ;
+	}
+
+	if (hdepth >= ddepth)
+		snprintf(desc, desc_sz, "NCQ (depth %d)", ddepth);
+	else
+		snprintf(desc, desc_sz, "NCQ (depth %d/%d)", hdepth, ddepth);
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@ap: Port on which target device resides
@@ -1319,6 +1340,7 @@ static int ata_dev_configure(struct ata_
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
+			char ncq_desc[20];
 
 			lba_desc = "LBA";
 			dev->flags |= ATA_DFLAG_LBA;
@@ -1327,15 +1349,18 @@ static int ata_dev_configure(struct ata_
 				lba_desc = "LBA48";
 			}
 
+			/* config NCQ */
+			ata_dev_config_ncq(ap, dev, ncq_desc, sizeof(ncq_desc));
+
 			/* print device info to dmesg */
 			if (print_info)
 				printk(KERN_INFO "ata%u: dev %u ATA-%d, "
-				       "max %s, %Lu sectors: %s\n",
+				       "max %s, %Lu sectors: %s %s\n",
 				       ap->id, dev->devno,
 				       ata_id_major_version(id),
 				       ata_mode_string(xfer_mask),
 				       (unsigned long long)dev->n_sectors,
-				       lba_desc);
+				       lba_desc, ncq_desc);
 		} else {
 			/* CHS */
 
@@ -5335,6 +5360,7 @@ EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_id_string);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index fdc95f1..5f81136 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -41,6 +41,7 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_request.h>
+#include <scsi/scsi_tcq.h>
 #include <scsi/scsi_transport.h>
 #include <linux/libata.h>
 #include <linux/hdreg.h>
@@ -679,6 +680,14 @@ static void ata_scsi_dev_config(struct s
 		request_queue_t *q = sdev->request_queue;
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
+
+	if (dev->flags & ATA_DFLAG_NCQ) {
+		int depth;
+
+		depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
+		depth = min(ATA_MAX_QUEUE - 1, depth);
+		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
+	}
 }
 
 /**
@@ -713,6 +722,45 @@ int ata_scsi_slave_config(struct scsi_de
 }
 
 /**
+ *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
+ *	@sdev: SCSI device to configure queue depth for
+ *	@queue_depth: new queue depth
+ *
+ *	This is libata standard hostt->change_queue_depth callback.
+ *	SCSI will call into this callback when user tries to set queue
+ *	depth via sysfs.
+ *
+ *	LOCKING:
+ *	SCSI layer (we don't care)
+ *
+ *	RETURNS:
+ *	Newly configured queue depth.
+ */
+int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
+{
+	struct ata_port *ap;
+	struct ata_device *dev;
+	int max_depth;
+
+	if (sdev->id >= ATA_MAX_DEVICES || queue_depth < 1)
+		return sdev->queue_depth;
+
+	ap = (struct ata_port *) &sdev->host->hostdata[0];
+	dev = &ap->device[sdev->id];
+
+	if (!ata_dev_enabled(dev))
+		return sdev->queue_depth;
+
+	max_depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
+	max_depth = min(ATA_MAX_QUEUE - 1, max_depth);
+	if (queue_depth > max_depth)
+		queue_depth = max_depth;
+
+	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
+	return queue_depth;
+}
+
+/**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d463156..0413c7b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -108,7 +108,7 @@ enum {
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
-	ATA_MAX_QUEUE		= 2,
+	ATA_MAX_QUEUE		= 32,
 	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
@@ -644,6 +644,8 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
+				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_port *ap, 
 				       struct ata_device *adev);
 
-- 
1.2.4


