From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: fix ata_scsi_change_queue_depth()
Date: Tue, 20 Feb 2007 23:31:22 +0900
Message-ID: <20070220143122.GR1625@htj.dyndns.org>
References: <20070220142027.GP1625@htj.dyndns.org> <20070220142706.GQ1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:33643 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964924AbXBTOb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 09:31:26 -0500
Received: by an-out-0708.google.com with SMTP id b33so362802ana
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 06:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070220142706.GQ1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: haebler@gmail.com, lkml@fliagreco.com.ar

Fix ata_scsi_change_queue_depth() such that...

* NCQ on/off is exactly determined using the same logic as the issue path.

* queue depth is adjusted to 1 if NCQ is not enabled.

* -EINVAL is returned if requested action is ignored due to limitations.

This fixes the bug which allows queue depth to be increased on
blacklisted NCQ hosts/devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -986,29 +986,32 @@ int ata_scsi_change_queue_depth(struct s
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
 	unsigned long flags;
-	int max_depth;
 
-	if (queue_depth < 1)
+	if (queue_depth < 1 || queue_depth == sdev->queue_depth)
 		return sdev->queue_depth;
 
 	dev = ata_scsi_find_dev(ap, sdev);
 	if (!dev || !ata_dev_enabled(dev))
 		return sdev->queue_depth;
 
-	max_depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
-	max_depth = min(ATA_MAX_QUEUE - 1, max_depth);
-	if (queue_depth > max_depth)
-		queue_depth = max_depth;
-
-	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
-
+	/* NCQ enabled? */
 	spin_lock_irqsave(ap->lock, flags);
-	if (queue_depth > 1)
-		dev->flags &= ~ATA_DFLAG_NCQ_OFF;
-	else
+	dev->flags &= ~ATA_DFLAG_NCQ_OFF;
+	if (queue_depth == 1 || !ata_ncq_enabled(dev)) {
 		dev->flags |= ATA_DFLAG_NCQ_OFF;
+		queue_depth = 1;
+	}
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	/* limit and apply queue depth */
+	queue_depth = min(queue_depth, sdev->host->can_queue);
+	queue_depth = min(queue_depth, ata_id_queue_depth(dev->id));
+	queue_depth = min(queue_depth, ATA_MAX_QUEUE - 1);
+
+	if (sdev->queue_depth == queue_depth)
+		return -EINVAL;
+
+	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
 	return queue_depth;
 }
 
