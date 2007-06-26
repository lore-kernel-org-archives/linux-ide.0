From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: call ata_check_atapi_dma() with qc better prepared
Date: Wed, 27 Jun 2007 02:47:35 +0900
Message-ID: <20070626174735.GR29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:19791 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbXFZRrl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 13:47:41 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1789829nzf
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 10:47:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com

In atapi_xlat(), prepare qc better before calling
ata_check_atapi_dma() such that ata_check_atapi_dma() can use info
from qc.  While at it, reformat weird looking if/else block in the
function.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -2384,11 +2384,6 @@ static unsigned int atapi_xlat(struct at
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (scmd->sc_data_direction == DMA_NONE);
 
-	if (!using_pio)
-		/* Check whether ATAPI DMA is safe */
-		if (ata_check_atapi_dma(qc))
-			using_pio = 1;
-
 	memset(qc->cdb, 0, dev->cdb_len);
 	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
 
@@ -2401,19 +2396,22 @@ static unsigned int atapi_xlat(struct at
 	}
 
 	qc->tf.command = ATA_CMD_PACKET;
+	qc->nbytes = scmd->request_bufflen;
+
+	/* check whether ATAPI DMA is safe */
+	if (!using_pio && ata_check_atapi_dma(qc))
+		using_pio = 1;
 
-	/* no data, or PIO data xfer */
 	if (using_pio || nodata) {
+		/* no data, or PIO data xfer */
 		if (nodata)
 			qc->tf.protocol = ATA_PROT_ATAPI_NODATA;
 		else
 			qc->tf.protocol = ATA_PROT_ATAPI;
 		qc->tf.lbam = (8 * 1024) & 0xff;
 		qc->tf.lbah = (8 * 1024) >> 8;
-	}
-
-	/* DMA data xfer */
-	else {
+	} else {
+		/* DMA data xfer */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
@@ -2422,8 +2420,6 @@ static unsigned int atapi_xlat(struct at
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	qc->nbytes = scmd->request_bufflen;
-
 	return 0;
 }
 
