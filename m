From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
Date: Fri, 13 Jan 2017 13:37:57 +0100
Message-ID: <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the TI DA850 AHCI SATA controller.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/ata/ahci-da850.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
new file mode 100644
index 0000000..d07c241
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
@@ -0,0 +1,21 @@
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
+  - da850,clk_multiplier: the multiplier for the reference clock needed
+                          for 1.5GHz PLL output
+
+Example:
+
+	sata: ahci@0x218000 {
+		compatible = "ti,da850-ahci";
+		reg = <0x218000 0x2000>, <0x22c018 0x4>;
+		interrupts = <67>;
+		da850,clk_multiplier = <7>;
+	};
-- 
2.9.3
