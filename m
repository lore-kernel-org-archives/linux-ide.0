From: Andy Warner <andyw@pobox.com>
Subject: T10/04-262 ATA pass thru - another patch.
Date: Tue, 5 Oct 2004 18:20:49 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041005182049.E13871@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:18893 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266477AbUJEXWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 19:22:51 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, John Linville <linville@redhat.com>, linville@tuxdriver.com, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached are two patchfiles, which implement the following
features of libata ATA pass-thru:

 o check condition processing
 o 12-byte CDB handling

patch.041005 can be applied to vanilla libata-2.6 trees
patch-dev.041005 can be applied to libata-dev-2.6 trees

Questions/problems -> me.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.041005"

===== drivers/scsi/libata-core.c 1.100 vs edited =====
--- 1.100/drivers/scsi/libata-core.c	2004-09-16 01:45:15 -05:00
+++ edited/drivers/scsi/libata-core.c	2004-10-05 16:40:35 -05:00
@@ -321,10 +321,10 @@
 	tf->lbam = inb(ioaddr->lbam_addr);
 	tf->lbah = inb(ioaddr->lbah_addr);
 	tf->device = inb(ioaddr->device_addr);
+	tf->feature = inb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = inb(ioaddr->error_addr);
 		tf->hob_nsect = inb(ioaddr->nsect_addr);
 		tf->hob_lbal = inb(ioaddr->lbal_addr);
 		tf->hob_lbam = inb(ioaddr->lbam_addr);
@@ -353,10 +353,10 @@
 	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
 	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
 	tf->device = readb((void __iomem *)ioaddr->device_addr);
+	tf->feature = readb((void __iomem *)ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
 		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
 		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
 		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
@@ -1946,7 +1946,7 @@
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
 	sg_dma_len(sg) = buflen;
 
-	WARN_ON(buflen > PAGE_SIZE);
+//    WARN_ON(buflen > PAGE_SIZE);
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
===== drivers/scsi/libata-scsi.c 1.52 vs edited =====
--- 1.52/drivers/scsi/libata-scsi.c	2004-08-27 15:05:05 -05:00
+++ edited/drivers/scsi/libata-scsi.c	2004-10-05 16:41:26 -05:00
@@ -315,6 +315,85 @@
 	}
 }
 
+/*
+ *	ata_pass_thru_cc - Generate check condition sense block.
+ *	@qc: Command that completed.
+ *
+ *	Regardless of whether the command errored or not, return
+ *	a sense block. Copy all controller registers into
+ *	the sense block. Clear sense key, ASC & ASCQ if
+ *	there is no error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8 ;
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq. We will overwrite some
+	 * (many) of the fields later.
+	 *
+	 * TODO: reorganise better, by splitting ata_to_sense_error()
+	 */
+	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc, drv_stat) ;
+	} else {
+		sb[3] = sb[2] = sb[1] = 0x00 ;
+	}
+
+	/*
+	 * Sense data is current and format is
+	 * descriptor.
+	 */
+	sb[0] = 0x72 ;
+
+	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+
+	/*
+	 * Set length of additional sense data.
+	 * Since we only populate descriptor 0, the total
+	 * length is the same (fixed) length as descriptor 0.
+	 */
+	desc[1] = sb[7] = 14 ;
+
+	/*
+	 * Read the controller registers.
+	 */
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Copy registers into sense buffer.
+	 */
+	desc[2] = 0x00 ;
+	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
+	desc[5] = tf->nsect ;
+	desc[7] = tf->lbal ;
+	desc[9] = tf->lbam ;
+	desc[11] = tf->lbah ;
+	desc[12] = tf->device ;
+	desc[13] = drv_stat ;
+
+	/*
+	 * Fill in Extend bit, and the high order bytes
+	 * if applicable.
+	 */
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		desc[2] |= 0x01 ;
+		desc[4] = tf->hob_nsect ;
+		desc[6] = tf->hob_lbal ;
+		desc[8] = tf->hob_lbam ;
+		desc[10] = tf->hob_lbah ;
+	}
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -623,10 +702,22 @@
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
-	else
-		cmd->result = SAM_STAT_GOOD;
+	/*
+	 * If this was a pass-thru command, and the user requested
+	 * a check condition return including register values.
+	 * Note that check condition is generated, and the ATA
+	 * register values are returned, whether the command completed
+	 * successfully or not. If there was no error, SK, ASC and
+	 * ASCQ will all be zero.
+	 */
+	if ((cmd->cmnd[0] == ATA_16) && (cmd->cmnd[2] & 0x20)) {
+		ata_pass_thru_cc(qc, drv_stat) ;
+	} else {
+		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+			ata_to_sense_error(qc, drv_stat);
+		else
+			cmd->result = SAM_STAT_GOOD;
+	}
 
 	qc->scsidone(cmd);
 
