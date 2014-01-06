From: <gregkh@linuxfoundation.org>
Subject: Patch "ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN" has been added to the 3.12-stable tree
Date: Mon, 06 Jan 2014 10:56:21 -0800
Message-ID: <13890345811491@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: marex@denx.de, eric.nelson@boundarydevices.com, gregkh@linuxfoundation.org, linux-ide@vger.kernel.org, r65037@freescale.com, shawn.guo@linaro.org, tj@kernel.org
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN

to the 3.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     ahci-imx-explicitly-clear-imx6q_gpr13_sata_mpll_clk_en.patch
and it can be found in the queue-3.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 10becdb402af4fd4808a0491a726b96128c41076 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Mon, 25 Nov 2013 09:47:00 +0100
Subject: ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN

From: Marek Vasut <marex@denx.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci_imx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -60,7 +60,7 @@ static int imx6q_sata_init(struct device
 	/*
 	 * set PHY Paremeters, two steps to configure the GPR13,
 	 * one write for rest of parameters, mask of first write
-	 * is 0x07fffffd, and the other one write for setting
+	 * is 0x07ffffff, and the other one write for setting
 	 * the mpll_clk_en.
 	 */
 	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
@@ -71,6 +71,7 @@ static int imx6q_sata_init(struct device
 			| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
 			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
 			| IMX6Q_GPR13_SATA_TX_LVL_MASK
+			| IMX6Q_GPR13_SATA_MPLL_CLK_EN
 			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
 			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
 			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M


Patches currently in stable-queue which might be from marex@denx.de are

queue-3.12/ahci-imx-explicitly-clear-imx6q_gpr13_sata_mpll_clk_en.patch
