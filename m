Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9A3ACA6F
	for <linux-ide@vger.kernel.org>; Sat, 12 Sep 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207942; cv=none; b=bIMwOsouBn+vq029UC3YSxKUW3BZ37uw5FZ0Om96naG3YLXU0uQ5Qq0LfIJwoxzP3ibW1MF4yYMFOoMH4qU52P/BNDYOiAxG1LkTPsdyNm3GVy4zA1vCJtDfTmAsYbdD07NUS56WFU0eaUI/0ZUqsqrX5+cgUzXKgJ1VwBwGrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207942; c=relaxed/simple;
	bh=L8wjSkw2EdjFBnlgcl+3U01kSoAX8Dldlk2sgQF/G04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvTXcUIRVYSv4CQbb5GRPcFPuRclU71KiIh/n24FHttAHTwnWc0V94wlqJ0PYGyX3TvVnBGUG1FfAxza9jECOpjum/NLZeU31bRE8wYpH+gK4z7PLxqA6f8yiJKDrGCTBSBGeA0fpu2RsC6OLktcxEUH2ZCvHzB4WHINB4Gn15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbeSUtFe; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbeSUtFe"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so314615f8f.2
        for <linux-ide@vger.kernel.org>; Sat, 12 Sep 2026 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789207939; x=1789812739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8POLFJQtP/wEzujshVuV+6lnugcRc54DgfC4qYT4MLw=;
        b=PbeSUtFekITzd8hPMLqr82xuImPpASHzYmLZvjN/BrAulCugBZuKvME5fTOqq5MSwk
         lotEquikNEresQ9fxlOzTY8kmegEbLZbPLKBITx7ldRgVBMugiDZ2oqF5Blm1IqH2kRZ
         /i8dKtNQh8Unp9l0V0RM6xPj60WGhMqipjIsNGJvDZtGwo8fYQ10u+y98rU8FYBUvDSt
         RkkuTBgeJeyGyq9KAQN3lXruFDxliT7S3o0jGkC7P17xmHo3Xyt8wZYN/3k65EosVQYG
         5nTYMdegz4mjUNZ4YWxbfPzdXbBrYpv4yDvvwkgNNjoE0/lWsPPzTL62PukgH0GHzt2C
         8ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789207939; x=1789812739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8POLFJQtP/wEzujshVuV+6lnugcRc54DgfC4qYT4MLw=;
        b=Pe3lkUrcRKaCwp2DzZpaZKi+i1+KdNxKEQA7v8L/WTlRJ1lmPAuJx3b1N/wHgHMA51
         5al+/7O4FdxCF7ORmRGk5wUq91GToaWfKB2CQLpD8Vqwj5MIhxBtGCwsGHWPWAnBMoYR
         U4eGC4AzpoiNdJSo0p/9kLqdUTcJdklEUov83m/yifzKcOguZKtA4ElbeADQmJRU0xjt
         rVt8O+SVNaeHnCQg0lSxy+wHWS+WjTeHfwp4mRGv2Pq2VvcNytI9wnRMa7QujGxfgOcg
         2FsRiGgcldbyaV4o4iPSWf1GCOZQ1XwTQA/nGGIWTcdQNaFHKG3WB5NBRP8aYs85F04c
         Pu/w==
X-Forwarded-Encrypted: i=1; AKwUvBxPt1Uaon0nd99BehyRpMxpe2wNPrM6R5hSWnX2/GTaf5s1ePST4XBl0/0D1Nyz2IJZqdRmWJkBjtI=@vger.kernel.org
X-Gm-Message-State: AFuF++n/3TVvxc6tJbyx8nrJFZJ7wXC3yWspjm/737hqr+ayo9zwFFS0
	3TyG/n04VCAYKMf1uDcMN+0DGVm2z5WH5xwNJ0j68saSq3VTBqDuAB86
X-Gm-Gg: AYBFou1L1PbmQBHp4mVKe2V8esZPZOVDWgohovD2kAhx8CEWb4p3lBq5tIzmYK+evL5
	UDQsAWPaTBchkWLYj3Vr1YiYmYIMuVF+JLS27MCnx6DH365FxY+utxXZtnYXdbXbLwE5WP9aX8X
	mfbruN9GpwlkK0P2CcqsZd8vl9IOwPP/mdaqFDyErNRSuXRc5GyUv+bSbEvZja0I7sV2nT2dWsw
	jHJXnDSH1eXFjSYv5UMrfrZesjHKnbQKRU5Dhi+Rl+heiA5FVrArYWgpp8dsnwieyxbWlN0bpmU
	SsT8mK0bD6Yro5uTcRCOUEpi6irt8+M/a6yfi7/SzyMMPGr5BDTwsEw2H5FqvOH5PrX5mN1UjNV
	icyYQe1JyLGJ3rrziD+uwK/H+YFIZa8Wf7SH2zmT2T0SiHGhkbubazWkZtaTeT4abaWgWwcJkvC
	hx8tYtvFWBmIv2lB8hpM2WV6dXGCXzTn9Ac90/yCSczCdIPCcN4sLhdHORMJn9qIMIgTigMUWAH
	7svOEd3U1yePJSxaw8vpiUMmQuuMT4Vr9m1tp+sLjh/6u1L7daDBSEipg0rQ3s/4sTnUVb3vOt0
	Krx7mG143e5rcSA0JXi4N1K4muf4JNPc/tRn+CqV2CbZXd3XPSjC7zc9dy1IffGTZc+uv+Roa72
	kyw==
X-Received: by 2002:a05:600c:3494:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49e619aab42mr205123835e9.9.1789207939001;
        Sat, 12 Sep 2026 03:12:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm212687045e9.13.2026.09.12.03.12.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 03:12:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: Fix ata_scsi_hotplug() reference in kernel-doc
Date: Sat, 12 Sep 2026 12:12:15 +0200
Message-Id: <20260912101215.86413-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ata_scsi_remove_dev() comment misspells its caller as
ata_eh_scsi_hotplug(). The caller is ata_scsi_hotplug(). Correct the
reference, which predates libata's move from drivers/scsi to
drivers/ata.

Fixes: 580b2102327a ("[PATCH] libata-hp: implement SCSI part of hotplug")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b648dc039b1f85938f3a5b7ba201b1e5..db43fd7b6418205ca8e882c6f18a89ba3af9acb7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -5382,7 +5382,7 @@ bool ata_scsi_offline_dev(struct ata_device *dev)
  *	ata_scsi_remove_dev - remove attached SCSI device
  *	@dev: ATA device to remove attached SCSI device for
  *
- *	This function is called from ata_eh_scsi_hotplug() and
+ *	This function is called from ata_scsi_hotplug() and
  *	responsible for removing the SCSI device attached to @dev.
  *
  *	LOCKING:
-- 
2.39.5 (Apple Git-154)