@@ -1368,6 +1459,135 @@
 	return dev;
 }
 
+/*
+ *	ata_scsi_map_proto - Map pass-thru protocol value to taskfile value.
+ *	@byte1: Byte 1 from pass-thru CDB.
+ *
+ *	RETURNS:
+ *	ATA_PROT_UNKNOWN if mapping failed/unimplemented, protocol otherwise.
+ */
+static u8
+ata_scsi_map_proto(u8 byte1)
+{
+	switch((byte1 & 0x1e) >> 1) {
+		case 3:		/* Non-data */
+			return ATA_PROT_NODATA;
+
+		case 6:		/* DMA */
+			return ATA_PROT_DMA;
+
+		case 4:		/* PIO Data-in */
+		case 5:		/* PIO Data-out */
+			if (byte1 & 0xe0) {
+				return ATA_PROT_PIO_MULT;
+			}
+			return ATA_PROT_PIO;
+
+		case 10:	/* Device Reset */
+		case 0:		/* Hard Reset */
+		case 1:		/* SRST */
+		case 2:		/* Bus Idle */
+		case 7:		/* Packet */
+		case 8:		/* DMA Queued */
+		case 9:		/* Device Diagnostic */
+		case 11:	/* UDMA Data-in */
+		case 12:	/* UDMA Data-Out */
+		case 13:	/* FPDMA */
+		default:	/* Reserved */
+			break;
+	}
+
+	return ATA_PROT_UNKNOWN;
+}
+
+/**
+ *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
+ *	@qc: command structure to be initialized
+ *	@cmd: SCSI command to convert
+ *
+ *	Handles either 12 or 16-byte versions of the CDB.
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on failure.
+ */
+static unsigned int
+ata_scsi_pass_thru(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &(qc->tf);
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN) {
+		return 1;
+	}
+
+	/*
+	 * 12 and 16 byte CDBs use different offsets to
+	 * provide the various register values.
+	 */
+	if (scsicmd[0] == ATA_16) {
+		/*
+		 * 16-byte CDB - may contain extended commands.
+		 *
+		 * If that is the case, copy the upper byte register values.
+		 */
+		if (scsicmd[1] & 0x01) {
+			tf->hob_feature = scsicmd[3];
+			tf->hob_nsect = scsicmd[5];
+			tf->hob_lbal = scsicmd[7];
+			tf->hob_lbam = scsicmd[9];
+			tf->hob_lbah = scsicmd[11];
+			tf->flags |= ATA_TFLAG_LBA48 ;
+		} else {
+			tf->flags &= ~ATA_TFLAG_LBA48 ;
+		}
+
+		/*
+		 * Always copy low byte, device and command registers.
+		 */
+		tf->feature = scsicmd[4];
+		tf->nsect = scsicmd[6];
+		tf->lbal = scsicmd[8];
+		tf->lbam = scsicmd[10];
+		tf->lbah = scsicmd[12];
+		tf->device = scsicmd[13];
+		tf->command = scsicmd[14];
+	} else {
+		/*
+		 * 12-byte CDB - incapable of extended commands.
+		 */
+		tf->flags &= ~ATA_TFLAG_LBA48 ;
+
+		tf->feature = scsicmd[3];
+		tf->nsect = scsicmd[4];
+		tf->lbal = scsicmd[5];
+		tf->lbam = scsicmd[6];
+		tf->lbah = scsicmd[7];
+		tf->device = scsicmd[8];
+		tf->command = scsicmd[9];
+	}
+
+	/*
+	 * Set flags so that all registers will be written,
+	 * and pass on write indication (used for PIO/DMA
+	 * setup.)
+	 */
+	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
+
+	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
+		tf->flags |= ATA_TFLAG_WRITE;
+	}
+
+	/*
+	 * Set transfer length.
+	 *
+	 * TODO: find out if we need to do more here to
+	 *       cover scatter/gather case.
+	 */
+	qc->nsect = cmd->bufflen / ATA_SECT_SIZE ;
+
+	return 0;
+}
+
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
  *	@dev: ATA device
