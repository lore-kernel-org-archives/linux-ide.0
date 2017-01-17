From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/14] devicetree: bindings: add bindings for ahci-da850
Date: Tue, 17 Jan 2017 13:26:03 +0100
Message-ID: <1484655976-25382-2-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the TI DA850 AHCI SATA controller.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
new file mode 100644
index 0000000..e7111b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
@@ -0,0 +1,18 @@
+Device tree binding for the TI DA850 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,da850-ahci"
+  - reg: physical base addresses and sizes of the controller's register areas
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+
+Optional properties:
+  - clocks: clock specifier (refer to the common clock binding)
+
+Example:
+
+	sata: ahci@218000 {
+		compatible = "ti,da850-ahci";
+		reg = <0x218000 0x2000>, <0x22c018 0x4>;
+		interrupts = <67>;
+	};
-- 
2.9.3
