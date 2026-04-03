Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772126ACC
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182067; cv=none; b=iAQazYI/5ja5HTKxq2cA3LJTMMTbdrnId82AIMfDAlzhZ4RyamRQ1Z2hq6cJvw21gWbBILvvtoPk7tOEH/8BaOSzsV+YefE5GL1L7tqOOqmxZcIztpxJL3LE4WG5KDs9NUE19xIhxYVf46VvmSoSXoixazlXmbS7lEROTCjVK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182067; c=relaxed/simple;
	bh=F5CdQZrL4gp5TeKzgooraePx3Jvd+C9h57C443O9dVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doXSks90XIZs2855P+fIuxhlMtz/Ds7ZQjZLKEYGe+Mf7j+ub28MYFRayJuoqKh8mSTSgR1+hYez1EZyrg7WZ6852P1inKquav8UxwFF2l9cJC0WG6DuUXPG9Whh20Kfcrnf+Zh7k696+dY7L25gCnu2O4FF146aV1sFH/UHBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE5mCfzM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE5mCfzM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b258576d8cso9551325ad.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 19:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775182066; x=1775786866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ku90D44LCjqBhnPMIOnGHuam8RMePj3r4X3iAHNGeo=;
        b=bE5mCfzMScNf1UQirKtCl1U+l8WRBv2biY+OUGIjnQ7elczjB2LIp6++uCLBTOZDf7
         J9yXMzWWecDKxNcKVE+WUGFWnZzCL+qj9PbsVi5oi37Phr4U0RRfU0F6IQhITKLJ4wD/
         Ty++ZACXWjCEwrBS3KBg+PbCwuOxaEH7vRSF7awoexQxymRI53aWzYghwE/uDfjJmH6d
         bl9AC0HhTvicyYJ4RB1I/yZc2GkU0pq3UD3nSCcFC4JlEZw7FejM4e+JhipwpgzzkfJW
         XshMCxpVGkdOw0rlMq/QJucIzSXzS9pY9B3YgJcNTa+MAF76db2cRmnCIfXVtwfhb2Oo
         fHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775182066; x=1775786866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ku90D44LCjqBhnPMIOnGHuam8RMePj3r4X3iAHNGeo=;
        b=DbtitsCgl2HxkPeJ4nljcZ1imjzM7PUitpk0xBYNLnO028oi4HIIQLIIrVTntNYDhN
         tcahB/8srpjqLjcJiPqnoVb5qxNCH3g2Vx9JWkOLLPZaOswAbsM19BvuoOL83bhY7JdZ
         OCF7ObH7GYfgTt3+bO1AB4SvKJiCUPRmw6upGat8Hga/54/x2itbNhfg0C7fl/VvRUHY
         4j5NrhiX8k7Hw5r2r++yMWRqkch/HZegMnUNxOv4NuZqPmUHJSyxNsL0M9zQZLZEzHny
         ES+1Fu7wEuJCmXWk90JsWyph7IhiY5SGjvtmFfSTt1EU0MLvNVmmj2pzmEQz0dpjx5wa
         ccMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXL5Gben6DDP8LQojMteDrblvZlYIugHuAwILglYuI00LDzAbNJL7sameaTr8ym/mtJxKMtXa3V3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwBtZ4gdczL/Zwqv67gWWFXNlaQRN5KbbFq7Jj/FQAYbDfqcG
	OSJge0I/m/YHlYyPkDHVb8AdCth9BQw799TlBaUarkFaGHJZfnf+4Uxl1C7yele5fI8=
X-Gm-Gg: AeBDietmXg1CPiNKk5HACJpio4I6MT1Lzv3r3OAKXdabvINRWJ/dR8CFfcI0iyvvOb4
	24LHuYQBOlDTJQ4UJMtWglVzah5OEkxOWK7RwVh6ddzZ+stpIRiRTOhOFtaHh9vydoz1y6R5cm7
	szHBXn4KdNtw2q/jbp4ABgixx+QGMY86i4o9XJtc6bk0JLbm2dEfUe+M/XABsTkBbVwBbm7oo2J
	dV6JFgWJQKnjFp5OpZZiuX9ZpgdQe0B2VoKssHjIYxbSSUyhcx52Z7GW1P8xRblbMknI1k0REE1
	BXTvuA7JMSuy8kHxiJ9IDED6nAo/+v2wFtfynSOlRtdYmsyJqEN5w1w1eLS36Mh0keceRgDtA+8
	KFsiAYBW+YW1iM+tV4ZP8LyDaWKw6Qys6twcB5ZUIGMMGIi+ymsy7hemSkOOrFlqyVLMlLDKwL/
	y+OXiqqZcTn/xNYOBTXsPmwP2Y2IHij+G9dFnbNT2KMIekRaZGiS27+Q==
X-Received: by 2002:a17:903:1968:b0:2b2:4fc1:f657 with SMTP id d9443c01a7336-2b2817d8be9mr14994485ad.6.1775182066234;
        Thu, 02 Apr 2026 19:07:46 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747530e4sm43739115ad.18.2026.04.02.19.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 19:07:45 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoyu Lu <hechushiguitu666@gmail.com>
Subject: [PATCH v3] ata: pata_arasan_cf: fix missing newline in dev_err() messages
Date: Fri,  3 Apr 2026 10:07:09 +0800
Message-ID: <20260403020710.254-1-hechushiguitu666@gmail.com>
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

Acked-by: Viresh Kumar <vireshk@kernel.org>
Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
---
Changes in v3:
- Rebase on libata/for-next branch as requested
- Correct Acked-by tag (was Reviewed-by in v2)

Changes in v2:
- Change subject to include parentheses in dev_err()

 drivers/ata/pata_arasan_cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 514d549286b5..abcdef123456 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -380,7 +380,7 @@ static inline int wait4buf(struct arasan_cf_dev *acdev)
 	if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
 		u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;

-		dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "read");
+		dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" : "read");
 		return -ETIMEDOUT;
 	}

@@ -474,7 +474,7 @@ static int sg_xfer(struct arasan_cf_dev *acdev, struct scatterlist *sg)
 			dma_len = min(xfer_cnt, FIFO_SIZE);
 			ret = dma_xfer(acdev, src, dest, dma_len);
 			if (ret) {
-				dev_err(acdev->host->dev, "dma failed");
+				dev_err(acdev->host->dev, "dma failed\n");
 				goto fail;
 			}

--
2.17.1
