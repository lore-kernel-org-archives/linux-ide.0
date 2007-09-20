From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Set transfer sizes properly for ATAPI
Date: Thu, 20 Sep 2007 15:01:44 +0100
Message-ID: <20070920150144.4772e18d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56571 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056AbXITNye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 09:54:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

In theory this isn't needed. In practice it seems to matter now and then
and was also done by the old IDE DMA layer.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-scsi.c linux-2.6.23rc6-mm1/drivers/ata/libata-scsi.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-scsi.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/libata-scsi.c	2007-09-19 21:30:51.368961456 +0100
@@ -2276,8 +2276,8 @@
 		qc->tf.feature |= ATAPI_PKT_DMA;
 	} else {
 		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
+		qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
+		qc->tf.lbah = 0;
 	}
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
@@ -2386,6 +2386,7 @@
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (scmd->sc_data_direction == DMA_NONE);
+	unsigned int nbytes;
 
 	memset(qc->cdb, 0, dev->cdb_len);
 	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
@@ -2400,19 +2401,25 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 	qc->nbytes = scmd->request_bufflen;
-
+
 	/* check whether ATAPI DMA is safe */
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
@@ -2423,6 +2430,9 @@
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
+
+	/* FIXME: We need to translate 0x05 READ_BLOCK_LIMITS to a MODE_SENSE
+	   as ATAPI tape drives don't get this right otherwise */
 	return 0;
 }
 