@@ -1400,6 +1620,10 @@
 	case VERIFY:
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
+
+	case ATA_12:
+	case ATA_16:
+		return ata_scsi_pass_thru ;
 	}
 
 	return NULL;
===== drivers/scsi/sata_svw.c 1.26 vs edited =====
--- 1.26/drivers/scsi/sata_svw.c	2004-09-16 01:45:15 -05:00
+++ edited/drivers/scsi/sata_svw.c	2004-09-29 18:13:06 -05:00
@@ -138,9 +138,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readw(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
===== drivers/scsi/sata_vsc.c 1.19 vs edited =====
--- 1.19/drivers/scsi/sata_vsc.c	2004-09-16 01:45:15 -05:00
+++ edited/drivers/scsi/sata_vsc.c	2004-09-29 18:13:07 -05:00
@@ -139,9 +139,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb(ioaddr->error_addr);
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
===== include/scsi/scsi.h 1.24 vs edited =====
--- 1.24/include/scsi/scsi.h	2004-08-24 18:09:04 -05:00
+++ edited/include/scsi/scsi.h	2004-09-27 22:11:07 -05:00
@@ -113,6 +113,9 @@
 /* values for service action in */
 #define	SAI_READ_CAPACITY_16  0x10
 
+/* Temporary values for T10/04-262 until official values are allocated */
+#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
+#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
 
 /*
  *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-dev.041005"

diff -ur -X /tmp/dontdiff libata-dev-2.6/drivers/scsi/libata-core.c hotplug/drivers/scsi/libata-core.c
--- libata-dev-2.6/drivers/scsi/libata-core.c	2004-10-05 16:23:15.000000000 -0500
+++ hotplug/drivers/scsi/libata-core.c	2004-10-05 16:40:35.193080994 -0500
@@ -321,10 +321,10 @@
 	tf->lbam = inb(ioaddr->lbam_addr);
 	tf->lbah = inb(ioaddr->lbah_addr);
 	tf->device = inb(ioaddr->device_addr);
+	tf->feature = inb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = inb(ioaddr->error_addr);
 		tf->hob_nsect = inb(ioaddr->nsect_addr);
 		tf->hob_lbal = inb(ioaddr->lbal_addr);
 		tf->hob_lbam = inb(ioaddr->lbam_addr);
@@ -353,10 +353,10 @@
 	tf->lbam = readb((void __iomem *)ioaddr->lbam_addr);
 	tf->lbah = readb((void __iomem *)ioaddr->lbah_addr);
 	tf->device = readb((void __iomem *)ioaddr->device_addr);
+	tf->feature = readb((void __iomem *)ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
 		writeb(tf->ctl | ATA_HOB, (void __iomem *) ap->ioaddr.ctl_addr);
-		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
 		tf->hob_nsect = readb((void __iomem *)ioaddr->nsect_addr);
 		tf->hob_lbal = readb((void __iomem *)ioaddr->lbal_addr);
 		tf->hob_lbam = readb((void __iomem *)ioaddr->lbam_addr);
diff -ur -X /tmp/dontdiff libata-dev-2.6/drivers/scsi/libata-scsi.c hotplug/drivers/scsi/libata-scsi.c
--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2004-10-05 16:23:15.000000000 -0500
+++ hotplug/drivers/scsi/libata-scsi.c	2004-10-05 16:41:26.459332921 -0500
@@ -468,6 +315,85 @@
 	}
 }
 
+/*
+ *	ata_pass_thru_cc - Generate check condition sense block.
+ *	@qc: Command that completed.
+ *
+ *	Regardless of whether the command errored or not, return
+ *	a sense block. Copy all controller registers into
+ *	the sense block. Clear sense key, ASC & ASCQ if
+ *	there is no error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8 ;
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq. We will overwrite some
+	 * (many) of the fields later.
+	 *
+	 * TODO: reorganise better, by splitting ata_to_sense_error()
+	 */
+	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc, drv_stat) ;
+	} else {
+		sb[3] = sb[2] = sb[1] = 0x00 ;
+	}
+
+	/*
+	 * Sense data is current and format is
+	 * descriptor.
+	 */
+	sb[0] = 0x72 ;
+
+	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+
+	/*
+	 * Set length of additional sense data.
+	 * Since we only populate descriptor 0, the total
+	 * length is the same (fixed) length as descriptor 0.
+	 */
+	desc[1] = sb[7] = 14 ;
+
+	/*
+	 * Read the controller registers.
+	 */
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Copy registers into sense buffer.
+	 */
+	desc[2] = 0x00 ;
+	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
+	desc[5] = tf->nsect ;
+	desc[7] = tf->lbal ;
+	desc[9] = tf->lbam ;
+	desc[11] = tf->lbah ;
+	desc[12] = tf->device ;
+	desc[13] = drv_stat ;
+
+	/*
+	 * Fill in Extend bit, and the high order bytes
+	 * if applicable.
+	 */
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		desc[2] |= 0x01 ;
+		desc[4] = tf->hob_nsect ;
+		desc[6] = tf->hob_lbal ;
+		desc[8] = tf->hob_lbam ;
+		desc[10] = tf->hob_lbah ;
+	}
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -785,7 +711,7 @@
 	 * ASCQ will all be zero.
 	 */
 	if ((cmd->cmnd[0] == ATA_16) && (cmd->cmnd[2] & 0x20)) {
-/*DWD*/		printk("XX  0x%0lx/0x%0x\n", qc->tf.flags, qc->tf.protocol);
+		ata_pass_thru_cc(qc, drv_stat) ;
 	} else {
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
 			ata_to_sense_error(qc, drv_stat);
@@ -853,6 +779,7 @@
 
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
+
 	/* select device, send command to hardware */
 	if (ata_qc_issue(qc))
 		goto err_out;
@@ -1533,9 +1460,11 @@
 }
 
 /*
- * ata_scsi_map_proto() -	Map the protocol specified
- *				in the pass-thru CDB onto the
- *				protocol values used by taskfiles.
+ *	ata_scsi_map_proto - Map pass-thru protocol value to taskfile value.
+ *	@byte1: Byte 1 from pass-thru CDB.
+ *
+ *	RETURNS:
+ *	ATA_PROT_UNKNOWN if mapping failed/unimplemented, protocol otherwise.
  */
 static u8
 ata_scsi_map_proto(u8 byte1)
