From: akpm@linux-foundation.org
Subject: [patch 09/10] libata_scsi: Fix transfer lengths
Date: Tue, 02 Oct 2007 13:53:04 -0700
Message-ID: <200710022053.l92Kr4Wg021703@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52277 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901AbXJBUx3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

This should get into the base tree very soon anyway but it fixes a ton of
devices so it would be nice to have in -mm so I can get people to test -mm not
"-mm + a bit" when reporting ATAPI problems.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-scsi.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff -puN drivers/ata/libata-scsi.c~libata_scsi-fix-transfer-lengths drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c~libata_scsi-fix-transfer-lengths
+++ a/drivers/ata/libata-scsi.c
@@ -2336,8 +2336,8 @@ static void atapi_request_sense(struct a
 		qc->tf.feature |= ATAPI_PKT_DMA;
 	} else {
 		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
+		qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
+		qc->tf.lbah = 0;
 	}
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
@@ -2446,6 +2446,7 @@ static unsigned int atapi_xlat(struct at
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (scmd->sc_data_direction == DMA_NONE);
+	unsigned int nbytes;
 
 	memset(qc->cdb, 0, dev->cdb_len);
 	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
@@ -2465,14 +2466,20 @@ static unsigned int atapi_xlat(struct at
 	if (!using_pio && ata_check_atapi_dma(qc))
 		using_pio = 1;
 
+	/* Some controller variants snoop this value for Packet transfers
+	   to do state machine and FIFO management. Thus we want to set it
+	   properly, and for DMA where it is effectively meaningless */
+	nbytes = min(qc->nbytes, (unsigned int)63 * 1024);
+
+	qc->tf.lbam = (nbytes & 0xFF);
+	qc->tf.lbah = (nbytes >> 8);
+
 	if (using_pio || nodata) {
 		/* no data, or PIO data xfer */
 		if (nodata)
 			qc->tf.protocol = ATA_PROT_ATAPI_NODATA;
 		else
 			qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
 	} else {
 		/* DMA data xfer */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
@@ -2483,6 +2490,9 @@ static unsigned int atapi_xlat(struct at
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
+
+	/* FIXME: We need to translate 0x05 READ_BLOCK_LIMITS to a MODE_SENSE
+	   as ATAPI tape drives don't get this right otherwise */
 	return 0;
 }
 
_
