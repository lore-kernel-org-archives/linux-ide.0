From: Marek Vasut <marex@denx.de>
Subject: [RESEND PATCH 1/6] ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Wed, 20 Nov 2013 11:27:22 +0100
Message-ID: <1384943242-8201-1-git-send-email-marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36324 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3KTK1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 05:27:30 -0500
In-Reply-To: <1384942659-5362-1-git-send-email-marex@denx.de>
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
 drivers/ata/ahci_imx.c | 1 +
 1 file changed, 1 insertion(+)

RESEND: Fix the Cc here.

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index ae2d73f..478921b 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
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

