From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata: implement ATAPI per-command-type DMA horkages
Date: Wed, 28 Nov 2007 00:13:58 +0900
Message-ID: <11961764412253-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:54869 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468AbXK0POS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:18 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688062roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:17 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

ATAPI DMA is filled with mines.  Sector aligned READ transfers usually
work but many other commands transfer non-sector aligned or variable
number of bytes, and there are devices and controllers which have
problems dealing with such non-aligned DMA transactions.

This patch implement ATAPI per-command-type DMA horkages and EH logic
to set those quickly.  This way, failures localized to certain command
type don't affect other operations (most importantly READs) and
working configuration is found quickly such that the device can be
used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   21 +++++++++++++++++++++
 drivers/ata/libata-eh.c   |   35 +++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    5 +++++
 3 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a7789d5..b6cbc72 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4634,6 +4634,27 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
 int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	unsigned int horkage = qc->dev->horkage;
+
+	switch (atapi_cmd_type(qc->cdb[0])) {
+	case ATAPI_READ:
+		break;
+
+	case ATAPI_WRITE:
+		if (horkage & ATAPI_DMA_HORKAGE_WRITE)
+			return 1;
+		break;
+
+	case ATAPI_READ_CD:
+		if (horkage & ATAPI_DMA_HORKAGE_READ_CD)
+			return 1;
+		break;
+
+	case ATAPI_MISC:
+		if (horkage & ATAPI_DMA_HORKAGE_MISC)
+			return 1;
+		break;
+	}
 
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index baa7f4f..3b78fb9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1489,6 +1489,38 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	return action;
 }
 
+static void atapi_eh_dma_horkages(struct ata_queued_cmd *qc)
+{
+	struct ata_device *dev = qc->dev;
+	const char *type;
+
+	if (!ata_is_atapi(qc->tf.protocol) || !ata_is_dma(qc->tf.protocol) ||
+	    !(qc->err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT)))
+		return;
+
+	switch (atapi_cmd_type(qc->cdb[0])) {
+	case ATAPI_WRITE:
+		type = "WRITE";
+		dev->horkage |= ATAPI_DMA_HORKAGE_WRITE;
+		break;
+	case ATAPI_READ_CD:
+		type = "READ CD [MSF]";
+		dev->horkage |= ATAPI_DMA_HORKAGE_READ_CD;
+		break;
+	case ATAPI_MISC:
+		type = "MISC";
+		dev->horkage |= ATAPI_DMA_HORKAGE_MISC;
+		break;
+	default:
+		return;
+	}
+
+	ata_dev_printk(dev, KERN_WARNING, "ATAPI DMA for %s disabled (0x%x). \n"
+		"         If this continues to happen, please report to\n"
+		"         linux-ide@vger.kernel.org\n",
+		       type, dev->horkage);
+}
+
 static int ata_eh_categorize_error(unsigned int eflags, unsigned int err_mask,
 				   int *xfer_ok)
 {
@@ -1809,6 +1841,9 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
 			eflags |= ATA_EFLAG_IS_IO;
+
+		/* handle ATAPI DMA horkages */
+		atapi_eh_dma_horkages(qc);
 	}
 
 	/* enforce default EH actions */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 02ab12b..51dde95 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -342,6 +342,11 @@ enum {
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
 
+	ATAPI_DMA_HORKAGE_WRITE		= (1 << 28), /* PIO for WRITEs */
+	ATAPI_DMA_HORKAGE_READ_CD	= (1 << 29), /* PIO for READ_CDs */
+	ATAPI_DMA_HORKAGE_READ_DVD_STR	= (1 << 30), /* PIO for READ DVD STR */
+	ATAPI_DMA_HORKAGE_MISC		= (1 << 31), /* PIO for MISC commands */
+
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
 	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
-- 
1.5.2.4

