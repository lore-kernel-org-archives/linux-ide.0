Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2252770B;
	Wed, 11 Dec 2024 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879535; cv=none; b=KP7dB3977RH0m5JOrYlycQt6TyDlNHqPPW2bYapOVCb834jXxiZErm/I/3lD2RDJLe4N5qxDPsFDfzR1fNdaHdjRualS6UhlJ1n8cqO82y5L/OZeyEN+FF6RHUxzhYK0TeEIZZwwKA4FMdRWFTpnGB6uyxEDzCdlTxMZJkRLG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879535; c=relaxed/simple;
	bh=cnnP4hCKIWi7SwF3nDS+Egk4DRR+dl0e4kvTBUDu3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tv4EvJYtFUIlKIwebn5jo3roxBDirrW3VQunev+19N+N4WqlU4d3OCnFc532jVXxt72iO4o5B66hSGX8t85NIDukeByas+wHeCSMBtIkLSkFBmtMtbpFnKSvsUMLERRrf2GGoeqm7/nKMHCEuEf5o/xyG7oE1jAXq3Rr/z/T2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=db/Y1zdM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="db/Y1zdM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=JA6yJI3hAs3QVLpLQ9RJ1pSSqXOxxGKSknL8PWgYp8I=; b=db/Y1zdMYe7eiJqK
	Pzbm9ZoUmRIWEarB1xob+V3oQ3Sz73JdBupybMRb0KwIB+Ou+Yp3SCqWedi1u9lzvS70Fy/CJFHWj
	9L6Xs79M1PBdtJQepbmJ1q4mXv4LNFw/CUC5OXbsUQbij3IZ9Ss7tokqw+wtT3aq/+XCLn50BeMB/
	zqZVeudcDBNnjWKj98cP7ub0BqILGOB9WeUwypHDgQeQwU/qSUPKlH/r0vNV2p+D6AEpx8k/pqCfr
	tj8qVcA5pktD83Wmg/2Af6xL6dU5lg6h9OgHgbumo4gwaOHwMy9pfLr1t/M4qin5YXWhxkGhr9sbk
	3t/jHDn6KxCg2feflA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tLBGk-004eQy-2h;
	Wed, 11 Dec 2024 01:12:02 +0000
From: linux@treblig.org
To: linus.walleij@linaro.org,
	dlemoal@kernel.org,
	cassel@kernel.org
Cc: p.zabel@pengutronix.de,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ata: sata_gemini: Remove unused gemini_sata_reset_bridge()
Date: Wed, 11 Dec 2024 01:12:01 +0000
Message-ID: <20241211011201.261935-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

gemini_sata_reset_bridge() was added in 2017 by the initial
commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/ata/sata_gemini.c | 12 ------------
 drivers/ata/sata_gemini.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index d040799bf9cb..821ca31effe7 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -224,18 +224,6 @@ void gemini_sata_stop_bridge(struct sata_gemini *sg, unsigned int bridge)
 }
 EXPORT_SYMBOL(gemini_sata_stop_bridge);
 
-int gemini_sata_reset_bridge(struct sata_gemini *sg,
-			     unsigned int bridge)
-{
-	if (bridge == 0)
-		reset_control_reset(sg->sata0_reset);
-	else
-		reset_control_reset(sg->sata1_reset);
-	msleep(10);
-	return gemini_sata_setup_bridge(sg, bridge);
-}
-EXPORT_SYMBOL(gemini_sata_reset_bridge);
-
 static int gemini_sata_bridge_init(struct sata_gemini *sg)
 {
 	struct device *dev = sg->dev;
diff --git a/drivers/ata/sata_gemini.h b/drivers/ata/sata_gemini.h
index 6f6e691d6007..b6e4a5c86e01 100644
--- a/drivers/ata/sata_gemini.h
+++ b/drivers/ata/sata_gemini.h
@@ -17,6 +17,5 @@ bool gemini_sata_bridge_enabled(struct sata_gemini *sg, bool is_ata1);
 enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg);
 int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge);
 void gemini_sata_stop_bridge(struct sata_gemini *sg, unsigned int bridge);
-int gemini_sata_reset_bridge(struct sata_gemini *sg, unsigned int bridge);
 
 #endif
-- 
2.47.1

