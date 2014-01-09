From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.11.y.z extended stable] Patch "ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN" has been added to staging queue
Date: Thu,  9 Jan 2014 12:02:39 +0000
Message-ID: <1389268959-28626-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54170 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaAIMCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 07:02:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Eric Nelson <eric.nelson@boundarydevices.com>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Linux-IDE <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 6ffbfee687a83797895987a1a45443e998e77eb5 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Mon, 25 Nov 2013 09:47:00 +0100
Subject: ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN

commit 10becdb402af4fd4808a0491a726b96128c41076 upstream.

We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
Linux will fail to find the attached drive on some boards.

This entire fix was:
Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/ata/ahci_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 58debb0..566cca4 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -60,7 +60,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 	/*
 	 * set PHY Paremeters, two steps to configure the GPR13,
 	 * one write for rest of parameters, mask of first write
-	 * is 0x07fffffd, and the other one write for setting
+	 * is 0x07ffffff, and the other one write for setting
 	 * the mpll_clk_en.
 	 */
 	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
@@ -71,6 +71,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 			| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
 			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
 			| IMX6Q_GPR13_SATA_TX_LVL_MASK
+			| IMX6Q_GPR13_SATA_MPLL_CLK_EN
 			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
 			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
 			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
--
1.8.3.2

