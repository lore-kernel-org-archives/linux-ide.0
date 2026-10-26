Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046327;
	b=LEWrnM5/jcvYMPZhZgvgOu2DvzBqkGbfb15PoXWWoKWbXH57ZSfzk1SuRVLaPJ1GXcdj
	 Xvs5ffi+n8Uw2r77YRBwhqbNM4f/EVjj8Z7cmr2eWItPUfl5Yvjam/fK0l4dkzpoKOGRw
	 r2u1SusdLgnH907C64NszD2OrtFtX4kUPrrJ6tDS9NsCoGC5whF4JpYpsPi1fx9B2DmK2
	 t7B5UJnOnL/+UpcIyiHIZu1u1wiI6/QRFqpP+U4+aiMTNqwLpibC66KqSLWl+KpZSz83m
	 ovqBeAVdjlwlDY2DoR0IfbUJfiu3HZf+/HKj3pACz4ycrx5FKyeaQodLlF+E0xi1veg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aed4Rgnz6EIvDA20M5W9ZTUqmqT/8I65PlxJXFCzwH4=;
	b=gOyS22ezJosO9tDcRVLJAO9e5kXTv/5aaOezjfzvEtU8IpKC2u8sMsEU9Tjj7mpCF3yf
	 35e9LmuZR2phGHnBYmLRPPkxAe8kYwFvuRVOpKi+9CD8YlO/G5kef9NuiPho+RTFpJco0
	 Z4MDQpuwNV8xfpxcVtzg3XSFpPS4cZSpYGKVeeE1YzkAhm+TvwVx03yk6eG1NxIdL1sj4
	 0a38zXyUktMKG51bkwYZxir/GCl/V29ia2tBqK66kg4GKQCYbsEEYYcBBVWEATfMpeAit
	 m9FJEHZTijYZ2C/Ipys297+ktLBIm9+0DLsG7HxZ2lnvblGZLIeNHs94j1INarXVcGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DUDTcG4m;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F9606A321
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 20:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DUDTcG4m
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e47347279so1352866f8f.1
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046325; x=1793651125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aed4Rgnz6EIvDA20M5W9ZTUqmqT/8I65PlxJXFCzwH4=;
        b=DUDTcG4m01pngZDHRm0vtPFiOHAjvOKTNBrJy4qLEyCDaX/4FvhKwMnM/B4N4dICPY
         ZN0PpluhYDZ5mz+D/aKGoBDrXZPuXdmjwcVarXDdeygPP8yCZctQduU40Y1H+kU644z6
         czhYGUD9XX4B2g52+eUdXWkWWZT1Iwjg39rB2CBRkQ3kx5H14H2EOuoJIT06bkWlxR1V
         zqOFf1kGIQnKdc2wwPUge9u5DKN2M7IXGfo+hSksdnHJRXaWCG/Ycy0L3syVwSF7fvWu
         HHPKhE8Gp53Pc9pxLqdCA/JYg+wzU1pRAdidExi+kSNz6cMUaLEFjM2M6mMpDkb3TJ8U
         4PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046325; x=1793651125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aed4Rgnz6EIvDA20M5W9ZTUqmqT/8I65PlxJXFCzwH4=;
        b=jimp8ujKr1lph2ur6/Dhze3Da6fnWGAMnwd5i6gMTnkl+Xgdh25vNbCoT39sa+DAg0
         0SmUjfsoOP4Opj1+s6U40KL/15IlTXDtVEe8MN07hVs7e8BemxuLGoTR4AuuU2WCs6re
         QTtBKJP0I/6lJ5rnwGi0ad4aEOqKqowL8De6GHM5lBzqzx3Mb6aBqpXIslT6t7u8DZpJ
         xT3ZLXlw2rbb0epqoUq8jm0eACucM4PJFOA1sjM+lU/gX4HK7/f1uc45VAFYRGxfXCaC
         kn2uPTLgkHhbbdk6h5z+QlFs55aOmshhVfIJd3hSGdwGBHN8P7q8t14alTb+5RuUceur
         mTiA==
