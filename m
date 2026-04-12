Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A146CA5A
	for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008204; cv=none; b=j2F1Wp3qOvIDSwUXRxJhaIsUqPoHEVx6r2Ti7l0jb1lHizyFMMw3O1ToF90rWXO51fOEyf5zgxVAOOqeWLYBx42oJrTKccBgz8bY5CBYHlXuiOPuVHi/iBuVngggwXb2Bx3W9S/gJtatT1meYNBWvWRaxBNUmzbDqLDgMo+86vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008204; c=relaxed/simple;
	bh=tRRvi5YtRVXMY4QJsM9F6kWKMx/wNMB3++ordcHvjY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TwoNoblCz/vErARKcwxGIU83APqMCRaQOdOyV9zI0WHwrySA/C+Mjy11DVq/Znyjh2i2azN7+tTjK4rwUAFWU9Lc80OjMHgMG2W6EBxBcHBlxZ3pyQ2gKxIJCFNZKQv+DB29N9uWbagAcDSnlmRbvDexGQDFLoOfkOUWNmDoCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH4q2jSr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH4q2jSr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f3eaf4b9aso41534b3a.0
        for <linux-ide@vger.kernel.org>; Sun, 12 Apr 2026 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776008201; x=1776613001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zIIsrwYoyoyzN/bzsbXwITV0IR2iB/tzp3wGCo7y0Zw=;
        b=dH4q2jSreBUceZPNq96jlFO823mQDHP1sJS3qfgaduuEDke2pyNjhy/Tu4KYeTzAIk
         Q2y1S+jlvhHz+H9b72OpyQLDa9zVdQllYnY+h12u7/zG/Z9D9yUTkjl7FTVJPSrcRest
         mehqBFyiRsxwJYRDScdb0om9tfuGWkJn68Mft+iWlshVmZneBrX9n7B2DdVPsPG6v4+u
         9wX+P7Nt1Y5baYCuV7+LHMBau1hEeRrlkoUmmDAU2jSsFhCeLEfEMk3M/pv9gtDmZdmz
         8aVkaxY9H3wFcTWR8QYuALhnBmACvypp4ekBY2QQpS3o3StC4iJTWE9Fz5HMBri9Jscz
         kl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776008201; x=1776613001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIIsrwYoyoyzN/bzsbXwITV0IR2iB/tzp3wGCo7y0Zw=;
        b=QPjQs6CsMzWkYN9ON8WYepPbnOJ2TMN3e9dPwCa8yM1ZbB6CPtvErE+FZ5ruqgc56f
         rGrhX4R4+uSw2XCAbmc14EEC3RzC9i/eY4y6AtCY0/iEgrfYAPmFUgPniCx2px4xFcxi
         qJen3ALZv5/S8zjNd8LjULq5Y3TpS2LCoMRQcah42Vy33m1k99QsYISQtXYQmz90yjbP
         YSHsNEA3BkE3w2eg9MEuTZA8tjkbY9ICBovQ/yFKDy14G7sQOsDdAfP7wXsuSFdwVDnB
         r5faZ1PH3CUNOd8RvEe8iUHuSjXM6eygHdwei2fQ0dlmZdnC7FNdQitCN8lRwlTfotO9
         UwXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6cAbUlYu6+TQqGenHcXtyzMXhWsOIxSnbGaT4hw1h/W5StF8oISYxQ0mLD04zxKt1vaco/jj5yzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRxH3FaAdlyC6V4MDlVFe3EvueA4MKn2wiD6tPAuH2GVTJ0JL
	h+mo4Y8zdGGt3i3uvHBsqofapUyP8V5faegW3Ul/T2GX8LLnS/bzprE/8dQiLL7NVUmMly3et0H
	hlIKH1+kZCy2xIA==
X-Received: from pfgs39.prod.google.com ([2002:a05:6a00:17a7:b0:82c:e9cd:a73f])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e05:b0:82f:37e3:ae72 with SMTP id d2e1a72fcca58-82f37e3b155mr2033486b3a.5.1776008201289;
 Sun, 12 Apr 2026 08:36:41 -0700 (PDT)
Date: Sun, 12 Apr 2026 08:36:37 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412153637.475606-1-ipylypiv@google.com>
Subject: [PATCH v=2] ata: libata-scsi: fix requeue of deferred ATA
 PASS-THROUGH commands
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>, 
	Xingui Yang <yangxingui@huawei.com>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
during resets or NCQ failures. This deferral logic completed commands
with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.

However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
to zero. This causes the mid-layer to fail the command immediately
instead of retrying, even though the command was never actually issued
to the hardware.

Switch to DID_REQUEUE to ensure these commands are inserted back into
the request queue regardless of retry limits.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes from v1:
- Dropped the usage of set_host_byte() because it is logically a separate
  change from what this commit is fixing. set_host_byte() does not clear
  the status byte and the ML byte.

 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3b65df914ebb..cd607911d724 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1692,7 +1692,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	/*
 	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
 	 * do not try to be smart about what to do with this deferred command
-	 * and simply retry it by completing it with DID_SOFT_ERROR.
+	 * and simply requeue it by completing it with DID_REQUEUE.
 	 */
 	if (!qc)
 		return;
@@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
 	ap->deferred_qc = NULL;
 	cancel_work(&ap->deferred_qc_work);
 	ata_qc_free(qc);
-	scmd->result = (DID_SOFT_ERROR << 16);
+	scmd->result = (DID_REQUEUE << 16);
 	scsi_done(scmd);
 }
 
-- 
2.53.0.1213.gd9a14994de-goog

