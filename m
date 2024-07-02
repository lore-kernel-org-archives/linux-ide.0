Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4211C686
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888465; cv=none; b=i7bMjq7Zum3THDImw328eDvDIKR2QjQ9+KMlzgSOUkN/sHDmg5PfD7RQpaenlV5DXJfMOst2Src4slJ3OH3jKqAeBsSgfK3hj9/OKE3Bk/TfI2XN+O2wXAkasrRruoZAf2BeOw4py/Fd86E7oIkv2gyIYquvJKaQVlfeyCpcO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888465; c=relaxed/simple;
	bh=BMiyKMLwYO4ZPYOP19tvEv3Gb8DtBupJrrjIS0a8MKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVOVnjBFqBcYNC8z3ismtLBFbEeueQ2r/Xk5+FIHqqxISR2Zpm37dXyjRalvkKItK8CSHtWVZJC0RHoMOFnrmmDrUhdsNgGDjfAfhB2nQ2DwE50ijls+tR0nxNcB3k/AlEtZSEUdFyDdODcmjgIu50+v15VkPFj2fNQLRbv2NWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmQNRHd1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmQNRHd1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-71bce629b2fso3249880a12.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888463; x=1720493263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oDyu1t8Xgx68nOCglw7QJXgCM7MJOxOJdmoGHyawoE=;
        b=jmQNRHd1h2gdjbHaftwZc3f7TqhCnGEl9fuKWmjLdTS7mx4vUn6rhehSw3gA0fyKv0
         cDaCfCbXp1ty/TsnfSbfaPdznVpq2p+24CMRhngpJYt8QtcKf8V+3KhSXaUKumUsnyKN
         zDfC++oauGoKaihvRUbuyGDaImK5UlW+VB5A27+9E6aqglWxpW+zXx5uB9t760Eta+d9
         QLPDpK7dq0O/gB/DKqJWYDDQiJmLifQFYUm6wB3JeFTryw2Tjnr9lbY/Tfk0zubuA5+T
         apLxAxEuNvrMpQ502H9vFOXUohn5VV6vW4ynZ8C8n4gOx4EsxFE3wWYxOon5l2eXRNhe
         judQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888463; x=1720493263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oDyu1t8Xgx68nOCglw7QJXgCM7MJOxOJdmoGHyawoE=;
        b=FVL6mdrhRt5BspwL5GJ89isQarMPt5JqxCh8pJVC9B/1DtW/Va8gv1jebJddYFmEkk
         PVNcs+OA7hLQdM6QdAZj/pF+Rt0g+2+8oqLQI39bA0bNI+RMMIJ5P2IAqxqeavaP0YPV
         FR/br1tYTYjsfdhDkl/VOcZhJjR1dYR9XuUa+AjgOhZbNz0fSTyyl6iNeIPKzugtgEVT
         v5wUymXJ+m46FBBskoHj6AYlfkhc9f/AjPxBbop8XBkThFZ5DeEDHG6z8s5rQUJJHO92
         J8belNb8ghXyeSbEkq2+F0jgY/BcjiKZ3k1aFL9v+sj3wgMh6Mvcgv8XJKS9BQUMSFLV
         /04w==
X-Forwarded-Encrypted: i=1; AJvYcCUop9fJF1hf0Bz6U53SPLaFMHGwTeOzLd7vVeztwgSU5OTI8QmtwHrhF9qvFLWV2lKln1IXz5gsn7Pr9vkp7gnVptOHPg166UY6
X-Gm-Message-State: AOJu0YyiG+cwUObiVUXHG+1yUs+vEL30P9+6fkg9MdDXVo5iMIjWM5KB
	BRYKskA0/nwN54DLV1CvuHzOur2CFQjzefCjVu9KC34waScAEjP9oAQFq2HE1B+FVxqnBAlysvu
	JskRHG63iVg==
