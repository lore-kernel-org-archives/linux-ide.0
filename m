Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BA42A96
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765534; cv=none; b=MdU75YkKWgz9vk863cNE7lg3mM7G8MgCsjoOPnoOTyd7+uDHcRUBXbdK6NCNY30hazbZM/cBTKWnfH0NjetKI/JOyK4vgnpdaFwQEBBVPA2sVLbg2Ai1iTvnmBxcewrYTaYxpKEMvq3qRRo/9ZooQYXlXOSTBRpoINa7WMFRMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765534; c=relaxed/simple;
	bh=R6VFjLoew43DjorRPLUqnwrrULmQKOSLr1IATedYfOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqbvT2Jbr19NA/iqGYdUe5uQlSA29eEBtW/FN2l85zdjqWoz0uMiQ+zjnicC8uZtoqva1DZiwkh9dFTFScmtlfY5k8y5VhLNCa0cWSiD8UYDoBCEqh54Ga1HdhDR+j5Mgut9d2Q9KzMFr6io8K7jls7Aru60RHgKdAtQEnwmb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrw9zN7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrw9zN7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so38601b3a.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2026 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765533; x=1785370333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtrGfCC98mn5vA02LN8CzZjl6C4GThAo3sAWaEwlL/c=;
        b=TKrw9zN7BAD5MBRy76xG42MgtE6/wv0jrA2jDJxTmv9g1ejQsPAFHzoI9QAkivpufH
         lbNxp8NkibG5KmHCPdChNdz/eUoXWC8J951YEuZIo+ZdnBuZkfu9yT91/+xYAFmVK1BS
         y942HtFIqlVORWwFaFfy0/8DPsNxcGXbXj8FX4eBrkFPsgP77WpKpnTWQrAjtATY6zY9
         0oOxfhxS0/tt6mdLjUHvckiEO0a1I/VWsWzwR1fCYCpSDtHMueePOYwOBLlsLBAUXm4I
         O0KJ6mKrCE9+UJUR602Eye3CTJj2mWzUIGaK4GPWwuFMp+Gp67inXhx4WkyHhlxbF2Kc
         KYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765533; x=1785370333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UtrGfCC98mn5vA02LN8CzZjl6C4GThAo3sAWaEwlL/c=;
        b=Omxm5axJfovYNZsBEs+MXjKDks0Cn85RJrM7YjJsm9H/ksjmPeOmpvb+7WAAkMdfbE
         6mQLScsqGGko6s9HHTy3vjY1BpEs2xiclu6ZOsk+vVI3oQwBMi7ZpKyrP6d4qYd15IAe
         6E2GL5WfJz5HqXxrvEbLf8nz2L12g9gsIOGBeYoaGyAeiQce8pqDqb5AVeOz/0Okm/dW
         NdkFJrsWx8sM4kNmlBLCINvMuDMvyk8oEq/sgKvqTj6JObTLpr/ChV91xRo/H5sgcEzf
         Th6REukJKQSIddbilWMl7eM7iq3QmPvtxyH9TbAIctx8ujRfq7dAIB/xvBuGv09RLlYr
         SGKA==
X-Gm-Message-State: AOJu0YxlkO7/swTJkybAkbIYRnpDdqf9LmRHKbbN3X/cjf1s8Qg1plbi
	CizeCDmTSTaU/IGSpEYYh75JzASa1nGKHayAeCLCAXE8/UJMzqgnBZPaHfOsBw==
X-Gm-Gg: AR+sD13sxoiMb69C6nlO9bHb6Q6oT7tKZeKcVSJtiI1k4HabDSALp1AV6GzVyGfEXIF
	IawDpdIPDvmM7b6fi9i0L3KFjLRcvbsDAAM/p53OQpTT0NIVRbtgISzrugAL1TCAjLRr3/ZH3PQ
	16jsGKelq3zrtC21yZ5pl8t22xS5CHLjEuBsFW1lvHTAlGcQ/48uZLlBx2GI/ceXg1gTHdEiYPO
	HgaRILrS8/7oUxf6fLFl4A2SsF5v39FKa4/qVkz5WJWjuPfP7DxvIZbE8r8cpsCoGw3QBvwMSDM
	xPUx4c+V2s7kexjqmmVviTLZxRwcIN+XuMcokF+0MQbWPRNBq3kCqcQG1T0c9t8VNSAYDz4biuk
	oibQOkRdEvNSDRS28S8oLknb/87EQ5HaRgL+AvkJ+QQfOOI1JsU5UAQT9KeqjWZL5v4QmrBZgNY
	sELouxFRUQ8xzIooke0LhmVIaNaaanyyXpBrKwdR19pceG7tWX1dFrxKb8neBE6fNv+f3YnjDxa
	FQK8c3tN+SfqbsQFjf4wbHjfvX07VAuPcYPJ9OxtdUHwHHDLGGniaR/l0XFZf8DBw==
X-Received: by 2002:a05:6a00:ba02:b0:84a:2dcb:5ace with SMTP id d2e1a72fcca58-84e2bbe9067mr1043464b3a.62.1784765532727;
        Wed, 22 Jul 2026 17:12:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1760025esm2037253b3a.57.2026.07.22.17.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:12:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ata: sata_dwc_460ex: fix data race on hsdev->sactive_issued in interrupt handler
Date: Wed, 22 Jul 2026 17:12:07 -0700
Message-ID: <20260723001208.1469323-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723001208.1469323-1-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
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

Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8a1d80ac906a..73bacdfd0bd3 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -465,9 +465,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
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

