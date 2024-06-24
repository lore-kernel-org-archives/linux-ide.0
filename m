Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCF1A2576
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267157; cv=none; b=gysHaN9Ns/cfkDE0NHhf1gOYpWfu8PxiaM8Iou6cHTEfPALsNV/QbicD7hSGZXhzO/+Xe/8RoVANx6Mhw5gRa2ynw0PBpCZpNoWMIMII76vxIxz6U3y/kklY5xLDiIXUVfUfkasTZuhWB2SJ5E64jGAKnxhdlfROeC14Wr3acKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267157; c=relaxed/simple;
	bh=Up6V+DxPHud41/ok240Yxqnh88BYXSB4LT1/yseuVM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYIfayrxlS25PErJisITLfCP24ZdUR/klfAt9TFEKE/KmsV71RVStvjWFY9Y7YzCm3KlZdo4ZXoVmmy91weX5sShBoHhQGzYmnpn6banlny+sDQZU9E1J0G02H1fKA0RJBhWGel0vt6BCaTcBK8TZ08SEEV1B3r1x+r4t/ClUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj8rYbhh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj8rYbhh"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0322e5d0daso323936276.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267155; x=1719871955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUtfz3bhoNl6XZdgw0Jyrha+rGGjCaq3OYUhxmJGLk4=;
        b=Dj8rYbhhg1U61NnC+WnlENUSx8Z+mvtXpEIK3qKgugdZNvOQOmHspwnF+lr9U0KBZU
         Uz1QWa/8ubDpfKa+zAw10x1UjFo1MZO5/1+SI92iNoGxJRACdVY9pRsOdj5sRe1FbZfP
         Ef5s+9lBSP1e4ibSBHrMpTJJVhXzly14XEn3+aB5qWy9N77TwchrIaBWfp6LszhSBDIo
         aWQAc2YFWe3ZQcA23zu58vT1Y0DZ8BVkgv3nPEb19/g18eYPnW5wxRbzjzFF2tHzAbu2
         GtDnPQ4CxHaIWTkSlkb025FmjkWO1ZIELveob2QCWY/gTXWe16I03TQeBhg7Rwt180pz
         cwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267155; x=1719871955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUtfz3bhoNl6XZdgw0Jyrha+rGGjCaq3OYUhxmJGLk4=;
        b=kDKdSG5fnOrUsp1EA9lT8bsSf89IgEOg9UTrnGJOfcQWFxjQVk17m97lCyCCk5R4Wc
         QXS0kGGgVQJh1EtXbeNbYsq3E4fb7QIcjk6TkJWUOk/z0XTEEVo+5fWBBdCBbd8f9eZR
         JltyE9SoYp3V+cWjy9GbGjm7wv1N09SfqkuH1FNBXbpnVLYf1TbmHjhjqDNyNG/n1Ffd
         MxtF6ijbXXXOoJtWGxGxIrXOX291Tp/OUd4uMdukww56bMMn0fhFUL8yt6xvkz6CbqMk
         IBDi8CYMZmpsJ8hz993BRluggXFkGEEaRumpHBlibm6OWcBuQex3YhAoQq4gD95cH7RI
         aRNA==
X-Forwarded-Encrypted: i=1; AJvYcCXX0Yz3dVh9ZpFDBPkEiLs58qaswVsWlYw4lHorAU+OSW31J4YqILNacg0NWKyQiSGWxjJwgPvQ5JH9RYZfxPz57+ADV/dsZAjw
X-Gm-Message-State: AOJu0Ywz6zpebYliGm3eqq+Y8ZBeDPADjHqVuAeeDSOHMp5hSlO5O1h7
	H7UQj8rWh3d0jq7v0axLFRd69LQN3KqDAs/PADgAzEP4Mbmndep2ZQXsQRizouC4Jer7FNK2wHz
	q2jIbehUr0w==
X-Google-Smtp-Source: AGHT+IFOerdlJvZ2UgYsr6VZcIvadTxqhWj051FHAGqyrWnnWeZQEP6tOT2f0SoGARXgYQA2WDQyb34wRFw//Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1208:b0:e02:bde8:1057 with SMTP
 id 3f1490d57ef6-e02fa3242e1mr303000276.1.1719267155506; Mon, 24 Jun 2024
 15:12:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:07 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-4-ipylypiv@google.com>
Subject: [PATCH v2 3/6] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..1aeab6e1c8b3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -929,8 +929,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -968,8 +966,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.741.gdbec12cfda-goog