X-Gm-Message-State: AFq9FYIAgCHRhvxPvjULbH0MrH36hdyjoaf4rEHYaXFLe1mVwFaqogUy
	7DngksQwXorGRBFVxef2w9F+g96NhhVXq4KXR05/vwRM5xkEeiJVOqMu
X-Gm-Gg: AYBFou1WM/zr8HgF7b5amnUZAQ+ODl+4wQg4DuapAoPAHcNZbDzPMOf81oIrKviNGLv
	o7SPALKMhOZUWPub2ZgMZaznskDWqvTznWvfjEQLt0BRUp/7I7b9qc3guwvXdA/R6Lz2NeCNQjr
	WMbsP2eBzAxs7qBVQT/DXxAMSfxa/vC4sGVijQ0kI8A6tmXxiCmWgIrWZYbbi/xnUWxnJN0zS7k
	ZbFw7BU7jd9mX6qUtIT6dk8hT1AerptqeqhJdDE6Bv1MRdTwXumKvaLssJj0K7kU2pe1qvFioO8
	nQTjHSX03MIOWGdNRsZP5Uqm9ZFJPGiG5WdmDInBlCc8s29YacweijfgpZVv5LIhu9q0SkWbXhI
	quWMdEUx1fhYzsBNPsbNA/UOyMB31YtTYmpdPlEPFTM5xINP5OsFlBUAKqew8/6DlfUdVegogXw
	uIpwta3rFh3yoLW8vX2gTMefR6MXx5fSmEztjK9O22dVVRxnLAJV4XKauHwnGswSWUIulnZxac4
	19M0tsqDP6WGVOqkB284RXNOkACjvBqq1O60sOYoABeNPqPJGmBC4/vfMN5djCFm/I=
X-Received: by 2002:a05:600c:3541:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4a35acc6a2emr148103215e9.33.1793046325020;
        Mon, 26 Oct 2026 13:25:25 -0700 (PDT)
Received: from unicorn.lan.internal ([2a0d:3341:b894:4600:8f9a:af38:72d6:7c0e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm276685585e9.5.2026.10.26.13.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:25:24 -0700 (PDT)
From: Giuseppe Piscitelli <ooonea@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata-core: Check device support before querying power state
Date: Mon, 26 Oct 2026 21:25:11 +0100
Message-ID: <20261026202513.669084-1-ooonea@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The standby path queries the power state before checking whether the
device accepts ATA power-management commands. This sends CHECK POWER MODE
to ATAPI devices, including the QEMU DVD-ROM, which rejects it.

Run the existing taskfile initialization and device-class check first,
as the active-power path already does.

Fixes: 9cec467d0502 ("ata: libata-core: Do not call ata_dev_power_set_standby() twice")
Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>
---
OpenAI Codex investigated the QEMU DVD power-command failures and wrote
this fix and its local validation.

Earlier validation covered 1,536 source-body dispatch cases, a Linux 7.3
build and two ordinary corrected QEMU DVD cycles. No exhaustive ATA/ATAPI
hardware matrix was run. This base was checked for applicability; no new
build or runtime test was run.

 drivers/ata/libata-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 92233fb..c644e2c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2047,6 +2047,10 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
+	/* Issue STANDBY IMMEDIATE command only if supported by the device */
+	if (!ata_dev_power_init_tf(dev, &tf, false))
+		return;
+
 	/* If the device is already sleeping or in standby, do nothing. */
 	if ((dev->flags & ATA_DFLAG_SLEEPING) ||
 	    !ata_dev_power_is_active(dev))
@@ -2065,10 +2069,6 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	    system_entering_hibernation())
 		return;
 
-	/* Issue STANDBY IMMEDIATE command only if supported by the device */
-	if (!ata_dev_power_init_tf(dev, &tf, false))
-		return;
-
 	ata_dev_notice(dev, "Entering standby power mode\n");
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
base-commit: 69be770908ae57354a41d7e1cc99ab46278d2e86
-- 
2.54.0

