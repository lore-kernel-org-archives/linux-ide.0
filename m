From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 01/14] devicetree: bindings: add bindings for ahci-da850
Date: Mon, 30 Jan 2017 11:01:58 +0100
Message-ID: <1485770531-6772-2-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the TI DA850 AHCI SATA controller.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-da850.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
new file mode 100644
index 0000000..5f81934
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
@@ -0,0 +1,18 @@
+Device tree binding for the TI DA850 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,da850-ahci"
+  - reg: physical base addresses and sizes of the two register regions
+         used by the controller: the register map as defined by the
+         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
+         for enabling/disabling the SATA clock receiver
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+
+Example:
+
+	sata: sata@218000 {
+		compatible = "ti,da850-ahci";
+		reg = <0x218000 0x2000>, <0x22c018 0x4>;
+		interrupts = <67>;
+	};
-- 
2.9.3
