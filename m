Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09633242D4
	for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2026 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078083; cv=none; b=EYSdBKWNRUf8Mzyo0upBxSJoxmzI5Us0OVuYNidjbj6XZ2BRfj7zkd/Gvu+qMOpk5TyxuKHmX1D2EFvimhjhbHMOdFbl5TtWqpTHCPiG+GyqdA452jCC7mPmxCbgOJ5q4mwgl4u5Z9AnDwha4DZnpXm4K7UJm3I0UOn5QJNHlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078083; c=relaxed/simple;
	bh=/cAePJoFLFQ0qWUgua+YcI2anEkgrMTozN9FQTusvEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7FTD5u2keCGTtER1qoee6s1vuZuHtKSm8MEvW646kGIDSgAkh7Wmy+t0oIoMBKuhsCB9guuUMd0aK1PtF4XjYmG/AHiMfMd8wACCcghRVuGo72dKJ7soKvepWzosTDK2D4QLMDKagdqgkF/LhN0Quw89CBVLjfuFAKQ0NH3bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcH9aAYt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcH9aAYt"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so4436984b3a.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2026 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784078081; x=1784682881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ZKIboljlMl2BHS7OS/1CYKXR7VTo24iT4oUvOKxEkI=;
        b=FcH9aAYtpJGscaLWmZS2UMHIOpiHYcW9qN2JO321FbzcmBI2PI+tQwTVkEnKBvig5A
         ksglqYV8P7uf1wn9Q6svdGra5PzhfKo83VTT62a/IcTYXkBmNCG68bqfd4oU72v9Wr55
         dyHU6eaMwiwoDeSbSVXIfxlUapLJVFvRJv8QcEYUl7s/bCuB9GCDNLLVMiNUqtf2N+Jc
         /L9JViE9aSCHWi66NRsdi+3WTtpaESo2W0uBtmMWI7w+vQzgIOvwBk2enU3mVFJEtMPB
         GBuIfqKF6HYpWQtns+lKy1aVgfwhhwVlreo7V7kfnKT/Q4b10DHw5aYQiCzFIw6IJeEw
         GP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784078081; x=1784682881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ZKIboljlMl2BHS7OS/1CYKXR7VTo24iT4oUvOKxEkI=;
        b=ZfBRdVbU3eW0yZ6Pfr/DKHj/dspuvdx3dyUOtDmPtXmmM44EMef4z0zP9gQYqo8rSl
         k0PFeZdz9fk++DAW/X9dzpnFfeMO0ZPA/f9Q9g6XRlgFPgrEYUsTtrq3uLsm+FYIWiuK
         U/5ZpIBmaRENG4PTICB99hN3hs4MS9rQatVJcwXjWQzqkXDr00QfP4L/R4IhJKjc7n/u
         qiXz4bJpB1iQSVUuLWP2y1iA7SAi2nyBu7Yc9ueQayvIxfCe5Hy8M+kmTKhutZctS5Xv
         p3DR6xp3wZqM0HYPqL8YqAELoWYTk2lLEPx55rS591nTomQ6s8fs10BChNP6L0IBWWGI
         RCPw==
X-Gm-Message-State: AOJu0YyxXC7ZPws+bSa5cYk3NP+PwTOTSMVomab+VCyty/7LzjxmaoOa
	ggggzusAzJYxA/wFniueWJeSbyFx3D3ejPI9ILNjxqJIT8sznS8kWd6O18kVoA==
X-Gm-Gg: AfdE7ckAcFe92R/FB+IwdnA/n14Le92dAa6R5BLty7TuEaj6DxpC/a4pK5TF7L41J3L
	874l1tH6+rwS14mANuT891s2B3/deXk/X6ejLiCp//9spNVppnu260XCwqCuomb94uT3BgsN+Uv
	J0sY9IxOqyIjv96Z44ELbs/O5nI1NAp5pU1RBLPQ4t9TXl1krAga9wwPjpkBeObUTJ9Na6htGAs
	QuLl3hqT97Lf7kTYZLNTcs6wzphohZawxfXKkJmBOpxbB0N7G0VYnkIcS9NYybw3xUSnqd7HeDC
	GDrqhjqWLHHtOqhIHR0GP/lKkbp/NPgRyxrln37vXIZcHL+kjinyeeh7cWqOFm0fAmLt09FJWZj
	39Ir7dIZKZ+Vp/HqqP8pTbp1kJPcTXxt7VMqDuwvoZrj/8ZCdnDFG99i+hAc6T0YgKhIRnF5DBd
	IqqN5t0GoauB3uIERUi06B5TXhutJxNrEqGV80FKtMF2rllCQzgMj02oszrmf5Mo7qb0PTamVuc
	xXxQIwsGx/20XaXU4uyCfBl1U6xGMURGWpicykeTSCCMpLhnuLjh39i1QnZBPzVwg==
X-Received: by 2002:a05:6a21:9203:b0:3c1:142e:762d with SMTP id adf61e73a8af0-3c34d5299f3mr7430640637.1.1784078081000;
        Tue, 14 Jul 2026 18:14:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3c1f77fsm10621994a12.32.2026.07.14.18.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:14:40 -0700 (PDT)
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
Subject: [PATCH] ata: sata_highbank: use devm_platform_ioremap_resource
Date: Tue, 14 Jul 2026 18:14:38 -0700
Message-ID: <20260715011438.1274211-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with devm_platform_ioremap_resource(), which fetches the
resource, requests the region and maps it in one call. Switch the error
check to IS_ERR()/PTR_ERR() and drop the now-unused struct resource
pointer.

There is a single IORESOURCE_MEM resource, and the SATA PHY registers
are mapped separately via of_iomap() from distinct DT nodes, so the
region reservation added by devm_ioremap_resource() is exclusive and
does not introduce overlap failures.

The mem-based ata_port_desc() line is dropped along with the resource
pointer; the remaining per-port description is retained.

Built for ARM (drivers/ata/sata_highbank.o) with LLVM=1.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_highbank.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 3421039f4bae..a0b6e197cfb5 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -455,7 +455,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct ecx_plat_data *pdata;
 	struct ata_host *host;
-	struct resource *mem;
+	void __iomem *mmio;
 	int irq;
 	int i;
 	int rc;
@@ -463,11 +463,9 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	struct ata_port_info pi = ahci_highbank_port_info;
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(dev, "no mmio space\n");
-		return -EINVAL;
-	}
+	mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -488,12 +486,7 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 
 	hpriv->irq = irq;
 	hpriv->flags |= (unsigned long)pi.private_data;
-
-	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
-	if (!hpriv->mmio) {
-		dev_err(dev, "can't map %pR\n", mem);
-		return -ENOMEM;
-	}
+	hpriv->mmio = mmio;
 
 	rc = highbank_initialize_phys(dev, hpriv->mmio);
 	if (rc)
@@ -537,7 +530,6 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		ata_port_desc(ap, "mmio %pR", mem);
 		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
 
 		/* set enclosure management message type */
-- 
2.55.0

