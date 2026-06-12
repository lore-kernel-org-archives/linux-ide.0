Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCC38E8AD
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289176; cv=none; b=TX3iKvCz92XpTfEvWRzuGfbHTS14D2+CmjhnGC9WEouBUNJkS+1KNizG2lNobw0DfqkCuL0+lUN8u5f4TsXF81EW6asFf8dhQKKIAOrTBwBNY3k2bU312biLpToBnRzq+5qn+V8KLAHyvSynf05oj9Lkd3LYaBtrkCQHJYv6DME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289176; c=relaxed/simple;
	bh=zwK5twrcz+LPB8Di+qZyvrQYZFZ+Wu6jlYQLqk+YTPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaEUXt7tXxb3qTNq8y3LuQFJO1JhU9XdiGRRz+Px9dQy4Q7zC/3taKAFAtBkMIl9c/LyuJejy/MHbI8WUuAsqo7kCaYSECgdMVG6LTb1rLfeSH+YSQCjjMUPQLypKaLeBDmRayStYmaNMkCLv8RKqLnlRJ7xAYbI33Uu26EyRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzVwwHyr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzVwwHyr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858cc9870aso1081251a12.0
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289174; x=1781893974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNeIX9pYnmvrn/0wKk+nm7m2LRVDAEPh9EXPv8gmtgc=;
        b=bzVwwHyr0WX6DOOOItW0PdrxFJs8P3yuM1DrlRnB/M7bT79oM6u9VnT4bhEvHT/W3R
         EXTZAuKoZ18ZN8Fo4y8exwVfeSeIy100tann8WL4Baj7JYYeNvpvJ5JK2wVlrichk3Ei
         qw8Dg41CgBN9fiyQedwBox2wo1FjRP7MLazplzW3GnfCJFHVRibsmrD2fhCZUBwZKHZ3
         YpitN2PWy0ZJAq47hHWLuAnzvCNWtN1uOI9icRnuCATl3RBWi12O6Mj4K0yrKs2wgYXj
         ipH3e585x7zndkZcRK9MWjogJksdkNo+L3wRnpgm62ySzD5TFMcOdjpg+56xzz9kdzOD
         rfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289174; x=1781893974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNeIX9pYnmvrn/0wKk+nm7m2LRVDAEPh9EXPv8gmtgc=;
        b=CgQHxXlmPjx7hYobZaN7CXoYI95t8ZN1bMYbpvtN08uTl4EHcS60mECUDqdiXXfMRy
         dU9UX1gUpW6GTjdZIwRsvQm/Iax8RhMNezHr6yY8HwEa9Sru/2dnAzu9I6hQxrAaA83a
         rXU73/ya3p4XY8KdZrIThnQpzHE6gUMXyE0mb6l9sLAVguIYBcTqYestuvdVhrCTLCvB
         mWGBedCKY4oflY1wzAUeUAvZ5BRzsZcoXHqlk7V1kVIaHj3v+Y8V6Mkq8D+m99orAWw/
         SL9tiTDzoleg+yOJi5sgg1pWdA1OyRm0OIRpOg+ZIaiXRGu17LSo9VcqwgYF/Jz0Flx9
         Ecvw==
X-Gm-Message-State: AOJu0YyFYc7kTSA4Eg9q2P6PBpFsY3h8IkGf6SPjAH6Zql5ZvTOY4kjt
	ncCUu7ExGeXa6ToNGCLBTPAvU9SweJ1e3tXTztlZdIxgb3l28DlLLOm7Yq6Ltw==
X-Gm-Gg: Acq92OEAoRMdiU4dKBJ9gvW02HAYBstQAcRmahGqBI6zpC2YpnFU5MPGSy7xPQtdz9q
	go4WyLn63kFG/4KOd2AdDjvIOzLN1+ArkZnw/v+xvTuub9NZ3+t0cOfeO9UxbyFdUzAbv6oMjfa
	Qm9FNtOJkLPtr/1CJU0JD2rp07j6BDUvZ7/oeiqYTx5xeCxq8uH3l/2iL5UEw31hR9/nZ0h2+hb
	Q34RBdVHDYfVtJBuqjcuqfWl/cU9jBzsPthMg1gyRyVrkmeDbSzi9hSWIDoR2C98EEv5uZ7sjQ7
	zwIJfh4wLv6U1x8TXqS9JSIKJ4ZCImL33nXVeR36fIzOZFCP1GyNm0dtCWoFu0cHYXfb9tQfqXM
	0IAhnjLekYqp1Ior46At9XfakFVYIEOVLO07xfPHFOML0oAXdT/k2Ewu5nvygUHT7lWHVwe1R9Y
	//Ri7kxcnQ7KnxhD46bJdw0LQrisiGJJN2azYTHTnXCtNgkk38zYTxWK9gHORUP+muXQ96YJAvg
	htBHBIJGYaunVf0C3l+Ww/QcywOZ+7ugg==
