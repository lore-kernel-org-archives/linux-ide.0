From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/6] ARM: i.MX5: Add PATA and SRTC clocks
Date: Thu,  4 Apr 2013 11:25:08 +0200
Message-ID: <1365067509-10186-6-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284Ab3DDJZn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 05:25:43 -0400
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

This adds the clock gates and the binding documentation
for PATA and SRTC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx5-clock.txt | 2 ++
 arch/arm/mach-imx/clk-imx51-imx53.c                    | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index 2a0c904..da5eb30 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -172,6 +172,8 @@ clocks and IDs.
 	can1_serial_gate	157
 	can1_ipg_gate		158
 	owire_gate		159
+	srtc_gate		160
+	pata_gate		161
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 0f39f8c..026a819 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -83,7 +83,7 @@ enum imx5_clks {
 	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
 	epit1_ipg_gate, epit1_hf_gate, epit2_ipg_gate, epit2_hf_gate,
 	can_sel, can1_serial_gate, can1_ipg_gate,
-	owire_gate,
+	owire_gate, srtc_gate, pata_gate,
 	clk_max
 };
 
@@ -235,6 +235,8 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[epit2_ipg_gate] = imx_clk_gate2("epit2_ipg_gate", "ipg", MXC_CCM_CCGR2, 6);
 	clk[epit2_hf_gate] = imx_clk_gate2("epit2_hf_gate", "per_root", MXC_CCM_CCGR2, 8);
 	clk[owire_gate] = imx_clk_gate2("owire_gate", "per_root", MXC_CCM_CCGR2, 22);
+	clk[srtc_gate] = imx_clk_gate2("srtc_gate", "per_root", MXC_CCM_CCGR4, 28);
+	clk[pata_gate] = imx_clk_gate2("pata_gate", "ipg", MXC_CCM_CCGR4, 0);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
-- 
1.8.2.rc2

