Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593B172BBA
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863899; cv=none; b=NIuynlRzEmFwlU55p6Qt7jglf0Vci8Lm2NrDUNkEuZ7kcp2SUfhxNvma0LDrqmJNHAhqlyv/wLQDO8KN8v5LZbp97boErLk5ts6npjQmibSR9Zv2MWJnMAvqnyI1zmq9SBLsSdNv5iwDC6AKu3AAGKJkU3Y+0v7dvh9W249DhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863899; c=relaxed/simple;
	bh=TdwWxPt68vemC3NjLpNegwFE9LXNnMsLaGF7PK7//vE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJcwTIYqn/0tZW1FPUvErAC99gLYZKsdYe0RWy2XWLf2ZGGysbymiIrc5eKO2EP1OF8U7w/jsi+0EhGBPZX/kkOnmq+1yskqR1SF8AWV7PwcMpQvnAVQz4TkNE8UYXOgmrYMlgbWt4+RjG+E1LKVJSGL6XT1YpF/ZiJxudiA6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCtS9x2R; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCtS9x2R"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70d8b7924e7so2016544a12.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863897; x=1720468697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAE+S7QoWzFH/OclA3EgmIeGcizxeFkCmPKpIfdU7EE=;
        b=JCtS9x2R0x7nXvkMbjq7/Mq+2+zaq/R7/Ecer4K/gfErnNAxpYOK7LENS4rjeYGj1l
         /5aoh51sMyBqLvHNmiMM0xvXQHI512uOBiuqPlY9rz6e531dgNyUS6Cj7FxXVHg4zWEo
         rjyNCaDhRQp1UVg+5k2lH1E7uHyjX7y1InJTEshYVR+ucoB8yfnUKYghI+mBCa957uoo
         pK7QBtPck6+OYEMGVJLshZJpKDp7c6zJC7bdk7ZvWVrL3A7xw8kFbPD5YRi0ep1LhVX+
         W6zKdQAoao9Q1+6aDQkyDar3CQ42m31TQLB9xc81K/Oi29nVxpc8LkaBQqi1ZZWdU1kj
         zJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863897; x=1720468697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAE+S7QoWzFH/OclA3EgmIeGcizxeFkCmPKpIfdU7EE=;
        b=Vg/ddyq6jNG3OD2uFvlHu46f5nhNJWFyITRxajmssFpFzbwHlMIMyjY6gSIuWwc6rY
         i0nY9VvWdqEV/wqGY2c1uXrhjLEMWY19GYYe6kXfNvD0txBt8aTjJo1pjU5zJyy+cBpO
         s1ip8mO5NLgY/aehgJL4jIz9zT650lpSQhbUXKZ3Pe506zgGnRW2H2RsrLhlUpySifOx
         hl6qP5RaBlp7GZZCQCIckGvQcH4WOb1PEX5u65PIS68dvjENnJ70Mp4u+ToxZb5rwwUI
         Cr4dpRiy7uY44X2FD485K2cmA+b527Wsl1Pa2SdxyJKLfcBs8ZsQ+b5NIlrXgokwNmEO
         P46g==
X-Forwarded-Encrypted: i=1; AJvYcCVeH1VDiMw1lxUL8lz4NCyFDMaVfyYNZieydwfTr22ckvCuU2/tzncSQNb85F3uLfrAevE/O/OBgkIPdHL7rPv53pJh4Aho1RWY
X-Gm-Message-State: AOJu0YzyRB4LdLUMSwQsliyPhbYnuA6fNal+vETzej7z16ppGd5fhx5m
	s+4TMS9/BJrgKBoJjPUxBo8iVWWpy/ws8xF/eIt5yDfyhIJgPQvkNekvGHxZivEAYmF1ogZHWkX
	a44MbT1eOVA==
X-Google-Smtp-Source: AGHT+IGeBjcfeksNmObJJCdjEL5DSD5FQ7r2tl+wmERKHImybrRhNIc+EbJN086wSbYxF7ttUGty6fFeKxqwDw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:3347:0:b0:718:b441:478f with SMTP id
 41be03b00d2f7-73cf2c29ad8mr16400a12.3.1719863896897; Mon, 01 Jul 2024
 12:58:16 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:57 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-8-ipylypiv@google.com>
Subject: [PATCH v4 7/8] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
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
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 92d75780fc3b..a66c177b6087 100644
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

