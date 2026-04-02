Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391031F9A4
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120803; cv=none; b=WNLlIaEdduGHuRHJYKJ4rOvp2YLAxwhPFZnWcq5vmPKrDSehoHfgRHKt81KSZ+bqeoyb1oPctTP+OYu1wJOa+efN5OroIb6F4vaCL1ngw1Kjzgj26BMHCOeZEMZAghFGkhYLgDsv5nx+Q361OJdhYoXR4e/BvmC0PLNRvwJ/gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120803; c=relaxed/simple;
	bh=TvE0ShnDfsPJcHgLlx9dLvY4D53BW24CXeXfrsIZALg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRyCNj9PxQEuXy0G7VhBlH824OWHJ9VqPLmxSUGqEFOwWgDmOu0DuBZIKeFIZfKG3WbA45fPoqax/7hvv04wB/tNxchj3XXVxKdRA33P2Im6EUMqFyN7KUMcjM9P62Nkx9VvoSz9mZ+mmJ1lQkx90vR3RCtYkQg5WiOyUNU6oF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpSltXqf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpSltXqf"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so300062b3a.1
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120801; x=1775725601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NHkPd71whA6OvRg4mcESCl7NRtMfCv3203TjuFyqQI=;
        b=JpSltXqfLeTiwKNTG7fANmERoCX4tmiU5AmdkBR/0EgTBA9EVZSL37qCCnhn56ElQW
         +u3zHRNO8+PTtm+4zmiik/d4rAL/H6QcXY0jZ7UMxnWakZ+fqipvu4Eg1IW0As3/dt/R
         cUQ67h4oFTbQ+5ujoi6Nna1S0b5re9nGx60Ar2uXjqy4lw8pNBEQEg4mOyXy8mqHYmeh
         OyC7wzS5QO/lntOm8CC0+Q9J3mcCeTg/ReMmBusQJxI6OddCn5p8KnBc2npaQSZ+vs93
         tZ18z33O4czTaWLMmhnnUd6feuyDDlBxbWLnzbW/tNYrFPTuRcHMa9B56MkZmEsMc6O0
         q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120801; x=1775725601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NHkPd71whA6OvRg4mcESCl7NRtMfCv3203TjuFyqQI=;
        b=s8bnUC2VyomwS0fibqLhfB2k9U9PF9Le7y1yLnciMg/l5j4ylmuXIzkkn6y8YyiUbu
         KQ0nbXyy3CG0hgD4QDE6FgBipCx37LZBhKq6ZAh0qGDrlmpdYOSkn33wBCi69cBOcm2E
         Vx68Mqm5rcYg53hEl+uGopw7RxR369HFmUQXwCPnysQIrT61nkqNEcp1pNT5Ul8yFd11
         o2Vsj4h5eue/NwzDxl8Q93h54Zo3Dzod7hv305i7gzVrYF+3eG1Cl9qIdmzY+SQ6TLPM
         GE3cgy1ULtLMRjsy4DfO8NPZjhsPR2qf4oDXn3oZfFHT0ZPBYR5pNiLtpRS59ZRsaTws
         0OMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFqHvXjHEuF1/cwHZdizt8EDsthYlENPIKQDfMeRzS1SQGyhMr0LfsLFZzTjvmNYCZZW4ayYXr+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgmC4YePUUXtypZNyBCj5bewhVvbEbdze9T0lPem8RWAgSW+/
	uqu+1N3/9zYyYwtOuDVXTtVzgVcnJH1FUHVu2u1EVi0UQFUxdzOw/FfC
X-Gm-Gg: ATEYQzzJd8QUujGZu6tlgLTiNKE3Jhg8NRhrwQWmBryCi+16jMEi1CiM0oErJtvdsh9
	iSOxkHp+Mufulh9WSlshe7siasOc1TO7x/blx2gaBkdGBlkGxVaLsSlyDJlGuEZHchRzXbvwpDe
	JXjrWS1e17mu8C/3WC09TYlQnZVcm/WMdgbM61XvmgLcjdhIlFpYmCiOObVgMjwFeKrzVvNeVL/
	vF/INWVXsOuj7/IgXc2RJ2L9MXFpCTMJjgJmPNdk2seLrStKiXjiTpw4fjLuuKWrlXW3to78xfy
	/gYgpzLtoD7ZvD5DS5ihRYKRU5lLhz87t/dTH13nZszB62NTylwv+qgLzBztml4J3rRaTx5UwA1
	L3Q1Cyxe3d5odm1hyc98hLkTS7hbSbMgdZWBHfqEUokamoMBUflv9SmC74JNqqCspV2cxuqAE1t
	CpRp6arjtdXq3suotXT/f/rtAa4CHjBa90X4VXvz6ypNhS4kDcFZSRfd7zbRU+OiQL
X-Received: by 2002:a05:6a00:2350:b0:827:3914:f130 with SMTP id d2e1a72fcca58-82ce8ae50f3mr7963742b3a.36.1775120801360;
        Thu, 02 Apr 2026 02:06:41 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d67dsm2819915b3a.33.2026.04.02.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:06:41 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoyu Lu <hechushiguitu666@gmail.com>
Subject: [PATCH v2] ata: pata_arasan_cf: fix missing newline in dev_err() messages
Date: Thu,  2 Apr 2026 17:06:06 +0800
Message-ID: <20260402090612.2236-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c.

This keeps the error output as properly terminated log lines.

Reviewed-by: Viresh Kumar <vireshk@kernel.org>
Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
---
Changes in v2:
- Change subject to include parentheses in dev_err()
- Add Reviewed-by tag from Viresh

 drivers/ata/pata_arasan_cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 514d549286b5..abcdef123456 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -380,7 +380,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc
 	if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
 		u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;

-		dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "read");
+		dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" : "read");
 		return -ETIMEDOUT;
 	}

@@ -474,7 +474,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc
 			dma_len = min(xfer_cnt, FIFO_SIZE);
 			ret = dma_xfer(acdev, src, dest, dma_len);
 			if (ret) {
-				dev_err(acdev->host->dev, "dma failed");
+				dev_err(acdev->host->dev, "dma failed\n");
 				goto fail;
 			}

--
2.17.1
