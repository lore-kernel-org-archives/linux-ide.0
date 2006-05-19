From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/14] libata-hp-prep: use __ata_scsi_find_dev()
Date: Fri, 19 May 2006 06:16:34 -0700 (PDT)
Message-ID: <11480445843333-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:49900 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932219AbWESNQg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:36 -0400
Received: by nz-out-0102.google.com with SMTP id 8so626374nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:35 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert direct sdev -> dev lookup to __ata_scsi_find_dev().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

0671154af98c1bd1dadc37359dea4162b0d16b10
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1b2ac23..b52591e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -399,7 +399,7 @@ void ata_dump_status(unsigned id, struct
 int ata_scsi_device_resume(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = &ap->device[sdev->id];
+	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
 
 	return ata_device_resume(dev);
 }
@@ -407,7 +407,7 @@ int ata_scsi_device_resume(struct scsi_d
 int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = &ap->device[sdev->id];
+	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
 
 	return ata_device_suspend(dev, state);
 }
@@ -713,19 +713,15 @@ static void ata_scsi_dev_config(struct s
 
 int ata_scsi_slave_config(struct scsi_device *sdev)
 {
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+
 	ata_scsi_sdev_config(sdev);
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
-	if (sdev->id < ATA_MAX_DEVICES) {
-		struct ata_port *ap;
-		struct ata_device *dev;
-
-		ap = ata_shost_to_port(sdev->host);
-		dev = &ap->device[sdev->id];
-
+	if (dev)
 		ata_scsi_dev_config(sdev, dev);
-	}
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
 }
-- 
1.3.2

