Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA73E44F2
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034218; cv=none; b=AdZMfZUTJ1W7TlBoZaPJPkPGlblApJM7BjXpali8buzxNdN5wk46IkiAxLoTIVW6jGaDBOGjtkzSmvY2XTaVuNN2EoioVd4bsJ1Wp0mWYc3dyNChvelNxcJV+ksydC/L/fdbldHRjcxDAFbMIEkT2O9TidkaBuUJMbLilfXHvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034218; c=relaxed/simple;
	bh=A60/IlY5mxmQ0wnyvpXzKbJztytw11vUFaZY6i9pLf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs3wU56zgIdIP3qIAaMpj9npJpFe0H2N/zITi74g5i/SnqVQZM+nlhNB3rz/6x84MVMrNV8KmG9MAQ+m2cBgrBJI1oeOt38Fo3wJrI1hmr9F8bfNF7m9EcXYSDCr5eO/InlFY1eCXWhe8KYa1ArbhzJdziW3ZmpgxEFm+L5EOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJSeQ6YG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJSeQ6YG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6020084a91.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034216; x=1781639016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXKs8PNsUNepHHdJ0PnVTocrirWWsDcSWefxYJT2Kv0=;
        b=PJSeQ6YG752moRdmlHJJcrvcuy9/pPyg3fvoGC0qH1PCgKnPgSNrzVHNfE7JYEYkW8
         TkGrwuX30WvdgalbHgOZnG7j7X4XmHwoWUj6Q30KYJ/fVh/ryBvWi9a6IJbOo0JXp4Zg
         OydiLNlwMz5vvLkRRO91qOfePRaR/NUujn5FYlO3xSDzxmVPf7wHnoL3cePppgw0Osln
         zQTtvoblplA2XDc09LFDREunFG5kXNR/Y3ZuVXIq7GY2VTbEXgbZAzrxaeAezd4sZ0Fo
         Pynzz2CSQghs4RvXzAccrj9WRSm7bNPTZmyCcs0bhVnHl5HMq/g7vJWTBKRCinEv9qjp
         riRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034216; x=1781639016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXKs8PNsUNepHHdJ0PnVTocrirWWsDcSWefxYJT2Kv0=;
        b=T52WWnvSfEePTTWqQvqoWYASAUpaF4VWkdAvKqjwaLN0/VfUW62LBaIcV2CODiYNvH
         rTcG32pfSx7L7bSUtyOEPvxXqG7kSF3BY10W/bzCzWd7tC04Zu2dAGMO7MZvjF9ieJzu
         kGnMZuuNI3FpM3kIiUGNCwK2XnoIAes3q2znX9GUqQMoW1HXzoQks2e+3WoeCehAAfmv
         x+riUJP90JC4FbMLS/7dFUvENBl97Ls9KrmL/sAOTl1Zg+RlcrI3+2mGVXKJCZp5T1un
         WkmC0A9F1zbrVF/s6/BYoazWbH/tOQTtUHqyezpsgPrvEj3aSbekZHR2ty4DQb7uPzKO
         RztQ==
X-Gm-Message-State: AOJu0YzNWua/4vnr/t2nJP+gDbMzPJG/dPr/hv4VrAG0JODeQcevnNss
	uuH0B7D+r2YmIl5Arabj1m0j5Y173EAWj27pzX7jzyrHp1EquyHieoaW6GVSlTn8
X-Gm-Gg: Acq92OEQatys4cQ2kD2YYblkf/MCA4dm9aqRPl2tDYKQ6AJ6gK45BsdA1mziZbGozl/
	Lx3ImzUav9kMrY18y9al3u0qhy0F+gJpcMqeXjD+zYxv1gQ3xIXJ/5/vb67xhPZwBsE4YGIBKK+
	GZURyMSncjhBFR98Gxy2wO0GP69QblUmNt1rdq3TrvAhdKqXP7OlzJtK3Uw31cwDjG3CtffOAHv
	7pSCcVxG9lSbFt7vay6xnFUYseW7g4EkuLrfjrfJE8C5pMquC9LGBKAh+2n7MOmNFjXdzl2OMJe
	oPnfBKhF7vB/mTbAZX4M3lizeqkCGYODdX/HE6CQCI2PRLQ8Lncms0WJGG256pfaL1WOTWkXiYJ
	if+jXIyCZReF8RSO+yb+g0wxi0qNwWxdaSSUStrIOfsMpyK+JIjug6DfyPlIggE59hQFTeeErnm
	vTlCMgQUEpElvCX8Qih1MS+Gzg/UDUQ6XtJwmhpeRZMcVC0RvLxrU9aWv2I9JizqLfJzAvXOLeT
	fLdYDzqC099s4+NHj2DCZ7E5rR/Mn9NRRRRFbehqJBdOQ==
X-Received: by 2002:a17:90a:d44f:b0:369:69f8:ad6b with SMTP id 98e67ed59e1d1-370ec3d60cemr24915048a91.0.1781034216041;
        Tue, 09 Jun 2026 12:43:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 5/5] ata: pata_mpc52xx: use devm_platform_get_and_ioremap_resource
Date: Tue,  9 Jun 2026 12:43:11 -0700
Message-ID: <20260609194311.6217-6-rosenp@gmail.com>
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

Replace the open-coded sequence of of_address_to_resource(),
devm_request_mem_region(), and devm_ioremap() with the standard
devm_platform_get_and_ioremap_resource() helper.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 84a4cf42ef54..d3ee117b8aa0 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -671,7 +670,7 @@ static int mpc52xx_ata_init_one(struct device *dev,
 static int mpc52xx_ata_probe(struct platform_device *op)
 {
 	unsigned int ipb_freq;
-	struct resource res_mem;
+	struct resource *res_mem;
 	int ata_irq = 0;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv = NULL;
@@ -688,25 +687,9 @@ static int mpc52xx_ata_probe(struct platform_device *op)
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
@@ -740,7 +723,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
-	priv->ata_regs_pa = res_mem.start;
+	priv->ata_regs_pa = res_mem->start;
 	priv->ata_irq = ata_irq;
 	priv->csel = -1;
 	priv->mpc52xx_ata_dma_last_write = -1;
@@ -778,7 +761,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	}
 
 	/* Register ourselves to libata */
-	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start,
+	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem->start,
 				  mwdma_mask, udma_mask);
 	if (rv) {
 		dev_err(&op->dev, "error registering with ATA layer\n");
-- 
2.54.0

