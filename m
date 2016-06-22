From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH v4 1/3] Documentation: dt: Add Broadcom iproc pwm controller binding
Date: Wed, 22 Jun 2016 07:29:45 -0400
Message-ID: <1466594987-26537-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35861 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbcFVLao (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2016 07:30:44 -0400
Received: by mail-pa0-f41.google.com with SMTP id wo6so16261542pac.3
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2016 04:30:44 -0700 (PDT)
In-Reply-To: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Add a binding for Broadcom iproc pwm controller

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
new file mode 100644
index 0000000..21f75bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
@@ -0,0 +1,21 @@
+Broadcom iProc PWM controller device tree bindings
+
+This controller has 4 channels.
+
+Required Properties :
+- compatible: must be "brcm,iproc-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle + clock specifier pair for the external clock
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+  description of the cells format.
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
+
+Example:
+
+pwm: pwm@18031000 {
+	compatible = "brcm,iproc-pwm";
+	reg = <0x18031000 0x28>;
+	clocks = <&osc>;
+	#pwm-cells = <3>;
+};
-- 
2.1.0

