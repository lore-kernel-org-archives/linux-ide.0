From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Delegate nonrot flag setting to SCSI
Date: Wed, 24 Jun 2009 21:01:45 -0400
Message-ID: <yq1eit9rurq.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:43937 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZFYBCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 21:02:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, jens.axboe@oracle.com, linux-ide@vger.kernel.org


Now that the SCSI disk driver correctly handles non-rotational devices
we can move setting the queue flag to SCSI.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1119,10 +1119,6 @@ static int ata_scsi_dev_config(struct sc
 
 		blk_queue_dma_drain(q, atapi_drain_needed, buf, ATAPI_MAX_DRAIN);
 	} else {
-		if (ata_id_is_ssd(dev->id))
-			queue_flag_set_unlocked(QUEUE_FLAG_NONROT,
-						sdev->request_queue);
-
 		/* ATA devices must be sector aligned */
 		blk_queue_update_dma_alignment(sdev->request_queue,
 					       ATA_SECT_SIZE - 1);
