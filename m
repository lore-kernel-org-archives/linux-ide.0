From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 12/14] ARM: dts: da850: add pinmux settings for the SATA controller
Date: Tue, 17 Jan 2017 13:26:14 +0100
Message-ID: <1484655976-25382-13-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add pinmux sub-nodes for all muxed SATA pins.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..1f6a47d 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -78,6 +78,30 @@
 					0x10 0x00220000 0x00ff0000
 				>;
 			};
+			sata_cp_det_pin: pinmux_sata_cp_det_pin {
+				pinctrl-single,bits = <
+					/* SATA_CP_DET */
+					0x0c 0x00000000 0xf0000000
+				>;
+			};
+			sata_mp_switch_pin: pinmux_sata_mp_switch_pin {
+				pinctrl-single,bits = <
+					/* SATA_MP_SWITCH */
+					0x0c 0x00000000 0x0f000000
+				>;
+			};
+			sata_cp_pod_pin: pinmux_sata_cp_pod_pin {
+				pinctrl-single,bits = <
+					/* SATA_CP_POD */
+					0x10 0x40000000 0xf0000000
+				>;
+			};
+			sata_led_pin: pinmux_sata_led_pin {
+				pinctrl-single,bits = <
+					/* SATA_LED */
+					0x10 0x04000000 0x0f000000
+				>;
+			};
 			i2c0_pins: pinmux_i2c0_pins {
 				pinctrl-single,bits = <
 					/* I2C0_SDA,I2C0_SCL */
-- 
2.9.3
