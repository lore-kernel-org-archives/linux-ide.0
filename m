From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/14] ARM: dts: da850: add the SATA node
Date: Tue, 17 Jan 2017 13:26:15 +0100
Message-ID: <1484655976-25382-14-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35245 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdAQM1O (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2017 07:27:14 -0500
Received: by mail-wm0-f48.google.com with SMTP id r126so198503839wmr.0
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2017 04:27:09 -0800 (PST)
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the SATA node to the da850 device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 1f6a47d..7c32bf7 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -427,6 +427,12 @@
 			phy-names = "usb-phy";
 			status = "disabled";
 		};
+		sata: ahci@218000 {
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

