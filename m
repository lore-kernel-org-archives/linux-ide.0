From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata-hp-prep: store attached SCSI device
Date: Fri, 19 May 2006 06:16:37 -0700 (PDT)
Message-ID: <11480445842821-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:4321 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932234AbWESNQi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:38 -0400
Received: by py-out-1112.google.com with SMTP id z59so920071pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:38 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add device persistent field dev->sdev and store the attached SCSI
device.  With hotplug, libata needs to know the attached SCSI device
to offline and detach it, but scsi_device_lookup() cannot be used
because libata will reuse SCSI ID numbers - dead but not gone devices
(due to zombie opens, etc...) interfere with the lookup.

dev->sdev doesn't hold reference to the SCSI device.  It's cleared
when the SCSI device goes away.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   14 ++++++++++----
 include/linux/libata.h     |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

54beb5597d09c17687cc2a400c04a9ed1a28210f
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index b52591e..d24e091 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2738,16 +2738,22 @@ void ata_scsi_simulate(struct ata_device
 
 void ata_scsi_scan_host(struct ata_port *ap)
 {
-	struct ata_device *dev;
 	unsigned int i;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		struct ata_device *dev = &ap->device[i];
+		struct scsi_device *sdev;
+
+		if (!ata_dev_enabled(dev) || dev->sdev)
+			continue;
 
-		if (ata_dev_enabled(dev))
-			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
+		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
+		if (!IS_ERR(sdev)) {
+			dev->sdev = sdev;
+			scsi_device_put(sdev);
+		}
 	}
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 07c98c2..dbc9602 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -413,6 +413,7 @@ struct ata_device {
 	struct ata_port		*ap;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	struct scsi_device	*sdev;		/* attached SCSI device */
 	/* fields above n_sectors are not cleared across device init */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-- 
1.3.2

