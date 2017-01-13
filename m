From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/10] ARM: dts: da850: add pinmux settings for the SATA controller
Date: Fri, 13 Jan 2017 13:38:02 +0100
Message-ID: <1484311084-31547-9-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36477 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdAMMkL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2017 07:40:11 -0500
Received: by mail-wm0-f51.google.com with SMTP id c85so63097598wmi.1
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2017 04:39:10 -0800 (PST)
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

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

