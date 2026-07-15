Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D553191BB
	for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078028; cv=none; b=r+l/w91JsiGMOQ2+X5oR6E+NbSuuAU2YwLFmlEwIrOlZNbhP+T2a/PxB3QWpLbTjAB2X8kbVYBDgz7QKlZi3S3+otrmudDSBHUifG2jY2nJPExL+ZHtRHiKbWB1oab9IdXlUO4wiAbBP+nuD16cKmAECIWvCyBPlfAAAAFUZZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078028; c=relaxed/simple;
	bh=P43JCHOf5w5P2ZjP5fROoPb0nb32cDjMMB3GL/AOF+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXAJWGSUCV8flChapopJeu7rI5upHNQ0ePcOxNKE6eJe9UsCwnCP5leWvzmKC8uW+IvEsUSQuEstq5ckiCTJ3sKHXw6C2WmggoZCtgMZpXIJFtQlDARU89ADJC5kXE498eQCZJqm9N8EdExdSilnl4Hd/Y5a59ushwzRIvwN3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGIpM0iT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGIpM0iT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4917231a91.0
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2026 18:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784078026; x=1784682826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIHLfJs4cYwuricbvRyPu6UapQ2vEVELHf2OcqtSJ/8=;
        b=qGIpM0iT4+66WN0u/ooEU8xUjwwXklXS6NF8gzEFlB7VmQcavJS0FmrHTf/E21XwL3
         DL3+2gw8lELuqPWnBuiIlI16vFAFOK7yZUmRdWnhPPGpybpdtuhxD+zJk6N7lBlh/Bw0
         TnBnhh0UUj+Q0b+oe8oEfbJY5NUuLW+LYDgUH94cydeYXulfQhgM1qscq/qGJpIGplFk
         xzI4XC4YtAwtJt3aif0UTMXo9eH0WTSEn/X+gK7sLYq240MfMkmfA7KM1zzqy6AD0aj0
         S0vFqgdyzwNw7qF8GI+dIhsLM2gSZzNA+txMaoCiivwpqL2FMOyi87elET3N89jJEPeM
         l9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784078026; x=1784682826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIHLfJs4cYwuricbvRyPu6UapQ2vEVELHf2OcqtSJ/8=;
        b=rD8xeEn1/yuMpo8OQln+BsIaBLwkdQb160XA88WQcnga1L1KmqZiFWeZ/I/z+ZjsNP
         lhg8AoGsPb9VhXmDffc4+ZoZ+T84nzrg29bYJEUkGs1HtnZR/DBavGMnLdvRzll67X87
         Xb5HmUTjRNOhLRf3mps9H2kZrR2dFqLNoI5qbIRzHTYsrXF5Hj8sXoo8/K3+Ba6yRdI4
         Mkp7kVO7XwuM6LYMHRoLUJIuIB4auhec0RzR2JFiBuxUuxGtcV77LULc1lhpDCGW9IR5
         lWlTv1hC0PTFw5w+nD5x7bqbuaHpVzUskev3h4AlAN0N/LeBftfoOwtJf6kYoPdfSEHm
         jKdw==
X-Gm-Message-State: AOJu0YwqtZKj7XDNl3Lyw2y3uLW+XEDD25LjeyL6Nt+P/3r8yYtG1t9w
	8SqvM7jzyVRJQdeQkmDWBbz3Fb8zDjIXwIiKp8dTS5/uF5uvEHHwr5t8ix6uLA==
X-Gm-Gg: AfdE7cnoydmNg0c4OkEGk7w2GxcjnX7AKskM/uxgH+7m1T0AbVmUm+tdsrN6Pw2ABSP
	/Y9IGLtRQHLA+U2ogdHQeKau/3pxcGi53DthdNnaqyH8p5cAtPPpsGaK7sj37nL2ya6A+f7gM8J
	sAofbiQizVIjUvlzp5Jeki2VYeu92hzkaKgAP6X63U1UToIQOrt92792AcAt0LMjEfVzSXobVwq
	dhCTy80mYMHPgXz1YaXBPX1fbVv830VCMTDOaKjJoqkDjlOQrFlUUBNBj2p85wwfB+kNUG53jGX
	z3hKrDs1U10Y+qLyZU1HeKNjBv5tf49XId9oFlnYPZHuNJ41u3TDDHABiyiaFRtlDg541xCAZoz
	pWXRXjfoQDNqPVPlWqa5WmYJZeFpjuPUHEff9w4YpUY3i3+BSrPM95iRFt6f4fW6ShAfwSUUrGt
	Ggw53YeSWVm06AWvY4KNarE+yxcunYvQWS0uX73rOgMXtiyR1iYemcWtGvnA02jH1WVS6zkUOhO
	Pe5DzRSstgFaoUqL2D361jGW74VkrBKd+ACGspXQ+JEVCmWctI2LSGLqa3h4bi2kkkjGoh/EoHQ
X-Received: by 2002:a17:90b:534d:b0:387:e0cb:7f6 with SMTP id 98e67ed59e1d1-38e17fabbd6mr5420793a91.42.1784078026383;
        Tue, 14 Jul 2026 18:13:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1730acfesm2185900a91.14.2026.07.14.18.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:13:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] ata: pata_pxa: use devm_platform_ioremap_resource
Date: Tue, 14 Jul 2026 18:13:43 -0700
Message-ID: <20260715011343.1270261-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequences for the CMD and CTL ports with devm_platform_ioremap_resource(),
which fetches the resource, requests the region and maps it in one call.
Switch the error checks to IS_ERR()/PTR_ERR() accordingly and drop the
now-unused cmd_res and ctl_res variables.

The DMA port keeps using devm_ioremap() as its resource is
IORESOURCE_DMA. The CMD (res 0) and CTL (res 1) MEM resources are
disjoint in the ATA task-file layout, so the added region reservation
in devm_ioremap_resource() does not introduce overlap failures.

Built for ARM (drivers/ata/pata_pxa.o) with LLVM=1.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/pata_pxa.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 9f63bdfb8576..c816997dc0a9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -161,8 +161,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct pata_pxa_data *data;
-	struct resource *cmd_res;
-	struct resource *ctl_res;
 	struct resource *dma_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct dma_slave_config	config;
@@ -181,20 +179,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * CMD port base address
-	 */
-	cmd_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(cmd_res == NULL))
-		return -EINVAL;
-
-	/*
-	 * CTL port base address
-	 */
-	ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (unlikely(ctl_res == NULL))
-		return -EINVAL;
-
 	/*
 	 * DMA port base address
 	 */
@@ -221,14 +205,12 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	ap->pio_mask	= ATA_PIO4;
 	ap->mwdma_mask	= ATA_MWDMA2;
 
-	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
-						resource_size(cmd_res));
-	if (!ap->ioaddr.cmd_addr)
-		return -ENOMEM;
-	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
-						resource_size(ctl_res));
-	if (!ap->ioaddr.ctl_addr)
-		return -ENOMEM;
+	ap->ioaddr.cmd_addr	= devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ap->ioaddr.cmd_addr))
+		return PTR_ERR(ap->ioaddr.cmd_addr);
+	ap->ioaddr.ctl_addr	= devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ap->ioaddr.ctl_addr))
+		return PTR_ERR(ap->ioaddr.ctl_addr);
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
 	if (!ap->ioaddr.bmdma_addr)
-- 
2.55.0

