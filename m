From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] ata: sata_gemini: Retire custom pin control
Date: Tue,  8 Aug 2017 21:07:04 +0200
Message-ID: <20170808190704.11574-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:37527 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdHHTHL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2017 15:07:11 -0400
Received: by mail-lf0-f47.google.com with SMTP id m86so18826119lfi.4
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2017 12:07:10 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

I added a proper pin control driver for the Gemini SoC, so retire
this custom code and rely on the pin controller to set up the pads.

The "IOMUX" which is routing signals between the ATA and SATA
bridge inside of the chip is not about pin control and remains in
place.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/sata_gemini.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 8c704523bae7..4990dd496598 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -43,17 +43,6 @@ struct sata_gemini {
 	struct clk *sata1_pclk;
 };
 
-/* Global IDE PAD Skew Control Register */
-#define GEMINI_GLOBAL_IDE_SKEW_CTRL		0x18
-#define GEMINI_IDE1_HOST_STROBE_DELAY_SHIFT	28
-#define GEMINI_IDE1_DEVICE_STROBE_DELAY_SHIFT	24
-#define GEMINI_IDE1_OUTPUT_IO_SKEW_SHIFT	20
-#define GEMINI_IDE1_INPUT_IO_SKEW_SHIFT		16
-#define GEMINI_IDE0_HOST_STROBE_DELAY_SHIFT	12
-#define GEMINI_IDE0_DEVICE_STROBE_DELAY_SHIFT	8
-#define GEMINI_IDE0_OUTPUT_IO_SKEW_SHIFT	4
-#define GEMINI_IDE0_INPUT_IO_SKEW_SHIFT		0
-
 /* Miscellaneous Control Register */
 #define GEMINI_GLOBAL_MISC_CTRL		0x30
 /*
@@ -91,8 +80,6 @@ struct sata_gemini {
 #define GEMINI_IDE_IOMUX_MODE2			(2 << 24)
 #define GEMINI_IDE_IOMUX_MODE3			(3 << 24)
 #define GEMINI_IDE_IOMUX_SHIFT			(24)
-#define GEMINI_IDE_PADS_ENABLE			BIT(4)
-#define GEMINI_PFLASH_PADS_DISABLE		BIT(1)
 
 /*
  * Registers directly controlling the PATA<->SATA adapters
@@ -310,7 +297,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
-	u32 val;
 	int ret;
 
 	sg = devm_kzalloc(dev, sizeof(*sg), GFP_KERNEL);
@@ -362,16 +348,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	gmask = GEMINI_IDE_IOMUX_MASK;
 	gmode = (muxmode << GEMINI_IDE_IOMUX_SHIFT);
 
-	/*
-	 * If we mux out the IDE, parallel flash must be disabled.
-	 * SATA0 and SATA1 have dedicated pins and may coexist with
-	 * parallel flash.
-	 */
-	if (sg->ide_pins)
-		gmode |= GEMINI_IDE_PADS_ENABLE | GEMINI_PFLASH_PADS_DISABLE;
-	else
-		gmask |= GEMINI_IDE_PADS_ENABLE;
-
 	ret = regmap_update_bits(map, GEMINI_GLOBAL_MISC_CTRL, gmask, gmode);
 	if (ret) {
 		dev_err(dev, "unable to set up IDE muxing\n");
@@ -379,16 +355,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		goto out_unprep_clk;
 	}
 
-	/* FIXME: add more elaborate IDE skew control handling */
-	if (sg->ide_pins) {
-		ret = regmap_read(map, GEMINI_GLOBAL_IDE_SKEW_CTRL, &val);
-		if (ret) {
-			dev_err(dev, "cannot read IDE skew control register\n");
-			return ret;
-		}
-		dev_info(dev, "IDE skew control: %08x\n", val);
-	}
-
 	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");
 	platform_set_drvdata(pdev, sg);
 	sg_singleton = sg;
-- 
2.9.4

