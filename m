From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata DMADIR support
Date: Sat, 15 May 2004 17:46:01 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A68F99.1000006@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060506070408000801040707"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264746AbUEOVqN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 17:46:13 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BP6yy-0004Ww-Lt
	for linux-ide@vger.kernel.org; Sat, 15 May 2004 22:46:13 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060506070408000801040707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch goes by the specification -- which means it apparently 
doesn't work with at least one bridge.  So modify this patch as necessary.

Until a definitive solution is found, DMADIR will remain a "branch" off 
the main work.



--------------060506070408000801040707
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Sat May 15 17:44:43 2004
+++ b/drivers/scsi/libata-core.c	Sat May 15 17:44:43 2004
@@ -1167,6 +1167,9 @@
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
+		if (ata_id_use_dmadir(dev))
+			dev->flags |= ATA_DFLAG_DMADIR;
+
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;
 		if (tmp == 1)
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Sat May 15 17:44:43 2004
+++ b/drivers/scsi/libata-scsi.c	Sat May 15 17:44:43 2004
@@ -920,6 +920,9 @@
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
+		if ((qc->dev->flags & ATA_DFLAG_DMADIR) &&
+		    (cmd->sc_data_direction != SCSI_DATA_WRITE))
+			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
 	return 0;
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	Sat May 15 17:44:43 2004
+++ b/include/linux/ata.h	Sat May 15 17:44:43 2004
@@ -134,6 +134,8 @@
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,
@@ -203,6 +205,7 @@
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
 #define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
+#define ata_id_use_dmadir(dev)	((dev)->id[62] & (1 << 15))
 #define ata_id_u32(dev,n)	\
 	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
 #define ata_id_u64(dev,n)	\
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Sat May 15 17:44:43 2004
+++ b/include/linux/libata.h	Sat May 15 17:44:43 2004
@@ -90,6 +90,7 @@
 	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
 	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
 					     * (hopefully) flush? */
+	ATA_DFLAG_DMADIR	= (1 << 4), /* use DMADIR bit in ATAPI */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */

--------------060506070408000801040707--

