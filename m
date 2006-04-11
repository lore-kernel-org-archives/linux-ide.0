From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata-hp: store attached SCSI device
Date: Tue, 11 Apr 2006 23:06:22 +0900
Message-ID: <1144764382410-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:34748 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750837AbWDKOG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:28 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100709nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:27 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add device persistent field dev->sdev and store the attached SCSI
device.  With hotplug, libata needs to know the attached SCSI device
to offline and detach it, but scsi_device_lookup() cannot be used
because libata will reuse SCSI ID numbers - dead but not gone devices
(due to zombie opens, etc...) interfere with the lookup.

dev->sdev doesn't hold reference to the SCSI device.  dev->sdev is
cleared when the SCSI device goes away.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   14 ++++++++++----
 include/linux/libata.h     |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

784f79074e0ab0441363c7a87d1b93d6d11ac437
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 4ce390a..1793474 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2740,17 +2740,23 @@ void ata_scsi_simulate(struct ata_port *
 
 void ata_scsi_scan_host(struct ata_port *ap)
 {
-	struct ata_device *dev;
 	unsigned int i;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		struct ata_device *dev = &ap->device[i];
 
-		if (ata_dev_enabled(dev))
-			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
+		if (ata_dev_enabled(dev) && dev->sdev == NULL) {
+			struct scsi_device *sdev;
+
+			sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
+			if (!IS_ERR(sdev)) {
+				dev->sdev = sdev;
+				scsi_device_put(sdev);
+			}
+		}
 	}
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a93c44..5f8faca 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -407,6 +407,7 @@ struct ata_ering {
 struct ata_device {
 	unsigned int		devno;		/* 0 or 1 */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	struct scsi_device	*sdev;		/* attached SCSI device */
 	/* fields above n_sectors are not cleared across device init */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
-- 
1.2.4


