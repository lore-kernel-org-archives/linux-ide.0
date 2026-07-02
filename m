Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4374BE1
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950641; cv=none; b=ZJGqvmRQEVejbUgz++VbkiqIgdWi8bGax/IwYN6wtxMz3aLYbvKwbs/5cDIy9qSw8CUGJ8uN74leLUu1+z/vo5Day3LUUgSPsULkWGzP/0NBBaemAJFXAJPn7cOAnuRQjXCPbvacwrlT3N51AQFQUojc99Uua45/cvFeDdmTIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950641; c=relaxed/simple;
	bh=6QVXXXR7VnPCsBDa7jJHLkNn1qJRao3ES0tOJn0qU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5eUW2bVZOTSCH3cKEzNZ04MbLaAkLfLVlfqwfqNJnN/4m/JDmjYigbykTm7t6Yi5fQwoXh1d9eu6Z/Ep7nmCt9yP5r+eRcW0bUPsQAyPqr6MG6mR2ILAkyU9HM17Py555kQ4fDjq+Ih3gp/hn0aXTxYuYpiFIcc2j7b5y/ajdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPmt+A8M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPmt+A8M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9c9913ddaso221965ad.0
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950640; x=1783555440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLK7HgVTdbwsA8lqGnfEDgi+C7LFUJghOvU2vBmzBac=;
        b=rPmt+A8MPj0Y3IfA4M/gST0E7W0D1Kb+Nt06kF1JpeFf+iwgJlWRgEmqsCdFNjJvn4
         nx2SODAUS4Ljfw1kVK0MjTjL1jmVu43IRRgiqAxDwyFgQwh/QtKGwD/ahDXP9j+z/qOr
         KEoT/U9L3Cll4Bo0M4dgL2O+sPuxXXeVOAXf3MCXBnIDdX245CPfGGxN/8bawcRhHpw3
         n0RunW5RUV9p0u/akXi/ePWLVLIPHyHKMnVJ4gFpVW4fMAPF5Xr52jUuP2fZIDw4W3wl
         VOvet1A0Y5dqTMQxWkpgxIrBS9uTtJNRtsrmmoScm+vT5PPW1r+fLb3ao4F6J7L3Lr/4
         lxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950640; x=1783555440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLK7HgVTdbwsA8lqGnfEDgi+C7LFUJghOvU2vBmzBac=;
        b=QgLD4u9j17i0tnrz0lL3TCZUbWj1SVlRksH8Fdpm1BW3c1i61CR1ZCVry5aqiXSGqo
         DKlaBsfjKmpquRx+DliGLxS8GS0EMOvbJssAiNdA9g2aokCvdr/YCjZlfHW9GPBKZgIr
         22+XG+vGIoAF6p4dSVu6UIGiRDTl30ggxfjqPq3DpmxB1M1Q2qV00+3JIl/24K7GpaoK
         gnSXYly69ERxQjnuUbwsWqKLQ0DOB1cRKAEYlRQLsbcdBroy7Mi/2ARrvQUL/5/ao3+v
         uo4IB96GljVaWUQ6cgNfQz8Af1n0p3MAJxBoTMuBYRTEo5QheSsF4FT+RI1X+gpE0jG1
         Qcyg==
X-Gm-Message-State: AOJu0YyF5O1Pbe+I5SD9Yk0hg+PHdpVJmc9JKINKVhD8qFvRKanDXieM
	S0b8GTWL0mZmORiWP7cTxNjSKXlQcWPOZ8WcBfpZougSiCMHp8F62Jz/jwuPZg==
X-Gm-Gg: AfdE7cl7VXHNxHZPJgKdMHrRQKxwn9TPDx5rb8qZNwh/OAP1FW+1udvy75wqUKMMHjH
	HbYL2y4gyuAk8s+iwjJE5z5g0dGUAlHPGFC+RutGy6KURDrbEd6KdyIDOFNovC7NXFrUDCU8v3q
	/Pu3B4VlBiVY5QgSVjMGGpK3GOyWtU8Pj1MZgG2tprI4L//LR0A5WWlob8Wgy4metfwmjLja2YT
	iI75YKbseuP7wEA6ZpoQzReIsaWvs74s5Eb2w4BNqadqhnesJQdLXxhyaFHD+1h9sBGU7uPyTk+
	GbiVErSeNpflTtmQomB/kq+K4kzUy4+LlpLe+4f16olvc3y4rnNyANOWUhcXqiCtBUA5wycWpfn
	hUPadmuLafldA0jB+t2UxsNbg6pXzIT9Iwh6Xl6T1pxWWqgtu7+Bce0/sjA6mSF2zqoEDnm0p94
	gyVkdUilu6dOBIM4fXRDcAfk2mEcQwtJSUE0nGkWC06Ll78cSNFlfuxM/DTfwnrY9XiYXv0u0x/
	fVaFmdnmg==
X-Received: by 2002:a17:903:178e:b0:2c9:ed2e:b8c1 with SMTP id d9443c01a7336-2ca7e754b1amr31988215ad.12.1782950639651;
        Wed, 01 Jul 2026 17:03:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 6/8] ata: sata_dwc_460ex: disable SATA interrupts on device removal
Date: Wed,  1 Jul 2026 17:03:48 -0700
Message-ID: <20260702000350.68331-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702000350.68331-1-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sata_dwc_remove() fails to mask the controller's INTMR and ERRMR
registers before tearing down the host.  If the hardware asserts an
interrupt during teardown (after ata_host_detach() but before the
IRQ handler is unregistered by devres), this can trigger an unhandled
interrupt storm and potentially lock up the system.

Add sata_dwc_disable_interrupts() and call it at the beginning of
sata_dwc_remove(), before ata_host_detach().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4c54c3ecd18e..f26220cac130 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -759,6 +759,12 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static void sata_dwc_disable_interrupts(struct sata_dwc_device *hsdev)
+{
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intmr, 0);
+	sata_dwc_writel(&hsdev->sata_dwc_regs->errmr, 0);
+}
+
 static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 {
 	/* Enable selective interrupts by setting the interrupt maskregister*/
@@ -1210,6 +1216,8 @@ static void sata_dwc_remove(struct platform_device *ofdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_dwc_device *hsdev = host->private_data;
 
+	sata_dwc_disable_interrupts(hsdev);
+
 	ata_host_detach(host);
 
 	phy_exit(hsdev->phy);
-- 
2.55.0

