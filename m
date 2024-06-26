Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168D194129
	for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443070; cv=none; b=BdqhDySHFBlTUkObGnwrbVTDIKsDyBmOX1/Gptctvi3th/+0qgEKXZuj16lZpG/rEGkGebLnxXZJWlhfsFxTPqVt+GwWWGSa9J6yz1epcKOvwrbiaBs0VHRsWD3XltjJSDGnAhyvEjjyg/wUTGNUXN/mqfHqdgpGGXQ206EPwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443070; c=relaxed/simple;
	bh=X36javU244m1Pe7Nm6RJMAr7OamOkUPb1UbNIZe4cd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W3z/au5q26WfoVnW6i6l04wiNK3b/2IAD9iEu4AAcCH2hU/FKnJpmFfoZt3itxzyjjg+5jJ+FnNZfnxT+8MBO2DYfCVi1yh9ppmp0J4l0RrHbfbncoBkmYyDSyP8f92UDwxdWH2cK1r8ekwE0l1RvF87FzrpawagkXJPcPm4KN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mx8v7Sf5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mx8v7Sf5"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c559235c6eso9412580a12.2
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443067; x=1720047867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYTcox1uxiDsgrgstLUNMompUZVUnfSZPE6ZrKVubcY=;
        b=mx8v7Sf5VSZ/raWU8yjyqdOgcCg0xNkuiNr2Ez/PP56TT6o4zPZXp6pI6aqbYYRLjX
         kKF+FBeaaDpAgYh9YuJo5zrJohSnorUnkL0uODIG7J9k7SMO8JocD5ekS37UTHC4DFvc
         207j9SpkKOtMcjI8v7bLNb2Wj9WKQ+IGyUtOe9ud3qTucj9VHiNZz6OrMeaq6u0mRs7U
         WB0+iQUkNhbi0eVhK2c6yPbsbE91AkDOrlesG1Xfbue2QddhU8XVVdEDyg1B7CZJubNY
         yGRIWWMMY8aoYee4GxbFkXNx70R5VHp+CSdM+Veyo/vkqlmw+zVMSnOaOb5jhvyU3kRT
         UwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443067; x=1720047867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYTcox1uxiDsgrgstLUNMompUZVUnfSZPE6ZrKVubcY=;
        b=syj19e536aKMUp+/1Gu7tr7rgm/KLfBCWZA/jCXlTQBDbsbV0OYYRcvKC4IAYBpT5i
         YT+CWWeqqB1buJkZKXMvnr6aCwhK58m4FgsWQjdotAPzFh7xUlJWU+OLwhfSRlvFtM8y
         bi0k1cQ7zTEuy3ZDe/kksCsyFOGSHMub8pEZjOXn7YyjoWZTiVbkrn8Qi/Lwtbw+6oot
         U6nhESfZ0FWKwXzqaWoFeHuVZKezY8vEIGQxBMBa7JFqqEBGVjXwGJ8U/sip1h89xJEj
         i0RaSwOIcu09NCteOCZDS+tPLfzevwD84DJp1lLzgrwj9q3Y1uhbEawOW6qnTK9HJCgi
         4uXg==
X-Forwarded-Encrypted: i=1; AJvYcCUHwfevLGVuFiIWfsShFkif9/BsFMUuxHAhf7p4dTePlf1tMTY/U/25nI2keeqXyTW6W6smGIJZ3fnSKJSSwIg2Ex4uY5cjUBcb
X-Gm-Message-State: AOJu0Yym73iuQgUSarmVZwOP4NihO8dMh87jEP54PFobXWxXUqRpO5H1
	Rnen8vZVq4nx6e92uj/PXjZFOZNihTvy3o7/ji7V+InM1rzJQAhCAR/pp4muvNsbVBC9NKRcy4f
	3PciUFYelnQ==
X-Google-Smtp-Source: AGHT+IFovcMZN+k505LVJQ0M7+wE+Qk1gQ7CAGuZCVOne74Cr/uZsi84LMT4f7Jo9RaI7qWgiK8IxZ8+6US2HQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:3d43:0:b0:71a:1f6f:1d0f with SMTP id
 41be03b00d2f7-71b5c3db10amr29716a12.6.1719443067521; Wed, 26 Jun 2024
 16:04:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:07 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-3-ipylypiv@google.com>
Subject: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense data
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

Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 72 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9e44ad4c2de..26b1263f5c7c 100644
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
@@ -1634,6 +1649,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	u8 *cdb = cmd->cmnd;
 	int need_sense = (qc->err_mask != 0) &&
 		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
+	int need_passthru_sense = (qc->err_mask != 0) ||
+		(qc->flags & ATA_QCFLAG_SENSE_VALID);
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
@@ -1645,13 +1662,16 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense))
-		ata_gen_passthru_sense(qc);
-	else if (need_sense)
+	    ((cdb[2] & 0x20) || need_passthru_sense)) {
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
+			ata_gen_passthru_sense(qc);
+		ata_scsi_set_passthru_sense_fields(qc);
+	} else if (need_sense) {
 		ata_gen_ata_sense(qc);
-	else
+	} else {
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
+	}
 
 	ata_qc_done(qc);
 }
@@ -2590,14 +2610,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
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

