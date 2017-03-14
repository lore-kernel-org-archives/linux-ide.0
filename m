From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller
Date: Tue, 14 Mar 2017 12:04:50 +0100
Message-ID: <1489489491-14195-2-git-send-email-bgolaszewski@baylibre.com>
References: <1489489491-14195-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489489491-14195-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Add DT bindings for the onboard SATA controller present on the DM816x
SoCs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-dm816.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
new file mode 100644
index 0000000..f8c535f
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
@@ -0,0 +1,21 @@
+Device tree binding for the TI DM816 AHCI SATA Controller
+---------------------------------------------------------
+
+Required properties:
+  - compatible: must be "ti,dm816-ahci"
+  - reg: physical base address and size of the register region used by
+         the controller (as defined by the AHCI 1.1 standard)
+  - interrupts: interrupt specifier (refer to the interrupt binding)
+  - clocks: list of phandle and clock specifier pairs (or only
+            phandles for clock providers with '0' defined for
+            #clock-cells); two clocks must be specified: the functional
+            clock and an external reference clock
+
+Example:
+
+	sata: sata@4a140000 {
+		compatible = "ti,dm816-ahci";
+		reg = <0x4a140000 0x10000>;
+		interrupts = <16>;
+		clocks = <&sysclk5_ck>, <&sata_refclk>;
+	};
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
