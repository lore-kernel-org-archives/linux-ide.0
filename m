From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 1/5] Documentation: devicetree: add Broadcom SATA binding
Date: Wed, 22 Apr 2015 19:59:06 -0700
Message-ID: <1429757950-28789-2-git-send-email-computersforpeace@gmail.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36318 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbbDWDAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2015 23:00:50 -0400
In-Reply-To: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: no change

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
new file mode 100644
index 000000000000..afeede13e195
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -0,0 +1,35 @@
+* Broadcom SATA3 AHCI Controller for STB
+
+SATA nodes are defined to describe on-chip Serial ATA controllers.
+Each SATA controller should have its own node.
+
+Required properties:
+- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
+                       "brcm,sata3-ahci"
+- reg                : register mappings for AHCI and SATA_TOP_CTRL
+- reg-names          : "ahci" and "top-ctrl"
+- interrupts         : interrupt mapping for SATA IRQ
+
+Also see ahci-platform.txt.
+
+Example:
+
+	sata@f045a000 {
+		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
+		reg-names = "ahci", "top-ctrl";
+		interrupts = <0 30 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0: sata-port@0 {
+			reg = <0>;
+			phys = <&sata_phy 0>;
+		};
+
+		sata1: sata-port@1 {
+			reg = <1>;
+			phys = <&sata_phy 1>;
+		};
+	};
+
-- 
1.9.1

