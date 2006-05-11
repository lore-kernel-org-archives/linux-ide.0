From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata-ncq: implement NCQ device configuration
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586833688-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:63075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751788AbWEKOoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:54 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216446nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:54 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that all NCQ related stuff are in place, implement NCQ device
configuration and bump ATA_MAX_QUEUE to 32 thus activating NCQ
support.

Original implementation is from Jens Axboe.

---

 drivers/scsi/libata-core.c |   31 ++++++++++++++++++++++++++++--
 drivers/scsi/libata-scsi.c |   46 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    4 +++-
 3 files changed, 78 insertions(+), 3 deletions(-)

efed0a60183811c87f012f7b32f50f8cc3139564
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3e3d3d1..54240db 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1251,6 +1251,28 @@ static inline u8 ata_dev_knobble(struct 
 	return ((dev->ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
+static void ata_dev_config_ncq(struct ata_device *dev,
+			       char *desc, size_t desc_sz)
+{
+	struct ata_port *ap = dev->ap;
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
  *	@dev: Target device to configure
@@ -1311,6 +1333,7 @@ static int ata_dev_configure(struct ata_
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
+			char ncq_desc[20];
 
 			lba_desc = "LBA";
 			dev->flags |= ATA_DFLAG_LBA;
@@ -1319,14 +1342,17 @@ static int ata_dev_configure(struct ata_
 				lba_desc = "LBA48";
 			}
 
+			/* config NCQ */
+			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
+
 			/* print device info to dmesg */
 			if (print_info)
 				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
-					"max %s, %Lu sectors: %s\n",
+					"max %s, %Lu sectors: %s %s\n",
 					ata_id_major_version(id),
 					ata_mode_string(xfer_mask),
 					(unsigned long long)dev->n_sectors,
-					lba_desc);
+					lba_desc, ncq_desc);
 		} else {
 			/* CHS */
 
@@ -5675,6 +5701,7 @@ EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
+EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_scr_valid);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9bef68c..996058a 100644
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
@@ -684,6 +685,14 @@ static void ata_scsi_dev_config(struct s
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
@@ -718,6 +727,43 @@ int ata_scsi_slave_config(struct scsi_de
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
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev;
+	int max_depth;
+
+	if (queue_depth < 1)
+		return sdev->queue_depth;
+
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev || !ata_dev_enabled(dev))
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
index d059c75..97e25a6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -109,7 +109,7 @@ enum {
 	ATA_MAX_PORTS		= 8,
 	ATA_DEF_QUEUE		= 1,
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
-	ATA_MAX_QUEUE		= 2,
+	ATA_MAX_QUEUE		= 32,
 	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
 	ATA_MAX_BUS		= 2,
@@ -682,6 +682,8 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
+				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 
 /*
-- 
1.2.4


