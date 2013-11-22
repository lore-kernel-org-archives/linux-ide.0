From: Marek Vasut <marex@denx.de>
Subject: [PATCH V2 1/6] ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Fri, 22 Nov 2013 12:04:59 +0100
Message-ID: <1385118304-27435-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56305 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3KVLFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 06:05:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
Linux will fail to find the attached drive on some boards.

This entire fix was:
Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 drivers/ata/ahci_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

V2: Update the value in the comment from 0x7ffffffd to 0x7ffffffe

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index ae2d73f..14227d1 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -113,7 +113,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 	/*
 	 * set PHY Paremeters, two steps to configure the GPR13,
 	 * one write for rest of parameters, mask of first write
-	 * is 0x07fffffd, and the other one write for setting
+	 * is 0x07fffffe, and the other one write for setting
 	 * the mpll_clk_en.
 	 */
 	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
@@ -125,6 +125,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
 			| IMX6Q_GPR13_SATA_TX_LVL_MASK
 			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
+			| IMX6Q_GPR13_SATA_MPLL_CLK_EN
 			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
 			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
 			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
-- 
1.8.4.2

