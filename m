Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB888C2FF
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950635; cv=none; b=WtSSMqNt4WA8RK8u3qB2Skba+W6KsUY785kFgHS0tKtPEmbj5VY1wcLdUvlkhOgW19aCoHyMfDyKDVAKGWAQBpLdeSI/BVRRYtYpcRY4Ef7Buaw4WOO1lxd7QwBOiyzWNyNBEvNvKHzbUC6yVmfd9W6B2QwponqmYM+NM4KZBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950635; c=relaxed/simple;
	bh=u40/8x5LNWJbKDPMvdoWzefuDibpTjH1qLJJC8ciCKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBXIHNsyOrPWzFViv8FRBaUbiUXT7tJ4QM7xDmu45nGZIk7jne/ZnqJVy3KKQUyFxBT7NuulYwl7hTr1bpM6GErz9zJtMRxSKeG2q8FO+MBG7TVRTVgAprgbCPN/+fLYuG8H5W6VRfpSDotuL10IxoN3BGNXWsh0T2rjvl4BCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJQIe7Kf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJQIe7Kf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ca06ad2d11so10879895ad.0
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950634; x=1783555434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTb+qhpxD6q9CZ2PQIbqetvVoOu8RBCT2g3dDL734iM=;
        b=oJQIe7KfZ60Ne6fPLTaTAYrvWUz6QpFV43qhGzovbBMvIRmHCJ7vM0w8Q8gSSe4k80
         P9a+pVv214gxPdQnslfMBatuJvmkVaAoH+cq+tb9XjMBwZzUMsIZCG06uJXUNQvE+IgG
         YdtwKQkp6gN9M6462XTe/Hze9sNNZsKdbWq5U/aHPFXd+cvw0JBiwby73SVudeGrsHQA
         3O2xxbxDAeMmdIzx+MNB6hsvLUA49TaUMUy9dOJtDZaasmSC+SYJKo4M+/i80ICiqBQT
         rQvPPEQgYQLPjihLmFIb9GQKPg1xgT0H7WZAoPJ9Dli6/+cNdxMOypc+Eg6Vrc53kXQ9
         iBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950634; x=1783555434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTb+qhpxD6q9CZ2PQIbqetvVoOu8RBCT2g3dDL734iM=;
        b=lhBtjtdcZ1wizno5BXjGiMYZGJJGhdY/F0q25tGLzhwiIVTsqvvlWDtDtDaRRbLkMa
         rQ3qnEwSex81D4Y5ExVBMlPubgr7vWJnI7F8DRMxkJCQnKJRGirISWc80YhO6btp74Gg
         aU3W3qSmgl1rgONc6QyaJVksi04jgbMGOkBwL+x/1pmThBYaSf4osFBHw0ARXIRS+A8V
         FucEBdxMDXXFKtKGU8SPBxdhuQe6819dWV1fR38LtKkCrCnXZ6zE5ddL1xH7OYT/qnAG
         Y/J8GYyuZwsflaWpcKxHgeTsGhDv0yTvs94DUZPIHuQVpo0YaOUet7w3g/2vG+KQ4Il0
         t5Uw==
X-Gm-Message-State: AOJu0Yzjf4DEpDNtOOZFu8dy1JluQ8g+Xxl50utYgr1uy00toFR5YZny
	lQ+ELDN2NrayseuK4ePiV81cIn7m1ZUxATXzAMecgt0/hmeLq8YVLVzvBvY7aw==
X-Gm-Gg: AfdE7ck+Pb9phqOq/lUIamVnctZmOW6X+InHsepIVgQW7dtp5iOIqpED08DjBLgRCy1
	JNBITOSdESAMd7riM3oRy3lsmRWDvMpzt4z93unEcaZP/3xxcvp6EfP5tJcIZL6V7czi+6Th+9R
	m7Z2+39KfE2NdI1enrN8Vl8QkjlCrbONrueUEqKYIZWZCFHMM2aDYYKwqDiS0c19RmvtJQLdpo5
	PfHTLNOQh+IKeL92cxQsd6qWHehCwRAtEeEqiPlbJzvOU+joAqP4MxSdKXavqwOovXAx06gky4/
	iT1MSHMFR6ju6q1wnxF3FdiyOvNwrfDa5XKFkub5Embo107+tGWEQRxg8DHdNpME9U4T2cjuFoq
	Lsc5+ZHoLf/25YLoGmFatksOrhIDrLkGfmom5SYNtsSt4ht893SYZbbhPv8GDdwUeSClTxAQj14
	i6QBPEZQXJN9MYpMdG0Zba426nm92G4UKa8qYSuZWdaWByxkxliJkPzjUDQpHAePye7ZA7ws8tM
	Y4GS9DAjSsF2ziFxhwb
X-Received: by 2002:a17:902:f652:b0:2c9:da58:17dd with SMTP id d9443c01a7336-2ca7e8f389cmr36295485ad.34.1782950633774;
        Wed, 01 Jul 2026 17:03:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm5023255ad.69.2026.07.01.17.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:03:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/8] ata: sata_dwc_460ex: use device_property_present()
Date: Wed,  1 Jul 2026 17:03:43 -0700
Message-ID: <20260702000350.68331-2-rosenp@gmail.com>
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

There's no need to use np here when dev is enough. Follows the similar
pattern elsewhere where of APIs are replaced with device ones,
especially when using platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4fc22ce4bd9a..d4c554f0979d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
@@ -809,7 +810,7 @@ static int sata_dwc_dma_get_channel(struct sata_dwc_device_port *hsdevp)
 	struct device *dev = hsdev->dev;
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_property_present(dev->of_node, "dmas"))
+	if (!device_property_present(dev, "dmas"))
 		return sata_dwc_dma_get_channel_old(hsdevp);
 #endif
 
@@ -1180,7 +1181,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_property_present(np, "dmas")) {
+	if (!device_property_present(dev, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
 			return err;
-- 
2.55.0

