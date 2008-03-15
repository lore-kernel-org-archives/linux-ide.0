From: Matthew Wilcox <matthew@wil.cx>
Subject: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 09:37:31 -0600
Message-ID: <20080315153730.GX613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34704 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYCOPhr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 11:37:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This patch adds partial support for the SCSI commands READ_BUFFER and
WRITE_BUFFER.  Because ATA only supports a single 512-byte buffer per
drive, this isn't as useful as it could be, but it might prove interesting
when extended to handle the DOWNLOAD MICROCODE operations.

Comments?

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8f0e8f2..f12403f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1711,6 +1711,117 @@ void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 	args->done(cmd);
 }
 
+/*
+ * This helper is used for three subcommands of READ_BUFFER.  Subcommand 0
+ * wants a header prefixing the data.  Subcommand 3 returns a descriptor
+ * and subcommand 0xb returns a descriptor for the echo buffer.  While these
+ * all have slightly different formats, in practise they all look sufficiently
+ * similar that this common function can be used.
+ */
+static void ata_scsi_fill_buffer_descriptor(struct scsi_cmnd *cmd, int desc)
+{
+	u8 *rbuf;
+	unsigned int buflen;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
+
+	memset(rbuf, 0, buflen);
+	rbuf[0] = desc ? 0xff : 0x0;
+	rbuf[1] = 0x0;
+	rbuf[2] = 0x2;
+	rbuf[3] = 0x0;
+
+	ata_scsi_rbuf_put(cmd, rbuf);
+
+	local_irq_restore(flags);
+}
+
+static int ata_scsi_read_buffer_descriptor(struct scsi_cmnd *cmd)
+{
+	ata_scsi_fill_buffer_descriptor(cmd, cmd->cmnd[1] == 0x3);
+
+	cmd->result = SAM_STAT_GOOD;
+	return 1;
+}
+
+static void ata_scsi_rwbuf_header(struct scsi_cmnd *cmd)
+{
+	struct scatterlist *sg = scsi_sglist(cmd);
+	ata_scsi_fill_buffer_descriptor(cmd, 0);
+
+	/* XXX: fewer than 4 bytes in the page?  Doomed. */
+	sg->offset += 4;
+	sg->length -= 4;
+}
+
+/**
+ * ata_scsi_rwbuf_xlat - Translate READ_BUFFER and WRITE_BUFFER
+ *
+ * SCSI has a very flexible READ_BUFFER and WRITE_BUFFER system.
+ * ATA's READ BUFFER only supports an offset of 0 and length 512.
+ * SCSI also uses WRITE_BUFFER for DOWNLOAD MICROCODE, which is not
+ * yet supported by this function.
+ */
+static unsigned int ata_scsi_rwbuf_xlat(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	const u8 *cdb = scmd->cmnd;
+	struct ata_taskfile *tf = &qc->tf;
+	int offset = 0;
+
+	if (cdb[0] == WRITE_BUFFER) {
+		tf->flags |= ATA_TFLAG_WRITE;
+		tf->command = ATA_CMD_WRITE_BUFFER;
+	} else {
+		tf->command = ATA_CMD_READ_BUFFER;
+	}
+
+	switch (cdb[1]) {
+	case 0x0:	/* Read/write data with header */
+		ata_scsi_rwbuf_header(scmd);
+		offset = 4;
+	case 0x2:	/* Read/write data */
+	case 0xa:	/* Read/write echo buffer */
+		break;
+	case 0x3:	/* Read descriptor */
+	case 0xb:	/* Read echo buffer descriptor */
+		if (cdb[0] == READ_BUFFER)
+			return ata_scsi_read_buffer_descriptor(scmd);
+	case 0x4:
+	case 0x5:
+	case 0x6:
+	case 0x7:
+		/* XXX: We can translate to DOWNLOAD_MICROCODE here */
+
+	default:
+		goto invalid_fld;
+	}
+
+	if ((cdb[2] != 0) || (cdb[3] != 0) || (cdb[4] != 0) || (cdb[5] != 0))
+		goto invalid_fld;
+	if (((cdb[6] << 16) | (cdb[7] << 8) | cdb[8]) != (512 + offset))
+		goto invalid_fld;
+
+	qc->flags |= ATA_QCFLAG_IO;
+	qc->nbytes = 512;
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_PIO;
+	tf->nsect = 0;
+	tf->lbah = 0;
+	tf->lbam = 0;
+	tf->lbal = 0;
+
+	return 0;
+
+invalid_fld:
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	/* "Invalid field in cbd" */
+	return 1;
+}
+
 /**
  *	ATA_SCSI_RBUF_SET - helper to set values in SCSI response buffer
  *	@idx: byte index into SCSI response buffer
@@ -2913,6 +3024,10 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 	case WRITE_16:
 		return ata_scsi_rw_xlat;
 
+	case READ_BUFFER:
+	case WRITE_BUFFER:
+		return ata_scsi_rwbuf_xlat;
+
 	case SYNCHRONIZE_CACHE:
 		if (ata_try_flush_cache(dev))
 			return ata_scsi_flush_xlat;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1c622e2..fc77d6d 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -176,6 +176,8 @@ enum {
 	ATA_CMD_WRITE_MULTI_FUA_EXT = 0xCE,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_SET_MULTI	= 0xC6,
+	ATA_CMD_READ_BUFFER	= 0xE4,
+	ATA_CMD_WRITE_BUFFER	= 0xE8,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
