From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: separate out rw ATA taskfile building into ata_build_tf()
Date: Tue, 14 Nov 2006 22:47:10 +0900
Message-ID: <11635120302199-git-send-email-htejun@gmail.com>
References: <1163512029469-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:62855 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965811AbWKNNrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:47:17 -0500
Received: by wr-out-0506.google.com with SMTP id i22so143730wra
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:47:16 -0800 (PST)
In-Reply-To: <1163512029469-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out rw ATA taskfile building from ata_scsi_rw_xlat() into
ata_build_tf().  This will be used to improve media error handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  133 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/ata/libata-scsi.c |  119 +++++------------------------------------
 drivers/ata/libata.h      |    4 +-
 3 files changed, 144 insertions(+), 112 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9ddc512..1b33f05 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -199,7 +199,8 @@ static const u8 ata_rw_cmds[] = {
 
 /**
  *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
- *	@qc: command to examine and configure
+ *	@tf: command to examine and configure
+ *	@dev: device tf belongs to
  *
  *	Examine the device configuration and tf->flags to calculate
  *	the proper read/write commands and protocol to use.
@@ -207,10 +208,8 @@ static const u8 ata_rw_cmds[] = {
  *	LOCKING:
  *	caller.
  */
-int ata_rwcmd_protocol(struct ata_queued_cmd *qc)
+static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device *dev)
 {
-	struct ata_taskfile *tf = &qc->tf;
-	struct ata_device *dev = qc->dev;
 	u8 cmd;
 
 	int index, fua, lba48, write;
@@ -222,7 +221,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	if (dev->flags & ATA_DFLAG_PIO) {
 		tf->protocol = ATA_PROT_PIO;
 		index = dev->multi_count ? 0 : 8;
-	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
+	} else if (lba48 && (dev->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
 		index = dev->multi_count ? 0 : 8;
@@ -283,6 +282,130 @@ u64 ata_tf_read_block(struct ata_taskfil
 }
 
 /**
+ *	ata_build_tf - Build ATA taskfile for given request
+ *	@tf: Target ATA taskfile
+ *	@dev: ATA device @tf belongs to
+ *	@block: Block address
+ *	@n_block: Number of blocks
+ *	@tf_flags: RW/FUA etc...
+ *	@tag: tag
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	Build ATA taskfile @tf for request described by @block,
+ *	@n_block, @tf_flags and @tag on @dev.
+ *
+ *	RETURNS:
+ *
+ *	0 on success, -ERANGE if the request is too large for @dev,
+ *	-EINVAL if the request is invalid.
+ */
+int ata_build_tf(struct ata_taskfile *tf, struct ata_device *dev,
+		 u64 block, u32 n_block, unsigned int tf_flags,
+		 unsigned int tag)
+{
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->flags |= tf_flags;
+
+	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
+			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
+		/* yay, NCQ */
+		if (!lba_48_ok(block, n_block))
+			return -ERANGE;
+
+		tf->protocol = ATA_PROT_NCQ;
+		tf->flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
+
+		if (tf->flags & ATA_TFLAG_WRITE)
+			tf->command = ATA_CMD_FPDMA_WRITE;
+		else
+			tf->command = ATA_CMD_FPDMA_READ;
+
+		tf->nsect = tag << 3;
+		tf->hob_feature = (n_block >> 8) & 0xff;
+		tf->feature = n_block & 0xff;
+
+		tf->hob_lbah = (block >> 40) & 0xff;
+		tf->hob_lbam = (block >> 32) & 0xff;
+		tf->hob_lbal = (block >> 24) & 0xff;
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device = 1 << 6;
+		if (tf->flags & ATA_TFLAG_FUA)
+			tf->device |= 1 << 7;
+	} else if (dev->flags & ATA_DFLAG_LBA) {
+		tf->flags |= ATA_TFLAG_LBA;
+
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
+				return -ERANGE;
+
+			/* use LBA48 */
+			tf->flags |= ATA_TFLAG_LBA48;
+
+			tf->hob_nsect = (n_block >> 8) & 0xff;
+
+			tf->hob_lbah = (block >> 40) & 0xff;
+			tf->hob_lbam = (block >> 32) & 0xff;
+			tf->hob_lbal = (block >> 24) & 0xff;
+		} else
+			/* request too large even for LBA48 */
+			return -ERANGE;
+
+		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+			return -EINVAL;
+
+		tf->nsect = n_block & 0xff;
+
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device |= ATA_LBA;
+	} else {
+		/* CHS */
+		u32 sect, head, cyl, track;
+
+		/* The request -may- be too large for CHS addressing. */
+		if (!lba_28_ok(block, n_block))
+			return -ERANGE;
+
+		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+			return -EINVAL;
+
+		/* Convert LBA to CHS */
+		track = (u32)block / dev->sectors;
+		cyl   = track / dev->heads;
+		head  = track % dev->heads;
+		sect  = (u32)block % dev->sectors + 1;
+
+		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
+			(u32)block, track, cyl, head, sect);
+
+		/* Check whether the converted CHS can fit.
+		   Cylinder: 0-65535
+		   Head: 0-15
+		   Sector: 1-255*/
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
+			return -ERANGE;
+
+		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
+		tf->lbal = sect;
+		tf->lbam = cyl;
+		tf->lbah = cyl >> 8;
+		tf->device |= head;
+	}
+
+	return 0;
+}
+
+/**
  *	ata_pack_xfermask - Pack pio, mwdma and udma masks into xfer_mask
  *	@pio_mask: pio_mask
  *	@mwdma_mask: mwdma_mask
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9b0d59d..0d1b96a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1266,17 +1266,14 @@ nothing_to_do:
 
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
 {
-	struct ata_taskfile *tf = &qc->tf;
-	struct ata_device *dev = qc->dev;
+	unsigned int tf_flags = 0;
 	u64 block;
 	u32 n_block;
-
-	qc->flags |= ATA_QCFLAG_IO;
-	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	int rc;
 
 	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
 	    scsicmd[0] == WRITE_16)
-		tf->flags |= ATA_TFLAG_WRITE;
+		tf_flags |= ATA_TFLAG_WRITE;
 
 	/* Calculate the SCSI LBA, transfer length and FUA. */
 	switch (scsicmd[0]) {
@@ -1284,7 +1281,7 @@ static unsigned int ata_scsi_rw_xlat(str
 	case WRITE_10:
 		scsi_10_lba_len(scsicmd, &block, &n_block);
 		if (unlikely(scsicmd[1] & (1 << 3)))
-			tf->flags |= ATA_TFLAG_FUA;
+			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
@@ -1300,7 +1297,7 @@ static unsigned int ata_scsi_rw_xlat(str
 	case WRITE_16:
 		scsi_16_lba_len(scsicmd, &block, &n_block);
 		if (unlikely(scsicmd[1] & (1 << 3)))
-			tf->flags |= ATA_TFLAG_FUA;
+			tf_flags |= ATA_TFLAG_FUA;
 		break;
 	default:
 		DPRINTK("no-byte command\n");
@@ -1318,106 +1315,16 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		goto nothing_to_do;
 
-	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			   ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
-		/* yay, NCQ */
-		if (!lba_48_ok(block, n_block))
-			goto out_of_range;
-
-		tf->protocol = ATA_PROT_NCQ;
-		tf->flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
-
-		if (tf->flags & ATA_TFLAG_WRITE)
-			tf->command = ATA_CMD_FPDMA_WRITE;
-		else
-			tf->command = ATA_CMD_FPDMA_READ;
-
-		qc->nsect = n_block;
-
-		tf->nsect = qc->tag << 3;
-		tf->hob_feature = (n_block >> 8) & 0xff;
-		tf->feature = n_block & 0xff;
-
-		tf->hob_lbah = (block >> 40) & 0xff;
-		tf->hob_lbam = (block >> 32) & 0xff;
-		tf->hob_lbal = (block >> 24) & 0xff;
-		tf->lbah = (block >> 16) & 0xff;
-		tf->lbam = (block >> 8) & 0xff;
-		tf->lbal = block & 0xff;
-
-		tf->device = 1 << 6;
-		if (tf->flags & ATA_TFLAG_FUA)
-			tf->device |= 1 << 7;
-	} else if (dev->flags & ATA_DFLAG_LBA) {
-		tf->flags |= ATA_TFLAG_LBA;
-
-		if (lba_28_ok(block, n_block)) {
-			/* use LBA28 */
-			tf->device |= (block >> 24) & 0xf;
-		} else if (lba_48_ok(block, n_block)) {
-			if (!(dev->flags & ATA_DFLAG_LBA48))
-				goto out_of_range;
-
-			/* use LBA48 */
-			tf->flags |= ATA_TFLAG_LBA48;
-
-			tf->hob_nsect = (n_block >> 8) & 0xff;
-
-			tf->hob_lbah = (block >> 40) & 0xff;
-			tf->hob_lbam = (block >> 32) & 0xff;
-			tf->hob_lbal = (block >> 24) & 0xff;
-		} else
-			/* request too large even for LBA48 */
-			goto out_of_range;
-
-		if (unlikely(ata_rwcmd_protocol(qc) < 0))
-			goto invalid_fld;
-
-		qc->nsect = n_block;
-		tf->nsect = n_block & 0xff;
-
-		tf->lbah = (block >> 16) & 0xff;
-		tf->lbam = (block >> 8) & 0xff;
-		tf->lbal = block & 0xff;
-
-		tf->device |= ATA_LBA;
-	} else {
-		/* CHS */
-		u32 sect, head, cyl, track;
-
-		/* The request -may- be too large for CHS addressing. */
-		if (!lba_28_ok(block, n_block))
-			goto out_of_range;
-
-		if (unlikely(ata_rwcmd_protocol(qc) < 0))
-			goto invalid_fld;
-
-		/* Convert LBA to CHS */
-		track = (u32)block / dev->sectors;
-		cyl   = track / dev->heads;
-		head  = track % dev->heads;
-		sect  = (u32)block % dev->sectors + 1;
-
-		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
-			(u32)block, track, cyl, head, sect);
-
-		/* Check whether the converted CHS can fit.
-		   Cylinder: 0-65535
-		   Head: 0-15
-		   Sector: 1-255*/
-		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
-			goto out_of_range;
-
-		qc->nsect = n_block;
-		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
-		tf->lbal = sect;
-		tf->lbam = cyl;
-		tf->lbah = cyl >> 8;
-		tf->device |= head;
-	}
+	qc->flags |= ATA_QCFLAG_IO;
+	qc->nsect = n_block;
 
-	return 0;
+	rc = ata_build_tf(&qc->tf, qc->dev, block, n_block, tf_flags, qc->tag);
+	if (likely(rc == 0))
+		return 0;
 
+	if (rc == -ERANGE)
+		goto out_of_range;
+	/* treat all other errors as -EINVAL, fall through */
 invalid_fld:
 	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c82318b..d4791e7 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -44,7 +44,9 @@ extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
-extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern int ata_build_tf(struct ata_taskfile *tf, struct ata_device *dev,
+			u64 block, u32 n_block, unsigned int tf_flags,
+			unsigned int tag);
 extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
-- 
1.4.3.3


