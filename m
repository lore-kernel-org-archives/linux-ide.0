Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD73431E66
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950639; cv=none; b=o1npXJ1uVP/PVsvHB80RB+eMbDllKInYZahbPTWKyX8P5G4ptODRHw/1wWdJLemIGQl4OzoxoyG5yaFhQ/p4Kx/X9jyEeN0ga9OCCrn1bmT27x6G1YdYZJm3en0Kb+aFzHycVa+hfrqx2GxfUNaXd1xUcKEDV+73G09HKDS3RiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950639; c=relaxed/simple;
	bh=vKcW73rj/HAWS+mdL9p+53eUeyncJbNJWXi2tbB1mKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjMpi+JSMuTZcHZGBEAEoz3lah44T2Hca46khz6xNQt1y1awb4bwwudb9QPbDbAA48uxojqj7pY66ICWhnQsq17gauYxijgVrTsIHCSFZiGqa1+a53tu4JCyOSDVMCk1FJSyLTsXz39qbm9R0YUIapxg9viUH0vU3T6DIHNzQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0h8EIHi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0h8EIHi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c7cfa17fedso11737795ad.3
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950637; x=1783555437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhUALtqBmM0O5xc81uU+e8IeAZx94R3OQxF/O7No750=;
        b=I0h8EIHiusSBnnTpAsCQJw+TMjUcjBGG5ct2BbA3zcUgj39ABxlwoZRnW4qnnsyZyu
         sd21DVmlHouA1GCW1lB/bc3MTPWelfivvecL8ZCMNLJ/RejSo+9XBwHX23qGzivj0YQs
         G072ppIzNFBAk8l7EF47TbdX+yr8/GlAN190DVFd5TT1JJVjHOawX5Sg7pdJm05aGA8M
         A5ePm8al9jCJKlmFFCvkFeDEotkzvzzCbLfomaP+t3SdgKaHFfX31jbQPrA6hTKYV/Zj
         MGHyC82+Xxw6grsmpTYz5hNtYyIGQKx+tJESianZ2fLHZLQpMweK1oImXR7UcnHbJxtN
         D9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950637; x=1783555437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhUALtqBmM0O5xc81uU+e8IeAZx94R3OQxF/O7No750=;
        b=HUkRVeOQpwPoNk3c9JzctfsZ9BfhM5OFxSlsZUDGYNJH2rw+JbmADvmCGvyqRtiRHS
         QEt0ua6bf/idXyIlWhRW+inLaJuV4ylhpSIYJ028sdyf7uE2LCmaEvhw0B2pu74QdY2a
         zBn7I4m0ZtMLaj/rOZ5rCF0TDnVi8E4LTF0W/D6HqJheEihZcrNc/oHaxPhV9Y9AKX7F
         JmXSEq/9KBP7yLyRBiK4bqoTQELNNWEdODTdQRG3AKTkR+WmR2veTpBG+4pSGcDVJfy9
         2Wg6UBfyR4WfML4OH0XajmULwyOf1QOdCaoh4X0BhiX94EFmQm9hx0K2vPJJ4idVZBkO
         ZQZA==
X-Gm-Message-State: AOJu0Yzw1heLULC2EXCa3vAwTeuzWoMSi1CosocrLbtil0zMiyt9FVs3
	fusv/8Bluc4VZ4xrSXfDBW4+Xgqmnbn5qYwOUUaT0FPSCO0fz3qtv0fBdbDnGQ==
X-Gm-Gg: AfdE7cks8JaoZv57bSvFlojfk7zUyJnPT6UCNpwRP/mgtXL7Ff32uQGwnoBPSmStnlY
	gOWsf0gRsABdEyiserSn5R+dxkx5ue167iTGgmVVtwGX0yEzxheWWIPa8y9JGMCCQzBN+sGoQWm
	7/zsy+b13f6q3/HWJ07nKeAWd+05AKsGaNrpHaF2Lf9zrsUPSUVMLqLhUtr/1c90gkfob7fEAyI
	M511V8adfHnZtDM/UI4BtPcimRXBgZs3TvPc55NqWOJFQFw0FivGNfoQvxVVcuireP7OMVDSLeM
	mIQyTvygjpiSSxiPTvZwGxmRVdmkInOt3sU2zxU8XSZ87lMT07zD+bQK7e5Dd4Tpb2wWaWbceWm
	vN1BbhbNZKpvi1eg2LhVBvNiBJiMyzMqzEiyCVlXs6TODh3igTmHNpEzsp5httiGVoUcEv4Km52
	G/5bkwWokaEy6JG+V1cwoX7fBGkFjYCFSopcnxOCGbmSYbbVpQ8v6NuPlfcPU494HLw6qLl1UPv
	q13CvOYWw==
X-Received: by 2002:a17:902:cccf:b0:2ca:329:3da0 with SMTP id d9443c01a7336-2ca7e682ae3mr39492905ad.3.1782950637371;
        Wed, 01 Jul 2026 17:03:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 4/8] ata: sata_dwc_460ex: drop redundant struct copy of port_info
Date: Wed,  1 Jul 2026 17:03:46 -0700
Message-ID: <20260702000350.68331-5-rosenp@gmail.com>
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

sata_dwc_port_info[0] was copied to a local auto variable before being
referenced via a pointer array.  The local copy is never modified, so
drop it and point ppi directly at the static data.  This saves ~104
bytes of stack and makes the const qualification consistent.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 43011789c75e..2a28e6655bba 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1130,8 +1130,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	int err = 0;
 	int irq;
 	struct ata_host *host;
-	struct ata_port_info pi = sata_dwc_port_info[0];
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	const struct ata_port_info *pi = &sata_dwc_port_info[0];
+	const struct ata_port_info *ppi[] = { pi, NULL };
 	struct resource *res;
 
 	/* Allocate DWC SATA device */
-- 
2.55.0

