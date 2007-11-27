From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata: use PIO for misc ATAPI commands
Date: Wed, 28 Nov 2007 00:13:59 +0900
Message-ID: <11961764413291-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.182]:60821 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450AbXK0POS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:18 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688059roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:17 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

ATAPI devices come with plethora of bugs and many ATA controllers have
trouble dealing with odd byte DMA transfers.  The problem is currently
somewhat masked by not allowing DMA transfers if the transfer size
isn't aligned to 16 bytes plus partial masking in problematic LLDs.

This masking is taken verbatim from IDE and is far from perfection.
There's no fundamental explanation why this should be sufficient and
there are ATAPI devices which don't work with the IDE driver.

In addition, this mixture of PIO and DMA commands reduces test
coverage which is already insufficient considering the crazy number of
ATAPI devices out in the wild.

Also, these misc ATAPI commands usually transfer small amount of data
and are used infrequently.  There isn't much to be gained from using
DMA.  Combined with the fact that another OS which is probably the
only one that most ATAPI device vendors test against uses PIO for
these commands, it's much wiser to use PIO for these commands and
concentrate debugging efforts on getting PIO right for misc commands
and DMA for bulk transfer commands.

Private command type / transfer length filtering in sata_promise,
pata_it821x and pata_pdc2027x are removed as core layer filtering is
more conservative.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c   |   10 +--------
 drivers/ata/libata-eh.c     |   17 ++-------------
 drivers/ata/libata-scsi.c   |   17 ++-------------
 drivers/ata/pata_it821x.c   |    4 ---
 drivers/ata/pata_pdc2027x.c |   44 -------------------------------------------
 drivers/ata/sata_promise.c  |   31 ++++++++---------------------
 include/linux/libata.h      |    1 -
 7 files changed, 16 insertions(+), 108 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b6cbc72..338766e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4651,16 +4651,8 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 		break;
 
 	case ATAPI_MISC:
-		if (horkage & ATAPI_DMA_HORKAGE_MISC)
-			return 1;
-		break;
-	}
-
-	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
-	 * few ATAPI devices choke on such DMA requests.
-	 */
-	if (unlikely(qc->nbytes & 15))
 		return 1;
+	}
 
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3b78fb9..656b06e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1271,7 +1271,6 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 {
 	struct ata_device *dev = qc->dev;
 	unsigned char *sense_buf = qc->scsicmd->sense_buffer;
-	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
@@ -1296,15 +1295,9 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
-		tf.protocol = ATAPI_PROT_DMA;
-		tf.feature |= ATAPI_PKT_DMA;
-	} else {
-		tf.protocol = ATAPI_PROT_PIO;
-		tf.lbam = SCSI_SENSE_BUFFERSIZE;
-		tf.lbah = 0;
-	}
+	tf.protocol = ATAPI_PROT_PIO;
+	tf.lbam = SCSI_SENSE_BUFFERSIZE;
+	tf.lbah = 0;
 
 	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
 				 sense_buf, SCSI_SENSE_BUFFERSIZE, 0);
@@ -1507,10 +1500,6 @@ static void atapi_eh_dma_horkages(struct ata_queued_cmd *qc)
 		type = "READ CD [MSF]";
 		dev->horkage |= ATAPI_DMA_HORKAGE_READ_CD;
 		break;
-	case ATAPI_MISC:
-		type = "MISC";
-		dev->horkage |= ATAPI_DMA_HORKAGE_MISC;
-		break;
 	default:
 		return;
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f07704c..6a580ef 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2322,12 +2322,6 @@ static void atapi_sense_complete(struct ata_queued_cmd *qc)
 	ata_qc_free(qc);
 }
 
