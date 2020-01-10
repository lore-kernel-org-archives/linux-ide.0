Return-Path: <SRS0=xOnl=27=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCBBC33CA2
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639192072A
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jan 2020 08:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skq8ltOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgAJIPN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:15:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36948 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgAJIPN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jan 2020 03:15:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so1201069ljg.4
        for <linux-ide@vger.kernel.org>; Fri, 10 Jan 2020 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgBAA26YSmvqOQUXo77H/YHA2sgAeLttOgWtV78OrVM=;
        b=skq8ltOJVTP+GvSkiER6qztqVtoRvig5AuVl05qGh+a2i+n7mk50686F/ChgctC9uO
         xAay+vEdK9JtDr1oGEYNjDkDjB4owDI+zv01kKh8aqj8/pW00JgrWTFGkixmUNJxZCXJ
         m2S51N5X/g6yBPX+E+PXiiQdJ0+CyC6HqbsKQBF8rkioSVIznuUb6NCAPplPGFuXE0Aq
         AOPclZIS9sfW+z/CvbIfRE/NCmCANxB5OUtaQEp70Z+tJMjtj2Q+PiBBHxmWZbV1mHTZ
         sgB0K+a5kbUeDy4ZEAHN7mF2cHCZILO7fAlsog33WxiQfbjOVNbzdfZdq5yXuDVkGklo
         dW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgBAA26YSmvqOQUXo77H/YHA2sgAeLttOgWtV78OrVM=;
        b=t3k2St9OGPCi2PC/a0TjsD1ZnTdbFrgpT7gE4YR7pWSkAxkFF5w/IcAZ4XfR6XDdMv
         uU6CCoLcU7ZFU+nYa94g0ILIYTv7e3IifpAylYSsjB+TPxdxZA+EOnfAUTrsGYblGk4B
         nEKFkgGjPRHTBQ+LWFGvDMlQa9EtpwdXgASSTMM14FGRL4ANxdodoowaLQEHP3fuImw8
         b73a0BnARBBJkblpPb2+8h7uDc4vXjsjML0Y4hqhPUkvqAGC2lP8tOe4cBlhwKU7LnJw
         GDZHpIghoenFN2/bGqjG1RLDtWfBOpSbaaR+sfilaXspSs+m3hQvVHWMVSvFpvbg5poz
         RY5g==
X-Gm-Message-State: APjAAAWj9L/+mkLs7qxyd0GXebMO6+Vtg1PYpzkRaavTAI20gNDKEk4X
        jJ92mubXKQwITV+NvS7Z7DsVmQ==
X-Google-Smtp-Source: APXvYqzGLxatgljJ/feU2uNk9/NiI44HjHEGXnYpfo7WgmsW+aoAhqoscfWqU6bFXCPFBSCCirrmBg==
X-Received: by 2002:a2e:8698:: with SMTP id l24mr1791134lji.94.1578644110045;
        Fri, 10 Jan 2020 00:15:10 -0800 (PST)
Received: from linux.local (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id r15sm592496ljh.11.2020.01.10.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:15:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v3] dt-bindings: Convert Faraday FTIDE010 to DT schema
Date:   Fri, 10 Jan 2020 09:14:11 +0100
Message-Id: <20200110081411.9806-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110081411.9806-1-linus.walleij@linaro.org>
References: <20200110081411.9806-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This uses the new pata-common.yaml schema to
convert the Faraday FTIDE010 to DT schema.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on the new common binding for just PATA
  controllers.
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
index 000000000000..bfc6357476fd
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
+  - $ref: pata-common.yaml#
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

