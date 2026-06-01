Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1635DA4A
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341690; cv=none; b=LWaEKRQN/8Oa26z+NUJ3R3nmEQPTUqAi9VzmHWxhL5wC8Hs2yRb11AYZewDOh04dJIRHqxuSqve2VXS/zcFl1uV0O6gmpPbrrjnXkn9zuaHEK6b4DqZvX/ayU9zrN6bJIkCa1yvKSANHbOeuyefedKjZTibGU9KFlJvTTfwxW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341690; c=relaxed/simple;
	bh=SMkFI++1OcZmW1b6oIZAzPZLgEZD/wZ/b/qHqus+Dm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANm2aC2hghTRdWgBELjLJD8Rw+dWY3DYQ2PmUN2q97tV3jEUTe9mFHu6JJ9n8ybIAExt1yBIVxH9leezg6YVbDTX2cLbNVyJAnTmA7Qn0Px4zH0agQq7rVzvbS4jQVnH4YEu2piTJ6+KUNJqQk3UN1vWJomFMgvC6h1sEWwv6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIEwcuTu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIEwcuTu"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c858b392697so1030676a12.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Jun 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341687; x=1780946487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUhtVYrg48qb3KiaDyySI952AGcCHN+px951Lp59iZI=;
        b=IIEwcuTun4WwBXBveTgg6w6B/xPut7DKMdHGYVzuR+FEvilErQVy82l/GcILSbmu+e
         g74bpxOfYKMN8b5OUY5/Hz53NWrMF9Pa/JQv0FvtZVBzDe72YzqQyrSuEWvMP7SrsSbr
         KF58nSGHPYMi7bbXNUeIvY//Q3RRvwppNjGaAxjXrgkpJ6eWJhNpXdLzeBcQANgKPuhl
         bBLixkoSJ24vtADmkrhhv3ox81OQNNB5ivjxbsqXxxWnbIB3ArfHiEO3ZpMM3FE/UEWS
         30j9iWu3wgrS85o3KxB4QOoKxp9aeAbKiPhJXeHJGkjJDqtwQ7U/5u2H1AVTbiB3+KQG
         3VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341687; x=1780946487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUhtVYrg48qb3KiaDyySI952AGcCHN+px951Lp59iZI=;
        b=cJPChLRtcKfTgV2DuAXOZLucDQ5q4B1JoLtaxgH55JnJyZl08SBMHoE/NXK0qX5PzL
         BjjtDICx7HV+18xLkZ+tWhL7IN/4pa7Oqbdl5DJg+towqnpFqwtUFpGovgNNCASXhBX1
         GDXTaBsT0xmJO5A9kwS9MpQc0r/ek8jMwx60atr98jVXKf5mEgbgLffqAXD8nISY9Jlf
         Y7fbLvk0msY2GsG8PUcRjrYvaTJD5DqmYvy0EO6saaFWWqeip2H8anX1s3gRzV19lOtt
         gsJqilZKvgs3Ocf3EMfyaK7IhnBqUXb59Cw6Syq0kvNLqqvapap06gKc3EVITtzI7bcz
         JdRA==
X-Gm-Message-State: AOJu0YwJc9YMPkzuiX3Mtr0oBtjGAZtlSkZDTSdccuQ/AR5jqQPmb0la
	fwThhPxj3uqRJXa7dAQwTE9Aa+BG1HdvouZb9zppOBBolllCSCyK0cI5e0JXzQ==
X-Gm-Gg: Acq92OGWYguQuexJpiQWDOJUyvu0WVXhlY5I0hKsdExJp/gSnhpVKBIBarO8uULn8GX
	WEF14g5+6hii++Fj/OuCcLy1C2UomI0UwQl9Py/Kxm1RpG1260Hs/zZo5H8jGE9174djuDzguM4
	hZLUYcGCIMS9pQU3Y57CGwLtTRF4iwvVb4IYm7z9KE44fZC03Y2f5rnw8NuV3RGs2JJaVcsU7So
	4Q0hECUO9ceN6u6ZKUP6rUAS7QpLna4uSc92VRiHAWdVcUnVveIviX5/JWUfZva07257WdL2Ydu
	D4xNvCivAPNwMH0VCPXOPjboHKCjBLrAUAMmgX8EyhCI8t2nFGvEth+d2GLQjbRiDmj1JYc68Ej
	4CBuZBBtplgWRWLiwUmzele4wIrd53JXDX1Hffv/ogCOLIhApQ6Qoafa0RIx2yDWgwJSOFGzThb
	HYZ1iexSEgJkB+J2YwTr3Ay7lCLRIz2OMN5nkzyTQOGTKgV3Z6Jyn/CYE2kn/CMg+YOwxL1ArfG
	gELOZbJcDYL/pXX1nenOsSx7QmT85PmibJCvsH2FiTAuQ==
X-Received: by 2002:a05:6a00:3924:b0:83b:905:c9fd with SMTP id d2e1a72fcca58-84225841280mr10637961b3a.24.1780341687288;
        Mon, 01 Jun 2026 12:21:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84234c99af5sm7477561b3a.53.2026.06.01.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:21:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ata: pata_ep93xx: fix incorrect return value in data_xfer
Date: Mon,  1 Jun 2026 12:21:09 -0700
Message-ID: <20260601192109.21262-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while (words--) loop post-decrements words, so it underflows from
0 to UINT_MAX on exit.  The function then returns "words << 1", which
is either 0 (for odd-length transfers after words++) or 0xFFFFFFFE
(for even-length transfers).  Callers like __atapi_pio_bytes() depend
on the correct byte count to manage scatter-gather progress; a wrong
value causes ATAPI PIO transfer errors.

Fix by returning buflen instead of the corrupted words counter, matching
what ata_sff_data_xfer() does.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 192f75636d18..5b79a7a019ce 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -506,7 +506,7 @@ static unsigned int ep93xx_pata_data_xfer(struct ata_queued_cmd *qc,
 		words++;
 	}
 
-	return words << 1;
+	return buflen;
 }
 
 /* Note: original code is ata_devchk */
-- 
2.54.0

