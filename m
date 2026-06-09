Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C01374A17
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034215; cv=none; b=U6/iSkBKLu0p1qeC/xXLuwJOume45gPD/1xuhtFV/3lNn0IT19WMD99AiJnWZMHH7hpqm53WaBJor28dUKYCdM7k6JCGlW35FzD+/cA/inTuI7cToey50AAJceYXE7hiqbC2Hi5UaIF5sz3oCY8PzyQuejVwvFaa/3sjcuGCEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034215; c=relaxed/simple;
	bh=+mCSz8IgsZJSF/994en9Jy/gdzM11kUCuMV6CSTi5oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvCOQ3B74gpo6BTsrWjuI02SRkq+qSiv//V7QPqw9hdZUkADaEDf4bYF++Evw9Xj7PgWYfbbCTkloz3h5bsZ5uxkMoZANW4QlsspXJOj+6bZl595A8sTVvQ8TuTFhVyn0I8G7vg3PvQXT25/xptZxFaePtaeezVF3U8rtBH0S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXcl/LCW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXcl/LCW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so3289585b3a.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034212; x=1781639012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SP6y+7hWipoDG4pW4BKYAHsl5/WYOj5NyOOliWtuB8=;
        b=qXcl/LCWTLagkQZ8Ym22g4cYtKJMLLnXtS20cpvpsSLLZZo/2VKVUKfEDt9SEW6AAp
         stcZ6N7YYesH56WYltfBfTmpNx2MQYHHEa+Fh6FB3IZgZ4lFtbzR2EZs7IJF59hSHxVL
         pPq1G26yI29UPs1RNfIvTyv3ojgGbYlIWqTzswjSSKqWeimB1iL8uAtYLml5GjnzqJvH
         E76/YwkKsb1sNVqRa+fa3BI+B1J/gpv0diiRyENextlxq4g94sfl+9FZ5vNZ4nbgW1Tx
         0ixZgN2wV8yjAgMlO6EEf3jOAptK6EoQbw62qst0ouYIZVk6SPFsDuuQxFsq9zbkzXGt
         HsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034212; x=1781639012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5SP6y+7hWipoDG4pW4BKYAHsl5/WYOj5NyOOliWtuB8=;
        b=cBPLTaA6/PotRRevuL1RrUkX46XLrF5J/PNxvuT29H8qyuiftKIzfv7BcRoLA1A70m
         vJqQdNHKjPnA8j6xu2OFA/xSW4Tb3qgMmPYdU6bv2bsn1vBlInk9w2VRCENukj8DewDs
         ZI+0oTvPxB4xbkFkBYQBVUNWhcoQmt2x+tMB6+clcNzOdiFYZ8A0xxjqLQ2IMYr29xgl
         Axtu6svGMHNwCI2MP5FVkG5PpxQyVs0NDxyZxrqhAKXEcC6t5AEXMxcoWnXYcQC+QSKD
         z7eiFNxNn4RJduz/oEaWP3GTWPTyNtWQeQKY+xZs0pS44ZXAgdeRZ34uv92IsbTBjeEY
         SR4g==
X-Gm-Message-State: AOJu0YzuYfkFuPMqflUJucA6fe7N0HScxDQTpvmLvov8dku6fBpgtGFw
	vPUxZTadOSmDpsDwaB1VwiVhhAfehVOscUhvi/62ytrHM7wKAnR3cv858+6Nrj3g
X-Gm-Gg: Acq92OFKyT6Opj4nEp1Ic5eLVQ+v+b1QPQZ3GdSTWbdk6O8FEY3X9gqH2BD7romtb4t
	MU/1ngLNyDleN59NXi/LM94k6NuTDEYWwXntGYn/fJjn1uTP1P8I58aZw7AGRkD4DXfrL9y3MOZ
	tDhhveGEFJVpkgDBgnvppNPrIh6dYz507dtFwsIPxw5ZkyjSwyAEcdYOYVaj1g6TPPGNDappdqt
	4room0xsHRqayJSXVemSKBAnarjQ/2xOG5uahatsSbgno+D8z0YV0Bmv3+Nr0uaS5XLI34aZdQa
	JO/nl4Ykgr04lTnBGwSlYs9f1Ktw6/5B+c+Dn5PnkR6RcBMDiGBKCUw7eJ7Wr4M8dZw/ZgnxO6H
	5gsJKpZLEjOK/+Z/CQFQz/jNJI0KXQSY9ksMCgDGqg2YHKDBGnG/zEnqryVtD7FkYsSo4rgaN/C
	xzT6X8vkNUQ8gVgIZTO016Uds6/BGcjqozFW2a3VIdw5keOUYFXQks/YyeBMzdVVaJWS3nGiJ5D
	bbka6Dl5RKIt7Yqsj4F/kCqc0p8S8s33Y1Xf7hJ2AoraA==
X-Received: by 2002:a05:6a00:9084:b0:842:7e6f:f487 with SMTP id d2e1a72fcca58-842b0e5cdb6mr23437785b3a.15.1781034211948;
        Tue, 09 Jun 2026 12:43:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 2/5] ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering
Date: Tue,  9 Jun 2026 12:43:08 -0700
Message-ID: <20260609194311.6217-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609194311.6217-1-rosenp@gmail.com>
References: <20260609194311.6217-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use non-devm request_irq/free_irq to ensure proper ordering in
error/remove paths: free_irq() before bcom_ata_release(), preventing
a use-after-free where the IRQ handler accesses freed BestComm
resources.

Assisted-by: opencode:big-pickle
Fixes: d01159dffa15 ("drivers/ata/pata_mpc52xx.c: clean up error handling code")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index fe445d6aaff6..b46b83df03d1 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -769,18 +769,18 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	priv->dmatsk = dmatsk;
 
 	task_irq = bcom_get_task_irq(dmatsk);
-	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
-				"ATA task", priv);
+	rv = request_irq(task_irq, &mpc52xx_ata_task_irq, 0,
+			  "ATA task", priv);
 	if (rv) {
 		dev_err(&op->dev, "error requesting DMA IRQ\n");
-		goto err2;
+		goto err_free_task;
 	}
 
 	/* Init the hw */
 	rv = mpc52xx_ata_hw_init(priv);
 	if (rv) {
 		dev_err(&op->dev, "error initializing hardware\n");
-		goto err2;
+		goto err_free_irq;
 	}
 
 	/* Register ourselves to libata */
@@ -788,13 +788,15 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 				  mwdma_mask, udma_mask);
 	if (rv) {
 		dev_err(&op->dev, "error registering with ATA layer\n");
-		goto err2;
+		goto err_free_irq;
 	}
 
 	return 0;
 
- err2:
+ err_free_irq:
+	free_irq(task_irq, priv);
 	irq_dispose_mapping(task_irq);
+ err_free_task:
 	bcom_ata_release(dmatsk);
  err1:
 	irq_dispose_mapping(ata_irq);
@@ -812,6 +814,7 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 
 	/* Clean up DMA */
 	task_irq = bcom_get_task_irq(priv->dmatsk);
+	free_irq(task_irq, priv);
 	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
-- 
2.54.0

