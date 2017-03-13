From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller
Date: Mon, 13 Mar 2017 17:36:21 +0100
Message-ID: <1489422982-3461-2-git-send-email-bgolaszewski@baylibre.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the onboard SATA controller present on the DM816x
SoCs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-dm816.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
new file mode 100644
index 0000000..b87ed5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
@@ -0,0 +1,20 @@
+Device tree binding for the TI DM816 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,dm816-ahci"
+  - reg: physical base address and size of the register region used by
+         the controller (as defined by the AHCI 1.1 standard)
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+  - clocks: clock specifiers (refer to the clock binding); two clocks
+            must be specified: the functional clock and an external
+            reference clock
+
+Example:
+
+	sata: sata@4a140000 {
+		compatible = "ti,dm816-ahci";
+		reg = <0x4a140000 0xffff>;
+		interrupts = <16>;
+		clocks = <&sysclk5_ck>, <&sata_refclk>;
+	};
-- 
2.9.3
