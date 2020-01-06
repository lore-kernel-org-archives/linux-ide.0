Return-Path: <SRS0=GUab=23=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F6C00523
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51102072C
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stOruzXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgAFBxF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:53:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39451 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgAFBxF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Jan 2020 20:53:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so35339073lfb.6
        for <linux-ide@vger.kernel.org>; Sun, 05 Jan 2020 17:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iD+50azB+tBKY9G51G0/uhlJUSlWLQtRjkrA1mNR5YY=;
        b=stOruzXeJyJ/iE3IWrf9S/Cd2tR8jd2uiRl9BelOJJzATVGY+EwgRN7zdChxXra/3a
         WzLGlNiBdQS7iHYgL9imf5adLfJgc0JD9VzJhNPhOxlwoKhZ18ygZMVCpX3b/Cgco9yu
         Mo1AiiazwDJf+MxlfxwzeFnHBsWtJXQhIB9sqb5l9lHXz8QmcsegEsMqNoJV/CxscDhM
         gFkNRUd6U/ThpkgZyI70UTPBhxkMV4YoNFq/h5X4QVysEI8w/o4ADhUJHb8h2TNbb5gB
         BLoacIOt9Al3CKrbwv/46H7MnBZbRX5QeUWswo0xBE/o43u2daBvCQzoCjNi9rhIC//t
         HD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iD+50azB+tBKY9G51G0/uhlJUSlWLQtRjkrA1mNR5YY=;
        b=emDDe9Rbx2Xp7Dqa0YRd/q6kufZTiWcNh/oG9p48d/JGUFSuNlcoDse9Yx1VMx5Es3
         q4bPDP4avsMohJ+Su4F3M0h30dXY621WJC17AEoYsQ4Il8SxqqunDZWWNietV9ptUD0W
         sXLtJa++yS7ONb+YjR1ooiE2/WY7/ItrbXuST48JtHrkwrO5R1sHy1FYW4cbTWlyEVjU
         /11KkHGfmXLPXxFk8FMJiwXGApxIwebY5Na0i1/yQOnykQXkQ/yKIPddds+4K7T22tAO
         KrmAazAPjcQrKHPMULCLr/69ryt7QbWVEajYKYWuyayi9vzXX6mY9S7+WMvKXqNxcdhI
         BSug==
X-Gm-Message-State: APjAAAU6Rm/omtIDr+NbBsG5sL0nFecK7Y1hBxTole6u0LAalm5B/gbI
        h9STBkpUrCao0RiErUES095sYA==
X-Google-Smtp-Source: APXvYqyQsSVL56NAprHy8ONdVeBhui2YsYjZVSScZMAt+kEwr25M7JfCOcTjn2UDxwdNN0NSjx24ug==
X-Received: by 2002:ac2:5582:: with SMTP id v2mr15879998lfg.183.1578275582860;
        Sun, 05 Jan 2020 17:53:02 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id v26sm28389374lfq.73.2020.01.05.17.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:53:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v2] dt-bindings: Convert Faraday FTIDE010 to DT schema
Date:   Mon,  6 Jan 2020 02:52:56 +0100
Message-Id: <20200106015256.13194-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This uses the new pata-sata-controller.yaml schema to
convert the Faraday FTIDE010 to DT schema.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename the node for the example controller to "ide@"
- Rename the drives to ports, so ide-port@0 etc instead of
  drive@0.
---
 .../bindings/ata/faraday,ftide010.txt         | 38 --------
 .../bindings/ata/faraday,ftide010.yaml        | 89 +++++++++++++++++++
 2 files changed, 89 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
 create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.yaml

diff --git a/Documentation/devicetree/bindings/ata/faraday,ftide010.txt b/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
deleted file mode 100644
index a0c64a29104d..000000000000
--- a/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Faraday Technology FTIDE010 PATA controller
-
-This controller is the first Faraday IDE interface block, used in the
-StorLink SL2312 and SL3516, later known as the Cortina Systems Gemini
-platform. The controller can do PIO modes 0 through 4, Multi-word DMA
-(MWDM)modes 0 through 2 and Ultra DMA modes 0 through 6.
-
-On the Gemini platform, this PATA block is accompanied by a PATA to
-SATA bridge in order to support SATA. This is why a phandle to that
-controller is compulsory on that platform.
-
-The timing properties are unique per-SoC, not per-board.
-
-Required properties:
-- compatible: should be one of
-  "cortina,gemini-pata", "faraday,ftide010"
-  "faraday,ftide010"
-- interrupts: interrupt for the block
-- reg: registers and size for the block
-
-Optional properties:
-- clocks: a SoC clock running the peripheral.
-- clock-names: should be set to "PCLK" for the peripheral clock.
-
-Required properties for "cortina,gemini-pata" compatible:
-- sata: a phande to the Gemini PATA to SATA bridge, see
-  cortina,gemini-sata-bridge.txt for details.
-
-Example:
-
-ata@63000000 {
-	compatible = "cortina,gemini-pata", "faraday,ftide010";
-	reg = <0x63000000 0x100>;
-	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&gcc GEMINI_CLK_GATE_IDE>;
-	clock-names = "PCLK";
-	sata = <&sata>;
-};
diff --git a/Documentation/devicetree/bindings/ata/faraday,ftide010.yaml b/Documentation/devicetree/bindings/ata/faraday,ftide010.yaml
new file mode 100644
index 000000000000..f7b9b625c0f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/faraday,ftide010.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/faraday,ftide010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTIDE010 PATA controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This controller is the first Faraday IDE interface block, used in the
+  StorLink SL3512 and SL3516, later known as the Cortina Systems Gemini
+  platform. The controller can do PIO modes 0 through 4, Multi-word DMA
+  (MWDM) modes 0 through 2 and Ultra DMA modes 0 through 6.
+
+  On the Gemini platform, this PATA block is accompanied by a PATA to
+  SATA bridge in order to support SATA. This is why a phandle to that
+  controller is compulsory on that platform.
+
+  The timing properties are unique per-SoC, not per-board.
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,ftide010
+      - items:
+        - const: cortina,gemini-pata
+        - const: faraday,ftide010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    const: PCLK
+
+  sata:
+    description:
+      phandle to the Gemini PATA to SATA bridge, if available
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: pata-sata-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cortina,gemini-pata
+
+    then:
+      required:
+        - sata
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+
+    ide@63000000 {
+      compatible = "cortina,gemini-pata", "faraday,ftide010";
+      reg = <0x63000000 0x100>;
+      interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&gcc GEMINI_CLK_GATE_IDE>;
+      clock-names = "PCLK";
+      sata = <&sata>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ide-port@0 {
+        reg = <0>;
+      };
+      ide-port@1 {
+        reg = <1>;
+      };
+    };
+
+...
-- 
2.21.0

