Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562373CB54D
	for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313815; cv=none; b=NUyiByQ/s62nS7h811F0vA7lSvdR3lm53ImX3EhRHx0UwyF1QDJ6hSx2l011UGGm2UPP+b3MOHjtNptRZ6UyrHWj1nJzNymZ3AWeQgE7JzwgGGwz9ECqaB4SFD/Lt1PpPdeR/901813BQ5JNMBhk8iiUJQKVPl2Y/CCM+/g6zC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313815; c=relaxed/simple;
	bh=34HtbU+/rsU/CTJswaXn8hR5CBFAQUP1ba7ChEd95so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqOxohwGaLpfGU9C8pJEi9F6G9SEJcIRYz7hIOcUOysqfXCgNaKUK0cTfyonTEjXz7E4A8eNTZq3ZehkMdkeVZaahwwRaQps/lJ0HunVGX+PVG4t7IEKwQx/QEgIf8oxFbnGw5ll2h4mdeIGjh1ZoK6JEpSMSBfKATQEWFJdTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWAEtk6y; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWAEtk6y"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df8818fe1eso1515885ad.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790313813; x=1790918613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsejoZQIre5nyQt5dGG7TVb9wPxBPsVWv94oDfpbxOY=;
        b=BWAEtk6yqve3h5fZ++CfVitXMlGrO/mD25ypw4RnAbDPjqWhGm+4g2aKobAZi0HjqR
         UWp64ggl11863TszjN4GM11ErA9TzYrfYLA4cki2Pn9inVvHEzcRF1hPqzVc9qNJjRn2
         /x7z37k2SpcbeMe17hQtKLd7WN8skTB7t6mjomq5kHbEkDUiKfOf0mBGxSBiI7f/hPP1
         zE8DRlumz8vRxa47YBrP7dkjc2z5msC2daK6mC3BXvwEcazp1Ike1a0guVWpqcDU65di
         ZQf/S0kGNVOtUbK5iwvxLSMosv5zNMJeHKqcOltJrhgWqRNKDwklsCyjjTWjyZDOLUsJ
         Eq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790313813; x=1790918613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsejoZQIre5nyQt5dGG7TVb9wPxBPsVWv94oDfpbxOY=;
        b=ZtpajM98kVdOpZh4KFkyU0VauLSzoCfLpm/6AzexhJh6+YHHIPphNJLZQCN0vdfm3V
         ODPU98bRQs/vGhoQqC+ABNXUyjfHLd/VapcaQ9wzceUNovB6Sbi0AykzG2d/Ud5EIKcI
         Rd2r0NmJWPoPVDOSZUQVhr9b0KFd9AzFdzismcTq9Mlq2ZpHgkVCwD+pEg5WTf5aIrPY
         uQkmlb8tcS2bAewwMtKeM7CWWsTzJ9ySg8GfX/0GHGLAIyub4GLtInamfCif6UlVNog3
         XSx640VHXcXAO/5wFD8vSqiTR7xhKMNxyIMfl5eav5aXkBSVUcjQmJU1lIg/43unzxCK
         oyNQ==
X-Gm-Message-State: AFuF++mCknLFZS8DCa3Ys/pGEUWKjXaIXQt9nVKIDOY0wW86/doBYDUW
	TkTImXon4xzThmlY02lZM+Lw+hdRE418knFis+yYobrLbl3+2d1QLKyx
X-Gm-Gg: AYBFou1hBqv2BiPu4Df5qpcxkaeFwc6MzsFmZzDGnj5hPIv5l6tRRSWAosKvVEisEBn
	xm9SO0EhnOHcAbZPz1gdUvJEIk7JxS3xR+fV+KQZVaYTxbHrA+p5vm4wqjckSPaxtWbb59qnHE6
	pEwmoa2al3yXsUFCnDrmuSumOeSTkJzSJ9pl1mr0xbrPWyE4GELSgVLsTfTuV8klEuQJwRxbOau
	Tp+eRIzobSxh5PIaX35eoaPKle3Eo58YHoWYrTDc4KFmqC3ChLLP1cxfbhS7iGuG71IiYfElM2O
	5PeZCqNNgcmw00VDCcuemsHRTKCmd4XM5qKFsXw0kFA0Zud9pzttwoWT1ei/LNCOWGir0WVbq02
	jS7LNP3ih9M8n/0A7dVDkzWNKLmhITV0fk0VzXeXDRwYqfig18D4fJhhzzqMldFlVPV1gy0LtVn
	w8m7QQeGVxSlGVNutHWCe2QWl79+25SR4oZ1jxFt6E22tKScjP4j570aOBd+MXBqRumF6WRFL6O
	FOvyVIsrug+4qxrxulwsm5iKVKJoP65ClRWrt0o9AW/GrSkWNqfBV5TfvypyXSWMG4qexd04QEX
	Ls/8+Tle/D9B9w8gtqRxAKP0scGGp84VmFgUgkCqirpWZ5FcwqqRwznr0rM=
X-Received: by 2002:a17:90b:2b48:b0:3a0:7c6c:9824 with SMTP id 98e67ed59e1d1-3a098b337a7mr2625231a91.33.1790313813078;
        Thu, 24 Sep 2026 22:23:33 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm2320586a91.1.2026.09.24.22.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 22:23:32 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: name the libata/linux for-next branch
Date: Fri, 25 Sep 2026 13:23:29 +0800
Message-ID: <20260925052329.2683619-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arTuIxpEsaYIQXU4@ryzen>
References: <20260924033545.3624716-1-matthias.goergens@gmail.com> <arTuIxpEsaYIQXU4@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
names libata/linux without a branch.  The repository's HEAD pointer
points to branch master, which has no active development.  Active
development is on the for-next branch.  Name the branch so the entry
identifies where development happens.

Documentation/process/submitting-patches.rst sends contributors to the
T: entry to find the tree to prepare patches against, so a branch-less
entry whose HEAD is already in mainline points them to the wrong branch.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Changes in v2:
- Reworded the commit message as Niklas Cassel suggested: no dates or
  commit hashes, and "wrong branch" rather than "wrong tree".
- Kept Damien's Reviewed-by, as the diff is unchanged.

v1: https://lore.kernel.org/all/20260924033545.3624716-1-matthias.goergens@gmail.com/

This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..c9565f2c7644 100644
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

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

