Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552C77105
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888473; cv=none; b=NAPxJexTKlh+hSd6Flp84UF5Hxk0SvBHBcVxuD9w9ZiG49twjFNWC5bZTome3TxzKPjjKgki0B4ZiPsn6w08pIdMF3cbK9xX2M0dIqGaVOW8QUiNvG+O+U8Ff73xMtM+Kkab8qL3ig3EjSqddM2RMyn4QVH+iXXB+dvJaJNg+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888473; c=relaxed/simple;
	bh=DNUVAyv47k38434cyzshYGZfiQCUuvKrQV4LMhKazxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boAxflj7mhOWDrcO6sYdHBrXbkElSZlfOzVloTZlx2KdZj4B6erA4ChDxNy7nRaRL4KuBoadHoD1W3HieetmDN8f/tKulxdFmbAWtD7SG9MJDSb4TTPYN2T2wO32efCe6+pPcALaXcT336KL+cF/hUSHuGkjKj3HEe1B9da/5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+rm9ksd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+rm9ksd"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353bb2fecso6763802276.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888471; x=1720493271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MNHowcTUXzmf64pvPdyG2MLqdUXcPdrWLseGnurKJE=;
        b=j+rm9ksdzdgSAUbKc/pFbe+Rof518Kmp5lV05UDJoHNHDQ43//QoDdeMFDnzxZZ819
         pKz1ccJuz1MRQIkNQboL5Txyeb6KZHCxtFC8XLF3+WO5ghpQze4dheHb0GZWuBpIWaZy
         23QmZgPx1OmqyZCF92gaglnJaB8m+hHu5bWX+CmsLefjNFN9KNmyorJvExjuHb8PEmfL
         1oMbUOhwb6Qy86eVAtebekL5+Zmf+xux2ZSOmJsra15fC+PoOWA+ij0KcuPJGtHg4/NS
         FdyPZVTIWQYix0e+wSEWeuTR5cATS3WnAC+gMupmDKHB5d4ijnSorr21AELjYS/dq9bA
         L7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888471; x=1720493271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MNHowcTUXzmf64pvPdyG2MLqdUXcPdrWLseGnurKJE=;
        b=rC0NgLo/6/+JnhhNPG1Bisz9aIij1lL2sB4Uw2ZPhhjIVh+0XoqNX9dgEdEVF0ADbv
         yV9emWPRn8pJC0YEuuRkFtj0ze3DlD/x8IRJAIMsEOOUJ12Tz8zPJQOpOTsgdzGxGwMi
         ztw3xGiweG8HaRhsElzzouoqzr3hRum+8gCKd0YuPQVy0+wiTEJTJlZC+og/MohamLpm
         JVw/76PMLXckAD6vAmTn7K7gRYVyQTp+eLJHHjwTDy25s7hzVE9n9TGtXNhZqc5pj2aA
         t4gmblyST7D0WmEQSAngGsDV8RhT/SYzwZkNGQep0657qZNKJ7DgsUoBF/sieTH8RoDu
         adrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8rdNZaQkL/n4sPbZ7pQYg2xtF4E9UP7YzJ1Idelch1DrHHwZ8frahPxNz4sDDm5WDM0TRgiHaPOYW1IsazPeNT9EDfxLAr/mA
X-Gm-Message-State: AOJu0YyUIYP913DbJgC8Y30+lzGFfnWUhqR9H3S4rXI7b6YvzTJRnDnC
	DXb2OkqUZKHAJBolPH2UNggUVnLFf/ujguFdzjK4Wf0XhB4hj7TXVDSNJ10AxqmylkoOVi5u/OY
	8p9ZCzFBk9w==
X-Google-Smtp-Source: AGHT+IFI/SVSIyN6BwKOfwv+gERTLL4AsKvZU1MITQc3NOrEJnH3r1eYrd/ssXsWI6jJqzXGObMENfBEDs9jVw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:2d91:b0:e03:250f:c1ee with SMTP
 id 3f1490d57ef6-e036eb5e687mr63261276.5.1719888471621; Mon, 01 Jul 2024
 19:47:51 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:35 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-8-ipylypiv@google.com>
Subject: [PATCH v5 7/7] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
 using result_tf
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 226a36c9504b..8f21b3b0bc75 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -242,10 +242,17 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
  */
 static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't set ATA PT sense fields\n");
+		return;
+	}
+
 	if ((sb[0] & 0x7f) >= 0x72) {
 		unsigned char *desc;
 		u8 len;
@@ -923,10 +930,17 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
  */
 static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	u8 sense_key, asc, ascq;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't generate ATA PT sense data\n");
+		return;
+	}
+
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -967,6 +981,13 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't generate sense data\n");
+		return;
+	}
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.45.2.803.g4e1b14247a-goog

