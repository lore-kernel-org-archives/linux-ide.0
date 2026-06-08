Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F439B944
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955264; cv=none; b=OcduOYSUWC4NOHXerk8YFQ8JfIqumvmGmwl5LTx5gX/H8mFnKHVvX8fPPhcN5Wk3wcg34Y6lWKVpPPS1sHRG01fChx4F/Rp4jjSV4O+O1nzZcFP+lBsVRqZPuzUoDGwrisDYq7mJuGgr1QW1MGCJHbIUAehazFrkRKK2bFGSLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955264; c=relaxed/simple;
	bh=+NMUZbj4m2spouETtmQ64oCrbdMr9GoH1qqy2susiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUYyNzYINgjCoY+A+1kDeCJREjDD5m3v5uXs2eYm8N/A5ru0PP1brtx11WgSiQyN3YdxHEHtKkjIj6muoUXr7RcPrmMTMP5DBxFYyNPS5ErDlWRlychWyALJ8m0zuZrraF21n60AH0Fvd6+0Ietz+r+s2MAfYx3IfMuaqeo2HaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nslza6xh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nslza6xh"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8587427468so1900237a12.1
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2026 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780955258; x=1781560058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s30Xy+F24DvtDUmj65tpM/pnrumc3gqeMOd2G0xccRA=;
        b=nslza6xhZ6gBc8tVaa2P1FYc73zP5RWT+VUOfOlMVkI1CZAusHOb6SOe8OK5D01KXg
         dmQfGodMwqUQIOR2dNVQxhZl87YO972nyMKshhe8sL05DPOz9AjAYqffavqDcLAuHANS
         FGiBXM37f3f4Z1aIfcOXS6XV/+IXzs+5LZc8eXLA3UOf8lmUBRuXXD7OfQlIN1V6E6NZ
         IqQjeyBly6i7uon7Mju3Z4g/swjbSgPIM9hPlAl++iX7IA/o5bUhybmU1Is2mVwkBbkI
         sw6Izgt3E/wN+wuwschZYc5ZDFOeHL/1EXMSYb4IfDofDgcpcOswUlPw6ub+Whf8vv22
         iWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955258; x=1781560058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s30Xy+F24DvtDUmj65tpM/pnrumc3gqeMOd2G0xccRA=;
        b=idL/TEtfmjJ597Y89GTVxWR6g8zI6dL8trmaCExeuuMUM8LpUQVr8/CV6yz2fi1WJn
         is1FwVbvoCCIy+T+oE0VIn3cP2/OpP8y+Q4bhvcFe47hj/NT8ntlhgYd4ARhcrJdUKfq
         suLvPqGmTCTPTkoAUb15TvpsUSvehOxD5zuHyUgcf4HWLK0923XuolGtkez9hUs+WmQN
         Xghgl38I9/iQOICaCROoIxkdVvc7GUrvK28O5FQ52a63QVA7wow8CecE4MrayW5JALBi
         +xuTtFI16QjS7MUB/S+Zb/faHZAishPgSech12SjUPAEUVMMqvnaW4N/2Ho6ONcrpoTt
         E/Jw==
X-Gm-Message-State: AOJu0YwkXApHryXmWxX4wMPqMeIEb+6ZVOcnvWnPN2JqWYAqWYDz3W5j
	j28teej79dbl+vSFXAcqhsRxvAeFPiAM3QgDSBGo9Q7EPj4jb0Z8Qlp42Z+CfXIb
X-Gm-Gg: Acq92OHYhLZQqp37nVsrDq41SI4eFkbV2wjiSv1qb96yppBH4MqPKziEexKAd+aqW0O
	yKyhvsaDYmDQC26BZ5/iirBDxXzgVFWzy8RNE4+PS6YDuIRsn9AMXEeblzvsCuufQ0tBUFm6cj/
	Om+y4sG/68WnO16K8zIgL105S5Fss4uLv8N0MFr/S+K3bpuCJItZjJtpGBUg/L3EBVtIxBGQOnL
	Q3ALN88Wd7f5iJVaQB3tb0SjUmyh4M95yGvJtIVEZLCN/fmLyTCHXoUuwxa2jGjWEleOcaPBa6H
	5c+MnLmPyu6nWwtsEi2hUyJeZx2s+gyHngyemj54E8fSLzgqVTklwJ4SSRH2eqYxs9+1vSU+mGJ
	eA9L0+t5eK2ilEZ9mmagluob6VtgdIUWFCJnEEzGx3nMzOnRQL65q7HEKO81HsWOp55ZbgwUY0Y
	9GtrOWpJdql6AIFxhu0imD/PXOe3srUV25t5TVV0rzBHAaAjiKA22WSWAagNNGwkLHmKCzsvon+
	f9F/XMLIrGEsGmdz34jxWL5VVmEaRLLs+xhNuf29HmKaA==
X-Received: by 2002:a05:6a21:9204:b0:39c:4af6:4309 with SMTP id adf61e73a8af0-3b4ccd61dedmr21170749637.12.1780955258475;
        Mon, 08 Jun 2026 14:47:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm16016505a12.24.2026.06.08.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:47:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering
Date: Mon,  8 Jun 2026 14:47:15 -0700
Message-ID: <20260608214718.49503-2-rosenp@gmail.com>
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

The BestComm task IRQ handler accesses priv->dmatsk, which is freed
by bcom_ata_release().  With devm_request_irq(), the handler remains
registered until devres unwinds after the error/remove function
returns, creating a window where the handler can access freed memory.

Switch to request_irq() / free_irq() so that the interrupt is
unregistered before bcom_ata_release() tears down the task.

Assisted-by: opencode:big-pickle
Fixes: d01159dffa15 ("drivers/ata/pata_mpc52xx.c: clean up error handling code")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 210a63283f62..9af0aa89a5c6 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -767,11 +767,11 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	}
 
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
 	priv->dmatsk = dmatsk;
 
@@ -779,7 +779,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	rv = mpc52xx_ata_hw_init(priv);
 	if (rv) {
 		dev_err(&op->dev, "error initializing hardware\n");
-		goto err2;
+		goto err_free_irq;
 	}
 
 	/* Register ourselves to libata */
@@ -787,13 +787,15 @@ static int mpc52xx_ata_probe(struct platform_device *op)
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
@@ -811,6 +813,7 @@ static void mpc52xx_ata_remove(struct platform_device *op)
 
 	/* Clean up DMA */
 	task_irq = bcom_get_task_irq(priv->dmatsk);
+	free_irq(task_irq, priv);
 	irq_dispose_mapping(task_irq);
 	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
-- 
2.54.0

