Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD31A254D
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267154; cv=none; b=afqIyHYFyVM9SDvxmHiKRFLMNH9Vk6kxWw1b2bCIVh414GMFrTAMRGQgZYF4Q6SFU+uVNoqVdmRweDyWMf6Yto/9R6XFa5MGmMsLKoB7+vRBjfiNS+w3P1l0JM0BwN4aWzhImvOjr2qDfadY4LMTNr0NkZdctpNpk02PVjlpIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267154; c=relaxed/simple;
	bh=+UCCdZQ3eCuIV7Y1LzKbJGHc3JfjUkOY8QeVYo3jO2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAqo0Fabbom+ZLmS2cPHwpJ2YZ92rkYPmlecCZyas7qCO6qgcSjpWqJXiu2WLHJ06VLodZqSDdyPpl58ZOh/PaUBumDmT/x5teHFHp3IRwJ8JWZNYZMUsKyvotdYLpfHMF5lbxuHqXbRpFTijooGdVHN1Je45ivtC9U1V3Mr8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vs4QjN1h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vs4QjN1h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f9a774d7e1so52420675ad.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267152; x=1719871952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPYUfgs5zw04kzOhQ8+F9AbTYxqJaear32gPB/pl9ow=;
        b=Vs4QjN1h1aE9QMbVibdZ7Wi/cj53XvESsgrVGCrCeP9mOcaojZGBGw4C34hrJgJ+PL
         LQ7M8Ifl1hZ0KjWwG2e9P7y1/dIsfewViPZ9r6akT3/1UPLxRSoQBuy/erkk8sKDa3Pf
         NqPV1YWFBfI1ATe3kxjs67tO1yW6Ue74KjGO4Uwk6U5tc1JCl4uYAJQnnqIIoLIxZeMf
         Ph36SjD6uEnXVdbVoxN6+Udhs+oZoQiy5wuHinqtzYyhvBZiurGmbDAzF1kAI6E90TrA
         UsKlBlx14QKIQsTPoPyUAV3HiymZX2B4myXeuJeSZ6Jdpa5/6IAvDIdw6bkmnHUgVzFe
         xlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267152; x=1719871952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPYUfgs5zw04kzOhQ8+F9AbTYxqJaear32gPB/pl9ow=;
        b=haBfzy9JeuFbnAFDa3mpk4V40Z50VFYo5t5T/CEricTCgUeZoz9fHIpdZvApT/17Sv
         CS7N9B7UqgduFHMtyrvHN8v8awtoHNfINejJN+3y/riLtoP4F0laDdVObpinJtgEHNN2
         YiZJm719LcJxQ5v/LD6Fnn0jFgxR18W6Bja/L+Xm5KZIswuMWSprdnR1YlTWIpBhYXJj
         V9CGCEM981gy7SXov0kret3C83VVlLSSeRW2YjaHPCbKclwqX//2knCssQtXxBNyWrTY
         WjjxSGjawrl7OZqgNpO5Q8r2n8cY/uXEXm6xKghlUHwqPE0FxjAe/BKZXHDlwV7qsnh5
         7NlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXdQyaiMQpcYfJDQ6Z+VF9Qax3u/HrOetgMJpLbdkPLvncSB4ClpqCewAZ3xVLPY85EMrXJ3FInwm6IuCb40E4Qw6+gg1T/k86
X-Gm-Message-State: AOJu0YyXEaPKzj505TD+UFr+jqJIczh2R9g3bzVQKMwdGaYTMnqTyUfn
	xQr9zlBPuZ9W2X9pTZsizKSlT9CT3F3KgbVPU2dsc459IpVzbzuD3J4tJCLUCLyOEN6kWDHwR2t
	o6JV+pJMYlg==
X-Google-Smtp-Source: AGHT+IF6xzy8x66j2jk6t+LDSAGlwtGWFsJBo+x/FEq/umMjUFalVzUGvRMupb1SHy0uxFHIyYxLIGjs7WR2SQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:f685:b0:1f6:917b:e064 with SMTP
 id d9443c01a7336-1fa1d624449mr6528115ad.6.1719267151816; Mon, 24 Jun 2024
 15:12:31 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:05 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-2-ipylypiv@google.com>
Subject: [PATCH v2 1/6] ata: libata-scsi: Do not overwrite valid sense data
 when CK_COND=1
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
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

Cc: <stable@vger.kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 72 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bb4d30d377ae..54fed6a427b1 100644
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
+	unsigned char *desc = sb + 8;
+
+	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
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
+		desc[0] = tf->error;
+		desc[1] = tf->status;
+		desc[2] = tf->device;
+		desc[3] = tf->nsect;
+		desc[7] = 0;
+		if (tf->flags & ATA_TFLAG_LBA48)  {
+			desc[8] |= 0x80;
+			if (tf->hob_nsect)
+				desc[8] |= 0x40;
+			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
+				desc[8] |= 0x20;
+		}
+		desc[9] = tf->lbal;
+		desc[10] = tf->lbam;
+		desc[11] = tf->lbah;
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
@@ -855,7 +927,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
-	unsigned char *desc = sb + 8;
 	u8 sense_key, asc, ascq;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -876,62 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 		 */
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
-
-	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
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
-		desc[0] = tf->error;
-		desc[1] = tf->status;
-		desc[2] = tf->device;
-		desc[3] = tf->nsect;
-		desc[7] = 0;
-		if (tf->flags & ATA_TFLAG_LBA48)  {
-			desc[8] |= 0x80;
-			if (tf->hob_nsect)
-				desc[8] |= 0x40;
-			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				desc[8] |= 0x20;
-		}
-		desc[9] = tf->lbal;
-		desc[10] = tf->lbam;
-		desc[11] = tf->lbah;
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
2.45.2.741.gdbec12cfda-goog

