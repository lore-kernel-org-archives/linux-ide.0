From: girishks2000@gmail.com
Subject: [PATCH 2/2] arm: exynos5440: add dts node for the ahci sata
Date: Fri,  1 Feb 2013 17:56:25 -0800
Message-ID: <510c7283.a4d1440a.7061.2699@mx.google.com>
References: <1359770185-31867-1-git-send-email-yes>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:39078 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab3BBB5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2013 20:57:24 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so1955784dad.41
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2013 17:57:24 -0800 (PST)
In-Reply-To: <1359770185-31867-1-git-send-email-yes>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, Girish K S <ks.giri@samsung.com>

From: Girish K S <ks.giri@samsung.com>

This patch adds dts support for the sata controller

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index a00ed6a..8d6a784 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -193,4 +193,13 @@
 		clocks = <&clock 8>;
 		clock-names = "rtc";
 	};
+
+	sata@210000 {
+		compatible = "samsung,exynos5440-ahci";
+		reg = <0x210000 0x10000>;
+		interrupts = <0 30 0>;
+		clocks = <&clock 10>;
+		clock-names = "sata";
+	};
+
 };
-- 
1.7.10.4

