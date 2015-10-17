From: vinayak.kale@gmail.com
Subject: [PATCH] libata: add support for NCQ commands for SG interface
Date: Sat, 17 Oct 2015 17:18:39 +0530
Message-ID: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36536 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbJQLtJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Oct 2015 07:49:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

From: Vinayak Kale <vinayak.kale@seagate.com>

This patch is needed to make NCQ commands with FPDMA protocol value
(eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.

Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
---
 drivers/ata/libata-scsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d7f0da..5b0a5ab 100644
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
@@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 			tf->hob_lbal = cdb[7];
 			tf->hob_lbam = cdb[9];
 			tf->hob_lbah = cdb[11];
-			tf->flags |= ATA_TFLAG_LBA48;
+			tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);
 		} else
 			tf->flags &= ~ATA_TFLAG_LBA48;
 
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

