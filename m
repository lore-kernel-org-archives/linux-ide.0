From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH v2 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Tue, 30 Oct 2012 17:01:33 +0100
Message-ID: <1351612897-14923-3-git-send-email-vasanthananthan@gmail.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

This patch adds Device Nodes for SATA and SATA PHY device.

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 .../devicetree/bindings/ata/exynos-sata-phy.txt    |   14 ++++++++++++++
 .../devicetree/bindings/ata/exynos-sata.txt        |   17 +++++++++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |   18 ++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h            |    3 +++
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    6 ++++++
 6 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
 create mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt b/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
new file mode 100644
index 0000000..37824fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
@@ -0,0 +1,14 @@
+* Samsung SATA PHY Controller
+
+SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
+Each SATA PHY controller should have its own node.
+
+Required properties:
+- compatible        : compatible list, contains "samsung,exynos5-sata-phy"
+- reg               : <registers mapping>
+
+Example:
+        sata@ffe07000 {
+                compatible = "samsung,exynos5-sata-phy";
+                reg = <0xffe07000 0x1000>;
+        };
diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
new file mode 100644
index 0000000..0849f10
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/exynos-sata.txt
@@ -0,0 +1,17 @@
+* Samsung AHCI SATA Controller
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA controller should have its own node.
+
+Required properties:
+- compatible        : compatible list, contains "samsung,exynos5-sata"
+- interrupts        : <interrupt mapping for SATA IRQ>
+- reg               : <registers mapping>
+- samsung,sata-freq : <frequency in MHz>
+
+Example:
+        sata@ffe08000 {
+                compatible = "samsung,exynos5-sata";
+                reg = <0xffe08000 0x1000>;
+                interrupts = <115>;
+        };
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a352df4..6910deb 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -55,6 +55,21 @@
 		};
 	};
 
+	i2c@121D0000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <40000>;
+		samsung,i2c-slave-addr = <0x38>;
+
+		sata-phy {
+			compatible = "samsung,sata-phy";
+			reg = <0x38>;
+		};
+	};
+
+	sata@122F0000 {
+		samsung,sata-freq = <66>;
+	};
+
 	i2c@12C80000 {
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index dddfd6e..e41520f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -92,6 +92,17 @@
 		interrupts = <0 54 0>;
 	};
 
+	sata@122F0000 {
+		compatible = "samsung,exynos5-sata-ahci";
+		reg = <0x122F0000 0x1ff>;
+		interrupts = <0 115 0>;
+	};
+
+	sata-phy@12170000 {
+		compatible = "samsung,exynos5-sata-phy";
+		reg = <0x12170000 0x1ff>;
+	};
+
 	i2c@12C60000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C60000 0x100>;
@@ -156,6 +167,13 @@
 		#size-cells = <0>;
 	};
 
+	i2c@121D0000 {
+                compatible = "samsung,exynos5-sata-phy-i2c";
+                reg = <0x121D0000 0x100>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+	};
+
 	spi_0: spi@12d20000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x12d20000 0x100>;
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 8480849..ffeb761 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -188,6 +188,9 @@
 #define EXYNOS4_PA_SATA			0x12560000
 #define EXYNOS4_PA_SATAPHY		0x125D0000
 #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
+#define EXYNOS5_PA_SATA_PHY_CTRL	0x12170000
+#define EXYNOS5_PA_SATA_PHY_I2C		0x121D0000
+#define EXYNOS5_PA_SATA_BASE		0x122F0000
 
 #define EXYNOS4_PA_SROMC		0x12570000
 #define EXYNOS5_PA_SROMC		0x12250000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index db1cd8e..7dbd4cc 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -61,6 +61,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos4210-spi.1", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI2,
 				"exynos4210-spi.2", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5-sata-ahci", EXYNOS5_PA_SATA_BASE,
+				"exynos5-sata", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5-sata-phy", EXYNOS5_PA_SATA_PHY_CTRL,
+				"exynos5-sata-phy", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5-sata-phy-i2c", EXYNOS5_PA_SATA_PHY_I2C,
+				"exynos5-sata-phy-i2c", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-- 
1.7.4.1
