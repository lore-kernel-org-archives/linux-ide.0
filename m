Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08130C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jan 2022 08:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiAaIOf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jan 2022 03:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiAaIOe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jan 2022 03:14:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C36C061714
        for <linux-ide@vger.kernel.org>; Mon, 31 Jan 2022 00:14:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f17so23752990wrx.1
        for <linux-ide@vger.kernel.org>; Mon, 31 Jan 2022 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg5fXn15IhK+/P0Jol3gdVtWDSJ61JNmTIm53AdAK/k=;
        b=4LxFmTLwWkrOWwgG1Y6ntsgZWZwAOZTmupyqDvK4IPgpb+py5MNhN7pxL/KokMrVlf
         kSGOvWlXBPtemE5HkeffCYS2Re5PppgXXfzQsk48zslbf8SQlIh63Rf3QsqpxJikrhYL
         o1dt/XgbQXVZzEgcdU7izGgVECLtiG9oEeYCP4C8sCjnfl25RxNbMjSwlJu6JJAex5G3
         Nuj+0VTcBeFR9rjGAD2hxN6RDm3oW18F+sY4Ek0mFp9O5yU1el875WBsr4D60j8UJjqu
         WUlY4uiH48Y5V2bbTOKUWtik7XEGqcpzhAB/1JNp9KNQh9g9lX3wdTScYLd5DPCpAvuX
         kkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg5fXn15IhK+/P0Jol3gdVtWDSJ61JNmTIm53AdAK/k=;
        b=oQR3x4uenRkl4yKhelgn4rdfQRqGmVApbvAZn+1vRSdDSGnz8Jxupt3h1Lv5giN7fP
         XJtSwIn4T8IVkJij/xeb35ngj0GAXoyAnCB7X84PLF+u11YPS0LwGNEqkeR2vlV6H07o
         SZlcNV0eADuLVrcXqmwyPyYiHuz2JaaSoOzS/9rBQbIzHwUZELiaEl2g5OGsKvQD6RrQ
         hupshDpQVx42QamuXkQHbbX7yW5P6nuceYuFtQ/7+u4KK+9S3MQGqznvt0i57VeGeq1e
         A45xpLpiopEqNW8aoJOmNfGKOv3/U+04e1uXLsM1bF56EEPw39/RXQ2tiFV9CYCdMR47
         orZg==
X-Gm-Message-State: AOAM533S/yLHlx3JOaqr6Fe4CN2WQ+kKZy+GRxqfsIixvQXWVEHYOECI
        YSLzMLDqpbV0UC+vZGcBHbP0Sw==
X-Google-Smtp-Source: ABdhPJy9awOmH+YltRFzK9gvP9YhaiAtrC/K76tTgNaBKxk8RftIMPMtOdnzdf/b9O2MQozbECO7tA==
X-Received: by 2002:a5d:4888:: with SMTP id g8mr16219617wrq.65.1643616872530;
        Mon, 31 Jan 2022 00:14:32 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n11sm9959600wms.3.2022.01.31.00.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 00:14:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     damien.lemoal@opensource.wdc.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] dt-bindings: convert ata/cortina,gemini-sata-bridge to yaml
Date:   Mon, 31 Jan 2022 08:14:27 +0000
Message-Id: <20220131081427.1780897-1-clabbe@baylibre.com>
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

 .../ata/cortina,gemini-sata-bridge.txt        | 55 -----------
 .../ata/cortina,gemini-sata-bridge.yaml       | 99 +++++++++++++++++++
 2 files changed, 99 insertions(+), 55 deletions(-)
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
index 000000000000..59ccbc83361c
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
@@ -0,0 +1,99 @@
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
+    const: "cortina,gemini-sata-bridge"
+  reg:
+    minItems: 1
+  resets:
+    minItems: 2
+    description: phandles to the reset lines for both SATA bridges
+  reset-names:
+    items:
+      - const: "sata0"
+      - const: "sata1"
+  clocks:
+    minItems: 2
+    description: phandles to the compulsory peripheral clocks
+  clock-names:
+    items:
+      - const: "SATA0_PCLK"
+      - const: "SATA1_PCLK"
+  syscon:
+    minItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global Gemini system controller
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
+                 The muxmode setting decides whether ATA0 or ATA1 is brought out,
+                 and whether master, slave or both interfaces get brought out.
+  cortina,gemini-enable-sata-bridge:
+    type: boolean
+    description: Enables the PATA to SATA bridge inside the Gemnini SoC.
+                 The Muxmode decides what PATA blocks will be muxed out and how.
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
+    sata: sata@46000000 {
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

