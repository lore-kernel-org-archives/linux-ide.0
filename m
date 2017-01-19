From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 13/14] ARM: dts: da850-lcdk: enable the SATA node
Date: Thu, 19 Jan 2017 14:29:47 +0100
Message-ID: <1484832588-18413-14-git-send-email-bgolaszewski@baylibre.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38248 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbdASNbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2017 08:31:08 -0500
Received: by mail-wm0-f42.google.com with SMTP id r144so77154299wme.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2017 05:30:10 -0800 (PST)
In-Reply-To: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable the SATA node for da850-lcdk. We omit the pinctrl property on
purpose - the muxed SATA pins are not hooked up to anything
SATA-related on the lcdk.

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