@@ -1571,8 +1500,18 @@
 	return ATA_PROT_UNKNOWN;
 }
 
+/**
+ *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
+ *	@qc: command structure to be initialized
+ *	@cmd: SCSI command to convert
+ *
+ *	Handles either 12 or 16-byte versions of the CDB.
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on failure.
+ */
 static unsigned int
-ata_scsi_pass_thru_16(struct ata_queued_cmd *qc, u8 *scsicmd)
+ata_scsi_pass_thru(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct ata_taskfile *tf = &(qc->tf);
 	struct scsi_cmnd *cmd = qc->scsicmd;
@@ -1582,45 +1521,70 @@
 	}
 
 	/*
-	 * If the CDB claims to contain extended
-	 * ATA commands copy the upper byte register values.
-	 * 
-	 * NOTE: at present copy all register fields,
-	 * regardless of which ones are valid according
-	 * to the .En bits. TODO: research optimal
-	 * algorithm for this.
+	 * 12 and 16 byte CDBs use different offsets to
+	 * provide the various register values.
 	 */
-	if (scsicmd[1] & 0x01) {
-		tf->hob_feature = scsicmd[3];
-		tf->hob_nsect = scsicmd[5];
-		tf->hob_lbal = scsicmd[7];
-		tf->hob_lbam = scsicmd[9];
-		tf->hob_lbah = scsicmd[11];
-		tf->flags |= ATA_TFLAG_LBA48 ;
+	if (scsicmd[0] == ATA_16) {
+		/*
+		 * 16-byte CDB - may contain extended commands.
+		 *
+		 * If that is the case, copy the upper byte register values.
+		 */
+		if (scsicmd[1] & 0x01) {
+			tf->hob_feature = scsicmd[3];
+			tf->hob_nsect = scsicmd[5];
+			tf->hob_lbal = scsicmd[7];
+			tf->hob_lbam = scsicmd[9];
+			tf->hob_lbah = scsicmd[11];
+			tf->flags |= ATA_TFLAG_LBA48 ;
+		} else {
+			tf->flags &= ~ATA_TFLAG_LBA48 ;
+		}
+
+		/*
+		 * Always copy low byte, device and command registers.
+		 */
+		tf->feature = scsicmd[4];
+		tf->nsect = scsicmd[6];
+		tf->lbal = scsicmd[8];
+		tf->lbam = scsicmd[10];
+		tf->lbah = scsicmd[12];
+		tf->device = scsicmd[13];
+		tf->command = scsicmd[14];
 	} else {
+		/*
+		 * 12-byte CDB - incapable of extended commands.
+		 */
 		tf->flags &= ~ATA_TFLAG_LBA48 ;
-	}
 
-	tf->feature = scsicmd[4];
-	tf->nsect = scsicmd[6];
-	tf->lbal = scsicmd[8];
-	tf->lbam = scsicmd[10];
-	tf->lbah = scsicmd[12];
+		tf->feature = scsicmd[3];
+		tf->nsect = scsicmd[4];
+		tf->lbal = scsicmd[5];
+		tf->lbam = scsicmd[6];
+		tf->lbah = scsicmd[7];
+		tf->device = scsicmd[8];
+		tf->command = scsicmd[9];
+	}
 
