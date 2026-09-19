Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F19395D8B
	for <linux-ide@vger.kernel.org>; Sat, 19 Sep 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856788; cv=none; b=XZKje4rR2Y6PLV2QLarxFSQkYNKw6UGVAO4ZskcB++HaBBQ0FJLwiyK+VEpcqAshOicF94y2NDcq7PEZp0H33eJJfF0/53xRreiVZFLqWXtJ/n1OPOT/rBvM2eAixBO919GeHvA3xOSmtRPF3HP5SM+Lx/7Kca/w7xoxxZigRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856788; c=relaxed/simple;
	bh=EhdLnzzAc5TdUIMAqbDDPh8BUtueMtNVdBdFvcaW01Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJo9jdHHdZUBwDedTM06k2l4W39zM/38EDyVPYEHL+BGVmUe1Bys5GWaxQ2sR5qjDTGJx6lVWAoWF2Kl9v/HCM8mvm7yBz9cA6ZV1O6XF1y3a5+T4l/ACrbnNWe3JM3qYgTWzEHhZ6bBxBg6dxlyJ1CoUIH2xfWFNkRm11czZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlUXIYWl; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlUXIYWl"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso2024976a91.2
        for <linux-ide@vger.kernel.org>; Sat, 19 Sep 2026 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856786; x=1790461586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UROJ2rA2pOTAq0U11/K+a+sFTni9M+0S8RdMLsEoDQ0=;
        b=qlUXIYWlFm8eZNYW3MZ9sT4OpbJBe8Emc75urx6VDQLq7fRMnuyOIcrjkUQhlu24xG
         XJLCyYCw2MJJL1Og066jkhbiokDL5dLU5vqErvqrJeWfe2Oz2azdiYEtzV21w92q4sLZ
         BUo6iJYblQ2qljR3nVeub07Aib92L1z5+trlj/21wZHYv2PCAuI9Y1w1HfvF21IfBn02
         dez6ddKhkpoyE2N284lOLwVz17EeVDQsl+LfbZD+DxyyTQ09vZjSns1rABSkTusWOM5A
         9WIcuD7uGp2n2kcRzbiZ6WPM8MW5kr0CPiGWrW2GIpmYVOKQbRgPkjvpZrI3U7oFroZh
         sKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856786; x=1790461586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UROJ2rA2pOTAq0U11/K+a+sFTni9M+0S8RdMLsEoDQ0=;
        b=BweA3LixrhtI8q8edNLCdgdaFSoLeX80meChBToTCLfcfUC2NnhebbZ51zJ9JXZBAc
         Qr+r6tr9dhsWUZvB9H61y9bUE2atAgHHCe197x8D1hsDyXBi9tEwRtlK4ubrIIuhbhZ3
         SnTdxHwBx178KBRH+igTxNBz/j0LG7SyplM0NDs84sRoruCrmUMn8fzunWVSOHE+Tdt8
         hUOHICJkz14EmPn9A88DreHeSgAd25WOMFq2e67TsUDzqcRwxVe0aDHUfexRXeVrainS
         dpv9Nk0LjorZqZUvxCvg+krYjVdOqiGDXsyIv91bDOAxviD4KEtYKPneSrpZbmHqeL04
         FKEg==
X-Gm-Message-State: AFuF++n3yA8Oi04CiYbRwlyVsZbzgWiGDOgoMiX9tF0M6R/njNh4FzHM
	XnJuAPADimrpQ3BcdBFSHgHlYPrKQUHrBZnqWogqQ6ElttAec3hT0Rlxg4UpJcGF
X-Gm-Gg: AYBFou3O/q6WBsiYqgYSiM06Bfb5Dygky2SI5z99uCVZ9T5Ba/TvAAK1Td7EggLJJwf
	MdUzKdaCsNmilZYvJk8s1lB7eErJQzdF3bjRUMdXMb5/MS4f1auQA3dOwbgWPAQSFc704HhOKpB
	T48kuUVKhi1J5P5D0kxUHAColNmST5S3evVmPt/H5eoZ9ynYLhWVKBsu8OCZnTKXLIlymgNh8Ly
	FAdC7S1QsSVHqOj53VmO8XxifI7dbgN71/ho0rkMOSClMCGVVzlz5KA7gt7JgYHSuMqya5gsp8d
	OZ3977pKevus0VOwjxT9IKAL9FTo+j1ymO3mBiaXASXzji5DwUCXN38OpL/BeSem4ijBz5E2Z3R
	4tN6Q6QEti+l1xXr5H2/ZxWV38Eawl5EL3oCX8EIVMdpCWee3y5EMH0b4Ma/PrIp/jC0FVDECai
	gpC0kelp5SdnqUed1LSS4I1SqgvHdGMOL9k4GctK31GRkiVBLNxdNrlT8D9vJyKmYd/KfXWpjSD
	mdxDE76SpXrM3VsGEKqQtnztTnTomzbIM/CJizEE6Yrca5116F8me4eC4aoip+9eaZZdw5GoBNT
	C5zkPtZZxw==
X-Received: by 2002:a17:90b:2709:b0:39e:6c69:9b8e with SMTP id 98e67ed59e1d1-39e6c69b257mr4682971a91.51.1789856786307;
        Sat, 19 Sep 2026 15:26:26 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb0190bsm6166605a91.13.2026.09.19.15.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:26 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: reject multi-sector taskfile commands when dev->multi_count is 0
Date: Sat, 19 Sep 2026 22:26:25 +0000
Message-ID: <20260919222625.3797581-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ata_scsi_pass_thru() (drivers/ata/libata-scsi.c), issuing
ATA_CMD_READ_MULTI / ATA_CMD_WRITE_MULTI / ATA_CMD_READ_MULTI_EXT /
ATA_CMD_WRITE_MULTI_EXT / ATA_CMD_WRITE_MULTI_FUA_EXT via SG_IO when
dev->multi_count == 0 sets qc->sect_size = 0 and triggers a divide-by-
zero or WARN_ON in the ATA PIO/taskfile path. Reject ATA_PROT_PIO multi-
sector commands with -EINVAL when dev->multi_count == 0.

Fixes: c6fd280766a0 ("Move libata to drivers/ata.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b648..c99f2845d09b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3507,6 +3507,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	if (is_multi_taskfile(tf)) {
 		unsigned int multi_count = 1 << (cdb[1] >> 5);
 
+		if (!dev->multi_count) {
+			fp = (cdb[0] == ATA_16) ? 14 : 9;
+			goto invalid_fld;
+		}
+
 		/* compare the passed through multi_count
 		 * with the cached multi_count of libata
 		 */
