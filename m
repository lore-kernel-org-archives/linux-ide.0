From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/10] ARM: dts: da850: add the SATA node
Date: Fri, 13 Jan 2017 13:38:03 +0100
Message-ID: <1484311084-31547-10-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add the SATA node to the da850 device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 1f6a47d..f5086b1 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -427,6 +427,12 @@
 			phy-names = "usb-phy";
 			status = "disabled";
 		};
+		sata: ahci@0x218000 {
+			compatible = "ti,da850-ahci";
+			reg = <0x218000 0x2000>, <0x22c018 0x4>;
+			interrupts = <67>;
+			status = "disabled";
+		};
 		mdio: mdio@224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
-- 
2.9.3
