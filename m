From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata: turn on the ATAPI DMA DIR support per word 62
Date: Fri, 07 Apr 2006 14:39:30 +0800
Message-ID: <44360922.8050801@tw.ibm.com>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:25223 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932315AbWDGGjo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Apr 2006 02:39:44 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k376dain030982
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 02:39:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k376aETA258126
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 00:36:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k376dZ32004324
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 00:39:36 -0600
In-Reply-To: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Turn on the ATAPI DMA DIR support if word 62 indicates it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
ATAPI DMA DIR follow-up patch to turn on the DMA_DIR support automatically
by checking identify device word 62. (Thanks for Jeff and Tejun's pointer.)

According to Jonathan's test result, SiI 3611 (the current known bridge that
requires the ATAPI DMA DIR support) doesn't implement word 62. So, the
atapi_dmadir parameter is preserved to enable the DMA DIR support manually as
work around.

Patch against upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2).
For your review, thanks.

--- upstream0/include/linux/ata.h	2006-04-06 16:07:36.000000000 +0800
+++ upstream1/include/linux/ata.h	2006-04-06 16:50:54.000000000 +0800
@@ -264,6 +264,7 @@ struct ata_taskfile {
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_dmadir_needed(id) ((id)[62] & (1 << 15))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
--- upstream0/include/linux/libata.h	2006-04-06 16:07:37.000000000 +0800
+++ upstream1/include/linux/libata.h	2006-04-06 16:53:35.000000000 +0800
@@ -121,6 +121,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_DMADIR	= (1 << 2), /* device requires ATAPI DMADIR */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
--- upstream0/drivers/scsi/libata-scsi.c	2006-04-06 16:07:32.000000000 +0800
+++ upstream1/drivers/scsi/libata-scsi.c	2006-04-07 13:54:28.000000000 +0800
@@ -2163,9 +2163,12 @@ static unsigned int atapi_xlat(struct at
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (cmd->sc_data_direction != DMA_TO_DEVICE))
-			/* some SATA bridges need us to indicate data xfer direction */
-			qc->tf.feature |= ATAPI_DMADIR;
+		if ((dev->flags & ATA_DFLAG_DMADIR) || atapi_dmadir)
+			/* some SATA bridges need us to indicate
+			 * data xfer direction
+			 */
+			if (cmd->sc_data_direction != DMA_TO_DEVICE)
+				qc->tf.feature |= ATAPI_DMADIR;
 	}
 
 	qc->nbytes = cmd->bufflen;
--- upstream0/drivers/scsi/libata-core.c	2006-04-06 16:07:32.000000000 +0800
+++ upstream1/drivers/scsi/libata-core.c	2006-04-07 13:59:01.000000000 +0800
@@ -78,7 +78,7 @@ MODULE_PARM_DESC(atapi_enabled, "Enable 
 
 int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
-MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
+MODULE_PARM_DESC(atapi_dmadir, "Manually enable ATAPI DMADIR bridge support (0=off, 1=on)");
 
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
@@ -1322,6 +1322,9 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		if (ata_id_dmadir_needed(id))
+			dev->flags |= ATA_DFLAG_DMADIR;
+
 		/* print device info to dmesg */
 		if (print_info)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",


