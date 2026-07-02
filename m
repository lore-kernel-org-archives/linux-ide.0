Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10C3B1BD
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950638; cv=none; b=ctuQC4bvCqBMhzbT0mgE6tCWkaJRUVQi2UwtN62lDJnffPisMNZV+yDy6qNUxm8iKMVbUBf0ZYr2ovX7JY8hV2NlHcKTCKO61X3cgoDwHb9hXZt0dH3QYvCo6sjzaQVCfIVyKpjeVI7l5sZAp4xVQzRRRFWB7FgHfmnFMQSGRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950638; c=relaxed/simple;
	bh=WuC6Ya8GmTTZtaLRIoU1ca2LMUwDmLF2AKQENiJ3WlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWSNO3YH8moY7SO7gaSwZZpsAjvxc9eMAOgVZU5jcLK81DaEkV1bsV96p+aY1tL0a2VLDBALpu3eQ9JWdzFk2uiCKIbgzXhjy4xj+vxcCQu+KUk/c80o5NlxeHu46V0iKfrRwb0uF3tdtW8t5l+zuxef/C40g0eG3ct7nK9J0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftZjOKeI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftZjOKeI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca15944645so10078195ad.0
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950636; x=1783555436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGvcZa6THMRepYDa0BghV2VvpfyJT/Md5Oe7Joec0Cw=;
        b=ftZjOKeIQW7y2F1LvjkCNPqd9W+/svhhI2pwKdQHEEKk9SRowVmsb0P/g5WfoyOXtk
         D9u6iT3k1iSPwv0suu4GlneSzITPLR/6B3ejhLOZWEaAdSyJlbUHAMScBUKiQ7+/F8ZX
         DbZ0HbV/YQompT6e6JPfIWXohBBIcr7oAiBkR4BACoZu0RqL39cOimfAGZKNnpj1WO4m
         iH3PFKCPrcscjVrynFndFKNi1xPVaRVdfUizdWD93+RHpSMPs/1kYfTK/lM/aOkIX+sy
         10KSZzg4RwwG558IPBU/7/yHrRsOeoEa8G5enWtCHm2Xc6rgj+vd48s0yt7GSUy+mU/8
         jyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950636; x=1783555436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eGvcZa6THMRepYDa0BghV2VvpfyJT/Md5Oe7Joec0Cw=;
        b=dlBQ6zmMG4SqJyBuOtT2qfZNuRI+PLonjTA6wgGUd5z622/7zNItF+X6PKU++IUWpE
         9vJ3eFRnMLcObtDnytKc/JsOs9RT/kwUwP/TKqcBx5uga7nbaZMs5wQKf3KD+Wz+dG+Z
         fdl/F9SYWpWo+Nv2aPtXiqHaXaq9Mt5SqRTtogYWfpKkZ65FymVmgEbX0hV3HumyAEx+
         YRXvOzdwQPdF76bQYVsZ/QRPqtWEjXu9f+hWX5chUi+Dm21hnbTkknupR+PS0wMlKoTd
         +cIljUHs+2MR6cFi3HcyFRhl9Xh/SNkHJBrXuKnbxdIGuVPEcoK8rGrJ0JhgGNyxIYOe
         ZmSg==
X-Gm-Message-State: AOJu0YzOrFI2lCE4+X6cEl78XXO3NLkhSYniaVCEExoan7GGw2tC6Llq
	w0t4hBqSOBD7F8wty9MClOTxSX3mR8pHWembSAXIROEY12qGrQGpFy/bvbi2gA==
X-Gm-Gg: AfdE7ckiYsnZieaeVQA9MmpaKX/Xrp9XdsNNBSB18Fx5BvDOtpmtOFP4wJgj4H/94Cj
	lv/4obi56eeDV7yrF6hGHR0e/VtXSVaBjnbVCAOug8Ve5KMjRreHSmnNeRGG+oqCz+Sa1i/u3DT
	4RHkYoCnRFXx5pYfPtZTvktp3PMQOvDTRXyTR1kkDr6UE+jNqrX1EM9R3MWi5GlJqgzqjw4Vwu5
	lHnZfpCBYI40Onlua2bwNk9tETxKn6uwfbeoDo8rnjW7kqoQY6aFAfK51Y1MZMnJ2e2yNuYQxGI
	ClYiuZnBoK9hAe0Xrie6WkMBIrgW1CA3LqXgzKGQWOr/Fsmqt1WOEeSJhZKCZCsnZVtOBxJD6ie
	tz+h3ddSsV/qm39KxAcD9n28CzPViddM6rMyj/WtN621Qw6hbV2XfVCUk//ww5qSjK74j4VGWPU
	cfg2rwKtI/CB3o57wizIlUefLu+eEBuds1XfCy5DX6xHHO6w0oGVvdNWTKyLBb0ZLVIBZM3o5a4
	NnCj83CoFnf1Ajgmdqe
X-Received: by 2002:a17:903:3c24:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2ca7e525064mr41441765ad.0.1782950636086;
        Wed, 01 Jul 2026 17:03:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/8] ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
Date: Wed,  1 Jul 2026 17:03:45 -0700
Message-ID: <20260702000350.68331-4-rosenp@gmail.com>
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

sata_dwc_enable_interrupts() is called before platform_get_irq() and
ata_host_activate(), leaving the SATA controller's interrupt mask
enabled without a registered handler.  If a later step fails (irq
request, phy init, etc.) or if the controller asserts an interrupt
during probe, the irq line may fire with no handler, causing a
spurious interrupt storm.

Move sata_dwc_enable_interrupts() after ata_host_activate() so that
interrupts are only unmasked once the handler is registered and the
core is fully initialized.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 1561adea323a..43011789c75e 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1165,9 +1165,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	hsdev->dev = dev;
 
-	/* Enable SATA Interrupts */
-	sata_dwc_enable_interrupts(hsdev);
-
 	/* Get SATA interrupt number */
 	irq = platform_get_irq(ofdev, 0);
 	if (irq < 0)
@@ -1198,6 +1195,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (err)
 		dev_err(dev, "failed to activate host");
 
+	/* Enable SATA Interrupts */
+	sata_dwc_enable_interrupts(hsdev);
 	return 0;
 
 error_out:
-- 
2.55.0

