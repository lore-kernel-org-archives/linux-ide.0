From: Marek Vasut <marex@denx.de>
Subject: [PATCH 3/5] ARM: imx: imx53: Add SATA PHY clock
Date: Sun, 17 Nov 2013 23:56:20 +0100
Message-ID: <1384728982-19834-3-git-send-email-marex@denx.de>
References: <1384728982-19834-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52797 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3KQW4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 17:56:38 -0500
In-Reply-To: <1384728982-19834-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Add SATA PHY clock which are derived from the USB PHY1 clock. Note that this
patch derives the SATA PHY clock from USB PHY1 clock gate so that the SATA
driver can ungate both the SATA PHY clock and USB PHY1 clock for the SATA to
work correctly.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 Documentation/devicetree/bindings/clock/imx5-clock.txt | 1 +
 arch/arm/mach-imx/clk-imx51-imx53.c                    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index 3716b36..8904731 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -199,6 +199,7 @@ clocks and IDs.
 	spdif_ipg_gate		185
 	ocram			186
 	sahara_ipg_gate		187
+	sata_phy		188
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 3d91172..06bfb4c 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -122,7 +122,7 @@ enum imx5_clks {
 	srtc_gate, pata_gate, sata_gate, spdif_xtal_sel, spdif0_sel,
 	spdif1_sel, spdif0_pred, spdif0_podf, spdif1_pred, spdif1_podf,
 	spdif0_com_s, spdif1_com_sel, spdif0_gate, spdif1_gate, spdif_ipg_gate,
-	ocram, sahara_ipg_gate, clk_max
+	ocram, sahara_ipg_gate, sata_phy, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -588,6 +588,7 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk[cko2] = imx_clk_gate2("cko2", "cko2_podf", MXC_CCM_CCOSR, 24);
 	clk[spdif_xtal_sel] = imx_clk_mux("spdif_xtal_sel", MXC_CCM_CSCMR1, 2, 2,
 				mx53_spdif_xtal_sel, ARRAY_SIZE(mx53_spdif_xtal_sel));
+	clk[sata_phy] = imx_clk_fixed_factor("sata_phy", "usb_phy1_gate", 1, 1);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
-- 
1.8.4.2

