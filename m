From: Andy Warner <andyw@pobox.com>
Subject: [PATCH] libata-dev-2.6 12-byte pass thru CDB.
Date: Thu, 14 Oct 2004 10:48:54 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041014104854.A21475@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:61151 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266349AbUJNPuq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Oct 2004 11:50:46 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch to add 12-byte support for ATA pass-thru CDB processing.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ata_12.patch"

===== drivers/scsi/libata-scsi.c 1.55 vs edited =====
--- 1.55/drivers/scsi/libata-scsi.c	2004-09-30 23:12:35 -05:00
+++ edited/drivers/scsi/libata-scsi.c	2004-10-14 10:20:16 -05:00
@@ -1533,9 +1533,11 @@
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
@@ -1571,8 +1573,18 @@
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
@@ -1582,45 +1594,70 @@
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
 
@@ -1657,8 +1694,9 @@
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
 
+	case ATA_12:
 	case ATA_16:
-		return ata_scsi_pass_thru_16 ;
+		return ata_scsi_pass_thru ;
 	}
 
 	return NULL;

--J2SCkAp4GZ/dPZZf--
