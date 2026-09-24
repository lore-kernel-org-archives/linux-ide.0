Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411E3644CA
	for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220951; cv=none; b=ZsKKKtEwn1DQNVyNgGT0hi3pmxQS+kuNIpRY7yIgEwO3wtevMeMD7N4Sx+QLxCwo7ZmfgHplnbJO4wzNy4qARZV9XJoTy6U1Od2IKuemf7KzjyTJqoyVKnp424quCQNqp312TRbXO8Oq4PidL8Aoqq9mpH/+CvL5OwFzel5s8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220951; c=relaxed/simple;
	bh=d3GvVhEa4JwU8AYGkyvh0pgozIP4vUrn343c5oJfbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDcrl++M/OAO8aZmY0wWvpBudPHUODvNe4zfGpWpQNIqBRspVNkHvogzo9NxG44Do76oJFSMbkUTGmZgv1Ve16z57IYD/jvxRqJk321FDmZvYb9Lrd2av69xQ1T0bmeaexH5/q5y8YKfIuEaSobMstxJ2QXTFClXcGoRlIQ0sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh3f2IiK; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh3f2IiK"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1133628a91.0
        for <linux-ide@vger.kernel.org>; Wed, 23 Sep 2026 20:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790220949; x=1790825749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSKvOChnuAbXSLTcw0yJ3/Iw9SGnpBZWWFc2cbHawdY=;
        b=Hh3f2IiKIF4yPfO5uJBoudyQJfz/HDa0Rlatqm9mZBIWHiyGTyHaoj3N0EbPeHSEJZ
         zvzFlpCQTsu66Ok1Nzyg3MA2sL3SxVq0bMKKQzSNCyD2A+P6yDwJ2BKMJpJoDdKhT46I
         aR8m4xC8aD6zm1CEwR1GwAqLQTakJAIDSTF+kaOQzA+kGRXaI1+97VuWEPb/lgOCBHRX
         LBn2qxv13X1o863yUpm2mNkfQ8kHww7RelLVUDF7NwqusvzmXiDN1ujMcDKMggvyGKHI
         QD3BDhWEEn481D3I2y+fiqVVA9LdleGhBjDPBNZqSRH1IIGT9hTf3hHmjFL/Pbtl/c/l
         P9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790220949; x=1790825749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSKvOChnuAbXSLTcw0yJ3/Iw9SGnpBZWWFc2cbHawdY=;
        b=lYP0JSckMu2PsLzUrfBf7jgpjAu1DAzZ+3XFGEVkK8KJmgWu17qG6gP/7jJH+OYbYg
         sd8vRzSVWG+wBWG/bz/s1lTa2TmGaUuKJmqZ0kW/jtnvlyH8yzO+NcTwdX14A3eEKIj9
         3C0n9MRkKjZeVbdb07Hj+m4W1MeWMtgJiZhZfQg48pDCwxphlfplwy1QViQZQFUhWHyG
         O95MBl1UQgZ29Jl7iqfb+dU+MV2puiMdgf2LJ3/FYN2/Geso5elqrMIOSMDmBWkjMkzU
         i+ZLqfusdDN0QkW6wWoqCKpI8jsIu8enscHp9l6xCjR2DGnFmPiRkExH0QugLKWIu6K2
         myzQ==
X-Gm-Message-State: AFuF++nKbW4xB0pDKRxEZoNoi4/vkQekF9wEfol/KBUgbYhXx+GgPJR1
	Lh45hLNZovazlK/EtK1FU5c0FTyh9LodEEOD42GrOkCyT8U1mxnOoI+k
X-Gm-Gg: AYBFou3Y+ztgHF9DmI3Kb1B08GDan3F2mboihaLdXaSK7Z3BNHqk7+33iKf4KRnCDuk
	Q51OpaF7Ev/wzIAQYW2JKRlx01CXDUP9irQSwl2xIHMMbhHGyURBM2hfa0NqwBmmYVMdjrBiuy/
	pByM7W9eNZ9bzC2dppcmJzcV2kPTwiAzhFY74QvDgdQCDjf58va81ybC7TDmPp+rpGhHEO97Z7X
	FiMqxQiGWykObR1Vtq6wH6PozejBUTk+aiZkqBBqZ6qs/8ff0yB1d6yE3PCzMMwNXtCY016/Zrp
	SsEgbmzKDsoa/mgZU0VrVCTtrgSoJ0jGBfrW4Ys8CXzjxWkd6tk9XR5yWNx3+sSYK7VMJsTVTh8
	NsBN4b5b5AiWHI6OZMN37AaRiOhi4eRsdr7MBxAmyQJbzjbHU3QQC3cGu3q8OLBVd9YBanu9q5r
	mDubMb3yo/nVtu7agWb8+ctfOUA3yLCvuywfQgafBoZiAhqZvElj7+dSaDzITGxlILv57rMswBB
	sgEzGpJETYl3ohvqfs7swHFJgxy+v1YUy+aya9xwkrKavxI2Df0HJtcZhclAilAYdFVR4fy6pFp
	LdgCrl1mWoLmxLAY0d5zXqOS3hblBYHVMeUbfdP84HaYDp1r1mg8yaOp/Mg=
X-Received: by 2002:a17:90b:3891:b0:39d:ee20:1e3b with SMTP id 98e67ed59e1d1-3a098b4b199mr1040984a91.23.1790220949290;
        Wed, 23 Sep 2026 20:35:49 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5c4sm2059722a91.5.2026.09.23.20.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:35:48 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the libata/linux for-next branch
Date: Thu, 24 Sep 2026 11:35:45 +0800
Message-ID: <20260924033545.3624716-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
names libata/linux without a branch.  The repository's HEAD (master,
8d3ae59288f1) is a commit from 2026-08-16 that mainline already
contains.  linux-next pulls for-next from this repository (Next/Trees,
next-20260923), and on 2026-09-24 that branch carried work not yet in
mainline.  Name the branch so the entry identifies where development
happens.

Documentation/process/submitting-patches.rst sends contributors to the
T: entry to find the tree to prepare patches against, so a branch-less
entry whose HEAD is already in mainline points them at the wrong tree.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..6d2897805618 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,7 +14905,7 @@ M:	Damien Le Moal <dlemoal@kernel.org>
 M:	Niklas Cassel <cassel@kernel.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git for-next
 F:	Documentation/ABI/testing/sysfs-ata
 F:	Documentation/devicetree/bindings/ata/
 F:	drivers/ata/

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.55.0

