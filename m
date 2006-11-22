From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: make sure sdev doesn't go away while rescanning
Date: Wed, 22 Nov 2006 11:21:31 +0900
Message-ID: <20061122022131.GU2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:52335 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S967005AbWKVCVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 21:21:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so51997uga
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 18:21:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ata_scsi_dev_rescan() doesn't synchronize against SCSI device detach
and the target sdev might go away in the middle.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0552c3f..3976b25 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3215,15 +3215,27 @@ static int ata_scsi_user_scan(struct Scs
 void ata_scsi_dev_rescan(void *data)
 {
 	struct ata_port *ap = data;
-	struct ata_device *dev;
+	unsigned long flags;
 	unsigned int i;
 
+	spin_lock_irqsave(ap->lock, flags);
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->device[i];
+		struct ata_device *dev = &ap->device[i];
+		struct scsi_device *sdev = dev->sdev;
 
-		if (ata_dev_enabled(dev) && dev->sdev)
-			scsi_rescan_device(&(dev->sdev->sdev_gendev));
+		if (!ata_dev_enabled(dev) || !sdev)
+			continue;
+		if (scsi_device_get(sdev))
+			continue;
+
+		spin_unlock_irqrestore(ap->lock, flags);
+		scsi_rescan_device(&(sdev->sdev_gendev));
+		scsi_device_put(sdev);
+		spin_lock_irqsave(ap->lock, flags);
 	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 
 /**
