From: vinayak.kale@gmail.com
Subject: [PATCH v2] libata: add support for NCQ commands for SG interface
Date: Tue, 27 Oct 2015 11:19:15 +0530
Message-ID: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32924 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbbJ0FuI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 01:50:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

From: Vinayak Kale <vinayak.kale@seagate.com>

This patch is needed to make NCQ commands with FPDMA protocol value
(eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.

Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
---
Changes in v2:
 - Decoupled tf->flags changes in ata_scsi_pass_thru() from this patch
   as per Tejun's suggestion. A separate patch will be sent for that change.

 drivers/ata/libata-scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d7f0da..c2af592 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2914,12 +2914,14 @@ ata_scsi_map_proto(u8 byte1)
 	case 5:		/* PIO Data-out */
 		return ATA_PROT_PIO;
 
+	case 12:	/* FPDMA */
+		return ATA_PROT_NCQ;
+
 	case 0:		/* Hard Reset */
 	case 1:		/* SRST */
 	case 8:		/* Device Diagnostic */
 	case 9:		/* Device Reset */
 	case 7:		/* DMA Queued */
-	case 12:	/* FPDMA */
 	case 15:	/* Return Response Info */
 	default:	/* Reserved */
 		break;
@@ -2992,6 +2994,10 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		tf->command = cdb[9];
 	}
 
+	/* For NCQ commands with FPDMA protocol, copy the tag value */
+	if (tf->protocol == ATA_PROT_NCQ)
+		tf->nsect = qc->tag << 3;
+
 	/* enforce correct master/slave bit */
 	tf->device = dev->devno ?
 		tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
-- 
1.9.1

