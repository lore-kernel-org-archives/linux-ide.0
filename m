From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 1/6] ARM: EXYNOS5: Clock settings for SATA and SATA PHY
Date: Tue,  9 Oct 2012 17:18:47 +0530
Message-ID: <1349783332-18467-2-git-send-email-vasanthananthan@gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63167 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2JILqT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2012 07:46:19 -0400
In-Reply-To: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>

This patch adds neccessary clock entries for SATA, SATA PHY and
I2C_SATAPHY

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 774533c..4ab964e 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -599,15 +599,20 @@ static struct clk exynos5_init_clocks_off[] = {
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "sata",
-		.devname	= "ahci",
+		.devname	= "sata_exynos",
+		.parent         = &exynos5_clk_aclk_200.clk,
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "sata_phy",
+		.devname	= "sata_phy_exynos",
+		.parent         = &exynos5_clk_aclk_200.clk,
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 24),
 	}, {
-		.name		= "sata_phy_i2c",
+		.name		= "i2c",
+		.devname	= "sata-phy-i2c",
+		.parent         = &exynos5_clk_aclk_200.clk,
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 25),
 	}, {
@@ -1157,6 +1162,16 @@ static struct clksrc_clk exynos5_clksrcs[] = {
 		.reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24, .size = 3 },
 	}, {
 		.clk	= {
+			.name		= "sclk_sata",
+			.devname	= "sata_exynos",
+			.enable		= exynos5_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &exynos5_clkset_aclk,
+		.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 24, .size = 1 },
+		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift = 20, .size = 4 },
+	}, {
+		.clk	= {
 			.name		= "sclk_gscl_wrap",
 			.devname	= "s5p-mipi-csis.0",
 			.enable		= exynos5_clksrc_mask_gscl_ctrl,
-- 
1.7.5.4

