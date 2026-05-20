Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA73C141F
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316649; cv=none; b=Mx7EB1iXHDVO3LERWd+r5NNIDeR0pF9Qs3SG8/sL6RX3at+rqpSvEI3zyiSmRDQqHmddYrFXGfTYL455+h94tpEfW2frUheChKjqjEoMuc5DrTz3EdwkGr1pskIBxDCOp9o/L3vdnFl7f0tWsy+U1T/+7BBrAuwwhhpuKZqtQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316649; c=relaxed/simple;
	bh=x5iofzhh9Kv4/fDT7xcT8nMb8+L0WfH1J+TTWcQfTws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Rkec8w9zqwA6cNYtkuFMnqDxji6USUr+czmgtht5YDWOXjlEHxkOr7wMwYeyUm/h2asv3ylbLVJHJs7bfn7jpK4ZSIclfKkIMVAJhyvfEfc/wSQME4Z/EqKPqgyScFxhcNqh9meF0pEjSmE4mkNhN5rc8eeEukcmKjSbjuwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLvkc+Ia; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLvkc+Ia"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36a35e4eefeso552808a91.1
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2026 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316642; x=1779921442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3DLl7Yg6VwAfpyI8SGBLVVQzN80urNsEnQ3t3qUrLo=;
        b=qLvkc+Ia09URLlD4sVABd6OkeNj9iAV8gCOq3d66pbL0v5G6I5asKdrvdVH25Zj75i
         kiRbg6fIziVs7Fjo5Ei7Ff9tIrx/4h6sS8GbcI003pkhFSKEswbyl8s/JYA3jhxbrmLt
         QVoIy3l0Pz94qlhJO1BeWsQzWy/pFkbWAj9IQiaf8rCl+Oq/m3rPNnOsH/e4Er2jV0zS
         O464nZSFLRwPGDYoH1MFl8KUHLYjiV8Dcdb5JI10mgMYVtGRJTEANF7XYzVhxQCq7EtB
         ZL3zlYU52FvcKzOkAKxEsbtZS3KJx/zbRmsb+aOoiDUK5VadbJdwCbEPKp26Y0JSlUJL
         /CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316642; x=1779921442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3DLl7Yg6VwAfpyI8SGBLVVQzN80urNsEnQ3t3qUrLo=;
        b=rWuv9Dm3T1SROLQP0IVCHs33e0Xz47keZIdB/djoXLeI+ZTA0ATzvWMzqNrPfgjwV+
         lGf/KBEhBqK4KTV6Dhd0MzUJ5qs/KermbydkPKdU4ESbPD8vVS65NCp9bOQbxUN1pmDR
         MqO7XDZhMMWZJ0FEElLT/uIuY1AW1Nx6Kg5Mzrz72cSMGX9wedzMyOoDsjeQUYQrnOzS
         e54yM/1mxOS3VhL6rI+NJQrluxrlM7UFDMVxrCH5jLyaREp2g0LNi9VENYu2RkO7U+W9
         0ugbwzlP5/ZEAt7fs6aqI9zXVzJy9RLqxnQ4aL11g3oLStQZCou4PVe2yQLc3wmZMmLi
         I9uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W9c1Gn/rKTNnNK3VCwryA6HKKLkTpdKDDQGDFn5iOMyS5kvjqRmfhZNXBF5oU4zkpvibPfHzhzTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OGCerf6DWVU8kzHNctYioZge9Cah5W27ei0Jf3FkClFYXxAv
	vsY52Kq75xXVp8atUYCA0q3x8Cu0+itXXVjbzSAlz0MTlpXeB6o9hxlD+rOlUA==
X-Gm-Gg: Acq92OGC63VlGAHzTfcQgSVerIdcX7bLET8I9CLmYe+4v4PW+6fHMlgds3EvFQ53bd4
	vaVT0P/nl+M22YlghHQWWoOO7gBTJNnh3fhAu7qbjNYKgkRw7AZ3ezesfIbqbqEkgvaypscOf/m
	yyttvLPFLOrD2wd3kg7LtomBA3OPatm46WGF7J6wUSu/MZ9YnnbvCFWGjVdT4XPvaGrLyluXeCw
	4RN3UUdESD4cLS28OncyUhoOE6adXKrW3zdHfUCIZKSEnzHsCcjLE9P9fbRyW752QeJB6Moqjqr
	NOJ4W7KKp9At2cOm1kwfjZf1GbCN5LTCUt1cYAjxkjvWa8Lze05j2vzm8/0VPN6MJO63oFaWnQ6
	AcZwlcZdReg66Th5oe5KiGju0rbVtGlFBRuu9gnWQDfgxSVEiCuYFlQlwyQHlw0lNXSQ3nKXOi/
	1f7TyhONNEUM0emHd2DiuEyO4YVK7h4BtnwXyVoJquuZGFJn3s4Cq08k6JRAdLkQGDxq8wzPztK
	BVCYgL6KDJ8Vl02UE/tsbomwpCcgg/nIgKL+mDQDvmD1Q==
X-Received: by 2002:a17:90a:d64f:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-36a4560485cmr457936a91.16.1779316642448;
        Wed, 20 May 2026 15:37:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc4b345sm638986a91.7.2026.05.20.15.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:37:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: bestcomm: Enable compile testing
Date: Wed, 20 May 2026 15:37:04 -0700
Message-ID: <20260520223704.39320-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the BestComm DMA engine to be selected for PowerPC
compile-test builds.

Make PATA_MPC52xx depend on PPC_BESTCOMM directly so selecting
PPC_BESTCOMM_ATA does not bypass the helper dependency.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/Kconfig          | 2 +-
 drivers/dma/bestcomm/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 28ca856ecc75..6e25e9fcadb2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -823,7 +823,7 @@ config PATA_MARVELL
 
 config PATA_MPC52xx
 	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
+	depends on PPC_BESTCOMM
 	select PPC_BESTCOMM_ATA
 	help
 	  This option enables support for integrated IDE controller
diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
index 5dd437295964..153b5492c93c 100644
--- a/drivers/dma/bestcomm/Kconfig
+++ b/drivers/dma/bestcomm/Kconfig
@@ -5,7 +5,7 @@
 
 config PPC_BESTCOMM
 	tristate "Bestcomm DMA engine support"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
 	default n
 	select PPC_LIB_RHEAP
 	help
@@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
 	depends on PPC_BESTCOMM
 	help
 	  This option enables the support for the GenBD tasks.
-
-- 
2.54.0

