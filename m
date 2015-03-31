From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 1/3] ahci: st: Update the ahci_st DT documentation
Date: Tue, 31 Mar 2015 08:35:07 +0100
Message-ID: <1427787309-1601-2-git-send-email-peter.griffin@linaro.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38259 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbCaHfV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2015 03:35:21 -0400
Received: by wibgn9 with SMTP id gn9so14637667wib.1
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2015 00:35:20 -0700 (PDT)
In-Reply-To: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, tj@kernel.org, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

As part of testing ahci_st driver working on stih407 I noticed
several things wrong in the DT documentation: -

1) Compatible string doesn't match the driver code
2) pwr-rst reset isn't documented (but exists in the driver)
3) some whitespace issues (spaces not tabs)

Also add in a stih407 family example into the doc.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 Documentation/devicetree/bindings/ata/ahci-st.txt | 45 ++++++++++++++++-------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
index 1331202..e1d01df 100644
--- a/Documentation/devicetree/bindings/ata/ahci-st.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
@@ -3,29 +3,48 @@ STMicroelectronics STi SATA controller
 This binding describes a SATA device.
 
 Required properties:
- - compatible	   : Must be "st,sti-ahci"
+ - compatible	   : Must be "st,ahci"
  - reg		   : Physical base addresses and length of register sets
  - interrupts	   : Interrupt associated with the SATA device
  - interrupt-names :   Associated name must be; "hostc"
- - resets	   : The power-down and soft-reset lines of SATA IP
- - reset-names	   :   Associated names must be; "pwr-dwn" and "sw-rst"
  - clocks	   : The phandle for the clock
  - clock-names	   :   Associated name must be; "ahci_clk"
  - phys		   : The phandle for the PHY port
  - phy-names	   :   Associated name must be; "ahci_phy"
 
+Optional properties:
+ - resets	   : The power-down, soft-reset and power-reset lines of SATA IP
+ - reset-names	   :   Associated names must be; "pwr-dwn", "sw-rst" and "pwr-rst"
+
 Example:
 
+	/* Example for stih416 */
 	sata0: sata@fe380000 {
-		compatible      = "st,sti-ahci";
-		reg             = <0xfe380000 0x1000>;
-		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
-		interrupt-names = "hostc";
-		phys	        = <&phy_port0 PHY_TYPE_SATA>;
-		phy-names       = "ahci_phy";
-		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
+		compatible	= "st,ahci";
+		reg		= <0xfe380000 0x1000>;
+		interrupts	= <GIC_SPI 157 IRQ_TYPE_NONE>;
+		interrupt-names	= "hostc";
+		phys		= <&phy_port0 PHY_TYPE_SATA>;
+		phy-names	= "ahci_phy";
+		resets		= <&powerdown STIH416_SATA0_POWERDOWN>,
 				  <&softreset STIH416_SATA0_SOFTRESET>;
-		reset-names     = "pwr-dwn", "sw-rst";
-		clocks	        = <&clk_s_a0_ls CLK_ICN_REG>;
-		clock-names     = "ahci_clk";
+		reset-names	= "pwr-dwn", "sw-rst";
+		clocks		= <&clk_s_a0_ls CLK_ICN_REG>;
+		clock-names	= "ahci_clk";
+	};
+
+	/* Example for stih407 family silicon */
+	sata0: sata@9b20000 {
+		compatible	= "st,ahci";
+		reg		= <0x9b20000 0x1000>;
+		interrupts	= <GIC_SPI 159 IRQ_TYPE_NONE>;
+		interrupt-names	= "hostc";
+		phys		= <&phy_port0 PHY_TYPE_SATA>;
+		phy-names	= "ahci_phy";
+		resets		= <&powerdown STIH407_SATA0_POWERDOWN>,
+				  <&softreset STIH407_SATA0_SOFTRESET>,
+				  <&softreset STIH407_SATA0_PWR_SOFTRESET>;
+		reset-names	= "pwr-dwn", "sw-rst", "pwr-rst";
+		clocks		= <&clk_s_c0_flexgen CLK_ICN_REG>;
+		clock-names	= "ahci_clk";
 	};
-- 
1.9.1

