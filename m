From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata-hp-prep: implement ata_dev_init()
Date: Fri, 19 May 2006 06:16:33 -0700 (PDT)
Message-ID: <1148044584401-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:4321 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932226AbWESNQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:34 -0400
Received: by py-out-1112.google.com with SMTP id z59so920071pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:34 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move initialization of struct ata_device into ata_dev_init() in
preparation for hotplug.  This patch calls ata_dev_init() from
ata_host_init() and thus makes no functional difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   26 +++++++++++++++++++++-----
 drivers/scsi/libata.h      |    1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

1b2521bc48b11f2b347d5c3b7cf7ee26c9bdc380
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9051b68..f239324 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5109,6 +5109,26 @@ static void ata_host_remove(struct ata_p
 }
 
 /**
+ *	ata_dev_init - Initialize an ata_device structure
+ *	@dev: Device structure to initialize
+ *
+ *	Initialize @dev in preparation for probing.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_dev_init(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+
+	memset((void *)dev, 0, sizeof(*dev));
+	dev->devno = dev - ap->device;
+	dev->pio_mask = UINT_MAX;
+	dev->mwdma_mask = UINT_MAX;
+	dev->udma_mask = UINT_MAX;
+}
+
+/**
  *	ata_host_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: associated SCSI mid-layer structure
@@ -5122,7 +5142,6 @@ static void ata_host_remove(struct ata_p
  *	LOCKING:
  *	Inherited from caller.
  */
-
 static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
@@ -5164,10 +5183,7 @@ static void ata_host_init(struct ata_por
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		dev->ap = ap;
-		dev->devno = i;
-		dev->pio_mask = UINT_MAX;
-		dev->mwdma_mask = UINT_MAX;
-		dev->udma_mask = UINT_MAX;
+		ata_dev_init(dev);
 	}
 
 #ifdef ATA_IRQ_TRAP
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index b76ad7d..d46c552 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -62,6 +62,7 @@ extern int ata_check_atapi_dma(struct at
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
-- 
1.3.2

