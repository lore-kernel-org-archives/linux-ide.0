Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F37194099
	for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443071; cv=none; b=rHigrRA/ugiA/qkKLD+oLleAK0muANDNi7dHbOEk8xnql1euEFC4zvC6DcQTB6LyBXgSFUW3O0i6Z+jCcygVn43v9dXN2BrRAWzPzlyCcODwNvcLrH8eaI4yq9Wji6SAGsv5brQvwoDSlC7YS16C8kGUPpltJ1EO+upNDO3VnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443071; c=relaxed/simple;
	bh=QOUE3m85wg/4GIuezGsx91HxmkwAowzlGh5n1SnE+jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5c+ec0RjiQb/53ZAZCYhNj6VCOhDLeVvndntLNgDbYgGqOsMzWjzKIMwmgfHX/18E/y1PyziSgFvynqmBYwdVuUV1VG2oRTfd0EiiPWwJ2AORKhNLhsCalRkpXSi6rV6YLy4fXh+3+1+Pmmd/2Up0nANEzAyqDSIoWtV1gNevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NyliBBX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NyliBBX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6174d0421so79516005ad.2
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443069; x=1720047869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRuxhaMQ+1lW78nuyDa9Lm/q++gXoPPs3JwtC5y4GFo=;
        b=3NyliBBXP/fMKNHYsdd9Rjno6iYeRXJ9Q0JR8vH8xzdYYZbQo7ZIN4jVnXAQwNL5N0
         GXiVIpz1DUDINdc1ZHbfDtOQId92SmFdjl2FuR0fYCCm/rDcaFuiRUyjoPNUAlXM2vEP
         JhGTCoPf9gqLqZx4l9fupbIcFRdFn9FnPawUsw7OuTq4VgG2g7iKBnEgBk6QfksEQuYr
         Em132c68o7KwcGsJnYp3fnkh2MfiUKdnIkaGVu0FVwZ3+cj/+BRFSbWTKJVXtq+cXqbA
         bQitxYyTu1NuWXLXnYGpt4JYFkSGlYJOXKaBf2STv1TwhogdMyXt5XDjYjZ3ItjIGiom
         Or8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443069; x=1720047869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRuxhaMQ+1lW78nuyDa9Lm/q++gXoPPs3JwtC5y4GFo=;
        b=ihQqYX+rc0jJUFwLydb2pF24CChUULX/UcSRRt31skNy2y5X/JKyRAzdY/LXcvzLsP
         pt1TVRGRxd20+Ihj6PHwS6VwPKKHZKEP0DhGDXr9mbf88BdgXowuH8YdtSV7Sno4FbTJ
         VexMT6li1q4jIyi2r7MetAT4y1l1vEs3ps0j93dZ3SdRvlZbn6Qi+5h061bAUm0X/DTa
         NC5yFvIr9pJvuKvMP22NeNVx8b+ZeStxrR6tfHGc715WrbpTgTFDsYN66j2x/OdSYp25
         fUiwKqLD3o0tCUaHUdWWOQ5QgEBywCLNmQRYzbjvo3cCBHkZg9Sqbf3aLwz8fIBMwMet
         Ga/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmdtfocilOBHHUnrTHI16z/uVNbFLb/A5YJZFN87lBdxzK0o1NQNksjdQNuvlenYzRsoNZjfne/ZNXsatmCXQi1gfID5W+O1kX
X-Gm-Message-State: AOJu0Ywg9eS3d1sm3W3nVDP3QXnirQGKyuoOrmheEC6Si85P3dw61BSF
	dMRU3utw9k8ft+CGl95XFhDzxlHQQPrP2KGQUineENk2HFP1msTvExeCHwtNcR7r+Z3zAbDrApw
	QxKc/HtAIMw==
X-Google-Smtp-Source: AGHT+IEIAPNfqnBOOftySkpy/S1qLhtNZDiXS8lsXqrU0dYyZt2TBCiMdv15J5+VPG4DtZa7SQgsCmuWlH4hFA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:c40c:b0:1fa:1be4:1e5c with SMTP
 id d9443c01a7336-1fa1be42246mr10318515ad.3.1719443069215; Wed, 26 Jun 2024
 16:04:29 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:08 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-4-ipylypiv@google.com>
Subject: [PATCH v3 3/6] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..6b6e35292620 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -968,8 +965,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.803.g4e1b14247a-goog

