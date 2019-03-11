From: Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls1028a: Corrected the SATA ecc address.
Date: Mon, 11 Mar 2019 15:20:13 +0800
Message-ID: <20190311072014.36565-2-peng.ma@nxp.com>
References: <20190311072014.36565-1-peng.ma@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, andy.tang@nxp.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

Ls1028a SATA ecc address with more than 32 bit, so we should corrrect the
address.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index a8cf92a..3fcbd0a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -277,7 +277,7 @@
 		sata: sata@3200000 {
 			compatible = "fsl,ls1028a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-				<0x0 0x20140520 0x0 0x4>;
+				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-- 
1.7.1
