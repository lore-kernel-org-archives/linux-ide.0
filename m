From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 06/10] ARM: at91: declare the at91rm9200 memory controller as a syscon
Date: Mon, 16 Mar 2015 23:44:42 +0100
Message-ID: <1426545886-19162-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

The at91rm9200 memory controller is not simply an SDRAM controller. It also
controls the EBI (External Bus Interface), the SMC (Static Memory Controller)and
the Burst Flash Controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 2e99b5b57350..424ac8cbfa08 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -98,7 +98,7 @@ Example:
 	};
 
 RAMC SDRAM/DDR Controller required properties:
-- compatible: Should be "atmel,at91rm9200-sdramc",
+- compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
 			"atmel,at91sam9260-sdramc",
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 4fb333bd1f85..6d0fa9b87f46 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -92,7 +92,7 @@
 			};
 
 			ramc0: ramc@ffffff00 {
-				compatible = "atmel,at91rm9200-sdramc";
+				compatible = "atmel,at91rm9200-sdramc", "syscon";
 				reg = <0xffffff00 0x100>;
 			};
 
-- 
2.1.0
