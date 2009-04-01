From: salimmu@beardog.cca.cpqcorp.net
Subject: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Wed, 1 Apr 2009 15:51:15 -0500
Message-ID: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:30826 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZDAUvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2009 16:51:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, scameron@beardog.cca.cpqcorp.net, mike.miller@hp.com, steve.cameron@hp.com


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attach is a patch that adds translation of scsi WRITE_BUFFER to ATA_DOWNLOAD_MICROCODE command. This patch enables firmware flashing of sata drives that are registered as scsi devices under linux; hence scsi to ata translation is needed. This patch provides the translation.

Imran Salim
Hewlett Pacakrd Company
Houston, TX
(281) 514-1531


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.16.60-0.21-atawritebuffer.patch"

diff -burp linux-2.6.16.60-0.21/drivers/ata/libata-scsi.c linux-2.6.16.60-0.21.ver1.[coderefactor]/drivers/ata/libata-scsi.c
--- linux-2.6.16.60-0.21/drivers/ata/libata-scsi.c	2009-03-06 07:45:22.000000000 -0500
+++ linux-2.6.16.60-0.21.ver1.[coderefactor]/drivers/ata/libata-scsi.c	2009-03-09 08:15:36.000000000 -0400
@@ -1417,6 +1417,78 @@ nothing_to_do:
 	return 1;
 }
 
+/*
+ *	ata_scsi_write_buffer_xlat - Translates SCSI 'Write Buffer' command
+ *	into ATA equivalent 'Download Microcode' command. This function is
+ *	implemented according to following spec.
+ * 		Working Draft American National Standard Information Technology
+ *	 	SCSI/ATA Translation-2 (SAT-2)
+ *	 	T10/1826-D Rev 5 Date: June 22, 2008
+ *	@qc: Storage for translated ATA taskfile
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+static unsigned int ata_scsi_write_buffer_xlat(struct ata_queued_cmd *qc)
+{
+	/* scsi */
+	int mode = 0;
+	int buff_id = 0;
+	int buff_offset = 0;
+	int parm_list_len = 0;
+
+	/* ata */
+	int n_sect = 0;
+
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	const u8 *cdb = scmd->cmnd;
+	struct ata_taskfile *tf = &qc->tf;
+
+	mode = cdb[1] & 0x07; /* First 3 bits 0x07=00000111 */
+	buff_id = cdb[2];
+
+	buff_offset |= cdb[3] << 24;
+	buff_offset |= cdb[4] << 16;
+	buff_offset |= cdb[5];
+
+	parm_list_len |= cdb[6] << 16;
+	parm_list_len |= cdb[7] << 8;
+	parm_list_len |= cdb[8];
+
+	n_sect = parm_list_len / ATA_SECT_SIZE;
+	qc->nsect = n_sect;
+
+	tf->nsect =  n_sect & 0xff;
+	tf->lbal  = (n_sect >> 8) & 0xff;
+	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR | ATA_TFLAG_WRITE;
+
+	switch (mode) {
+	case 0x02:
+		if (buff_id == 0 && buff_offset == 0 && parm_list_len == 512) {
+			tf->command = ATA_CMD_WRITE_BUFFER;
+			tf->protocol = ATA_PROT_PIO;
+		} else {
+			ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
+		}
+		break;
+	case 0x05:
+		tf->command = ATA_CMD_DOWNLOAD_MICROCODE;
+		tf->protocol = ATA_PROT_PIO;
+		tf->feature = 7;
+		break;
+	case 0x07:
+		tf->command = ATA_CMD_DOWNLOAD_MICROCODE;
+		tf->protocol = ATA_PROT_PIO;
+		tf->feature = 3;
+		break;
+	default:
+		ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
+		return 1;
+	}
+
+	return 0;
+}
+
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -2730,6 +2802,9 @@ static inline ata_xlat_func_t ata_get_xl
 	case WRITE_16:
 		return ata_scsi_rw_xlat;
 
+	case WRITE_BUFFER:
+		return ata_scsi_write_buffer_xlat;
+
 	case SYNCHRONIZE_CACHE:
 		if (ata_try_flush_cache(dev))
 			return ata_scsi_flush_xlat;
diff -burp linux-2.6.16.60-0.21/include/linux/ata.h linux-2.6.16.60-0.21.ver1.[coderefactor]/include/linux/ata.h
--- linux-2.6.16.60-0.21/include/linux/ata.h	2009-03-06 07:45:53.000000000 -0500
+++ linux-2.6.16.60-0.21.ver1.[coderefactor]/include/linux/ata.h	2009-03-06 06:29:44.000000000 -0500
@@ -130,6 +130,7 @@ enum {
 	ATA_CMD_STANDBY		= 0xE2, /* place in standby power mode */
 	ATA_CMD_IDLE		= 0xE3, /* place in idle power mode */
 	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
+	ATA_CMD_DOWNLOAD_MICROCODE = 0x92,
 	ATA_CMD_FLUSH		= 0xE7,
 	ATA_CMD_FLUSH_EXT	= 0xEA,
 	ATA_CMD_ID_ATA		= 0xEC,
@@ -150,6 +151,7 @@ enum {
 	ATA_CMD_WRITE_MULTI	= 0xC5,
 	ATA_CMD_WRITE_MULTI_EXT	= 0x39,
 	ATA_CMD_WRITE_MULTI_FUA_EXT = 0xCE,
+	ATA_CMD_WRITE_BUFFER	= 0xE8,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
Signed-off-by: Imran Salim <imran.salim@hp.com>


--zYM0uCDKw75PZbzx--
