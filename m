From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5/5] arm64: dts: marvell: armada-cp110: Switch to per-port
 SATA interrupts
Date: Fri, 22 Feb 2019 15:53:56 +0100
Message-ID: <20190222145356.23072-6-miquel.raynal@bootlin.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190222145356.23072-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

There are two SATA ports per CP110. Each of them has a dedicated
interrupt. Describe the real hardware by adding two SATA ports to the
CP110 SATA node and enabling them in all the DTs including it
(7040-db/8040-db/8040-clearfog).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts |  7 ++++++-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 14 ++++++++++++--
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi  | 16 ++++++++++++++--
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 412efdb46e7c..54c1c0ddc813 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -194,7 +194,12 @@
 };
 
 &cp0_sata0 {
-	status = "okay";
+	sata-port@0 {
+		status = "okay";
+	};
+	sata-port@1 {
+		status = "okay";
+	};
 };
 
 &cp0_usb3_0 {
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 1bac437369a1..988cc7dc15d9 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -147,7 +147,12 @@
 
 /* CON4 on CP0 expansion */
 &cp0_sata0 {
-	status = "okay";
+	sata-port@0 {
+		status = "okay";
+	};
+	sata-port@1 {
+		status = "okay";
+	};
 };
 
 /* CON9 on CP0 expansion */
@@ -279,7 +284,12 @@
 
 /* CON4 on CP1 expansion */
 &cp1_sata0 {
-	status = "okay";
+	sata-port@0 {
+		status = "okay";
+	};
+	sata-port@1 {
+		status = "okay";
+	};
 };
 
 /* CON9 on CP1 expansion */
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index b9d9f31e3ba1..f27edddcacd1 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -292,10 +292,22 @@
 			"generic-ahci";
 			reg = <0x540000 0x30000>;
 			dma-coherent;
-			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&CP110_LABEL(clk) 1 15>,
 				 <&CP110_LABEL(clk) 1 16>;
-			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata-port@0 {
+				reg = <0>;
+				interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			sata-port@1 {
+				reg = <1>;
+				interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		CP110_LABEL(xor0): xor@6a0000 {
-- 
2.19.1
