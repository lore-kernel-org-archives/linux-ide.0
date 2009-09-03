From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: unbreak TPM filtering by reorganizing
 ata_scsi_pass_thru()
Date: Thu, 03 Sep 2009 16:08:11 +0900
Message-ID: <4A9F6B5B.80701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35109 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbZICHJL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Sep 2009 03:09:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Thilo-Alexander Ginkel <thilo@ginkel.com>

ata_scsi_pass_thru() was checking for input sanity and disallowed
commands while initializaing qc from scmd.  TPM filtering was added
right after protocol check at which point tf wasn't initialized
properly.  This means that TPM filtering has never really worked.

This patch fixes the bug by reorganizing ata_scsi_pass_thru() such
that qc is fully initialized before checking for invalid conditions
which is way less error prone.

Discovered while Thilo-Alexander Ginkel was trying debug patches for
bko#13416.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Thilo-Alexander Ginkel <thilo@ginkel.com>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5d7a1bd..b4ee28d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2760,28 +2760,6 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 		goto invalid_fld;

 	/*
-	 * Filter TPM commands by default. These provide an
-	 * essentially uncontrolled encrypted "back door" between
-	 * applications and the disk. Set libata.allow_tpm=1 if you
-	 * have a real reason for wanting to use them. This ensures
-	 * that installed software cannot easily mess stuff up without
-	 * user intent. DVR type users will probably ship with this enabled
-	 * for movie content management.
-	 *
-	 * Note that for ATA8 we can issue a DCS change and DCS freeze lock
-	 * for this and should do in future but that it is not sufficient as
-	 * DCS is an optional feature set. Thus we also do the software filter
-	 * so that we comply with the TC consortium stated goal that the user
-	 * can turn off TC features of their system.
-	 */
-	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm)
-		goto invalid_fld;
-
-	/* We may not issue DMA commands if no DMA mode is set */
-	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
-		goto invalid_fld;
-
-	/*
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
 	 */
@@ -2830,6 +2808,41 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	tf->device = dev->devno ?
 		tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;

+	/* READ/WRITE LONG use a non-standard sect_size */
+	qc->sect_size = ATA_SECT_SIZE;
+	switch (tf->command) {
+	case ATA_CMD_READ_LONG:
+	case ATA_CMD_READ_LONG_ONCE:
+	case ATA_CMD_WRITE_LONG:
+	case ATA_CMD_WRITE_LONG_ONCE:
+		if (tf->protocol != ATA_PROT_PIO || tf->nsect != 1)
+			goto invalid_fld;
+		qc->sect_size = scsi_bufflen(scmd);
+	}
+
+	/*
+	 * Set flags so that all registers will be written, pass on
+	 * write indication (used for PIO/DMA setup), result TF is
+	 * copied back and we don't whine too much about its failure.
+	 */
+	tf->flags = ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	if (scmd->sc_data_direction == DMA_TO_DEVICE)
+		tf->flags |= ATA_TFLAG_WRITE;
+
+	qc->flags |= ATA_QCFLAG_RESULT_TF | ATA_QCFLAG_QUIET;
+
+	/*
+	 * Set transfer length.
+	 *
+	 * TODO: find out if we need to do more here to
+	 *       cover scatter/gather case.
+	 */
+	ata_qc_set_pc_nbytes(qc);
+
+	/* We may not issue DMA commands if no DMA mode is set */
+	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
+		goto invalid_fld;
+
 	/* sanity check for pio multi commands */
 	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf))
 		goto invalid_fld;
@@ -2846,18 +2859,6 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 				       multi_count);
 	}

-	/* READ/WRITE LONG use a non-standard sect_size */
-	qc->sect_size = ATA_SECT_SIZE;
-	switch (tf->command) {
-	case ATA_CMD_READ_LONG:
-	case ATA_CMD_READ_LONG_ONCE:
-	case ATA_CMD_WRITE_LONG:
-	case ATA_CMD_WRITE_LONG_ONCE:
-		if (tf->protocol != ATA_PROT_PIO || tf->nsect != 1)
-			goto invalid_fld;
-		qc->sect_size = scsi_bufflen(scmd);
-	}
-
 	/*
 	 * Filter SET_FEATURES - XFER MODE command -- otherwise,
 	 * SET_FEATURES - XFER MODE must be preceded/succeeded
@@ -2865,30 +2866,27 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	 * controller (i.e. the reason for ->set_piomode(),
 	 * ->set_dmamode(), and ->post_set_mode() hooks).
 	 */
-	if ((tf->command == ATA_CMD_SET_FEATURES)
-	 && (tf->feature == SETFEATURES_XFER))
+	if (tf->command == ATA_CMD_SET_FEATURES &&
+	    tf->feature == SETFEATURES_XFER)
 		goto invalid_fld;

 	/*
-	 * Set flags so that all registers will be written,
-	 * and pass on write indication (used for PIO/DMA
-	 * setup.)
-	 */
-	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
-
-	if (scmd->sc_data_direction == DMA_TO_DEVICE)
-		tf->flags |= ATA_TFLAG_WRITE;
-
-	/*
-	 * Set transfer length.
+	 * Filter TPM commands by default. These provide an
+	 * essentially uncontrolled encrypted "back door" between
+	 * applications and the disk. Set libata.allow_tpm=1 if you
+	 * have a real reason for wanting to use them. This ensures
+	 * that installed software cannot easily mess stuff up without
+	 * user intent. DVR type users will probably ship with this enabled
+	 * for movie content management.
 	 *
-	 * TODO: find out if we need to do more here to
-	 *       cover scatter/gather case.
+	 * Note that for ATA8 we can issue a DCS change and DCS freeze lock
+	 * for this and should do in future but that it is not sufficient as
+	 * DCS is an optional feature set. Thus we also do the software filter
+	 * so that we comply with the TC consortium stated goal that the user
+	 * can turn off TC features of their system.
 	 */
-	ata_qc_set_pc_nbytes(qc);
-
-	/* request result TF and be quiet about device error */
-	qc->flags |= ATA_QCFLAG_RESULT_TF | ATA_QCFLAG_QUIET;
+	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm)
+		goto invalid_fld;

 	return 0;