X-Google-Smtp-Source: AGHT+IFBvwUGGAdmLQ5Bq25tNXwFEG7MnA2qkz6mLuAQxc8eTODP7wPfu4gagCH1EcQOqtBjBzmTe9QdVanGhw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:6384:0:b0:6ea:a4f3:14a3 with SMTP id
 41be03b00d2f7-74ceedd8de4mr5115a12.4.1719888463253; Mon, 01 Jul 2024 19:47:43
 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:30 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-3-ipylypiv@google.com>
Subject: [PATCH v5 2/7] ata: libata-scsi: Do not overwrite valid sense data
 when CK_COND=1
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Current ata_gen_passthru_sense() code performs two actions:
1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
2. Populates "ATA Status Return sense data descriptor" / "Fixed format
   sense data" with ATA taskfile fields.

The problem is that #1 generates sense data even when a valid sense data
is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
a separate function allows us to generate sense data only when there is
no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).

As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
which states that we don't want to translate taskfile registers into
sense descriptors for ATAPI.

Additionally, always set SAM_STAT_CHECK_CONDITION when CK_COND=1 because
SAT specification mandates that SATL shall return CHECK CONDITION if
the CK_COND bit is set.

The ATA PASS-THROUGH handling logic in ata_scsi_qc_complete() is hard
to read/understand. Improve the readability of the code by moving checks
into self-explanatory boolean variables.

Cc: stable@vger.kernel.org # 4.19+
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 169 +++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 77 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9e44ad4c2de..b59cbb5ce5a6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -230,6 +230,80 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
 				   SCSI_SENSE_BUFFERSIZE, information);
 }
 
