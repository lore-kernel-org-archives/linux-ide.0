From: <yuantian.tang@nxp.com>
Subject: [PATCH 2/2] arm64: dts: updated sata node on ls1046a dts
Date: Thu, 17 Nov 2016 15:59:20 +0800
Message-ID: <1479369560-9188-2-git-send-email-yuantian.tang@nxp.com>
References: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:56800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751884AbcKQIMg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 17 Nov 2016 03:12:36 -0500
In-Reply-To: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

On ls1046a soc, sata ecc should be disabled. So added sata ecc
register address so that driver can get this information.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 38806ca..88aaaf1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -507,7 +507,9 @@
 
 		sata: sata@3200000 {
 			compatible = "fsl,ls1046a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>;
+			reg = <0x0 0x3200000 0x0 0x10000>,
+			    <0x0 0x20140520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
 		};
-- 
2.1.0.27.g96db324

