From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] ata: sata_gemini: Introduce explicit IDE pin control
Date: Tue,  8 Aug 2017 21:07:14 +0200
Message-ID: <20170808190714.11623-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33696 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdHHTHT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2017 15:07:19 -0400
Received: by mail-lf0-f52.google.com with SMTP id d17so19000388lfe.0
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2017 12:07:19 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

The IDE pins are managed by the pin controller, if we want to
use these, we need to ask the pin controller to explicitly enable
them as by default, these pins are used for other business and
most users just rely on the SATA bridge.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/sata_gemini.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 4990dd496598..0f0fc82bc6c8 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 #include "sata_gemini.h"
 
 #define DRV_NAME "gemini_sata_bridge"
@@ -287,6 +288,29 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 	return 0;
 }
 
+static int gemini_setup_ide_pins(struct device *dev)
+{
+	struct pinctrl *p;
+	struct pinctrl_state *ide_state;
+	int ret;
+
+	p = devm_pinctrl_get(dev);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	ide_state = pinctrl_lookup_state(p, "ide");
+	if (IS_ERR(ide_state))
+		return PTR_ERR(ide_state);
+
+	ret = pinctrl_select_state(p, ide_state);
+	if (ret) {
+		dev_err(dev, "could not select IDE state\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int gemini_sata_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -355,6 +379,17 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		goto out_unprep_clk;
 	}
 
+	/*
+	 * Route out the IDE pins if desired.
+	 * This is done by looking up a special pin control state called
+	 * "ide" that will route out the IDE pins.
+	 */
+	if (sg->ide_pins) {
+		ret = gemini_setup_ide_pins(dev);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");
 	platform_set_drvdata(pdev, sg);
 	sg_singleton = sg;
-- 
2.9.4