X-Received: by 2002:a05:6a21:310c:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3b780f3ff1amr4174698637.14.1781289174317;
        Fri, 12 Jun 2026 11:32:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:a073:5e58:ab5:a167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm2795034a12.5.2026.06.12.11.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 6/6] ata: pata_mpc52xx: convert to full devm resource management
Date: Fri, 12 Jun 2026 11:32:27 -0700
Message-ID: <20260612183227.20446-7-rosenp@gmail.com>
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

Replace the open-coded of_address_to_resource()/devm_request_mem_region()/
devm_ioremap() sequence with devm_platform_get_and_ioremap_resource(),
and switch irq_of_parse_and_map() to platform_get_irq().

Use devm_add_action_or_reset() to manage the BestComm DMA task
(bcom_task) lifetime, and switch the task IRQ to devm_request_irq().
With both resources under devm, the LIFO teardown is free_irq before
bcom_ata_release, which is the correct ordering.

Remove the mpc52xx_ata_remove() wrapper and point .remove directly
at ata_platform_remove_one.  All error-path gotos and manual cleanup
are gone; any failure after devm_add_action_or_reset simply returns
and devm handles the unwind.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 64 ++++++++++++--------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 238b39af38db..2472a2e2fbf0 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -671,10 +670,15 @@ static int mpc52xx_ata_init_one(struct device *dev,
 /* OF Platform driver                                                       */
 /* ======================================================================== */
 
+static void devm_bcom_ata_release(void *data)
+{
+	bcom_ata_release(data);
+}
+
 static int mpc52xx_ata_probe(struct platform_device *op)
 {
 	unsigned int ipb_freq;
-	struct resource res_mem;
+	struct resource *res_mem;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv = NULL;
 	int rv, task_irq;
@@ -690,25 +694,9 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 
-	/* Get device base address from device tree, request the region
-	 * and ioremap it. */
-	rv = of_address_to_resource(op->dev.of_node, 0, &res_mem);
-	if (rv) {
-		dev_err(&op->dev, "could not determine device base address\n");
-		return rv;
-	}
-
-	if (!devm_request_mem_region(&op->dev, res_mem.start,
-				     sizeof(*ata_regs), DRV_NAME)) {
-		dev_err(&op->dev, "error requesting register region\n");
-		return -EBUSY;
-	}
-
-	ata_regs = devm_ioremap(&op->dev, res_mem.start, sizeof(*ata_regs));
-	if (!ata_regs) {
-		dev_err(&op->dev, "error mapping device registers\n");
-		return -ENOMEM;
-	}
+	ata_regs = devm_platform_get_and_ioremap_resource(op, 0, &res_mem);
+	if (IS_ERR(ata_regs))
+		return PTR_ERR(ata_regs);
 
 	/*
 	 * By default, all DMA modes are disabled for the MPC5200.  Some
@@ -738,7 +726,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
-	priv->ata_regs_pa = res_mem.start;
+	priv->ata_regs_pa = res_mem->start;
 	priv->csel = -1;
 
 	priv->ata_irq = platform_get_irq(op, 0);
@@ -762,47 +750,35 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
 	priv->dmatsk = dmatsk;
 
+	rv = devm_add_action_or_reset(&op->dev, devm_bcom_ata_release, dmatsk);
+	if (rv)
+		return rv;
+
 	task_irq = bcom_get_task_irq(dmatsk);
 	priv->task_irq = task_irq;
 	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
-				"ATA task", priv);
+			      "ATA task", priv);
 	if (rv) {
 		dev_err(&op->dev, "error requesting DMA IRQ\n");
-		goto err2;
+		return rv;
 	}
 
 	/* Init the hw */
 	rv = mpc52xx_ata_hw_init(priv);
 	if (rv) {
 		dev_err(&op->dev, "error initializing hardware\n");
-		goto err2;
+		return rv;
 	}
 
 	/* Register ourselves to libata */
-	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start,
+	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem->start,
 				  mwdma_mask, udma_mask);
 	if (rv) {
 		dev_err(&op->dev, "error registering with ATA layer\n");
-		goto err2;
+		return rv;
 	}
 
 	return 0;
-
- err2:
-	bcom_ata_release(dmatsk);
-	return rv;
-}
-
-static void mpc52xx_ata_remove(struct platform_device *op)
-{
-	struct ata_host *host = platform_get_drvdata(op);
-	struct mpc52xx_ata_priv *priv = host->private_data;
-
-	/* Deregister the ATA interface */
-	ata_platform_remove_one(op);
-
-	/* Clean up DMA */
-	bcom_ata_release(priv->dmatsk);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -843,7 +819,7 @@ static const struct of_device_id mpc52xx_ata_of_match[] = {
 
 static struct platform_driver mpc52xx_ata_of_platform_driver = {
 	.probe		= mpc52xx_ata_probe,
-	.remove		= mpc52xx_ata_remove,
+	.remove		= ata_platform_remove_one,
 #ifdef CONFIG_PM_SLEEP
 	.suspend	= mpc52xx_ata_suspend,
 	.resume		= mpc52xx_ata_resume,
-- 
2.54.0

