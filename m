Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FB2980B1
	for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342490; cv=none; b=ierK5NRCffEgkaNTmEwJDYgj6Dbp0XPpLeffb+tnrtAO+Bl5i4hKZ+bg+eNpFQ3LlEdhIBM/jEwuVKc3arnJ/eLzldeOBH6cTrue/cbOyIVN0BPzjw3pByn1uqNhFxA7oUy68xmdx3NLOcpVNsHFwY63e86zMuqVZ8WQYQSMd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342490; c=relaxed/simple;
	bh=/X/KZQAWZc9lzWOW3EtF/+qFy7ljzzEYyLnsPc/EUdE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJ/iTuajpZOMbQxd3rxoImobaPjbfTkgyvbCbOcYyy1WToH/y7wFnQXX7B6Lji+AtemRyF68ee7/fdF65yHO42P13eZW2DlGmHTVyQvRXTPQTNh2qeCKx7jzJwO/xGWuCP6A9Ix2lJ7V5myT6MSnqdXPEgL+y/TDK9e0bG/ttN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ag6CNiuj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ag6CNiuj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225505d1ca5so51571845ad.2
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2025 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745342487; x=1745947287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pHZApYLBDslBvQML3OtPuVw3MhXtPfkHp1YsT4Z2DZ4=;
        b=ag6CNiujSQlB4qSeE5fRVSYKKBiv5Z2D/kzUFme0xaYQ3HmYedL2D2cOV1/3IYSbGo
         YqEutDGYiW04TpZR4Z+ZFfBpQKRcVw9NkJd38j1aw2Br6pfjIU4x/LmUVcxXCxU5wNl3
         umyVBs+J3QN0vN+BqWBCMTDKnGA9OluUag0Rhp03pEMFhMTgU21PEe/y51Jps7+baQ2s
         uC4Q9IMw+9ivOZuj1OvBNgyfNAiTNlHgZqyhQsMDexVRbw9b+XWO/iHSW4faVzPj4sQN
         CficwzIdM/2yZ1oUQBHbDmVnZ2+uOkxgtwPYEO0xAJUNkw7l0m4sbJYECoPy28GiwkMz
         jnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342487; x=1745947287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHZApYLBDslBvQML3OtPuVw3MhXtPfkHp1YsT4Z2DZ4=;
        b=gB2YOH6jM6tSElFDz/mTT6j2uC6cTQ4UzpUHGBNi2QtmdSeBghKH/jbETSViNQWoia
         Lf0QG0NaDYkoyP08WIiBE+i85vddQSwpF0HZguJ9iCFnjKs0gex3QrWbXfc4D9yafzrU
         iadt5UyZ+X2xUj/YIqi81fVws8b83U7jnYIZGgIGyIzUFVFE8LQDsyBzsgRgrHn/fFLF
         3Pqdv/UqBRrS6tcpJQ3VjSZcnIQgmfq+RwrVjqrmzGqeaQozIo9jPwVM0lMWg5IjrSK+
         9lS2zCg41w9NPwJiTZzzOVq2p1IzD1Xnzz/cxzKQzhHUD8zG1Iqe6Ra4pv7bGUTEWQP9
         2YUA==
X-Gm-Message-State: AOJu0Yy7MhD4MdMij7u3Qu33O3/MYE8iCcfoIqKlcJtsVci7ZP9SWh+T
	boAWebFmqHO6YfHo1Nb/g75WB9DiXDfHsVJg95Bf5jW6lUVQHR7yzAC5c3JyAEfJ8YYZY793NDv
	uBEj7cLBPzQ==
X-Google-Smtp-Source: AGHT+IHP4tvdMttMOgmAEKu1kTpji4rqqt+XoPjS/E9okdw+miOCnuv5g6VfesskAI3nKmX0BLLf+K2YJvlrdw==
X-Received: from plri5.prod.google.com ([2002:a17:903:32c5:b0:223:5693:a4e9])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da89:b0:224:76f:9e4a with SMTP id d9443c01a7336-22c53583df9mr231659425ad.14.1745342487583;
 Tue, 22 Apr 2025 10:21:27 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:21:23 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250422172123.281387-1-ipylypiv@google.com>
