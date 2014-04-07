From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/4] ARM: mvebu: add Device Tree description of AHCI interfaces on Armada 38x
Date: Mon,  7 Apr 2014 16:57:42 +0200
Message-ID: <1396882664-19297-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48389 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755478AbaDGO5t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2014 10:57:49 -0400
In-Reply-To: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

The Marvell Armada 38x processors contain two AHCI compatible
interfaces. This commit adds the Device Tree description of those
interfaces at the SoC level, and also enables them on the Armada 385
DB platform, which allows access to both interfaces through SATA
ports.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
 arch/arm/boot/dts/armada-38x.dtsi   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 6828d77..bdde8ff 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -81,6 +81,14 @@
 				};
 			};
 
+			sata@a8000 {
+				status = "okay";
+			};
+
+			sata@e0000 {
+				status = "okay";
+			};
+
 			flash@d0000 {
 				status = "okay";
 				num-cs = <1>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59..634a020 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -338,6 +338,22 @@
 				reg = <0x72004 0x4>;
 			};
 
+			sata@a8000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xa8000 0x2000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 15>;
+				status = "disabled";
+			};
+
+			sata@e0000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xe0000 0x2000>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 30>;
+				status = "disabled";
+			};
+
 			coredivclk: clock@e4250 {
 				compatible = "marvell,armada-380-corediv-clock";
 				reg = <0xe4250 0xc>;
-- 
1.8.3.2

