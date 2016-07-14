From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/10] ata: Handle ATA NCQ NO-DATA commands correctly
Date: Thu, 14 Jul 2016 09:05:48 +0900
Message-ID: <1468454751-12466-8-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55786 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:16 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

Add a new taskfile protocol ATA_PROT_NCQ_NODATA to handle
ATA NCQ NO-DATA commands correctly.
And fixup ata_scsi_zbc_out_xlat() to use it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-eh.c       | 3 ++-
 drivers/ata/libata-scsi.c     | 5 ++++-
 drivers/ata/sata_dwc_460ex.c  | 2 ++
 include/linux/ata.h           | 1 +
 include/linux/libata.h        | 2 ++
 include/trace/events/libata.h | 1 +
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5688b86..d551378 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2611,7 +2611,8 @@ static void ata_eh_link_report(struct ata_link *link)
 				[ATA_PROT_NODATA]	= "nodata",
 				[ATA_PROT_PIO]		= "pio",
 				[ATA_PROT_DMA]		= "dma",
-				[ATA_PROT_NCQ]		= "ncq",
+				[ATA_PROT_NCQ]		= "ncq dma",
+				[ATA_PROT_NCQ_NODATA]	= "ncq nodata",
 				[ATAPI_PROT_NODATA]	= "nodata",
 				[ATAPI_PROT_PIO]	= "pio",
 				[ATAPI_PROT_DMA]	= "dma",
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0447a39..901b46a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3082,6 +3082,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		goto invalid_fld;
 	}
 
+	if (ata_is_ncq(tf->protocol) && (cdb[2] & 0x3) == 0)
+		tf->protocol = ATA_PROT_NCQ_NODATA;
+
 	/* enable LBA */
 	tf->flags |= ATA_TFLAG_LBA;
 
@@ -3548,7 +3551,7 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 
 	if (ata_ncq_enabled(qc->dev) &&
 	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
-		tf->protocol = ATA_PROT_NCQ;
+		tf->protocol = ATA_PROT_NCQ_NODATA;
 		tf->command = ATA_CMD_NCQ_NON_DATA;
 		tf->hob_nsect = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
 		tf->nsect = qc->tag << 3;
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 00c2af1..fa1530a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -290,6 +290,8 @@ static const char *get_prot_descript(u8 protocol)
 		return "ATA DMA";
 	case ATA_PROT_NCQ:
 		return "ATA NCQ";
+	case ATA_PROT_NCQ_NODATA:
+		return "ATA NCQ no data";
 	case ATAPI_PROT_NODATA:
 		return "ATAPI no data";
 	case ATAPI_PROT_PIO:
diff --git a/include/linux/ata.h b/include/linux/ata.h
index d20b1ee..35857d1 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -530,6 +530,7 @@ enum ata_tf_protocols {
 	ATA_PROT_PIO,		/* PIO data xfer */
 	ATA_PROT_DMA,		/* DMA */
 	ATA_PROT_NCQ,		/* NCQ */
+	ATA_PROT_NCQ_NODATA,	/* NCQ no data */
 	ATAPI_PROT_NODATA,	/* packet command, no data */
 	ATAPI_PROT_PIO,		/* packet command, PIO data xfer*/
 	ATAPI_PROT_DMA,		/* packet command with special DMA sauce */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77833f6..ce05d8d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1054,6 +1054,8 @@ static inline unsigned int ata_prot_flags(u8 prot)
 		return ATA_PROT_FLAG_DMA;
 	case ATA_PROT_NCQ:
 		return ATA_PROT_FLAG_DMA | ATA_PROT_FLAG_NCQ;
+	case ATA_PROT_NCQ_NODATA:
+		return ATA_PROT_FLAG_NCQ;
 	case ATAPI_PROT_NODATA:
 		return ATA_PROT_FLAG_ATAPI;
 	case ATAPI_PROT_PIO:
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 75fff86..2fbbf99 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -126,6 +126,7 @@
 		ata_protocol_name(ATA_PROT_PIO),	\
 		ata_protocol_name(ATA_PROT_DMA),	\
 		ata_protocol_name(ATA_PROT_NCQ),	\
+		ata_protocol_name(ATA_PROT_NCQ_NODATA),	\
 		ata_protocol_name(ATAPI_PROT_NODATA),	\
 		ata_protocol_name(ATAPI_PROT_PIO),	\
 		ata_protocol_name(ATAPI_PROT_DMA))
-- 
2.1.4

