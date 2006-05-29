From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata-hp-prep: implement ata_dev_init()
Date: Mon, 29 May 2006 15:25:57 +0900
Message-ID: <11488839573884-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:58383 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751246AbWE2G0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:23 -0400
Received: by wx-out-0102.google.com with SMTP id h27so298148wxd
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:23 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
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

1b63513233c45c44f359191b2e854e090f404e69
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11df827..84afb59 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5142,6 +5142,26 @@ static void ata_host_remove(struct ata_p
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
@@ -5155,7 +5175,6 @@ static void ata_host_remove(struct ata_p
  *	LOCKING:
  *	Inherited from caller.
  */
-
 static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
@@ -5198,10 +5217,7 @@ static void ata_host_init(struct ata_por
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


