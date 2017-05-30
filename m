From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/4 v3] ARM: dts: add Gemini PATA/SATA support
Date: Tue, 30 May 2017 13:34:02 +0200
Message-ID: <20170530113402.20450-4-linus.walleij@linaro.org>
References: <20170530113402.20450-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36726 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdE3LeW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 07:34:22 -0400
Received: by mail-lf0-f52.google.com with SMTP id h4so47417784lfj.3
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 04:34:21 -0700 (PDT)
In-Reply-To: <20170530113402.20450-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

The NAS4229B and SQ201 Gemini systems have a PATA controller
which is linked to a SATA bridge in the SoC. Enable both
platforms to use the PATA/SATA devices.

Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes, just resending to keep the patch set together.
- Cut the timings also from the second device instance.
ChangeLog v1->v2:
- Cut the timings - we open code these in the driver instead.
- Reference syscon node for clocks and resets as requested by
  the devicetree reviewers.
- Use reset line #defines from the new header file.

PATA maintainers: this file will be applied by me through the ARM
SoC git tree. It is provided for reference only so you see how
it will be used.
---
 arch/arm/boot/dts/gemini-nas4220b.dts | 10 ++++++++++
 arch/arm/boot/dts/gemini-sq201.dts    | 10 ++++++++++
 arch/arm/boot/dts/gemini.dtsi         | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
index 7668ba52158e..55f6a4f1f801 100644
--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -98,5 +98,15 @@
 				read-only;
 			};
 		};
+
+		sata: sata@46000000 {
+			cortina,gemini-ata-muxmode = <0>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
+		ata@63000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
index 46309e79cc7b..4d200f0bcd45 100644
--- a/arch/arm/boot/dts/gemini-sq201.dts
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -93,6 +93,12 @@
 			};
 		};
 
+		sata: sata@46000000 {
+			cortina,gemini-ata-muxmode = <0>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
 		pci@50000000 {
 			status = "okay";
 			interrupt-map-mask = <0xf800 0 0 7>;
@@ -114,5 +120,9 @@
 				<0x6000 0 0 3 &pci_intc 1>,
 				<0x6000 0 0 4 &pci_intc 2>;
 		};
+
+		ata@63000000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 8e833744e855..49cce9e9d51f 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -83,6 +83,19 @@
 			clock-names = "PCLK", "EXTCLK";
 		};
 
+		sata: sata@46000000 {
+			compatible = "cortina,gemini-sata-bridge";
+			reg = <0x46000000 0x100>;
+			resets = <&syscon GEMINI_RESET_SATA0>,
+				 <&syscon GEMINI_RESET_SATA1>;
+			reset-names = "sata0", "sata1";
+			clocks = <&syscon GEMINI_CLK_GATE_SATA0>,
+				 <&syscon GEMINI_CLK_GATE_SATA1>;
+			clock-names = "SATA0_PCLK", "SATA1_PCLK";
+			syscon = <&syscon>;
+			status = "disabled";
+		};
+
 		intcon: interrupt-controller@48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
@@ -178,6 +191,28 @@
 			};
 		};
 
+		ata@63000000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63000000 0x1000>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
+			clock-names = "PCLK";
+			sata = <&sata>;
+			status = "disabled";
+		};
+
+		ata@63400000 {
+			compatible = "cortina,gemini-pata", "faraday,ftide010";
+			reg = <0x63400000 0x1000>;
+			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
+			clock-names = "PCLK";
+			sata = <&sata>;
+			status = "disabled";
+		};
+
 		dma-controller@67000000 {
 			compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
 			/* Faraday Technology FTDMAC020 variant */
-- 
2.9.4

