From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 2/5] Documentation: devicetree: add Broadcom SATA PHY binding
Date: Wed, 22 Apr 2015 19:59:07 -0700
Message-ID: <1429757950-28789-3-git-send-email-computersforpeace@gmail.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

For 28nm STB chips, based on BCM7445.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2:
  - make each subnode into a provider, so we can use direct phandle references
    to them
  - drop the 'port-ctrl' register range, since this was shared with the SATA
    node

 .../bindings/phy/brcm,brcmstb-sata-phy.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
new file mode 100644
index 000000000000..7f81ef90146a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
@@ -0,0 +1,40 @@
+* Broadcom SATA3 PHY for STB
+
+Required properties:
+- compatible: should be one or more of
+     "brcm,bcm7445-sata-phy"
+     "brcm,phy-sata3"
+- address-cells: should be 1
+- size-cells: should be 0
+- reg: register range for the PHY PCB interface
+- reg-names: should be "phy"
+
+Sub-nodes:
+  Each port's PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- reg: the PHY number
+- phy-cells: generic PHY binding; must be 0
+Optional:
+- brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
+
+
+Example:
+
+	sata-phy@f0458100 {
+		compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+		reg = <0xf0458100 0x1e00>, <0xf045804c 0x10>;
+		reg-names = "phy";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata-phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		sata-phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
-- 
1.9.1
