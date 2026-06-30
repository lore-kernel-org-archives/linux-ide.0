Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49933DFC93
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851059; cv=none; b=hAawjPyxDulco49D+O8FGBjn1zaAUkqDpgtOAifrtVPgSoCbK8Q8vsSLH6GEY4mHLw9YRB8AOBUbvqhby9YrQoqepihPA5QIKq6FxhENyBUCTUfcwTBjBr3yjG8Gt3IGpz5UUbKj5mxu1QWG0pHv5YEV7ZqhuYsUAk79srr1j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851059; c=relaxed/simple;
	bh=b2VhNvXrHCrhosk8OuiXbSxaibv0yuL8K3YtVNw9Aqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0kHuOmGyQ8o+rg+vLK4xonyVavmnlNBxXk1t3LTQfg1jyHjYTR4Oi0uyVDaio/WeMFDFQzgkRFNTMY2aJrokjqKkSFXlSc4Zo8Mu+L8TJLGERFRaX5UVqqd8hiaTGmF9rnCdLTGhTGpiPrJC6jLUZZ/utJflydz8BoilVuZ+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkvkxold; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkvkxold"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c998fd549a8so911166a12.2
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851057; x=1783455857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cC8fzwBv6xibExzUk8Zd1lAmfRWnIh89Kfn8/etfuyA=;
        b=BkvkxoldVp6hG/dxW12tBOtMCKVuuE2b/4mkwum+4976rMTVATdsshGS81cDTO8GuU
         udD/p5+9GQahMpp2XgOxzybeyFeXgI4DknHT0W2uhEdB9qncuTkNLt7wqLMpVIBMCJzh
         oVSIKDK308Frv5p+TUGjB0Io1n13AEMBccBpBtmQA0QUKux9bd3/6AphkwkwUHDc6CZj
         6zs+SLn5e9HvmLw2XG/rhi3Ulk1gZl5Ul+BpfyBQU4bvabJvUJe6SULfvS+Zcys4hZMG
         xLvhyL1CZGkhsNZa8oL+sRZOj884XTew6ROBVJkGl4tJheuh7g9I683WKXZKN9NGdOjN
         s4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851057; x=1783455857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC8fzwBv6xibExzUk8Zd1lAmfRWnIh89Kfn8/etfuyA=;
        b=OOVVBmdlpqkukfOcuPncH7e8ih08EiQ/7wRhiyUIzhrzX9d+KzbVLVeSm1Q+i8orGD
         M0qGvo5Jvq2X79ZDiZs2J4/ftUzmnZzxuFJ0zzvpbpF2hF/DVgP3pHk1L8GvUk97m44T
         Ss64PymS/n+o0n0hhA/5Ywy4y7KwbuJ+F+bI816lovybGbewP9apOXyeAwaXAQG3ZaAm
         s14kgvSD0ZjWfs4uZrFr3Na9uVrpIUbKI5pVm2amj6zsFfxeDWKZewKlUOmUHn8pffsH
         zEXV3Kqfbh2k44vByx4egmduvlYc8Rn+dJ0IXYFspShjfJVYRc+mgQlhbOgbpABk+o/J
         2e2Q==
X-Gm-Message-State: AOJu0Yw0ouAOo98W3SKHX9BoDf7Vsipixfh+s9WEcITgnyHi/KDIk6hq
	Z6nJIunPyaI4DwQXAdwIwFTWT/PJaUiJjb0Vxaw5KEYxqRZKJNAzxTpzx6EQyY8B
X-Gm-Gg: AfdE7cleXWMY2sT2u0bDdAWNfL2Oj55MXkFU5IqwkSMrQcUrkdbUkKI2wlDk8x7dx/y
	rF00Ka8gEYuCQk5DGfmHNTVX2EcdoED31SXcZEIuVst4GD7+j2uNavVWjGUD2jf36PvXH5cmEk0
	4s5oyStPr5EJSTMvH3DVA9ea5SzhI69H23ks2ePCNvgM0nnsWxP1MtDfbNV3zv5GTDkErrlt5eu
	VlWT4+X5d0i94uipPDf6ZB4YAUMtEbGwrHO9jwqcq64ZDpN/0Kg/UsfijJ5q68jmGhDdeJ814s0
	qHyknzwKzWkArn0WEGNrpKDblTO+EFnSBgWVpn8LRmWv0ZyPyS44U28PvWalat/oweenOnuLofK
	kcUB5Z0tsR1CBvBYe4r1otT+I1hWmkPUZT0+cC2Aj9o/GcNXbagb0kC+o9PhGdsS05bqM0dYIGc
	xx3UT/vYACRUwfANFneLzuaKIEZ6X8TEKO8Knvo87QdZjm0CTykHdjFc5aD0cUZ1dFiVr0uhBWb
	/y7+sd0zRCZlTctGaRA
X-Received: by 2002:a05:6a00:451b:b0:842:7296:dba with SMTP id d2e1a72fcca58-847add682efmr1714088b3a.7.1782851057029;
        Tue, 30 Jun 2026 13:24:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a0337121sm2688854b3a.44.2026.06.30.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:24:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/5] ata: sata_dwc_460ex: cleanups and interrupt ordering fix
Date: Tue, 30 Jun 2026 13:24:10 -0700
Message-ID: <20260630202415.234463-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series modernizes the sata_dwc_460ex driver by replacing legacy OF
APIs with their modern device-property and platform-device counterparts,
converting old DMA resource teardown to devm-managed cleanup, fixing a
latent interrupt-ordering bug, and dropping a redundant stack copy of
port_info.

Patch 4 fixes a real issue: sata_dwc_enable_interrupts() was called
before the IRQ handler was registered, so a probe failure or an
asserted interrupt could trigger an unhandled irq storm.

Rosen Penev (5):
  ata: sata_dwc_460ex: use device_property_present()
  ata: sata_dwc_460ex: use platform_get_irq()
  ata: sata_dwc_460ex: use devm for old DMA resource lifetime management
  ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is
    registered
  ata: sata_dwc_460ex: drop redundant struct copy of port_info

 drivers/ata/sata_dwc_460ex.c | 66 +++++++++++++++---------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

-- 
2.55.0

