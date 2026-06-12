Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930634CFDA
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289171; cv=none; b=JiW4KcS4YxW/PlS+Jwy5LzGxhZ39P4hbTFabo6GdWrVc6MtPHVrN5SJbmvxPIoF2qLJjtSlXslpJJjayRYSvWlGHvjUkyz2qcp2/8xpJFWIDZLLD1Jm/0OBC9yX4KhZ4CPUniGVn3easYIHNa2iGQKQgAxDHrW1A7m7u4rV11fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289171; c=relaxed/simple;
	bh=lgccTGsaibWbGYrgiSBRBT3uAGaakFBX/Csibv5T0pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMsPLzkB1xrYICEW0qD2GikdStyotQbdPDl36fBXNuUp+6mnUdcJ9Se7NDpIHIk93f+03M0z4AWZEYT6Emh5mjUKgfObmr7M2Jw6Ax2ivPXO+5vSRmbT3l6tHFB8Y8sgMIjZbPP5ZBAYgqIGTZgi528xrq3Ki8qXVGA9VnXBZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTKYnTKO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTKYnTKO"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858961a8efso575589a12.2
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289168; x=1781893968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paVBip7d4bA/4l1GnzUS+7HmxQ3RS/Ae+nq1ju4rOJE=;
        b=CTKYnTKOmAZLLH8heRtBiWLLBqL8SxJ8TWaoefvJOQe+lpmfwwRBFZa7FhftZNH4H2
         BxH8NWZGVQOjwGDViyWj0tTHzMO/YVV5o3alW+ChSazS2YNjVbWnxJ0dEPjS6FDd2mTS
         vQ7ZbxtbCgtbJahPW+r/9UaczjrysFnt//SYXnKuxvnE2bSjWe65AYNXEXHHXeoa6ovT
         NtjLkc++6Ce+wLF9tzjdoUd/akH6xinJAekzbimvBXOAAgYMvftUoTIn+iyUf9X/4HVS
         s61v1YucWbaMnRuR+Iko2LTxfBR6NmQckJkij0AUU8Vxr0W7alUbjpq8TCxFCI2nMb8o
         mV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289168; x=1781893968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=paVBip7d4bA/4l1GnzUS+7HmxQ3RS/Ae+nq1ju4rOJE=;
        b=XCtsHs7vj6uuIfDHs1zvc4QPgBT4YOv2rw4T7VegfyCNJ3DIZY9Jtpu97fMjGZTDGO
         YEmivIUkeF9+3te64gLngdwgQWRR16iHpvRpi/FqXffqEMyQqRnlLne+7yMYg1txKf75
         iPIfMnCGMafyy/x2vFmjRPKx4Uk2ujmxOOYxnH4iME0U81kSMpXT/dpnAhTscx3A/HWy
         XD8SgOaS1V+7gvjHMF/nnTxfbKGPTSW8M7UjyVdBkpJ1HR8X3i9xms67HdlZQ+6sC/Ic
         +UujIMlX7WO9JiXhd+FBaz1/TMTgvNxh0IrjjgyOgHd59yk8+I1qunKTlZ9CzUS72nSH
         VJeQ==
X-Gm-Message-State: AOJu0Yy+f5YVyCudsXFeRvaPLi6tURh8mXgodKsw9OKmnzoWe2FJ4s3P
	IuhwAvRQ3Z55+ALJmXLk0Mw9dbAu5j0uwWkvK4D4qRhi+4LVNDYWFI5brNFkFg==
X-Gm-Gg: Acq92OHf/RMJnvCrXeoE7FFAwj0XMV/JrqUJSL1CMMmQ2hTKwBfy7WF8bFr+HTPCKhX
	7j8HwHCwDoya4iW9gZpHmj1v2aXRBm99+gkkuqVbrop9m7FpE+fTIcHEPZ2DeNTmHnQIaELVRc1
	OgMVeLvFw/uD2tYYpy4baa/h51nrvkMbJ5KQY7mT+0pKBUSP5Y5KNS2/VhSqMBislnISX2eRofJ
	xAMZdY2+Zad1lZ+koyQupGwBAFwaU/ycqfm5AqWLcxS4iA4g1oLsFyTi5qTlunbfb3fZXyUQsdX
	AjnpS4NHZUy1KsFIRRhPkuCAfsRDvJP1chyGpP9KE+7j2Udfw4HbD9wI2K/AzDJ2G0M35L0ifVY
	nALPqk01kuBNlIo5RlwdG3nCvTBYsE0V2MK070gUXECQYO3EDe5j1aW6hjOsxo7/TNRGbosVCre
	Ku4DAn/ArxuZsB//xoX1p04FXwhlYnM70PZx+c+qWRHAsoA61U3E1miH/A8mgBFIy5MMOiRl77a
	lyKFae9TfF6N+zXB31krkeAV4MrQYVvdw==
X-Received: by 2002:a05:6a21:6b0f:b0:39c:235:c5ec with SMTP id adf61e73a8af0-3b783fb3210mr4906265637.34.1781289168172;
        Fri, 12 Jun 2026 11:32:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 2/6] ata: pata_mpc52xx: synchronize with task IRQ before resetting DMA state
Date: Fri, 12 Jun 2026 11:32:23 -0700
Message-ID: <20260612183227.20446-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612183227.20446-1-rosenp@gmail.com>
References: <20260612183227.20446-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpc52xx_bmdma_stop() calls bcom_disable() to stop the BestComm task,
but an already-pending task completion IRQ can still fire and execute
mpc52xx_ata_task_irq() concurrently. The handler iterates the BD ring
via bcom_buffer_done()/bcom_retrieve_buffer() and writes to
priv->waiting_for_dma, while bmdma_stop resets the BD ring with
bcom_ata_reset_bd() and clears waiting_for_dma -- all without
synchronization.

Add a task_irq field to priv, store it during probe, and call
synchronize_irq() after bcom_disable() and before bcom_ata_reset_bd()
to ensure the handler has completed and cannot race with the BD ring
reset or the waiting_for_dma clear.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index fe445d6aaff6..72a2b677bc90 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -58,6 +58,7 @@ struct mpc52xx_ata_priv {
 
 	/* DMA */
 	struct bcom_task		*dmatsk;
+	int				task_irq;
 	const struct udmaspec		*udmaspec;
 	const struct mdmaspec		*mdmaspec;
 	int 				mpc52xx_ata_dma_last_write;
@@ -571,6 +572,7 @@ mpc52xx_bmdma_stop(struct ata_queued_cmd *qc)
 	struct mpc52xx_ata_priv *priv = ap->host->private_data;
 
 	bcom_disable(priv->dmatsk);
+	synchronize_irq(priv->task_irq);
 	bcom_ata_reset_bd(priv->dmatsk);
 	priv->waiting_for_dma = 0;
 
@@ -769,6 +771,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	priv->dmatsk = dmatsk;
 
 	task_irq = bcom_get_task_irq(dmatsk);
+	priv->task_irq = task_irq;
 	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
 				"ATA task", priv);
 	if (rv) {
-- 
2.54.0

