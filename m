From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Tue,  9 Oct 2012 17:18:48 +0530
Message-ID: <1349783332-18467-3-git-send-email-vasanthananthan@gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63167 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2JILqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2012 07:46:23 -0400
In-Reply-To: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>

This patch adds Device Nodes for SATA and SATA PHY device.

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   20 ++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h   |    7 +++++++
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++++++
 4 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 8a5e348..bb262ce 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -48,6 +48,17 @@
 		};
 	};
 
+	i2c@121D0000 {
+		samsung,i2c-sda-delay = <100>;
+                samsung,i2c-max-bus-freq = <40000>;
+		samsung,i2c-slave-addr = <0x38>;
+
+		sataphy@70 {
+			compatible = "samsung,i2c-phy";
+			reg = <0x38>;
+		};
+	};
+
 	i2c@12C80000 {
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 004aaa8..5a47a8f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -88,6 +88,18 @@
 		interrupts = <0 54 0>;
 	};
 
+	sata@122F0000 {
+                compatible = "samsung,exynos-sata-ahci";
+                reg = <0x122F0000 0x1ff>;
+		interrupts = <0 115 0>;
+        };
+
+        sata-phy@12170000 {
+                compatible = "samsung,exynos-sata-phy";
+                reg = <0x12170000 0x1ff>;
+        };
+
+
 	i2c@12C60000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C60000 0x100>;
@@ -152,6 +164,13 @@
 		#size-cells = <0>;
 	};
 
+	i2c@121D0000 {
+                compatible = "samsung,s3c2440-sataphy-i2c";
+                reg = <0x121D0000 0x100>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+        };
+
 	spi_0: spi@12d20000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d20000 0x100>;
@@ -460,4 +479,5 @@
 			#gpio-cells = <4>;
 		};
 	};
+
 };
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72b675..6827190 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -177,9 +177,16 @@
 #define EXYNOS4_PA_HSOTG		0x12480000
 #define EXYNOS4_PA_USB_HSPHY		0x125B0000
 
+#ifdef CONFIG_ARCH_EXYNOS4
 #define EXYNOS4_PA_SATA			0x12560000
 #define EXYNOS4_PA_SATAPHY		0x125D0000
 #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
+#endif
+#ifdef CONFIG_ARCH_EXYNOS5
+#define EXYNOS5_PA_SATA_PHY_CTRL	0x12170000
+#define EXYNOS5_PA_SATA_PHY_I2C		0x121D0000
+#define EXYNOS5_PA_SATA_BASE		0x122F0000
+#endif
 
 #define EXYNOS4_PA_SROMC		0x12570000
 #define EXYNOS5_PA_SROMC		0x12250000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index ef770bc..c931c6c 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -47,6 +47,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"s3c2440-i2c.0", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
 				"s3c2440-i2c.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos-sata-ahci", EXYNOS5_PA_SATA_BASE,
+				"sata_exynos", NULL),
+	OF_DEV_AUXDATA("samsung,exynos-sata-phy", EXYNOS5_PA_SATA_PHY_CTRL,
+				"sata_phy_exynos", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-sataphy-i2c", EXYNOS5_PA_SATA_PHY_I2C,
+				"sata-phy-i2c", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI0,
 				"exynos4210-spi.0", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI1,
-- 
1.7.5.4

