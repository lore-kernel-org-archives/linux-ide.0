From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 1/3] ahci: st: Update the ahci_st DT documentation
Date: Mon,  2 Mar 2015 12:48:37 +0000
Message-ID: <1425300519-13747-2-git-send-email-peter.griffin@linaro.org>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36958 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbbCBMsu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2015 07:48:50 -0500
Received: by wesw55 with SMTP id w55so33045713wes.4
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2015 04:48:45 -0800 (PST)
In-Reply-To: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org

As part of testing ahci_st driver working on stih407 I noticed
several things wrong in the DT documentation: -

1) Compatible string doesn't match the driver code
2) pwr-rst reset isn't documented (but exists in the driver)
3) some whitespace issues (spaces not tabs)

Also add in a stih407 family example into the doc.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
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

