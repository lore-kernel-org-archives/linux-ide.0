Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7ED1EEA49
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095841; cv=none; b=EW+IE6grBs01g6koqBX8KQh3JIkeWGA08CwXZT9dZBpJIhKhc4feFowA7xa2ocobbcS4c0qrF7wEDs6coxOOFgd4jUTLxBnWAPwXb3iZ+b/vPk7q2ohjC5LRspr7yXbUyvcJdXAlmsph+iGLgBDNEtssC+HKvGELwjye4/ss4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095841; c=relaxed/simple;
	bh=jphdJsPaHCdm62nizDYNEyAKCIPgP70F8r+n8Lx4AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RM9GtHv+dCQ7+veJQFx1dvhQgtXOlzwwCSyowyWT8c+PyV9yojwykHYL9x/nbfRhCQX7oNwXsjqIMqT1QXu6ivx05yal/UitjNgdUeDXcaS+EQbxHQeOfBd5mxXyJmdisjvycc3wOpo4TlHZDax/O0I56NtMvzXwEwI1CnPCb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7jJc8/g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7jJc8/g"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so1927145ad.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2026 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775095840; x=1775700640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/EMvQ1bs9uJIM3ZphpqGbVK2TDK3zSj+9Gk/nk73YI=;
        b=d7jJc8/g4GYLo/T2vFRQ9NEuoWHBBrg/N3rKk6u6ymEptmebnf3CWPnNxC4sEXlmmi
         93LmQimD6Xvd8zm9X/Vjn9EJhKv96r1PDNAMYgh6cl34dRS48rpKsE+b4OLHhflxt1dK
         nNIURIC2MyitgfGFnitJGbkfIy7pU0Db3hbutaAsJBWjS1yJNWpYk2aSlJo2/fwIW3Rf
         gZ2QdTWDixNDV6zLceVh1Q8skidS6d//QDAg76vwt551aPP0oyfGZYL6KXLirmETPo5p
         ZDCrYpTZlAT64vnHa6UliSBFHbrfoHcB3sfBrRWCiBLsLbqCA2c8oHZokq+sQHQ9EaBU
         QKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095840; x=1775700640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/EMvQ1bs9uJIM3ZphpqGbVK2TDK3zSj+9Gk/nk73YI=;
        b=j7nA6u+/s7//lrjYZ4ouFazL/3FZ+I5Nz2w8+JzKfoXANADY7pb2g7R7w3pQ9eRVX9
         6uqin/vhQnT85V2+eIK4iD5AglVPD+kGoMMSr3sxwt9pBXIDcqM/levbxQvFWMJTfn80
         +fherAEUQHipgqYZ/p+sNEIaGjFGA6CGnegqURgJyHQXe0ccvNKIUzwjLYwW7LabPEQE
         Jl63NfLqiXBuZAjuXG19EQjRYq64oRv8ZheZgg+8wkPEaVUGUw3PPjLp7qGsy60YruUw
         C0kZK6gFUb91DCCzhrT84d0c4peiYmLnThCTnyB7qhA3Dig3T7LAiyL67nbAf9NVf3sD
         9zhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8E+UG1Wkj8jBCPPaLebPtmBDu1Xxk1MlN2TKVtaHRK4OsVDwHS7BQSi6UE6xws3E2EzJSMVr4854=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFpK9IBPuK3aX7/kz2IStVxyWUafIo82u7ZDygXRp5TiRIbFh
	i/QvZQNJnvWHe9RjU9I3P8efxD2qNdnNpK9CQXhpxHkYyW3dQR9+unq+rchXBB6ID0E=
X-Gm-Gg: ATEYQzw15sVYRM4gTm33G5rtB9+seEn7I3x1uQYBiDK3M9ShJJe9H1tQK3PQHnixbh4
	ZVsuVXGSKyrwSB/kFtD0SdZon1sFWfy8KUUUNLPSiETOZChdh4VxT+GJCR8fxI2u8BlBPA0L0WK
	t279seQAqSA30RQ8Ja0oFaWLC2xCDNd3flODciyPO3rakPBRrce191CiJN80ZcTPqiH0i9Tm+IP
	Nb4ia1RtrOvVHkuh4HYQdhPg+GMWuoglZNQnPv34XEYBiZNvufjItytSk0wvRjgoaafUtWKN0HK
	6v/0OBZg4OqhoM/RxpPP8hqe9hswAhlfNBup2sXAKcX55mglp2+r3dtbWv6ySp8hHZ1EO/iTbgA
	DPc9tA/xVscb6b8PBbf0Wv1QLn6KDPPsjO+/oxQ7ZrBzFdNSZcomPqZ/+U3nou6GBwsJd3kLMQV
	NeJ4j9DxTGF2ZgDfWZ9JnIe6NYwuePz8+m58fyhhzsA0BTJi2Ow+a2
X-Received: by 2002:a17:903:17cf:b0:2b2:4d08:9e04 with SMTP id d9443c01a7336-2b269ab308bmr53899545ad.15.1775095840313;
        Wed, 01 Apr 2026 19:10:40 -0700 (PDT)
Received: from ZC-202510311500 ([123.139.39.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d20bsm10874915ad.16.2026.04.01.19.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 19:10:39 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoyu Lu <hechushiguitu666@gmail.com>
Subject: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err messages
Date: Thu,  2 Apr 2026 10:10:26 +0800
Message-ID: <20260402021027.56-1-hechushiguitu666@gmail.com>
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

Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
---
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
