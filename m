From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata: turn on the ATAPI DMADIR support per word 62
 (revised)
Date: Fri, 07 Apr 2006 18:46:52 +0800
Message-ID: <4436431C.8070800@tw.ibm.com>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com> <44360B05.6050509@garzik.org> <44363D2E.7010700@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:32923 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932412AbWDGKrK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Apr 2006 06:47:10 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k37Al5vo006425
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 06:47:05 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k37AoJlo184362
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 04:50:19 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k37Al4Op024955
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 04:47:04 -0600
In-Reply-To: <44363D2E.7010700@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Turn on the ATAPI DMADIR support if word 62 indicates it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
(Revised to add mwdma/udma mask of word 62 per Jeff's comments.
Need more testing once I get the SiI 3811, etc.)

ATAPI DMADIR follow-up patch to turn on the DMADIR support automatically
by checking identify device word 62. (Thanks for Jeff and Tejun's pointer.)

According to Jonathan's test result, SiI 3611 (the current known bridge that
requires the ATAPI DMADIR support) doesn't implement word 62. So, the
atapi_dmadir parameter is preserved to enable the DMA DIR support manually as
work around.

Patch against upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2).
For your review, thanks.

--- upstream0/include/linux/ata.h	2006-04-06 16:07:36.000000000 +0800
+++ upstream1/include/linux/ata.h	2006-04-07 17:52:24.000000000 +0800
@@ -47,6 +47,7 @@ enum {
 	ATA_ID_PROD_OFS		= 27,
 	ATA_ID_OLD_PIO_MODES	= 51,
 	ATA_ID_FIELD_VALID	= 53,
+	ATA_ID_DMADIR		= 62,
 	ATA_ID_MWDMA_MODES	= 63,
 	ATA_ID_PIO_MODES	= 64,
 	ATA_ID_EIDE_DMA_MIN	= 65,
@@ -264,6 +265,7 @@ struct ata_taskfile {
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
+#define ata_id_dmadir_needed(id) ((id)[62] & (1 << 15))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
--- upstream0/include/linux/libata.h	2006-04-06 16:07:37.000000000 +0800
+++ upstream1/include/linux/libata.h	2006-04-07 17:53:19.000000000 +0800
@@ -121,6 +121,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_DMADIR	= (1 << 2), /* device requires ATAPI DMADIR */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
--- upstream0/drivers/scsi/libata-scsi.c	2006-04-06 16:07:32.000000000 +0800
+++ upstream1/drivers/scsi/libata-scsi.c	2006-04-07 17:54:06.000000000 +0800
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
+++ upstream1/drivers/scsi/libata-core.c	2006-04-07 18:35:38.000000000 +0800
@@ -78,7 +78,7 @@ MODULE_PARM_DESC(atapi_enabled, "Enable 
 
 int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
-MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
+MODULE_PARM_DESC(atapi_dmadir, "Manually enable ATAPI DMADIR bridge support (0=off, 1=on)");
 
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
@@ -831,6 +831,7 @@ static inline void ata_dump_id(const u16
 /**
  *	ata_id_xfermask - Compute xfermask from the given IDENTIFY data
  *	@id: IDENTIFY data to compute xfer mask from
+ *	@class: class of attached device
  *
  *	Compute the xfermask for this device. This is not as trivial
  *	as it seems if we must consider early devices correctly.
@@ -843,7 +844,7 @@ static inline void ata_dump_id(const u16
  *	RETURNS:
  *	Computed xfermask
  */
-static unsigned int ata_id_xfermask(const u16 *id)
+static unsigned int ata_id_xfermask(const u16 *id, unsigned int class)
 {
 	unsigned int pio_mask, mwdma_mask, udma_mask;
 
@@ -873,6 +874,23 @@ static unsigned int ata_id_xfermask(cons
 	if (id[ATA_ID_FIELD_VALID] & (1 << 2))
 		udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
 
+	if (class == ATA_DEV_ATAPI && ata_id_dmadir_needed(id)) {
+		/* To prevent the pre ATA-7 host software (which is
+		 * not aware of the DMADIR word) from using ATAPI DMA
+		 * and causing trouble, the bridge mangles id[49],
+		 * id[63] and id[88] to report no DMA support.
+		 * 
+		 * We turn on DMA here if word 62 indicates it.
+		 * (Per ATA-7, DMADIR is only used for S-ATAPI
+		 * devices, therefore bits 0-10 are set to 1.
+		 * Anyway, we just use these bits as is.)
+		 */
+		WARN_ON(mwdma_mask || udma_mask);
+
+		mwdma_mask = (id[ATA_ID_DMADIR] >> 7) & 0x07;
+		udma_mask = id[ATA_ID_DMADIR] & 0x7f;
+	}
+
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
 
@@ -1256,7 +1274,7 @@ static int ata_dev_configure(struct ata_
 	 */
 
 	/* find max transfer mode; for printk only */
-	xfer_mask = ata_id_xfermask(id);
+	xfer_mask = ata_id_xfermask(id, dev->class);
 
 	ata_dump_id(id);
 
@@ -1322,6 +1340,9 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		if (ata_id_dmadir_needed(id))
+			dev->flags |= ATA_DFLAG_DMADIR;
+
 		/* print device info to dmesg */
 		if (print_info)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
@@ -2941,7 +2962,7 @@ static void ata_dev_xfermask(struct ata_
 
 		xfer_mask &= ata_pack_xfermask(d->pio_mask,
 					       d->mwdma_mask, d->udma_mask);
-		xfer_mask &= ata_id_xfermask(d->id);
+		xfer_mask &= ata_id_xfermask(d->id, d->class);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	}

