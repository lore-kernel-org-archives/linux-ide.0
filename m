From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata-hp-prep: update ata_scsi_find_dev() and friends
Date: Mon, 29 May 2006 15:25:58 +0900
Message-ID: <11488839582103-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:9699 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWE2G0Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:24 -0400
Received: by nz-out-0102.google.com with SMTP id s18so475446nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:23 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_find_dev() and __ata_scsi_find_dev() from
ata_scsi_find_dev().  ata_find_dev() checks ATA_FLAG_SLAVE_POSS for
id==1 case, so all three functions return NULL if id==1 is specified
for !SLAVE_POSS port.  These will be used by later hotplug
implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

113b8fe60b97a6ce664d6098f23b56b75247de87
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9e5cb9f..9adc5c1 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -52,8 +52,12 @@ #include "libata.h"
 #define SECTOR_SIZE	512
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
-static struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
+
+static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
+					const struct scsi_device *scsidev);
+static struct ata_device * ata_scsi_find_dev(struct ata_port *ap,
+					    const struct scsi_device *scsidev);
+
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -2308,6 +2312,23 @@ static unsigned int atapi_xlat(struct at
 	return 0;
 }
 
+static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
+{
+	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
+		return &ap->device[id];
+	return NULL;
+}
+
+static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
+					const struct scsi_device *scsidev)
+{
+	/* skip commands not addressed to targets we simulate */
+	if (unlikely(scsidev->channel || scsidev->lun))
+		return NULL;
+
+	return ata_find_dev(ap, scsidev->id);
+}
+
 /**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
@@ -2324,23 +2345,12 @@ static unsigned int atapi_xlat(struct at
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
1.3.2