-/* is it pointless to prefer PIO for "safety reasons"? */
-static inline int ata_pio_use_silly(struct ata_port *ap)
-{
-	return (ap->flags & ATA_FLAG_PIO_DMA);
-}
-
 static void atapi_request_sense(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -2357,15 +2351,10 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	qc->tf.command = ATA_CMD_PACKET;
+	qc->tf.protocol = ATAPI_PROT_PIO;
+	qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
+	qc->tf.lbah = 0;
 
-	if (ata_pio_use_silly(ap)) {
-		qc->tf.protocol = ATAPI_PROT_DMA;
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	} else {
-		qc->tf.protocol = ATAPI_PROT_PIO;
-		qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
-		qc->tf.lbah = 0;
-	}
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->complete_fn = atapi_sense_complete;
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index ca9aae0..b38d0a9 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -532,10 +532,6 @@ static int it821x_check_atapi_dma(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct it821x_dev *itdev = ap->private_data;
 
-	/* Only use dma for transfers to/from the media. */
-	if (qc->nbytes < 2048)
-		return -EOPNOTSUPP;
-
 	/* No ATAPI DMA in smart mode */
 	if (itdev->smart)
 		return -EOPNOTSUPP;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 2622577..c73c6e2 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -66,7 +66,6 @@ static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *e
 static void pdc2027x_error_handler(struct ata_port *ap);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
-static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
 static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask);
 static int pdc2027x_cable_detect(struct ata_port *ap);
 static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed);
@@ -155,7 +154,6 @@ static struct ata_port_operations pdc2027x_pata100_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -188,7 +186,6 @@ static struct ata_port_operations pdc2027x_pata133_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -506,47 +503,6 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
 }
 
 /**
- *	pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported for this command
- *	@qc: Metadata associated with taskfile to check
- *
- *	LOCKING:
- *	None (inherited from caller).
- *
- *	RETURNS: 0 when ATAPI DMA can be used
- *		 1 otherwise
- */
-static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 *scsicmd = cmd->cmnd;
-	int rc = 1; /* atapi dma off by default */
-
-	/*
-	 * This workaround is from Promise's GPL driver.
-	 * If ATAPI DMA is used for commands not in the
-	 * following white list, say MODE_SENSE and REQUEST_SENSE,
-	 * pdc2027x might hit the irq lost problem.
-	 */
-	switch (scsicmd[0]) {
-	case READ_10:
-	case WRITE_10:
-	case READ_12:
-	case WRITE_12:
-	case READ_6:
-	case WRITE_6:
-	case 0xad: /* READ_DVD_STRUCTURE */
-	case 0xbe: /* READ_CD */
-		/* ATAPI DMA is ok */
-		rc = 0;
-		break;
-	default:
-		;
-	}
-
-	return rc;
-}
-
-/**
  * pdc_read_counter - Read the ctr counter
  * @host: target ATA host
  */
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 2ab20a2..2633efb 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -931,32 +931,19 @@ static void pdc_exec_command_mmio(struct ata_port *ap,
 
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
 {
-	u8 *scsicmd = qc->scsicmd->cmnd;
-	int pio = 1; /* atapi dma off by default */
-
-	/* Whitelist commands that may use DMA. */
-	switch (scsicmd[0]) {
-	case WRITE_12:
-	case WRITE_10:
-	case WRITE_6:
-	case READ_12:
-	case READ_10:
-	case READ_6:
-	case 0xad: /* READ_DVD_STRUCTURE */
-	case 0xbe: /* READ_CD */
-		pio = 0;
-	}
+	const u8 *cdb = qc->cdb;
+
 	/* -45150 (FFFF4FA2) to -1 (FFFFFFFF) shall use PIO mode */
-	if (scsicmd[0] == WRITE_10) {
+	if (cdb[0] == WRITE_10) {
 		unsigned int lba =
-			(scsicmd[2] << 24) |
-			(scsicmd[3] << 16) |
-			(scsicmd[4] << 8) |
-			scsicmd[5];
+			(cdb[2] << 24) |
+			(cdb[3] << 16) |
+			(cdb[4] << 8) |
+			cdb[5];
 		if (lba >= 0xFFFF4FA2)
-			pio = 1;
+			return 1;
 	}
-	return pio;
+	return 0;
 }
 
 static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 51dde95..b1a59a4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -345,7 +345,6 @@ enum {
 	ATAPI_DMA_HORKAGE_WRITE		= (1 << 28), /* PIO for WRITEs */
 	ATAPI_DMA_HORKAGE_READ_CD	= (1 << 29), /* PIO for READ_CDs */
 	ATAPI_DMA_HORKAGE_READ_DVD_STR	= (1 << 30), /* PIO for READ DVD STR */
-	ATAPI_DMA_HORKAGE_MISC		= (1 << 31), /* PIO for MISC commands */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.5.2.4

