From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4 v2] ata: Add DT bindings for the Gemini SATA bridge
Date: Sat, 20 May 2017 01:05:58 +0200
Message-ID: <20170519230600.16782-2-linus.walleij@linaro.org>
References: <20170519230600.16782-1-linus.walleij@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170519230600.16782-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Janos Laube <janos.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paulius Zaleckas <paulius.zaleckas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hans Ulli Kroll <ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Feng-Hsin Chiang <john453-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This adds device tree bindings for the Cortina Systems Gemini
PATA to SATA bridge.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: John Feng-Hsin Chiang <john453-w0jeGXs5+AWXmMXjJBpWqg@public.gmane.org>
Cc: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Hans Ulli Kroll <ulli.kroll-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Fix ata0 misspelled as ata1 in one place.
---
 .../bindings/ata/cortina,gemini-sata-bridge.txt    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt

diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
new file mode 100644
index 000000000000..1c3d3cc70051
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
@@ -0,0 +1,55 @@
+* Cortina Systems Gemini SATA Bridge
+
+The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
+takes two Faraday Technology FTIDE010 PATA controllers and bridges
+them in different configurations to two SATA ports.
+
+Required properties:
+- compatible: should be
+  "cortina,gemini-sata-bridge"
+- reg: registers and size for the block
+- resets: phandles to the reset lines for both SATA bridges
+- reset-names: must be "sata0", "sata1"
+- clocks: phandles to the compulsory peripheral clocks
+- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
+- syscon: a phandle to the global Gemini system controller
+- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
+  the ATA controller and SATA bridges. Values 0..3:
+  Mode 0: ata0 master <-> sata0
+          ata1 master <-> sata1
+          ata0 slave interface brought out on IDE pads
+  Mode 1: ata0 master <-> sata0
+          ata1 master <-> sata1
+          ata1 slave interface brought out on IDE pads
+  Mode 2: ata1 master <-> sata1
+          ata1 slave  <-> sata0
+          ata0 master and slave interfaces brought out
+               on IDE pads
+  Mode 3: ata0 master <-> sata0
+          ata0 slave  <-> sata1
+          ata1 master and slave interfaces brought out
+               on IDE pads
+
+Optional boolean properties:
+- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
+  The muxmode setting decides whether ATA0 or ATA1 is brought out,
+  and whether master, slave or both interfaces get brought out.
+- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
+  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
+  be muxed out and how.
+
+Example:
+
+sata: sata@46000000 {
+	compatible = "cortina,gemini-sata-bridge";
+	reg = <0x46000000 0x100>;
+	resets = <&rcon 26>, <&rcon 27>;
+	reset-names = "sata0", "sata1";
+	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
+		 <&gcc GEMINI_CLK_GATE_SATA1>;
+	clock-names = "SATA0_PCLK", "SATA1_PCLK";
+	syscon = <&syscon>;
+	cortina,gemini-ata-muxmode = <3>;
+	cortina,gemini-enable-ide-pins;
+	cortina,gemini-enable-sata-bridge;
+};
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
