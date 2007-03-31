From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] libata: Limit ATAPI DMA to R/W commands only for TORiSAN
 DVD drives
Date: Sat, 31 Mar 2007 16:10:50 +0800
Message-ID: <460E178A.3070903@tw.ibm.com>
References: <460E1586.2000603@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60704 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbXCaIK7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 04:10:59 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2V8Aw5o030837
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 04:10:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V8AwSL160402
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:10:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V8AvAk021208
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:10:58 -0600
In-Reply-To: <460E1586.2000603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>

patch 4/4:

  Limit ATAPI DMA to R/W commands only for TORiSAN DRD-N216 DVD-ROM drives
  (http://bugzilla.kernel.org/show_bug.cgi?id=6710)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
I guess maybe other commands like READ_DVD_STRUCTURE and READ_CD also
work under ATAPI DMA, but not confirmed by Vlad yet. So, allow ATAPI DMA
only for Read/Write here for safty.

Patch against libata-dev tree, for your review, thanks.

diff -Nrup 03_max_sect/drivers/ata/libata-core.c 04_dma_rw_only/drivers/ata/libata-core.c
--- 03_max_sect/drivers/ata/libata-core.c	2007-03-31 14:11:33.000000000 +0800
+++ 04_dma_rw_only/drivers/ata/libata-core.c	2007-03-31 14:27:47.000000000 +0800
@@ -1787,6 +1787,10 @@ int ata_dev_configure(struct ata_device 
 	if (ata_device_blacklisted(dev) & ATA_HORKAGE_MAX_SEC_240)
 		dev->max_sectors = min(ATA_MAX_SECTORS_240, dev->max_sectors);
 
+	/* limit ATAPI DMA to R/W commands only */
+	if (ata_device_blacklisted(dev) & ATA_HORKAGE_DMA_RW_ONLY)
+		dev->horkage |= ATA_HORKAGE_DMA_RW_ONLY;
+
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
@@ -3356,7 +3360,8 @@ static const struct ata_blacklist_entry 
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_240 },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_240 |
+						ATA_HORKAGE_DMA_RW_ONLY },
 
 	/* Devices we expect to fail diagnostics */
 
@@ -3676,6 +3681,26 @@ int ata_check_atapi_dma(struct ata_queue
 	struct ata_port *ap = qc->ap;
 	int rc = 0; /* Assume ATAPI DMA is OK by default */
 
+	/* some drives can only do ATAPI DMA on read/write */
+	if (unlikely(qc->dev->horkage & ATA_HORKAGE_DMA_RW_ONLY)) {
+		struct scsi_cmnd *cmd = qc->scsicmd;
+		u8 *scsicmd = cmd->cmnd;
+
+		switch (scsicmd[0]) {
+		case READ_10:
+		case WRITE_10:
+		case READ_12:
+		case WRITE_12:
+		case READ_6:
+		case WRITE_6:
+			/* atapi dma maybe ok */
+			break;
+		default:
+			/* turn off atapi dma */
+			return 1;
+		}
+	}
+
 	if (ap->ops->check_atapi_dma)
 		rc = ap->ops->check_atapi_dma(qc);
 
diff -Nrup 03_max_sect/include/linux/libata.h 04_dma_rw_only/include/linux/libata.h
--- 03_max_sect/include/linux/libata.h	2007-03-31 14:07:49.000000000 +0800
+++ 04_dma_rw_only/include/linux/libata.h	2007-03-31 14:08:31.000000000 +0800
@@ -312,6 +312,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_240	= (1 << 3),	/* Limit max sects below 256 */
+	ATA_HORKAGE_DMA_RW_ONLY	= (1 << 4),	/* ATAPI DMA for RW only */
 };
 
 enum hsm_task_states {


