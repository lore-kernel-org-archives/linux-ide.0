Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3736308D
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146032; cv=none; b=ZBZlyIhCJT93ij1VPxCQ9zF60IzPg8gcfOfQvlQHnZ6rmUo7cAuFgL1RooQ4ZvYu5zeXmDB/aGUMlh6LqMMe14Gf7yTnLaB5LFcuEIUJ5/fju2S157KB3f4eYZAaM+SQPMvcHEzqP1SypflZjVkcxRSqoDoMgL8aSA+r84xyZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146032; c=relaxed/simple;
	bh=lJJPLiWQ88hF2omeXe9q0oHz1xITYMdJjEh/PkMHz9g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uqJ1qOi7d4ny7imgBjCkX1qFrgwAdom+drgrov59+VArWe+C0M+fgpaR9UPkMx0LrV+fmrSPQKniymq2zPOpPz3k9w0jyo/dlymQ7MP0vDCS1RQ0EFmrtjplMKZwVDtwVpAxsK+X3zhwECVPWRuRW9jXfgqeom3BaA7z228veB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXO1DQmP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXO1DQmP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce1c395ccso1534368b3a.2
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775146030; x=1775750830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tY3YLUnv7koH8w7vvcawAH8VEOQcI6MwE/0pyNwOOEs=;
        b=aXO1DQmPwvZtoKItVobD136gWUmQtqL4adFvwQl4KLICUv3teKt/O+Mu8xAz54s2w2
         wptloYqcZ1NoEKm9RGROdM03D5TFZRXkVDBZxoQ/JzQ19bAt5QfPZw02y71T5ydzsVW9
         L65LXdlt9OLEjoYAnseb0TGE5I5FR/zpZAFcOLon/04GyliFeyt4SNioIFdeAKF07tU1
         i1ZwM4S/LO2J3AApQD8DsUBiryTVKqZGhDKkDtt2lZn2cS38tLmoUgVJ6/B1mCB6N45x
         9UGE0Oo5T3TEivMyRjlCSmMf3kHEo88Aq86YexQBx0CQMuK/qKNic3V8nPJULCNv4gZA
         YmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146030; x=1775750830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tY3YLUnv7koH8w7vvcawAH8VEOQcI6MwE/0pyNwOOEs=;
        b=ShDh7vwhd70IymteAYqqcH88BNFMNz808EMGC/YvE67/LFS0oekGvqg1Zum8W+KL67
         bYji6/6G3LTnPGqEelFLZvSVVW6RmsTwX5ujYU+FQWJMlT8F+JHDcwdy68N0+jeayoh6
         2YT3w3sQbo1ElZLqVe3Q0cNwXFOmz2ysHAYOnp0syq4zVMN6cS3/X78eVZFfKMV26VcB
         A0priQYlCYAO3gR5pe532icxvP79I2bTqP69CxEplrEgysA7yjjoEm/J5PQktMf1cFxo
         FdhAaTkcQ0wfHGCyFeY7oDv7iQkKcP7dbY8RIT4d4G170MM2hmkhl08XrHaOPSYmVoWD
         FRvg==
X-Gm-Message-State: AOJu0YzvlPlghbM0fSsZmZNDliGE0KvcwidNUiv14CuFC0kJrfWnOZM+
	Y2hQLf4QrPFSnnDH2lW6ye6EwQbUT1o+ZmPwKG/IZgrRsD1Tkwy6LLdcEZ0j5i+rZRPeQxTjoCQ
	QE9no7Acpoj0YJA==
X-Received: from pfbhw14.prod.google.com ([2002:a05:6a00:890e:b0:82a:ff5:27be])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1888:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-82ce8957dd1mr9088627b3a.20.1775146029269;
 Thu, 02 Apr 2026 09:07:09 -0700 (PDT)
Date: Thu,  2 Apr 2026 09:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402160705.1033273-1-ipylypiv@google.com>
Subject: [PATCH v2] ata: libata-eh: Do not retry reset if the device is gone
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

If a device is hot-unplugged or otherwise disappears during error handling,
ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
continue to retry the reset operation up to max_tries times.

Prevent unnecessary reset retries by exiting the loop early when
ata_do_reset() returns -ENODEV.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes from v1:
- Corrected the commit message to reference ata_do_reset() instead of
  ata_eh_reset() for the early loop break.

drivers/ata/libata-eh.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 23be85418b3b..e97a842005e9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3171,7 +3171,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (try >= max_tries) {
+	if (try >= max_tries || rc == -ENODEV) {
 		/*
 		 * Thaw host port even if reset failed, so that the port
 		 * can be retried on the next phy event.  This risks
-- 
2.53.0.1185.g05d4b7b318-goog

