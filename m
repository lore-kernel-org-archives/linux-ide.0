From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] libata-hp: implement warmplug
Date: Wed, 31 May 2006 20:25:45 +0900
Message-ID: <11490747451922-git-send-email-htejun@gmail.com>
References: <11490747443727-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:46486 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964975AbWEaLZv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:25:51 -0400
Received: by py-out-1112.google.com with SMTP id e30so1039473pya
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:25:51 -0700 (PDT)
In-Reply-To: <11490747443727-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement warmplug.  User-initiated unplug can be detected by
hostt->slave_destroy() and plug by transportt->user_scan().  This
patch only implements the two callbacks.  The next function will hook
them.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 
 drivers/scsi/libata-scsi.c |   89 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    1 
 3 files changed, 91 insertions(+), 0 deletions(-)

83c47bcb3c533180a6dda78152334de50065358a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8df8ecc..c61cfc7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5942,6 +5942,7 @@ EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
+EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1256399..7c1ac58 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -57,6 +57,8 @@ static struct ata_device * __ata_scsi_fi
 					const struct scsi_device *scsidev);
 static struct ata_device * ata_scsi_find_dev(struct ata_port *ap,
 					    const struct scsi_device *scsidev);
+static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
+			      unsigned int id, unsigned int lun);
 
 
 #define RW_RECOVERY_MPAGE 0x1
@@ -727,6 +729,40 @@ int ata_scsi_slave_config(struct scsi_de
 }
 
 /**
+ *	ata_scsi_slave_destroy - SCSI device is about to be destroyed
+ *	@sdev: SCSI device to be destroyed
+ *
+ *	@sdev is about to be destroyed for hot/warm unplugging.  If
+ *	this unplugging was initiated by libata as indicated by NULL
+ *	dev->sdev, this function doesn't have to do anything.
+ *	Otherwise, SCSI layer initiated warm-unplug is in progress.
+ *	Clear dev->sdev, schedule the device for ATA detach and invoke
+ *	EH.
+ *
+ *	LOCKING:
+ *	Defined by SCSI layer.  We don't really care.
+ */
+void ata_scsi_slave_destroy(struct scsi_device *sdev)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	unsigned long flags;
+	struct ata_device *dev;
+
+	if (!ap->ops->error_handler)
+		return;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	dev = __ata_scsi_find_dev(ap, sdev);
+	if (dev && dev->sdev) {
+		/* SCSI device already in CANCEL state, no need to offline it */
+		dev->sdev = NULL;
+		dev->flags |= ATA_DFLAG_DETACH;
+		ata_port_schedule_eh(ap);
+	}
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
  *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
  *	@sdev: SCSI device to configure queue depth for
  *	@queue_depth: new queue depth
@@ -2902,3 +2938,56 @@ void ata_scsi_hotplug(void *data)
 
 	DPRINTK("EXIT\n");
 }
+
+/**
+ *	ata_scsi_user_scan - indication for user-initiated bus scan
+ *	@shost: SCSI host to scan
+ *	@channel: Channel to scan
+ *	@id: ID to scan
+ *	@lun: LUN to scan
+ *
+ *	This function is called when user explicitly requests bus
+ *	scan.  Set probe pending flag and invoke EH.
+ *
+ *	LOCKING:
+ *	SCSI layer (we don't care)
+ *
+ *	RETURNS:
+ *	Zero.
+ */
+static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
+			      unsigned int id, unsigned int lun)
+{
+	struct ata_port *ap = ata_shost_to_port(shost);
+	unsigned long flags;
+	int rc = 0;
+
+	if (!ap->ops->error_handler)
+		return -EOPNOTSUPP;
+
+	if ((channel != SCAN_WILD_CARD && channel != 0) ||
+	    (lun != SCAN_WILD_CARD && lun != 0))
+		return -EINVAL;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	if (id == SCAN_WILD_CARD) {
+		ap->eh_info.probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+		ap->eh_info.action |= ATA_EH_SOFTRESET;
+	} else {
+		struct ata_device *dev = ata_find_dev(ap, id);
+
+		if (dev) {
+			ap->eh_info.probe_mask |= 1 << dev->devno;
+			ap->eh_info.action |= ATA_EH_SOFTRESET;
+		} else
+			rc = -EINVAL;
+	}
+
+	if (rc == 0)
+		ata_port_schedule_eh(ap);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	return rc;
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4071156..74786c3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -734,6 +734,7 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
-- 
1.3.2


