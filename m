Return-Path: <SRS0=GUab=23=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE55C00523
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CB521582
	for <linux-ide@archiver.kernel.org>; Mon,  6 Jan 2020 01:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dISKWiGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgAFBmm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:42:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40316 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgAFBmm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Jan 2020 20:42:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so49297801ljk.7
        for <linux-ide@vger.kernel.org>; Sun, 05 Jan 2020 17:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9chmsIJFFcnPXoPZqXhoMG9yNnYZPSmA0/GegFR4AgY=;
        b=dISKWiGp1dnOoENE6xq992Bu0fjXWJCbwBJOzcI2wlasU4sYRntzWEoMzkOX2/ol3e
         YDNV93UM+T9M8LUjlReE3tv8sFwn5i9KWOhmzRipHeFDZdin9Eg/F/GfDSuyyWlEqbOh
         mWYrEgRzVftHLjkdHx9qL9x3yjcleruUzTXlqSorX85IGoQvVKVyoxo+CIhDT5BCtjeu
         5lqIb9vilMbXwZPnz8ZOLzHdP766D0T3pRG6Xo4DNlIiwjF8pxf+B9PWOrJiJivtU6/d
         nfWXN7HVZJj8NRJ5cDSQtH6SfMM/Wk5kXsr1NYfMMgsIbpBDLiaZlrgLqvaRes5bHnh6
         KFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9chmsIJFFcnPXoPZqXhoMG9yNnYZPSmA0/GegFR4AgY=;
        b=oXOwHNWNkJaHQFS+VPFz9tjoafaJ0pxg/w25MSIgSiuuHtWPuD97gj+YK0Sglv7J0M
         IbwcIdaTSDgCDtOyLOhGfrO+qoCstClA8UPf8hnFj61xGhBhsB2zCMY7P5hRtIMtqGn3
         nSsIZkM0/mBD+4mLhcmLq5NeO6DlFFGHcm1C5cScjdkogTCdY+ish6zjiuch777kpOtw
         0aI66xTQxg5rVGWgmlv5FXIXUcS+sKAtGrwQ/tFIvIveGoPobiY+D9xBNjWv1I73Yg2U
         z1ugSAheehfBot535ufcwAsIGRzaodvw2oCb+m7YtQ0v4bfRn8zzNbioytBVNcAhp8Xl
         qdwQ==
X-Gm-Message-State: APjAAAX+CghUKUaJ0Z3KkwvSjHmNNYhH0+F8M4JUe5POMusa6cC3hPLw
        5CeJoT98vYZ0wHxGnx/QZYa4hA==
X-Google-Smtp-Source: APXvYqwAO/UkDTtdUJ2tVUWTcRhd+zDL47nEx1Fdrit2CMkcoC8E7iOG4qhb3GMNbfcV596U49jm5A==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr53409191ljg.126.1578274959658;
        Sun, 05 Jan 2020 17:42:39 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id y8sm28377300lji.56.2020.01.05.17.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:42:39 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        device@vger.kernel.org
Subject: [PATCH 2/2 v2] dt-bindings: Convert Faraday FTIDE010 to DT schema
Date:   Mon,  6 Jan 2020 02:42:24 +0100
Message-Id: <20200106014224.12791-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106014224.12791-1-linus.walleij@linaro.org>
References: <20200106014224.12791-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This uses the new pata-sata-controller.yaml schema to
convert the Faraday FTIDE010 to DT schema.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: device@vger.kernel.org
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

