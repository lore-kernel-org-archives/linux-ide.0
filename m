From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Fri, 14 May 2004 20:38:51 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A5669B.6080108@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5343.	26.camel@patibmrh9> <1084579362.3271.5.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090502070405060201040901"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264844AbUEOAjG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 20:39:06 -0400
In-Reply-To: <1084579362.3271.5.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502070405060201040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pat LaVarre wrote:
> Results follow.  Much improved now, yes?

Yep, that's definitely a Silicon Image bridge all right :)

Here's a better version of the patch you generated.

Next thing is to handle ATA_PROT_ATAPI_DMA in ata_host_intr...

	Jeff



--------------090502070405060201040901
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.57 vs edited =====
--- 1.57/drivers/scsi/libata-core.c	Thu May 13 22:45:55 2004
+++ edited/drivers/scsi/libata-core.c	Fri May 14 20:35:23 2004
@@ -1168,6 +1168,9 @@
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
+		if (ata_id_use_dmadir(dev))
+			dev->flags |= ATA_DFLAG_DMADIR;
+
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;
 		if (tmp == 1)
===== drivers/scsi/libata-scsi.c 1.29 vs edited =====
--- 1.29/drivers/scsi/libata-scsi.c	Thu May 13 22:39:12 2004
+++ edited/drivers/scsi/libata-scsi.c	Fri May 14 20:36:28 2004
@@ -920,6 +920,9 @@
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
+		if ((qc->dev->flags & ATA_DFLAG_DMADIR) &&
+		    (cmd->sc_data_direction != SCSI_DATA_WRITE))
+			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
 	return 0;
===== include/linux/ata.h 1.5 vs edited =====
--- 1.5/include/linux/ata.h	Mon May 10 21:49:59 2004
+++ edited/include/linux/ata.h	Fri May 14 20:34:17 2004
@@ -84,6 +84,8 @@
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
 	ATA_ABORTED		= (1 << 2),	/* command aborted */
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* ATA command block registers */
 	ATA_REG_DATA		= 0x00,
@@ -203,6 +205,7 @@
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
 #define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
+#define ata_id_use_dmadir(dev)	((dev)->id[62] & (1 << 15))
 #define ata_id_u32(dev,n)	\
 	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
 #define ata_id_u64(dev,n)	\
===== include/linux/libata.h 1.29 vs edited =====
--- 1.29/include/linux/libata.h	Thu May 13 22:45:55 2004
+++ edited/include/linux/libata.h	Fri May 14 20:28:37 2004
@@ -90,6 +90,7 @@
 	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
 	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
 					     * (hopefully) flush? */
+	ATA_DFLAG_DMADIR	= (1 << 4), /* use DMADIR bit in ATAPI */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */

--------------090502070405060201040901--

