Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAD171BB
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950640; cv=none; b=i+SDbUwkHjYtvG36ze5gmEessxcRFl4iwWDSdGNuUfLpQmvVZBa5GGeb3LPRqfy+pMX5Y7R1z7bcsY351fo8OoBIt/1wHbqT4R7EiI5Sieq7F0uN8K8dpkNt1+b2D3Q/xLgT+8IGabagrg1819h83s0agHhMve/LQcbwQ0eG5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950640; c=relaxed/simple;
	bh=0c66/QOATJNJVuaMLWD+koTKUQXK5hRt7eSojJLMkws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X35V3dZKpdFaXtHkdkovm1Eho/emC87gZv4erQIFa3gnXkW/F66fvKTbbETqLQjyklt9yZjIzvGuX6kK8LeV7Ni+UJqHOEjUJv4Dibs6b2MpDXVygyyf4sqtEJlEQOa0/c/iTgFHPjYnt4kFQl5CPR95vAQQcllYO0YkmrveTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2u2j/G6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2u2j/G6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c979d03538so7416505ad.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950638; x=1783555438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njx3FT5+2XcrVfOflCbakNVVLX8Z+nm2I3XaOqh+4K8=;
        b=F2u2j/G6XYGZRO0bs2k32gKPo4mclt6BkIpWjfeoPeOzAueomrmfKbJjhSTzvnzxUX
         EKrAOm7hCNlvwVmY+y42klAn0cseSfWN8fT/rciz7vOgiFrW6fj1C/tI2EhDCNpFTdTZ
         GodEtCh7LxyZFx6FLieHg0xON7G9t/KBIuH00CH2XyIUZXy2eGC6DU/JSnC9xTK7z/l+
         wSWIt9cunZ7tEijJDpz7ev0rvxrk9Rd5RWz/C148Lu0Y+0rfJBaO1zj9B+z7Mp56V/bG
         8YAf/DYsff83dd78rIWNV5QXiJ11j8PlmGWKhSDfiQiFT4BMciGJTn+bjI2hJR/mMNAy
         OwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950638; x=1783555438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njx3FT5+2XcrVfOflCbakNVVLX8Z+nm2I3XaOqh+4K8=;
        b=gEgs7uSpbAxKrp4bSJK0roBwgtYHBd9n8Q/3QZQKmkF06xx9bLrSQxOLTVdQs8m2br
         e02Kqcq2Ypq/7VF38wxI0I2/fkCW/cyLxZ544dFG/qrQF/XwAVUZi8faa8TQ7wX3YiHS
         d7+j9BukWZDdwO0x2me0Eq4NxWad2Wrc5c8MF1pxngqpOtd2vdPph9BGr+e0wMLyso/n
         QkIQnWv1KBO0ArJVeK+hqtwefSIeKSu4REpxJaFrgO3p3KVdlSgDW+uIfUeh8/1T3FhM
         KrkHHABM30ksxVUchl3ci4ZfF/mFoK8ectbuwYFlczhjoWS++7q6UvbMtPL/2pusSyyP
         He6Q==
X-Gm-Message-State: AOJu0Yxx5iRHIIIigw1JutLs3OVgGeL9h6LS3WgJGgm3wKWdbheYsgN7
	SdJoRIy+NUSXFsHR7Icg/1uN6H7uNZPmq7Hm5T249zBywm1TdELFRu4qbfK1jg==
X-Gm-Gg: AfdE7cm3lfujppu4pTkB9Mtplpk5cEadyzD7kyfNQUuH9qani1kXv89+jTqfuhQu5Sh
	vxY58EP+QkXGHy157eihiQrsZlx/nkTHvDIIoKwp7qu6txIZyKV/WOiFKD7Hk9Qe/YptuPR4v6u
	x09J0u1Mrxt6HRM1yRVdzuy39qIndESUjtK3D3mIfI9gqsUHQHbWuw4uNvoEOjKwwj7cM98/mk7
	4nIrzCK2Ka+UJJLBZIrsiOF7S3qlzHGVr8XB3lGoF6UEMnp7fquyi5UQHDjF8C0aWwGn1STWfUH
	qNYqvlqXr3KTdKZiaEWhuEZTQk63f9xJGCdzIrv4iQJuEFgCH+YB+a82AGdeDvabnGnkR4PZdZs
	zZJdDYlZSrh3YePIMEdGCGmuLSpQTmqjlmCBAeRGpOYt1u5wrTKgSVocLsYKPiatFBX6hknYXHN
	UeUKiJh6vyGBhw+xyrBgXFKaNtBbGpgMsEvPrh93ia94THQ2sK8Pso3KdJivddcgLVpD2gO4N59
	gPxmopOUQ==
X-Received: by 2002:a17:903:1a26:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2ca9121e57dmr24309825ad.40.1782950638452;
        Wed, 01 Jul 2026 17:03:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 5/8] ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in interrupt handler
Date: Wed,  1 Jul 2026 17:03:47 -0700
Message-ID: <20260702000350.68331-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702000350.68331-1-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsdev->sactive_issued is written locklessly in sata_dwc_isr() before
acquiring host->lock, while sata_dwc_qc_complete() performs a
read-modify-write on the same field under the lock.  This creates a
data race that can corrupt NCQ tag tracking state.

Move the zero assignment inside the critical section so all accesses
to sactive_issued are serialized by host->lock.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2a28e6655bba..4c54c3ecd18e 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -467,9 +467,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	int handled, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	hsdev->sactive_issued = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
+	hsdev->sactive_issued = 0;
 
 	/* Read the interrupt register */
 	intpr = sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
-- 
2.55.0

