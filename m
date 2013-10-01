From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 3/3] ARM: dts: Enable ahci sata and sata phy
Date: Tue,  1 Oct 2013 12:03:03 +0530
Message-ID: <1380609183-21430-4-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: tj@kernel.org, kgene.kim@samsung.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, kishon@ti.com
Cc: s.nawrocki@samsung.com, ks.giri@samsung.com, aditya.ps@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-ide@vger.kernel.org

This patch adds dt entry for ahci sata controller and its
corresponding phy controller.phy node has been added w.r.t
new generic phy framework.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts  |    9 ++++++++-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    6 +-----
 arch/arm/boot/dts/exynos5250.dtsi         |   21 +++++++++++++++++----
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index cee55fa..50db341 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -363,7 +363,14 @@
 	};
 
 	i2c@121D0000 {
-		status = "disabled";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <40000>;
+		samsung,i2c-slave-addr = <0x38>;
+
+		sata-phy {
+			compatible = "sata-phy-i2c";
+			reg = <0x38>;
+		};
 	};
 
 	dwmmc_0: dwmmc0@12200000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 2538b32..21b4b25a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -91,15 +91,11 @@
 		samsung,i2c-slave-addr = <0x38>;
 
 		sata-phy {
-			compatible = "samsung,sata-phy";
+			compatible = "sata-phy-i2c";
 			reg = <0x38>;
 		};
 	};
 
-	sata@122F0000 {
-		samsung,sata-freq = <66>;
-	};
-
 	i2c@12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 668ce5d..46a0e3b 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -46,6 +46,7 @@
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
 		i2c8 = &i2c_8;
+		i2c9 = &i2c_9;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
@@ -216,16 +217,28 @@
 	};
 
 	sata@122F0000 {
-		compatible = "samsung,exynos5-sata-ahci";
+		compatible = "samsung,exynos5250-sata-ahci";
+		samsung,sata-freq = <66>;
 		reg = <0x122F0000 0x1ff>;
 		interrupts = <0 115 0>;
 		clocks = <&clock 277>, <&clock 143>;
 		clock-names = "sata", "sclk_sata";
+		phys = <&sata_phy>;
+		phy-names = "sata-phy";
 	};
 
-	sata-phy@12170000 {
-		compatible = "samsung,exynos5-sata-phy";
+	sata_phy:sata-phy@12170000 {
+		compatible = "samsung,exynos5250-sata-phy";
 		reg = <0x12170000 0x1ff>;
+		clocks = <&clock 287>;
+		clock-names = "sata_phyctrl";
+		#phy-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		sataphy-pmu {
+			reg = <0x10040724 0x4>;
+			};
 	};
 
 	i2c_0: i2c@12C60000 {
@@ -334,7 +347,7 @@
 		clock-names = "i2c";
 	};
 
-	i2c@121D0000 {
+	i2c_9: i2c@121D0000 {
                 compatible = "samsung,exynos5-sata-phy-i2c";
                 reg = <0x121D0000 0x100>;
                 #address-cells = <1>;
-- 
1.7.9.5
