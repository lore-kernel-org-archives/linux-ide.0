From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: use PIO for non-16 byte aligned ATAPI commands
Date: Wed, 27 Jun 2007 02:48:43 +0900
Message-ID: <20070626174843.GS29122@htj.dyndns.org>
References: <20070626174735.GR29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:17084 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbXFZRss (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 13:48:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2349935wah
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 10:48:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070626174735.GR29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com

The IDE driver used DMA for ATAPI commands if READ/WRITE command is
multiple of sector size or sg command is multiple of 16 bytes.  For
libata, READ/WRITE sector alignment is guaranteed by the high level
driver (sr), so we only have to worry about the 16 byte alignment.

This patch makes ata_check_atapi_dma() always request PIO for all data
transfer commands which are not multiple of 16 bytes.

The following reports are related to this problem.

http://bugzilla.kernel.org/show_bug.cgi?id=8605		(confirmed)
http://thread.gmane.org/gmane.linux.kernel/476620	(confirmed)
https://bugzilla.novell.com/show_bug.cgi?id=229260	(probably)

Albert first pointed out the difference between IDE and libata.  Kudos
to him.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>
---
 drivers/ata/libata-core.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4109,6 +4109,7 @@ static void ata_fill_sg(struct ata_queue
 	if (idx)
 		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
+
 /**
  *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
@@ -4126,33 +4127,19 @@ static void ata_fill_sg(struct ata_queue
 int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	int rc = 0; /* Assume ATAPI DMA is OK by default */
 
-	/* some drives can only do ATAPI DMA on read/write */
-	if (unlikely(qc->dev->horkage & ATA_HORKAGE_DMA_RW_ONLY)) {
-		struct scsi_cmnd *cmd = qc->scsicmd;
-		u8 *scsicmd = cmd->cmnd;
-
-		switch (scsicmd[0]) {
-		case READ_10:
-		case WRITE_10:
-		case READ_12:
-		case WRITE_12:
-		case READ_6:
-		case WRITE_6:
-			/* atapi dma maybe ok */
-			break;
-		default:
-			/* turn off atapi dma */
-			return 1;
-		}
-	}
+	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
+	 * few ATAPI devices choke on such DMA requests.
+	 */
+	if (unlikely(qc->nbytes & 15))
+		return 1;
 
 	if (ap->ops->check_atapi_dma)
-		rc = ap->ops->check_atapi_dma(qc);
+		return ap->ops->check_atapi_dma(qc);
 
-	return rc;
+	return 0;
 }
+
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
