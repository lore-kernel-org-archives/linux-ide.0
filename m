From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 005/102] ata: sata_gemini: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:09 +0200
Message-ID: <20170719152646.25903-6-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/ata/sata_gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 8c704523bae7d..7ae713a33e11a 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -274,14 +274,14 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
 		return ret;
 	}
 
-	sg->sata0_reset = devm_reset_control_get(dev, "sata0");
+	sg->sata0_reset = devm_reset_control_get_exclusive(dev, "sata0");
 	if (IS_ERR(sg->sata0_reset)) {
 		dev_err(dev, "no SATA0 reset controller\n");
 		clk_disable_unprepare(sg->sata1_pclk);
 		clk_disable_unprepare(sg->sata0_pclk);
 		return PTR_ERR(sg->sata0_reset);
 	}
-	sg->sata1_reset = devm_reset_control_get(dev, "sata1");
+	sg->sata1_reset = devm_reset_control_get_exclusive(dev, "sata1");
 	if (IS_ERR(sg->sata1_reset)) {
 		dev_err(dev, "no SATA1 reset controller\n");
 		clk_disable_unprepare(sg->sata1_pclk);
-- 
2.11.0
