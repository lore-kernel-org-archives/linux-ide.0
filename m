From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 14/14] ARM: dts: da850-lcdk: enable the SATA node
Date: Tue, 17 Jan 2017 13:26:16 +0100
Message-ID: <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Enable the SATA node for da850-lcdk. We omit the pinctrl property on
purpose - the muxed SATA pins are not hooked up to anything
SATA-related on the lcdk.

The REFCLKN/P rate on the board is 100MHz, so we need a multiplier of
15 for 1.5GHz PLL rate.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index afcb482..fbeee3c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -105,6 +105,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio_pins>;
-- 
2.9.3
