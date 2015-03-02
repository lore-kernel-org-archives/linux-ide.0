From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add sata DT nodes.
Date: Mon,  2 Mar 2015 12:48:38 +0000
Message-ID: <1425300519-13747-3-git-send-email-peter.griffin@linaro.org>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Now that the miphy28lp is upstream, we can add the sata dt nodes
for stih407 family silicon. This has been tested on b2120 board
J4 (sata0 channel). These nodes are disabled by default as a
special mini pci-e to sata daughter board is required which
isn't shipped with the board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index a57c06e..d526921 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -338,6 +338,50 @@
 			};
 		};
 
+		sata0: sata@9b20000 {
+			compatible = "st,ahci";
+			reg = <0x9b20000 0x1000>;
+
+			interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+			interrupt-names = "hostc";
+
+			phys = <&phy_port0 PHY_TYPE_SATA>;
+			phy-names = "ahci_phy";
+
+			resets = <&powerdown STIH407_SATA0_POWERDOWN>,
+				 <&softreset STIH407_SATA0_SOFTRESET>,
+				 <&softreset STIH407_SATA0_PWR_SOFTRESET>;
+			reset-names = "pwr-dwn", "sw-rst", "pwr-rst";
+
+			clock-names = "ahci_clk";
+			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
+
+			status = "disabled";
+		};
+
+		sata1: sata@9b28000 {
+			compatible = "st,ahci";
+			reg = <0x9b28000 0x1000>;
+
+			interrupts = <GIC_SPI 170 IRQ_TYPE_NONE>;
+			interrupt-names = "hostc";
+
+			phys = <&phy_port1 PHY_TYPE_SATA>;
+			phy-names = "ahci_phy";
+
+			resets = <&powerdown STIH407_SATA1_POWERDOWN>,
+				 <&softreset STIH407_SATA1_SOFTRESET>,
+				 <&softreset STIH407_SATA1_PWR_SOFTRESET>;
+			reset-names = "pwr-dwn",
+				      "sw-rst",
+				      "pwr-rst";
+
+			clock-names = "ahci_clk";
+			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
+
+			status = "disabled";
+		};
+
 		st_dwc3: dwc3@8f94000 {
 			compatible	= "st,stih407-dwc3";
 			reg		= <0x08f94000 0x1000>, <0x110 0x4>;
-- 
1.9.1
