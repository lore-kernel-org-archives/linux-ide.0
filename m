Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F517838C;
	Wed, 11 Dec 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733961177; cv=none; b=nV36JTX32OzmOxSsGV4IHYPcVtI9q24syHpg89sbjWEfJfUDUP43e1rUMQvwVIH1KisedAR0sB2UmQaYZSFLTEh4zIipDmVNShHUg7vYz2N3A0kbl8hA8m1oPmq8Kst0wiy2MhrjcO5QzebNS8N7NkMdZpaZ6UYaz1f1TDT5XdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733961177; c=relaxed/simple;
	bh=0yPjHf75CG5zl6NpzWY82XFujlgLSfDkSbAxBdG7O+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnq7KNLxjUQfXGAFVxEJf/qUCwxgN2wFpRQbb9Byxip+HVh/oV7U8VUiRPkoU4Gw0nrFVNzlqh7/b+vaDmh/FsdwE9n/FJfxwYjtngZeD3iPQ8IBdk+OwcG51Waottj2JiPqyNK/wj1kE3rDLzPvK6endFmf/bO+KtbguR9s4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PvU0U8y4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PvU0U8y4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=2MaGbw3QJR7d3eGdOVkIgDzRI4xX9G/8qOQoMDK2+8o=; b=PvU0U8y4vQ5lG9CR
	bNqZUtJrJbPoCFE5b5hJcQ9HKA7SJkyWzq+EwH2fKaPGtcBlRNh2tAnVSUchzI7bcYvpE8bEStD2Z
	DnfcwIOS8jLmoN94UGh5Jaq2eHnqfxRTPwyXWw07WGqb9mOn+b+ZkaGGhI2dGNU8DGLWfRtZQj3jU
	9rJ8LfaYKu1F+nCAUy0/bAqbfacI3MzTI0Z5f+JK2iqYsKh9qYArlmRLErMPmSaF8O1TsxJmikZTd
	nIg3U2Ur18/txj/OWEWjyDJE8vZueiTt6rlYW3aQlCFRLrCRwSLoREQ8KWi1Mgy7Y3sF34YTBHgDd
	W2Ksc0JXvNOXCWC2/g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tLWVf-004tSB-0S;
	Wed, 11 Dec 2024 23:52:51 +0000
From: linux@treblig.org
To: linus.walleij@linaro.org,
	dlemoal@kernel.org,
	cassel@kernel.org
Cc: p.zabel@pengutronix.de,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ata: sata_gemini: Remove remaining reset glue
Date: Wed, 11 Dec 2024 23:52:50 +0000
Message-ID: <20241211235250.136985-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Now that gemini_sata_reset_bridge() is gone, we can remove
the sata0/1_reset members and the code that creates them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---

Note: Applies after my
  ata: sata_gemini: Remove unused gemini_sata_reset_bridge()

 drivers/ata/sata_gemini.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 821ca31effe7..530ee26b3012 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -11,7 +11,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
-#include <linux/reset.h>
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -27,8 +26,6 @@
  * @muxmode: the current muxing mode
  * @ide_pins: if the device is using the plain IDE interface pins
  * @sata_bridge: if the device enables the SATA bridge
- * @sata0_reset: SATA0 reset handler
- * @sata1_reset: SATA1 reset handler
  * @sata0_pclk: SATA0 PCLK handler
  * @sata1_pclk: SATA1 PCLK handler
  */
@@ -38,8 +35,6 @@ struct sata_gemini {
 	enum gemini_muxmode muxmode;
 	bool ide_pins;
 	bool sata_bridge;
-	struct reset_control *sata0_reset;
-	struct reset_control *sata1_reset;
 	struct clk *sata0_pclk;
 	struct clk *sata1_pclk;
 };
@@ -253,21 +248,6 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 		return ret;
 	}
 
-	sg->sata0_reset = devm_reset_control_get_exclusive(dev, "sata0");
-	if (IS_ERR(sg->sata0_reset)) {
-		dev_err(dev, "no SATA0 reset controller\n");
-		clk_disable_unprepare(sg->sata1_pclk);
-		clk_disable_unprepare(sg->sata0_pclk);
-		return PTR_ERR(sg->sata0_reset);
-	}
-	sg->sata1_reset = devm_reset_control_get_exclusive(dev, "sata1");
-	if (IS_ERR(sg->sata1_reset)) {
-		dev_err(dev, "no SATA1 reset controller\n");
-		clk_disable_unprepare(sg->sata1_pclk);
-		clk_disable_unprepare(sg->sata0_pclk);
-		return PTR_ERR(sg->sata1_reset);
-	}
-
 	sata_id = readl(sg->base + GEMINI_SATA_ID);
 	sata_phy_id = readl(sg->base + GEMINI_SATA_PHY_ID);
 	sg->sata_bridge = true;
-- 
2.47.1