+/**
+ *	ata_scsi_set_passthru_sense_fields - Set ATA fields in sense buffer
+ *	@qc: ATA PASS-THROUGH command.
+ *
+ *	Populates "ATA Status Return sense data descriptor" / "Fixed format
+ *	sense data" with ATA taskfile fields.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->result_tf;
+	unsigned char *sb = cmd->sense_buffer;
+
+	if ((sb[0] & 0x7f) >= 0x72) {
+		unsigned char *desc;
+		u8 len;
+
+		/* descriptor format */
+		len = sb[7];
+		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
+		if (!desc) {
+			if (SCSI_SENSE_BUFFERSIZE < len + 14)
+				return;
+			sb[7] = len + 14;
+			desc = sb + 8 + len;
+		}
+		desc[0] = 9;
+		desc[1] = 12;
+		/*
+		 * Copy registers into sense buffer.
+		 */
+		desc[2] = 0x00;
+		desc[3] = tf->error;
+		desc[5] = tf->nsect;
+		desc[7] = tf->lbal;
+		desc[9] = tf->lbam;
+		desc[11] = tf->lbah;
+		desc[12] = tf->device;
+		desc[13] = tf->status;
+
+		/*
+		 * Fill in Extend bit, and the high order bytes
+		 * if applicable.
+		 */
+		if (tf->flags & ATA_TFLAG_LBA48) {
+			desc[2] |= 0x01;
+			desc[4] = tf->hob_nsect;
+			desc[6] = tf->hob_lbal;
+			desc[8] = tf->hob_lbam;
+			desc[10] = tf->hob_lbah;
+		}
+	} else {
+		/* Fixed sense format */
+		sb[0] |= 0x80;
+		sb[3] = tf->error;
+		sb[4] = tf->status;
+		sb[5] = tf->device;
+		sb[6] = tf->nsect;
+		if (tf->flags & ATA_TFLAG_LBA48)  {
+			sb[8] |= 0x80;
+			if (tf->hob_nsect)
+				sb[8] |= 0x40;
+			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
+				sb[8] |= 0x20;
+		}
+		sb[9] = tf->lbal;
+		sb[10] = tf->lbam;
+		sb[11] = tf->lbah;
+	}
+}
+
 static void ata_scsi_set_invalid_field(struct ata_device *dev,
 				       struct scsi_cmnd *cmd, u16 field, u8 bit)
 {
@@ -837,10 +911,8 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
  *	ata_gen_passthru_sense - Generate check condition sense block.
  *	@qc: Command that completed.
  *
- *	This function is specific to the ATA descriptor format sense
- *	block specified for the ATA pass through commands.  Regardless
- *	of whether the command errored or not, return a sense
- *	block. Copy all controller registers into the sense
+ *	This function is specific to the ATA pass through commands.
+ *	Regardless of whether the command errored or not, return a sense
  *	block. If there was no error, we get the request from an ATA
  *	passthrough command, so we use the following sense data:
  *	sk = RECOVERED ERROR
@@ -875,63 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		 */
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
-
-	if ((sb[0] & 0x7f) >= 0x72) {
-		unsigned char *desc;
-		u8 len;
-
-		/* descriptor format */
-		len = sb[7];
-		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
-		if (!desc) {
-			if (SCSI_SENSE_BUFFERSIZE < len + 14)
-				return;
-			sb[7] = len + 14;
-			desc = sb + 8 + len;
-		}
-		desc[0] = 9;
-		desc[1] = 12;
-		/*
-		 * Copy registers into sense buffer.
-		 */
-		desc[2] = 0x00;
-		desc[3] = tf->error;
-		desc[5] = tf->nsect;
-		desc[7] = tf->lbal;
-		desc[9] = tf->lbam;
-		desc[11] = tf->lbah;
-		desc[12] = tf->device;
-		desc[13] = tf->status;
-
-		/*
-		 * Fill in Extend bit, and the high order bytes
-		 * if applicable.
-		 */
-		if (tf->flags & ATA_TFLAG_LBA48) {
-			desc[2] |= 0x01;
-			desc[4] = tf->hob_nsect;
-			desc[6] = tf->hob_lbal;
-			desc[8] = tf->hob_lbam;
-			desc[10] = tf->hob_lbah;
-		}
-	} else {
-		/* Fixed sense format */
-		sb[0] |= 0x80;
-		sb[3] = tf->error;
-		sb[4] = tf->status;
-		sb[5] = tf->device;
-		sb[6] = tf->nsect;
-		if (tf->flags & ATA_TFLAG_LBA48)  {
-			sb[8] |= 0x80;
-			if (tf->hob_nsect)
-				sb[8] |= 0x40;
-			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				sb[8] |= 0x20;
-		}
-		sb[9] = tf->lbal;
-		sb[10] = tf->lbam;
-		sb[11] = tf->lbah;
-	}
 }
 
 /**
@@ -1632,26 +1647,32 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
-	int need_sense = (qc->err_mask != 0) &&
-		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
+	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
+	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
-	 * generate because the user forced us to [CK_COND =1], a check
+	 * generate because the user forced us to [CK_COND=1], a check
 	 * condition is generated and the ATA register values are returned
 	 * whether the command completed successfully or not. If there
-	 * was no error, we use the following sense data:
+	 * was no error, and CK_COND=1, we use the following sense data:
 	 * sk = RECOVERED ERROR
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
-	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense))
-		ata_gen_passthru_sense(qc);
-	else if (need_sense)
+	if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
+		if (!have_sense)
+			ata_gen_passthru_sense(qc);
+		ata_scsi_set_passthru_sense_fields(qc);
+		if (is_ck_cond_request)
+			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
-	else
+	} else {
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
+	}
 
 	ata_qc_done(qc);
 }
@@ -2590,14 +2611,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	/* handle completion from EH */
 	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 
-		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
-			/* FIXME: not quite right; we don't want the
-			 * translation of taskfile registers into a
-			 * sense descriptors, since that's only
-			 * correct for ATA, not ATAPI
-			 */
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
 			ata_gen_passthru_sense(qc);
-		}
 
 		/* SCSI EH automatically locks door if sdev->locked is
 		 * set.  Sometimes door lock request continues to
-- 
2.45.2.803.g4e1b14247a-goog

