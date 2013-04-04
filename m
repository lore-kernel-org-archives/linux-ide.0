From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/6] ARM: i.MX51: Add PATA support
Date: Thu,  4 Apr 2013 11:25:09 +0200
Message-ID: <1365067509-10186-7-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38441 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab3DDJZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 05:25:27 -0400
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

This adds the PATA device and the pinctrl group for to the i.MX51 dts.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fcf035b..cc54f0d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -411,6 +411,42 @@
 					};
 				};
 
+				pata {
+					pinctrl_pata_1: patagrp-1 {
+						fsl,pins = <
+							MX51_PAD_NANDF_WE_B__PATA_DIOW		0x2004
+							MX51_PAD_NANDF_RE_B__PATA_DIOR		0x2004
+							MX51_PAD_NANDF_ALE__PATA_BUFFER_EN	0x2004
+							MX51_PAD_NANDF_CLE__PATA_RESET_B	0x2004
+							MX51_PAD_NANDF_WP_B__PATA_DMACK		0x2004
+							MX51_PAD_NANDF_RB0__PATA_DMARQ		0x2004
+							MX51_PAD_NANDF_RB1__PATA_IORDY		0x2004
+							MX51_PAD_GPIO_NAND__PATA_INTRQ		0x2004
+							MX51_PAD_NANDF_CS2__PATA_CS_0		0x2004
+							MX51_PAD_NANDF_CS3__PATA_CS_1		0x2004
+							MX51_PAD_NANDF_CS4__PATA_DA_0		0x2004
+							MX51_PAD_NANDF_CS5__PATA_DA_1		0x2004
+							MX51_PAD_NANDF_CS6__PATA_DA_2		0x2004
+							MX51_PAD_NANDF_D15__PATA_DATA15		0x2004
+							MX51_PAD_NANDF_D14__PATA_DATA14		0x2004
+							MX51_PAD_NANDF_D13__PATA_DATA13		0x2004
+							MX51_PAD_NANDF_D12__PATA_DATA12		0x2004
+							MX51_PAD_NANDF_D11__PATA_DATA11		0x2004
+							MX51_PAD_NANDF_D10__PATA_DATA10		0x2004
+							MX51_PAD_NANDF_D9__PATA_DATA9		0x2004
+							MX51_PAD_NANDF_D8__PATA_DATA8		0x2004
+							MX51_PAD_NANDF_D7__PATA_DATA7		0x2004
+							MX51_PAD_NANDF_D6__PATA_DATA6		0x2004
+							MX51_PAD_NANDF_D5__PATA_DATA5		0x2004
+							MX51_PAD_NANDF_D4__PATA_DATA4		0x2004
+							MX51_PAD_NANDF_D3__PATA_DATA3		0x2004
+							MX51_PAD_NANDF_D2__PATA_DATA2		0x2004
+							MX51_PAD_NANDF_D1__PATA_DATA1		0x2004
+							MX51_PAD_NANDF_D0__PATA_DATA0		0x2004
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
@@ -591,6 +627,14 @@
 				status = "disabled";
 			};
 
+			pata: pata@83fe0000 {
+				compatible = "fsl,imx51-pata", "fsl,imx27-pata";
+				reg = <0x83fe0000 0x4000>;
+				interrupts = <70>;
+				clocks = <&clks 161>;
+				status = "disabled";
+			};
+
 			ssi3: ssi@83fe8000 {
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
-- 
1.8.2.rc2

