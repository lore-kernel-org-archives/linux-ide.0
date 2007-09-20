From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Set transfer sizes properly for ATAPI
Date: Thu, 20 Sep 2007 16:47:16 -0400
Message-ID: <46F2DC54.8040908@garzik.org>
References: <20070920150144.4772e18d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080701020904020600060707"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38211 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbXITUrS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 16:47:18 -0400
In-Reply-To: <20070920150144.4772e18d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701020904020600060707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> In theory this isn't needed. In practice it seems to matter now and then
> and was also done by the old IDE DMA layer.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied a modified version (attached)


--------------080701020904020600060707
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 8dcab000d7a3b114a3434129d1d6437263835c87
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 20 16:46:42 2007 -0400

    [libata] Always set ATAPI TF lbam/lbah, regardless of PIO or DMA
    
    A slightly modified version of Alan Cox's change:
      libata: Set transfer sizes properly for ATAPI
    
      In theory this isn't needed. In practice it seems to matter now and then
      and was also done by the old IDE DMA layer.
    
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/libata-scsi.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

8dcab000d7a3b114a3434129d1d6437263835c87
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f0f586b..8eac137 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2273,10 +2273,10 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 		qc->tf.feature |= ATAPI_PKT_DMA;
 	} else {
 		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
 	}
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+	qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
+	qc->tf.lbah = 0;
 
 	qc->complete_fn = atapi_sense_complete;
 
@@ -2383,6 +2383,7 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (scmd->sc_data_direction == DMA_NONE);
+	unsigned int nbytes;
 
 	memset(qc->cdb, 0, dev->cdb_len);
 	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
@@ -2402,14 +2403,20 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	if (!using_pio && ata_check_atapi_dma(qc))
 		using_pio = 1;
 
+	/* Some controller variants snoop this value for Packet transfers
+	   to do state machine and FIFO management. Thus we want to set it
+	   properly, even for DMA where it is effectively meaningless */
+
+	nbytes = qc->nbytes & 0xffff;
+	qc->tf.lbam = (nbytes & 0xff);
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

--------------080701020904020600060707--
