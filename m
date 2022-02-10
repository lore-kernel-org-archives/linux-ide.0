Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F10C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiBJJoY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:44:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiBJJoY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 04:44:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B219B
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:44:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d27so8469129wrc.6
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYbokiO3VJ4iW65Dstshrb5gvbsv2dMAOZw4XcPc5q4=;
        b=ee07sKZuUW5Fzua3Sw51Mw7bjBEPymx+0jNhtyPf0igFS6yhsCAfQGkrk/GBlgpsE0
         Yzm4WduYHn/qP0EkkrwzRj8K1Sv6+t1ZJLONpiv5qgyA+jmTYoGOHa3SD0M4hH7v22WM
         WtOnDop/iUyyvkU/BZKpf73aexOGewDvxRu3E2uS3TPohWRSBuYzg1Kb8GIW6fKJjaBm
         C216Y0QCumLti6ZDsDWT3a4Mmwy4bxSeIJsuVjcwWAFSmj22fCxnH2fzc6cs9bvMND5h
         i/QOcnRK957s4FN1XPK/twbiSbqsRWde9Td4aT69rWSDic4/PauBmWyWrLFb1sktAjhm
         pR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYbokiO3VJ4iW65Dstshrb5gvbsv2dMAOZw4XcPc5q4=;
        b=UNqfInjTUIExGdJAaFnaqq5JESc1voenQvBk2H2aQEkX3+FV637h21QLTz+zSO2PAX
         JuzApJIj64geF89K7Zt4tZgOH/SG/AYYOkQI7c2E93Corv+YMtl1eAq+xxj2jghy+z5P
         s10uTr5TvC1bJiEg0a/lSP9LKAyaVr/Mx8I4B0g1syAEgtzpLMT6PpDWsBmzI6UIcFBF
         hC//ZKcn8fFbu8Jx1LT9MTVOZOczue0k30UzS78HpbzCrNoTiu1PUSl4aBZiHDdiFk+B
         TRKh8MDISzUexcSoxpjQcdeqSrNyni/nKdAabG3AgDWctjhIkr/lhyR/CdprfdXsqyDs
         fGiQ==
X-Gm-Message-State: AOAM5301RifGP1qGOwyR1WEoJJhg7IY1XFEHA9jRO6H/XuPlzkN+grLY
        k5RV1BVlwxcLhyrFvh6Pc2N8AQ==
X-Google-Smtp-Source: ABdhPJzz1fvR+9MddyaPTLKd+vwNPOJs91LIu4TMck1tqi74rzqXIflDK7Xegr/DLz8AdO3+HYPwJg==
X-Received: by 2002:adf:ee81:: with SMTP id b1mr5482077wro.149.1644486262956;
        Thu, 10 Feb 2022 01:44:22 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o14sm20609108wry.104.2022.02.10.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:44:22 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     damien.lemoal@opensource.wdc.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] dt-bindings: convert ata/cortina,gemini-sata-bridge to yaml
Date:   Thu, 10 Feb 2022 09:44:14 +0000
Message-Id: <20220210094414.2815616-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch converts ata/cortina,gemini-sata-bridge binding to yaml

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- fixed cosmetic nits reported by Damien Le Moal
Changes since v2:
- Added blank lines between properties
- Removed useless quotes and label
- Re-indented description

 .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
 .../ata/cortina,gemini-sata-bridge.yaml       | 107 ++++++++++++++++++
 2 files changed, 107 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml

diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
deleted file mode 100644
index 1c3d3cc70051..000000000000
--- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Cortina Systems Gemini SATA Bridge
-
-The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
-takes two Faraday Technology FTIDE010 PATA controllers and bridges
-them in different configurations to two SATA ports.
-
-Required properties:
-- compatible: should be
-  "cortina,gemini-sata-bridge"
-- reg: registers and size for the block
-- resets: phandles to the reset lines for both SATA bridges
-- reset-names: must be "sata0", "sata1"
-- clocks: phandles to the compulsory peripheral clocks
-- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
-- syscon: a phandle to the global Gemini system controller
-- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
-  the ATA controller and SATA bridges. Values 0..3:
-  Mode 0: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata0 slave interface brought out on IDE pads
-  Mode 1: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata1 slave interface brought out on IDE pads
-  Mode 2: ata1 master <-> sata1
-          ata1 slave  <-> sata0
-          ata0 master and slave interfaces brought out
-               on IDE pads
-  Mode 3: ata0 master <-> sata0
-          ata0 slave  <-> sata1
-          ata1 master and slave interfaces brought out
-               on IDE pads
-
-Optional boolean properties:
-- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
-  The muxmode setting decides whether ATA0 or ATA1 is brought out,
-  and whether master, slave or both interfaces get brought out.
-- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
-  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
-  be muxed out and how.
-
-Example:
-
-sata: sata@46000000 {
-	compatible = "cortina,gemini-sata-bridge";
-	reg = <0x46000000 0x100>;
-	resets = <&rcon 26>, <&rcon 27>;
-	reset-names = "sata0", "sata1";
-	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
-		 <&gcc GEMINI_CLK_GATE_SATA1>;
-	clock-names = "SATA0_PCLK", "SATA1_PCLK";
-	syscon = <&syscon>;
-	cortina,gemini-ata-muxmode = <3>;
-	cortina,gemini-enable-ide-pins;
-	cortina,gemini-enable-sata-bridge;
-};
diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
new file mode 100644
index 000000000000..f0fad63bb1af
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems Gemini SATA Bridge
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
+    takes two Faraday Technology FTIDE010 PATA controllers and bridges
+    them in different configurations to two SATA ports.
+
+properties:
+  compatible:
+    const: cortina,gemini-sata-bridge
+
+  reg:
+    minItems: 1
+
+  resets:
+    minItems: 2
+    description: phandles to the reset lines for both SATA bridges
+
+  reset-names:
+    items:
+      - const: sata0
+      - const: sata1
+
+  clocks:
+    minItems: 2
+    description: phandles to the compulsory peripheral clocks
+
+  clock-names:
+    items:
+      - const: SATA0_PCLK
+      - const: SATA1_PCLK
+
+  syscon:
+    minItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global Gemini system controller
+
+  cortina,gemini-ata-muxmode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+    description: |
+      Tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:
+      Mode 0: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata0 slave interface brought out on IDE pads
+      Mode 1: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata1 slave interface brought out on IDE pads
+      Mode 2: ata1 master <-> sata1
+              ata1 slave  <-> sata0
+              ata0 master and slave interfaces brought out on IDE pads
+      Mode 3: ata0 master <-> sata0
+              ata0 slave  <-> sata1
+              ata1 master and slave interfaces brought out on IDE pads
+
+  cortina,gemini-enable-ide-pins:
+    type: boolean
+    description: Enables the PATA to IDE connection.
+      The muxmode setting decides whether ATA0 or ATA1 is brought out,
+      and whether master, slave or both interfaces get brought out.
+
+  cortina,gemini-enable-sata-bridge:
+    type: boolean
+    description: Enables the PATA to SATA bridge inside the Gemnini SoC.
+      The Muxmode decides what PATA blocks will be muxed out and how.
+
+required:
+  - clocks
+  - clock-names
+  - cortina,gemini-ata-muxmode
+  - resets
+  - reset-names
+  - compatible
+  - reg
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    sata@46000000 {
+      compatible = "cortina,gemini-sata-bridge";
+      reg = <0x46000000 0x100>;
+      resets = <&rcon 26>, <&rcon 27>;
+      reset-names = "sata0", "sata1";
+      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
+               <&gcc GEMINI_CLK_GATE_SATA1>;
+      clock-names = "SATA0_PCLK", "SATA1_PCLK";
+      syscon = <&syscon>;
+      cortina,gemini-ata-muxmode = <3>;
+      cortina,gemini-enable-ide-pins;
+      cortina,gemini-enable-sata-bridge;
+    };
-- 
2.34.1

