Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808F25DCF8
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818614; cv=none; b=b/n0ils8Iwnz5ptPJaAshuZWWgOsatujupCNa2Zmpzn7Au0El7Y9zqpID4GHywAyooRT+G1RwfPmR4YlyyEs1+VC6QcHuhlh4hWcqrCx3rml28JAI5oesLcK1Kosa1e9KJ8Z3HIMWBv4q+3CK7/q/sJoUV3Um0ZBsgAUWN3CiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818614; c=relaxed/simple;
	bh=kuvEtbfkl6Ezkk+GzK431w6+dJv4gwMnjWAsjS7JUro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyO4EO3xuRUw4mmY7bBMTtUQBpgT+mZoAhu4czRBQQFh2gAcax42FGRAKz1ESZESwugjX1qoqR9GxhBFzlP+WlYed3+coJkRluQXcy/cUSgg43DeDObaLDXfop3pgzh+D+PPZUdovebxr2975WsV6l6fOOM2ZktrCaEgCDQESTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKKm4sbz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKKm4sbz"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912baafc58so3370996f8f.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818611; x=1743423411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=dKKm4sbzrj/rB7/F7L7Kms9nAtrAXNB5XBSbewab8uq7vtzTvXISkUhKsfsqywZfc2
         zQ8yVS4B3b8BH9aVP8u0PSJtUoeZgtA/mv8TBGl5eJ8rkmcmc2SqHOtAEvs5UG1Ec2DU
         V1fy/ICDKc5sy8p746A3NV1BQ55rYzMruCcTtKHTC4/HvfsyFEDZh6pw402FlYCf4YZV
         Hey/i1EHm/PuERHYUgmw9Si1Ji4Ly48FPIHERCKwsQJRuJbBnp3w7tROsdnHPP0HFwlS
         wdD3SU5q56svhaj+Q43OAWc7pXXYiLjT7rXbsCgss65trEIIIN0G9xAzYfHGu5U+7tYr
         3lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818611; x=1743423411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=pdvEQvv6g7D9MpboxU/eWbWKLWH2lTG6BWKdgDr9wiO/NnN0B3eE2rfmxO8hvhfHMO
         J2Ez21I1HCvbXgXnQrU5GX9VYueyTgXdxxXTQba4KpiLqF7Plx2zoEWStxdsXmkf6eSe
         k20lSqrd9KLRmkR5W8PVg4q9Q5DHyGA7KS4FeCrezykAbBQmMz8ENqjpVIokPVciF1Gp
         Y59j8NNl80DaF3xt6Cz4dJNEV520ButA5Jph5NxIc77tPMUIkUCp2gZ3QvSsNCnnd5hA
         uR1iPBMppFu+Zy81iKSMwkZq4+GJ0diQarZ1crr1BaVb0WbvFDzW86OySXUd00mgV7WB
         Gn+g==
X-Gm-Message-State: AOJu0YzWbFU/XjZg74+27LlHCsB262xc2tTt3nesqobS35IaQgf8e2gR
	Lqr+eg8+3JH8C2iKmBlJe0Y9l8S5/8ocWKGhezB/a6mBa8qI8dhx
X-Gm-Gg: ASbGncstarb5FRzkC81QR87O/P2EQAoGN+vC2qFFvBqCyR2vILF/6ZxG+kAxg+Thh9e
	54yuFguYqmg5M8dfENUn8skoA4b44W6C/nY0RZJQ3i5lTyLp7T1QKy2ho+AMJYTNLbV7Q2KlhRd
	fzB07D+TZizmYd/iPobQrpvKMcC5UlR80VyrKSDJYdoDIOvOMp7nwk5LGf26Afel4yCfpwe+5KJ
	fg9ig7g2ZlCISsnWlBbP9NHreOpA0+FQEpxmvpQ0th/Qhkkdish372qWuwR5J7HNAenUk88IlE5
	lr3gmEN8lBHDu8JWp92GHT5bJLCjSSBwLjtTyArIUgE=
X-Google-Smtp-Source: AGHT+IFrbLF4MB7E5uF3pvUrcTFBxHW+1xGCe23DUKwj2zEx+ZxX9VyDqp731FjRRoxle/7Rv33lhg==
X-Received: by 2002:a05:6000:1ac7:b0:38d:d666:5448 with SMTP id ffacd0b85a97d-3997f93874cmr11994033f8f.40.1742818610454;
        Mon, 24 Mar 2025 05:16:50 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b55cdsm10875824f8f.52.2025.03.24.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:16:49 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v3 2/2] m68k: amiga_defconfig: enable PATA_CSWARP
Date: Mon, 24 Mar 2025 13:16:45 +0100
Message-Id: <20250324121645.208368-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324121645.208368-1-p.pisati@gmail.com>
References: <20250324121645.208368-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index c705247e7b5b..feed92c95394 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -334,6 +334,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
-- 
2.34.1

