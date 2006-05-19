From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/14] libata-hp-prep: update ata_scsi_find_dev() and friends
Date: Fri, 19 May 2006 06:16:33 -0700 (PDT)
Message-ID: <11480445841836-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:19937 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932216AbWESNQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:34 -0400
Received: by py-out-1112.google.com with SMTP id z59so920074pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:33 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
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

9677c34d81dee7f9564be0a7e2b037c7e0d6ca52
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 2007b4b..1b2ac23 100644
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

