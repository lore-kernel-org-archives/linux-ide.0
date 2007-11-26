From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH RFC] sata_promise: make pdc_atapi_pkt() use values from
	qc->tf
Date: Mon, 26 Nov 2007 20:34:38 +0900
Message-ID: <20071126113438.GB9232@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:5185 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbXKZLez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 06:34:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so491175rvb
        for <linux-ide@vger.kernel.org>; Mon, 26 Nov 2007 03:34:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikpe@it.uu.se, linux-ide@vger.kernel.org

Make pdc_atapi_pkt() use values from qc->tf instead of creating its
own.  This is to ease future ATAPI handling changes.

DONT APPLY YET
---
Mikael, would this work?  Values other than lbam and lbah remain the
same.  Does sata_promise have strict requirements for lbam and lbah?

Thanks.

 drivers/ata/sata_promise.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

Index: work/drivers/ata/sata_promise.c
===================================================================
--- work.orig/drivers/ata/sata_promise.c
+++ work/drivers/ata/sata_promise.c
@@ -450,7 +450,7 @@ static void pdc_atapi_pkt(struct ata_que
 	struct pdc_port_priv *pp = ap->private_data;
 	u8 *buf = pp->pkt;
 	u32 *buf32 = (u32 *) buf;
-	unsigned int dev_sel, feature, nbytes;
+	unsigned int dev_sel, feature;
 
 	/* set control bits (byte 0), zero delay seq id (byte 3),
 	 * and seq id (byte 2)
@@ -473,45 +473,37 @@ static void pdc_atapi_pkt(struct ata_que
 	buf32[2] = 0;				/* no next-packet */
 
 	/* select drive */
-	if (sata_scr_valid(&ap->link)) {
+	if (sata_scr_valid(&ap->link))
 		dev_sel = PDC_DEVICE_SATA;
-	} else {
-		dev_sel = ATA_DEVICE_OBS;
-		if (qc->dev->devno != 0)
-			dev_sel |= ATA_DEV1;
-	}
+	else
+		dev_sel = qc->tf.device;
+
 	buf[12] = (1 << 5) | ATA_REG_DEVICE;
 	buf[13] = dev_sel;
 	buf[14] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_CLEAR_BSY;
 	buf[15] = dev_sel; /* once more, waiting for BSY to clear */
 
 	buf[16] = (1 << 5) | ATA_REG_NSECT;
-	buf[17] = 0x00;
+	buf[17] = qc->tf.nsect;
 	buf[18] = (1 << 5) | ATA_REG_LBAL;
-	buf[19] = 0x00;
+	buf[19] = qc->tf.lbal;
 
 	/* set feature and byte counter registers */
-	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
+	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA)
 		feature = PDC_FEATURE_ATAPI_PIO;
-		/* set byte counter register to real transfer byte count */
-		nbytes = qc->nbytes;
-		if (nbytes > 0xffff)
-			nbytes = 0xffff;
-	} else {
+	else
 		feature = PDC_FEATURE_ATAPI_DMA;
-		/* set byte counter register to 0 */
-		nbytes = 0;
-	}
+
 	buf[20] = (1 << 5) | ATA_REG_FEATURE;
 	buf[21] = feature;
 	buf[22] = (1 << 5) | ATA_REG_BYTEL;
-	buf[23] = nbytes & 0xFF;
+	buf[23] = qc->tf.lbam;
 	buf[24] = (1 << 5) | ATA_REG_BYTEH;
-	buf[25] = (nbytes >> 8) & 0xFF;
+	buf[25] = qc->tf.lbah;
 
 	/* send ATAPI packet command 0xA0 */
 	buf[26] = (1 << 5) | ATA_REG_CMD;
-	buf[27] = ATA_CMD_PACKET;
+	buf[27] = qc->tf.command;
 
 	/* select drive and check DRQ */
 	buf[28] = (1 << 5) | ATA_REG_DEVICE | PDC_PKT_WAIT_DRDY;

