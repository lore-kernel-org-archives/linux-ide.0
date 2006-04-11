From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata-hp: separate out __ata_scsi_find_dev()
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <1144764381126-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.225]:34996 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750819AbWDKOGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:23 -0400
Received: by wproxy.gmail.com with SMTP id 58so967052wri
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:23 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out __ata_scsi_find_dev() from ata_scsi_find_dev().  The
underscored version doesn't check whether the ATA device is enabled
and useuable.  It unconditionally returns the associated ATA device if
channel/id/lun is valid.  This function will be used by hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

ec6e2517ec4dd32773cfed7e8d8ad3e559509d51
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 5f81136..4ce390a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -52,8 +52,9 @@
 #define SECTOR_SIZE	512
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
-static struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
+
+static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
+					      const struct scsi_device *scsidev);
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -2317,6 +2318,17 @@ static unsigned int atapi_xlat(struct at
 	return 0;
 }
 
+static struct ata_device *
+__ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
+{
+	/* skip commands not addressed to targets we simulate */
+	if (likely(scsidev->id < ATA_MAX_DEVICES &&
+		   scsidev->channel == 0 && scsidev->lun == 0))
+		return &ap->device[scsidev->id];
+
+	return NULL;
+}
+
 /**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
@@ -2333,23 +2345,12 @@ static unsigned int atapi_xlat(struct at
  *	RETURNS:
  *	Associated ATA device, or %NULL if not found.
  */
-
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
 {
-	struct ata_device *dev;
-
-	/* skip commands not addressed to targets we simulate */
-	if (likely(scsidev->id < ATA_MAX_DEVICES))
-		dev = &ap->device[scsidev->id];
-	else
-		return NULL;
-
-	if (unlikely((scsidev->channel != 0) ||
-		     (scsidev->lun != 0)))
-		return NULL;
+	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
-	if (unlikely(!ata_dev_enabled(dev)))
+	if (unlikely(!dev || !ata_dev_enabled(dev)))
 		return NULL;
 
 	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
-- 
1.2.4


