Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9E4315C
	for <linux-ide@vger.kernel.org>; Thu,  3 Apr 2025 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715771; cv=none; b=oIMdAR/wrA+8U30ftz4Yy2PLVnDSssu504kdfTaQRhH+szvHvi8IpuFjRpf6XEaw1685yAGF/NAHvYgRTqka37wVfqucLjJHo29Sh0cJr5QZVkKmjshcWAhBM3fUBzf2CU0reINLL5h9TefYbDYqgidJyiB8eLu0fLdbfmYCO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715771; c=relaxed/simple;
	bh=nlwF+7zQGq2HUh16yYIyEZYJ+TKektWBRDNwXwNzVoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MVpISVy5U9B8Zgm9KRYm28F4zRHT3B02SLNE89UV0U25oTkDM4wSizttP8BhjL/b9BMAv2PuqFEAzbYK2JO9eTxjDr/r16lyumBVw0ZYGW7uoHxsFodAPD0Gd9HjdVPLDgSYcC10zaG3u5BO1Eqz+ZiJC5RNS8Y7SZQsuztSwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TR7qM9M1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TR7qM9M1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22651aca434so14519355ad.1
        for <linux-ide@vger.kernel.org>; Thu, 03 Apr 2025 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743715768; x=1744320568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o0cnUQbWUsiUv5dGgvP3QCnvz4IYCWsIxDLFEGTUwHE=;
        b=TR7qM9M15ZmRCZKmOPHJ88VMuP9GxN3mAue+N+19AM+cCiVhI6V4aoUqiEl0uWsJvm
         UZ/JuGWEBGZMDxZpkqn7sthSMJH6MJypUT1Lxo2wu/zsr1Hy2RaYjhW4cf9jZ7A9IPJw
         QZ7hCFqAXrzUvmDkklKrS7Jyn0Qzx5QeprPr3B6VzPVawIydAZ+jBPtAH+ed2t9EQ4V/
         QS+zGGBqaoL7M8oqxLUHwsurVlzRa6W8fBaar/+ZltBS/58ZPTbtXzBn6V9tlmI57L7a
         s433jzNySzEwzN3tpmbFgUtxGZue7SshgdFzNjszsWCp1I/Nm7fuXUfl8T8Ks0nbqlVW
         0L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715768; x=1744320568;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0cnUQbWUsiUv5dGgvP3QCnvz4IYCWsIxDLFEGTUwHE=;
        b=Tu009au1R5etf5QKEHjAd2OPOfPGvd2kKvmsW4vcyJ6yvCAst+lj3h3qWtZNeo7lok
         XgHWZgeHfAwzVgLKXeO2ueCN1f9gm+X8lQrAjUtV9HHLnN07YsL/NvJmbGytmM+y05YL
         3+zd2WxDrjQzBJ1mGo9D9ZmgeDgTgMTrmXdZYir8C85eQdXODeZTi6Q+UkA1d4EmZwLa
         YTuTvbH2UPLtcW9M129Y1TVt6lQaVh7YQVlPibta+gsXEeck4aVT7ch9X7+Dsc8s2Kmn
         qMD9mJmcA2Fq/jKKyzBg/FV8CbSuS+eDw9/7Nds6ji4waUSOJEgd+LWPXcgalBoPHees
         jPog==
X-Gm-Message-State: AOJu0Yw9kHAsusW/K4mTAKL3rgasUpAZN2uHcrTsEjMOb0ycSRXsPxX3
	lpWuVb6NxHiqWCHLigLhvUbLnRWpK5aluVc5lUeOTiuW/uVjfQ5btLss8q+cU4jDVYQbQLNx/QD
	KmowcQFRLqw==
X-Google-Smtp-Source: AGHT+IHPtQAcMp97iUwO+iKmkYZGdnjkx3hYPOwQLgDFnvdTsvGov+e4Tx0+KFjRc+ZlGneeC+uKFiwmQdRIHw==
X-Received: from pfblg21.prod.google.com ([2002:a05:6a00:7095:b0:737:69cc:5b41])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f544:b0:21f:8453:7484 with SMTP id d9443c01a7336-22a8a87ec03mr5663175ad.30.1743715768494;
 Thu, 03 Apr 2025 14:29:28 -0700 (PDT)
Date: Thu,  3 Apr 2025 14:29:24 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403212924.306782-1-ipylypiv@google.com>
Subject: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field consistently
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The INFORMATION field is not set when sense data is obtained using
ata_eh_request_sense(). Move the ata_scsi_set_sense_information() call
to ata_scsi_qc_complete() to consistently set the INFORMATION field
regardless of the way how the sense data is obtained.

This call should be limited to regular commands only, as the INFORMATION
field is populated with different data for ATA PASS-THROUGH commands.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes in v2:
- Rephrased commit message to make it clearer.
- Dropped kernel-doc comment for the ata_scsi_set_sense_information().

 drivers/ata/libata-sata.c |  2 --
 drivers/ata/libata-scsi.c | 31 ++++++++++++++-----------------
 drivers/ata/libata.h      |  3 ---
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ba300cc0a3a3..b01b52e95352 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1644,8 +1644,6 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
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
2.49.0.504.g3bcea36a83-goog