Subject: [PATCH v3] ata: libata-scsi: Do not set the INFORMATION field twice
 for ATA PT
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

For ATA PASS-THROUGH + fixed format sense data + NCQ autosense
the INFORMATION sense data field is being written twice:

- 1st write: (redundant)
scsi_set_sense_information() sets the INFORMATION field to ATA LBA.
This is incorrect for ATA PASS-THROUGH.

- 2nd write: (correct)
ata_scsi_set_passthru_sense_fields() sets the INFORMATION field
to ATA ERROR/STATUS/DEVICE/COUNT(7:0) as per SAT spec.

There is no user-visible issue because second write overwrites
the incorrect data from the first write.

This patch eliminates the reduntant write by moving the INFORMATION
sense data field population logic to ata_scsi_qc_complete().

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes in v3:
- Rewrote the commit message to clearly point that this patch removes
  a redundant write to the INFORMATION sense data field.

Changes in v2:
- Rephrased commit message to make it clearer.
- Dropped kernel-doc comment for the ata_scsi_set_sense_information().


 drivers/ata/libata-sata.c |  2 --
 drivers/ata/libata-scsi.c | 31 ++++++++++++++-----------------
 drivers/ata/libata.h      |  3 ---
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2e4463d3a356..74a0af2888fa 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1659,8 +1659,6 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		if (ata_scsi_sense_is_valid(sense_key, asc, ascq)) {
 			ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc,
 					   ascq);
-			ata_scsi_set_sense_information(dev, qc->scsicmd,
-						       &qc->result_tf);
 			qc->flags |= ATA_QCFLAG_SENSE_VALID;
 		}
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2796c0da8257..ef117a0bc248 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -216,17 +216,21 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
 }
 
-void ata_scsi_set_sense_information(struct ata_device *dev,
-				    struct scsi_cmnd *cmd,
-				    const struct ata_taskfile *tf)
+static void ata_scsi_set_sense_information(struct ata_queued_cmd *qc)
 {
 	u64 information;
 
-	information = ata_tf_read_block(tf, dev);
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(qc->dev,
+			    "missing result TF: can't set INFORMATION sense field\n");
+		return;
+	}
+
+	information = ata_tf_read_block(&qc->result_tf, qc->dev);
 	if (information == U64_MAX)
 		return;
 
-	scsi_set_sense_information(cmd->sense_buffer,
+	scsi_set_sense_information(qc->scsicmd->sense_buffer,
 				   SCSI_SENSE_BUFFERSIZE, information);
 }
 
@@ -971,8 +975,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
  *	ata_gen_ata_sense - generate a SCSI fixed sense block
  *	@qc: Command that we are erroring out
  *
- *	Generate sense block for a failed ATA command @qc.  Descriptor
- *	format is used to accommodate LBA48 block address.
+ *	Generate sense block for a failed ATA command @qc.
  *
  *	LOCKING:
  *	None.
@@ -982,8 +985,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
-	u64 block;
 	u8 sense_key, asc, ascq;
 
 	if (ata_dev_disabled(dev)) {
@@ -1014,12 +1015,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
-
-	block = ata_tf_read_block(&qc->result_tf, dev);
-	if (block == U64_MAX)
-		return;
-
-	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
 }
 
 void ata_scsi_sdev_config(struct scsi_device *sdev)
@@ -1679,8 +1674,10 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		ata_scsi_set_passthru_sense_fields(qc);
 		if (is_ck_cond_request)
 			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
-	} else if (is_error && !have_sense) {
-		ata_gen_ata_sense(qc);
+	} else if (is_error) {
+		if (!have_sense)
+			ata_gen_ata_sense(qc);
+		ata_scsi_set_sense_information(qc);
 	}
 
 	ata_qc_done(qc);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0337be4faec7..ce5c628fa6fd 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -141,9 +141,6 @@ extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_set_sense(struct ata_device *dev,
 			       struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
-extern void ata_scsi_set_sense_information(struct ata_device *dev,
-					   struct scsi_cmnd *cmd,
-					   const struct ata_taskfile *tf);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern void ata_scsi_dev_rescan(struct work_struct *work);
-- 
2.49.0.850.g28803427d3-goog

