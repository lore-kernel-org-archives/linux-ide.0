Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E588248C
	for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186654; cv=none; b=JAWkj3N+WgDSQvfkEpRKLpjeMS5MUzzyOiFjs8C8bcIrfM4c9xUBbKH3LxSESs+w33IQS1b8Uw3mSa8KR6uJYXEZn/Cue7J/u8ZOwUsaS+WH373O+gV9s3p2fJp2LSFvVsOnmecGaDkSItlansWKjQqToKzHDfvZolVgmwEtxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186654; c=relaxed/simple;
	bh=QlSA9hiBOJwtGTvv3d+KZKqMIR80gc0bbwPQ1YpYN8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ieyzBpF0nsat4mh2XVKZWf22IK2ECSOAkYhKnFUYCfq2IrAjdA18J4WIv441FpOeVll1zUgaMNT+c+EEWWUUZ4066OKPPjw9s/6cWxy6cpAHgv1+zwDG7dHZ84RCca7p9D1vsJfIStEOAPEs70El0mzlAgTV3ne945DWXlcTJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXzNh4Yg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXzNh4Yg"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso3422074a91.1
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2025 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743186652; x=1743791452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5XkgDAXtfNhaslF4bnTqMQ8YiZ2dz7Mj1Z8vySNZRM=;
        b=CXzNh4Ygi1HjkphcAJ8FQ/OciFDis1PNM5Mwfb6ZG5OKukq1yKvis2C++NMf5i1GLW
         ZxhHW3LeRZ5/Chu+C/Kjj91QVl0w43b88nYAfACYDGJqTOsFVxNxEoUCmmCGRLqtnMO7
         XTAsPu7B7iM6/RLQs2iRGAxuymPxB9WszbmITaus1Cx3NZ2Jv4eAnjtFv134TfR92Tbr
         RlQeOcFZdlc1Rt7CdJ52ZIKLrtS6n0bGeq72agPX9rlyv76fWUnJOKOatU14oWvbyyXk
         yzrYPCkSeBj0wBFBfeflONhBF7g1MUccQMTUHSUSQIBmdqB43pNlNpROsyjRMpGk5EuI
         E3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743186652; x=1743791452;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5XkgDAXtfNhaslF4bnTqMQ8YiZ2dz7Mj1Z8vySNZRM=;
        b=OxrwoLMSIBk/K4wq6/fnbCYY/m1YPIcVLgUNF3xl3EIKC1Aikoh47rDZInkP3KhuI7
         hDc1PjUpSkDAlf9UZrrz60bj4D88Yt3q121tMg6i/OpMMTM2YS4xt503NforxeKtULMG
         I5nz9M4qsQ64kfFE+f0v8+9Zl2uk2HeVcOyEW4EAe9RABV+QkGDL6YYFHpECBltUvk7J
         +Rma1WtdHRGBBQIcIxG6HXLGDb3GSIz1VRvYWj/2CyI0zwUsAV4F3a3jTTFBZ/jnGmu2
         BST9Lu7uXQcMT4z68GxlgHc9dtDyiyuW2mQPOkQD+ukm+PxmbrJTWeaPV0TcQs25iB9f
         cL5Q==
X-Gm-Message-State: AOJu0Yzy6uggw6ZJBF7+NZoVmj01eMIj0gHcynFqUUWw0bhqnbUCHZe3
	seTl0gZ9JuVIqg0hn6dm7CTbQidvSTWOMPLDNpdhwB2cGCaSmEbjIIVDTyBpkWG5ZyX6F76CNvS
	U+UcZ7vZirA==
X-Google-Smtp-Source: AGHT+IFqMcmkQpb/45N2xHdJ5aJZJhkXbmjyHxZPwm9DA2WaQFXT/ONnoxMUUEDtuGLd5HfQUSPJx5J0NUGdEA==
X-Received: from pgac13.prod.google.com ([2002:a05:6a02:294d:b0:af2:5aab:ff5c])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6b0c:b0:1f5:a3e8:64c8 with SMTP id adf61e73a8af0-2009f79453emr587875637.36.1743186652206;
 Fri, 28 Mar 2025 11:30:52 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:30:46 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328183047.2132370-1-ipylypiv@google.com>
Subject: [PATCH] ata: libata-scsi: Set INFORMATION sense data field consistently
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Populate the INFORMATION field with ATA LBA when sense data is obtained
by the ata_eh_request_sense(). Kernel already populates the INFORMATION
field when sense data is reported via autosense or when it is generated
by the ata_gen_ata_sense().

ATA PASS-THROUGH commands, unlike regular ATA commands, populate
the INFORMATION field with ATA ERROR, STATUS, DEVICE, and COUNT(7:0)
fields thus setting ATA LBA into the INFORMATION field is incorrect.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-sata.c |  2 --
 drivers/ata/libata-scsi.c | 40 ++++++++++++++++++++++-----------------
 drivers/ata/libata.h      |  3 ---
 3 files changed, 23 insertions(+), 22 deletions(-)

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
index 2796c0da8257..7e93581439b2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -216,17 +216,30 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
 }
 
-void ata_scsi_set_sense_information(struct ata_device *dev,
-				    struct scsi_cmnd *cmd,
-				    const struct ata_taskfile *tf)
+/**
+ *	ata_scsi_set_sense_information - Populate INFORMATION field
+ *	@qc: ATA command
+ *
+ *	Populates the INFORMATION field with ATA LBA.
+ *
+ *	LOCKING:
+ *	None.
+ */
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
 
@@ -971,8 +984,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
  *	ata_gen_ata_sense - generate a SCSI fixed sense block
  *	@qc: Command that we are erroring out
  *
- *	Generate sense block for a failed ATA command @qc.  Descriptor
- *	format is used to accommodate LBA48 block address.
+ *	Generate sense block for a failed ATA command @qc.
  *
  *	LOCKING:
  *	None.
@@ -982,8 +994,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
-	u64 block;
 	u8 sense_key, asc, ascq;
 
 	if (ata_dev_disabled(dev)) {
@@ -1014,12 +1024,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
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
@@ -1679,8 +1683,10 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
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
2.49.0.472.ge94155a9ec-goog

