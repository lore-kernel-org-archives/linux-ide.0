Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3E1E49F;
	Sat, 21 Sep 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726922493; cv=none; b=FuCcRIcTDrQ9XJ43W1oR3JighCCniZG0iNhDHwvj3RkqzHAU4lt8KAOJ2t0WpXsKlhUqcNpO6ldl5kTQWRSdHIprPQU2hjbcd/M2/Cq90fd1EqRTYrILLuDMhxazybmgj9bOnejWVlQ4KZR47QtVPYpO1r5KFIN0X9xgFRCU2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726922493; c=relaxed/simple;
	bh=R6Zt2yw3+uEwHH74wHtOPgkurihBWb6aqyX2tTPja/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rt98WNgn3gZF+c9oKFQP4PAbosi0Y7GeG5DvMLHP0laR3uDWO8fV46bHL05TdgNWBG4JSSOjcCtFNbXxYZ7k7zg4Q/KDvIMxDRrBz/P8pm42S6MV/bnylIKvt0vC+GnTLOdMZbgClXmdMl4LMnRRJWIi1XB4Zz8BDa8uz1XqWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcm785nD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcm785nD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so1896291b3a.0;
        Sat, 21 Sep 2024 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726922492; x=1727527292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bW6xfRGtvDh0kx5w9xnfezu2iVu1HA/+txis3PyIUs=;
        b=Tcm785nD4OCg5nq2hePyNOhvd3CCwhc+Kob42FOmF0xytJLhSb0f3w1SZMyvcFeLEi
         hXkOmSuyuFNAPeln2qTVlVEMAK50pXZ0sEfh2AABIjN396lkXCxiH1wFYXNYiqRsCqf9
         cojLpbTikIfN2oS8ePsgoS7B4irDpOquFYgHFkWtP08anWoyrdr5a1GelyurU3PPz94s
         wlOiFDFqdL1dwCt1vKiHNJRAzb0RsfH/WphgQH6HYRaEkm6nlbf8cr64qLqLGsU2o8O2
         Ne/RBM0j43P+z7NdOw2lWgK3ZlSIrKqr1jvUoWgQi8M83BWrPYglhGNRF83icH/yd9XB
         4Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726922492; x=1727527292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bW6xfRGtvDh0kx5w9xnfezu2iVu1HA/+txis3PyIUs=;
        b=Jcc3/zIXj+RrZC+/M+THgxylO6KL2bHUjBir+EnwPts7g7+5s6LokdqXlzbNCPgo/O
         HIuvYS4DL9JEBVWgD08Bw1JDLxKeHGxTp+tIx6IscbytDp9jujoKdLB8W3LYL/D2j9+a
         4l5YK4fwKn9IytmKhOt0Qstg36VHOOdeYf2Nr+2i2VSeEQsZkULxnN/x5wEF/OACvUuM
         88VrkYE2vt/mFz5/KF0f0IaSOooNXq2xHXVKPlI3OuttTs0ZT9QqlJmXTtkB8lssbFnb
         O+oDn+VNUBC1L8aGgeA/+ENb8GYZYeAsUNvHUCZIs3zEtm8lHG60NDtd36mDF7WcLa85
         yz6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8rppLQFeOLXYvvz9Ot72fMlnIommJr+mi0GM1dpywGLtGI9wu7KposqmQ1tSLvDup66Ih2wxz4DtK1HFP@vger.kernel.org, AJvYcCUncMcQzf/YYCvW/1sopYrERPpIS6m21P9+6WmwWOicfYWKzOtjtwZugx0uww2S0jRXtTU8DsaU5Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIxribK7rkd7adu4sbJz48rMl7U10vtSUoe7zduzngBxV+ZrA
	PmcX4PhIhWerj3DUFooly/3MCM3YJZ/QK/wPrVWIF0S9ZqCI49VY
X-Google-Smtp-Source: AGHT+IHSlXZTE15if946l43XRE1qSKvMwa5VpNW4aOtz5k/Z4sARgFRj0egGo4s16sPm5PkBfYYy8g==
X-Received: by 2002:a05:6a00:218a:b0:717:6883:ad5 with SMTP id d2e1a72fcca58-7199cd8f1afmr9170772b3a.11.1726922491653;
        Sat, 21 Sep 2024 05:41:31 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4999fecdsm12319980a12.92.2024.09.21.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 05:41:30 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when CDL is not supported
Date: Sat, 21 Sep 2024 21:41:17 +0900
Message-Id: <20240921124117.82156-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
management"), the ata_cdl structure was added and the ata_cdl structure
memory was allocated with kzalloc(). Because of this, if CDL is not 
supported, dev->cdl is a NULL pointer, so additional work should never 
be done.

However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
dereferencing dev->cdl will result in a NULL pointer dereference.

Therefore, I think it is appropriate to check dev->flags in 
ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.

Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/ata/libata-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3328a6febc13..6f5527f12b0e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	if (spg) {
 		switch (spg) {
 		case ALL_SUB_MPAGES:
-			break;
+			if (dev->flags & ATA_DFLAG_CDL)
+				break;
+			fallthrough;
 		case CDL_T2A_SUB_MPAGE:
 		case CDL_T2B_SUB_MPAGE:
 		case ATA_FEATURE_SUB_MPAGE:
--
