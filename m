From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 8/8] ARM: dts: cubox-i: disable spread-spectrum for Cubox-i
 eSATA
Date: Tue, 24 Jun 2014 11:20:03 +0100
Message-ID: <E1WzNpb-0005e9-7W@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40049 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753288AbaFXKUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 06:20:11 -0400
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

Spread-spectrum doesn't work with Cubox-i hardware.  eSATA devices are
detected, but then fail on normal IO.  Therefore, disable this feature.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index 941365d7ee65..9efd8b0c8011 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -16,4 +16,5 @@
 	fsl,transmit-level-mV = <1104>;
 	fsl,transmit-boost-mdB = <0>;
 	fsl,transmit-atten-16ths = <9>;
+	fsl,no-spread-spectrum;
 };
-- 
1.8.3.1

