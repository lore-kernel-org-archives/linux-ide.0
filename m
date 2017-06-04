From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4 v4] ata: Add DT bindings for the Gemini SATA bridge
Date: Sun,  4 Jun 2017 10:50:07 +0200
Message-ID: <20170604085009.11902-2-linus.walleij@linaro.org>
References: <20170604085009.11902-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33896 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDIu2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jun 2017 04:50:28 -0400
Received: by mail-lf0-f54.google.com with SMTP id v20so26997618lfa.1
        for <linux-ide@vger.kernel.org>; Sun, 04 Jun 2017 01:50:28 -0700 (PDT)
In-Reply-To: <20170604085009.11902-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

This adds device tree bindings for the Cortina Systems Gemini
PATA to SATA bridge.

Cc: devicetree@vger.kernel.org
Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes, just resending to keep the patch set together.
ChangeLog v2->v3:
- No changes, just resending to keep the patch set together.
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