+	/*
+	 * Set flags so that all registers will be written,
+	 * and pass on write indication (used for PIO/DMA
+	 * setup.)
+	 */
 	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
-	tf->device = scsicmd[13];
-	tf->command = scsicmd[14];
+
+	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
+		tf->flags |= ATA_TFLAG_WRITE;
+	}
 
 	/*
+	 * Set transfer length.
+	 *
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
 	qc->nsect = cmd->bufflen / ATA_SECT_SIZE ;
 
-	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
-		tf->flags |= ATA_TFLAG_WRITE;
-	}
-
 	return 0;
 }
 
@@ -1657,8 +1621,9 @@
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
 
+	case ATA_12:
 	case ATA_16:
-		return ata_scsi_pass_thru_16 ;
+		return ata_scsi_pass_thru ;
 	}
 
 	return NULL;
diff -ur -X /tmp/dontdiff libata-dev-2.6/drivers/scsi/sata_svw.c hotplug/drivers/scsi/sata_svw.c
--- libata-dev-2.6/drivers/scsi/sata_svw.c	2004-10-05 16:23:15.000000000 -0500
+++ hotplug/drivers/scsi/sata_svw.c	2004-09-29 18:13:06.000000000 -0500
@@ -138,9 +138,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readw(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff -ur -X /tmp/dontdiff libata-dev-2.6/drivers/scsi/sata_vsc.c hotplug/drivers/scsi/sata_vsc.c
--- libata-dev-2.6/drivers/scsi/sata_vsc.c	2004-10-05 16:23:15.000000000 -0500
+++ hotplug/drivers/scsi/sata_vsc.c	2004-09-29 18:13:07.000000000 -0500
@@ -139,9 +139,9 @@
 	lbam = tf->lbam = readw(ioaddr->lbam_addr);
 	lbah = tf->lbah = readw(ioaddr->lbah_addr);
 	tf->device = readw(ioaddr->device_addr);
+	tf->feature = readb(ioaddr->error_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb(ioaddr->error_addr);
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;

--ikeVEW9yuYc//A+q--
