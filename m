From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to 1
Date: Sat, 30 Sep 2006 19:45:00 +0900
Message-ID: <20060930104500.GQ25800@htj.dyndns.org>
References: <20060930104439.GP25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:35077 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750811AbWI3LYm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 07:24:42 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1196462wxc
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 04:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060930104439.GP25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: ric@emc.com, axboe@kernel.dk

Turn off NCQ if queue depth is adjusted to 1.
---
 drivers/ata/libata-scsi.c |   12 +++++++++++-
 include/linux/libata.h    |    1 +
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3986ec8..bea9f7a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -889,6 +889,7 @@ int ata_scsi_change_queue_depth(struct s
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev;
+	unsigned long flags;
 	int max_depth;
 
 	if (queue_depth < 1)
@@ -904,6 +905,14 @@ int ata_scsi_change_queue_depth(struct s
 		queue_depth = max_depth;
 
 	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
+
+	spin_lock_irqsave(ap->lock, flags);
+	if (queue_depth > 1)
+		dev->flags &= ~ATA_DFLAG_NCQ_OFF;
+	else
+		dev->flags |= ATA_DFLAG_NCQ_OFF;
+	spin_unlock_irqrestore(ap->lock, flags);
+
 	return queue_depth;
 }
 
@@ -1293,7 +1302,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		goto nothing_to_do;
 
-	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
+	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
+			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			goto out_of_range;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e54a5fd..d1af1db 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,6 +143,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
+	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* devied limited to non-NCQ mode */
 	ATA_DFLAG_SUSPENDED	= (1 << 10), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
-- 
1.4.2.1

