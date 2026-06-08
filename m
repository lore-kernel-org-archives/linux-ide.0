Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4C3769E7
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955261; cv=none; b=H7QmicJbeI+ZfQdAkao9Hi5kIdq7PANgpVixGDO0hICfLHIVyc1DLAsbYadYdLQf+mHClID1UbOgcIUkdEgAOKMC2HuGApo9B/3odMo/9v5nhOPQ/S2D8Geisdt4ktD21pmmncijYkCPWe/DBG3EenyyNymAzUWyUQAyfAHqYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955261; c=relaxed/simple;
	bh=tdSiWKsxns6CPt/jy0ALFIb3BSWqQBL/zHu/FefKGdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpR7jhNZvfU40O/hno/T9RgFO9/ImqOOgJ2xdx/FM+yI3w/aY1dBB95rLqM3+LjOcb/dScInOdcHf2xY/scC1McQA329TMEC8Gncx2NvymwVBmMGF0TLZ1xgyie9lfAKciknR6eg/w3eTDznrytAixMLnPKLd8irfa1KkTDpj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJaxvwTL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJaxvwTL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so3057171a12.2
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2026 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780955260; x=1781560060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnO1pCD/ipOKWU15pcqCQJFHGQcWZGiwPn1ti26JNWI=;
        b=hJaxvwTLPHTIQX17oq/y8wttBdpmp0tzGiMos9h3uW0XryHxxPBfwoIhs5z2IXzB9y
         L+V+UUbaWmoiBq3DYE1/jS/mHzhVHAuacTnE0pAE0cvsBPVn+qHUCgDhFnXjyZ8y38Zr
         pKA0TXn3V+2RzUQvCcdR+2zuXUQ46zv8CHgwh3c1IDNysuutcmIAjoDLtNe6xsaDIYjN
         SUpdSXqT/e4jrcuyZ+DcZVKsxlD23iRqytzaXvvYq9JZwMQGqAN99xbq9TfiIJI890jv
         vca0ekpwn0KkIBBMLAacerymzCnh+rrlKERS8OIShCAVQNmaem5nW+TcWqZXWqK7l//J
         ++Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955260; x=1781560060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnO1pCD/ipOKWU15pcqCQJFHGQcWZGiwPn1ti26JNWI=;
        b=EU0xoWKqgNIlPZLMH4//JxzOtPvP5ftCzhPTuPkpyOJzRH/GPXpkcqxMmeEy7X807C
         Z1m5bjC9k4fM0E3Fk+rkU7DeAIeyuH7zLCaIU9Zsq/3+ZzQEiUdRjuYIVf8uuBBS6NdN
         u26UU0TMuvONgFcZWE/Be44bPjzwZ/XYl812JROzOlRUcJyax7fVibSXB0yc7shu6eCg
         udeHS+bem53uTncPPOVQMZI4mM+nxY4BtNfjQc1dcSjhlSl0s3PpM5y94FoUqDDkYZU/
         ZNBNslpuYtQH43hZveVzJ356yUxwC44wAoIb9RI6WUzCucH2RgDPIaHBnIQh0hr8s1HA
         ic6Q==
X-Gm-Message-State: AOJu0YwQPvqFEalTo12uZtb61pnX8WPgupVvyEShhAy1DcT0T34ntmWS
	u5Y1DWdGrdEeVyQmKeKYh74EMPYDE18IpBwKUomNE6PGz2MBxZ6WQ+rLLQFzJtFl
X-Gm-Gg: Acq92OHpMuYGT43FKyvY2aAyOthff//cnJNgjoYwf6oM+xRlSnZo3oqB8QEIgdi2lPF
	4x9NZh6gMdObWzmLtZM5UFaCJj9QvNoZJUI/ydG++bEyMevma+7Tz3Xn8lg2Aeb/6ihiaMVyWmq
	urYeXNkf13k5UEQgzWIia6fChTidTt2++IiDQexWjjye8M5dd04ZuuoagSVk6+OCqWnKecqZgv+
	94Zx6Sb9ZbPJS1hyNlKpKgvvGaFSD0L1K6d4a13Kj2jyjCQq9F9lJaXcfMBpOh9Dv0eKDaGnz8A
	4krRsWIlTYnygEXptYGJBpZhHTM6fdakiuLEjNV7XIdDIvEcJNQUeuUP06CxaW4H4G+VVaX7/n8
	MaocHSSSO5IBfyL6JdRS7d1KnhYleJ7uWEBQ9t9fIGH+9Mh1y+QnEl80rhAi0m6zynn+6VX0/Lh
	L/x4ArHjjyPBbT/mATTj1f+a9KOS+ccartkvIdXK8M4VVTZ4HWa529YOh+D0mFzEMl4YSCbdzQK
	PUQRKNUcuXr7KEaZNE8UFaPq85NXJ+Z0FhlSSp4DGh3pg==
X-Received: by 2002:a05:6a20:260a:b0:3b4:6f7e:d0f9 with SMTP id adf61e73a8af0-3b4cccf74b4mr18969073637.3.1780955260157;
        Mon, 08 Jun 2026 14:47:40 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm16016505a12.24.2026.06.08.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:47:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
Date: Mon,  8 Jun 2026 14:47:16 -0700
Message-ID: <20260608214718.49503-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608214718.49503-1-rosenp@gmail.com>
References: <20260608214718.49503-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcom_ata_release() calls bcom_task_free(), which already calls
irq_dispose_mapping(tsk->irq).  The explicit irq_dispose_mapping()
calls in the probe error path and remove function are redundant
and cause a double-free of the same mapping.

Remove them.

Assisted-by: opencode:big-pickle
Fixes: d01159dffa15 ("drivers/ata/pata_mpc52xx.c: clean up error handling code")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 9af0aa89a5c6..1246b705a411 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -794,7 +794,6 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
  err_free_irq:
 	free_irq(task_irq, priv);
-	irq_dispose_mapping(task_irq);
  err_free_task:
 	bcom_ata_release(dmatsk);
  err1:
@@ -814,7 +813,6 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 	/* Clean up DMA */
 	task_irq = bcom_get_task_irq(priv->dmatsk);
 	free_irq(task_irq, priv);
-	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
 }
-- 
2.54.0

