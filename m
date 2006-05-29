From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata-hp-prep: store attached SCSI device
Date: Mon, 29 May 2006 15:25:58 +0900
Message-ID: <11488839582227-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:58383 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWE2G03 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:29 -0400
Received: by wx-out-0102.google.com with SMTP id h27so298148wxd
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:29 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
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

16098cb84a40faee6726ff51371e9aa17e018a5f
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 95e5c23..a1caf3f 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2743,16 +2743,22 @@ void ata_scsi_simulate(struct ata_device
 
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
index c42ea93..54b2259 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -412,6 +412,7 @@ struct ata_device {
 	struct ata_port		*ap;
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	struct scsi_device	*sdev;		/* attached SCSI device */
 	/* n_sector is used as CLEAR_OFFSET, read comment above CLEAR_OFFSET */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-- 
1.3.2


