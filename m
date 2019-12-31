Return-Path: <SRS0=b2kW=2V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA2C2D0C2
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B69C206DB
	for <linux-ide@archiver.kernel.org>; Tue, 31 Dec 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpsqTVOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLaRZM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Dec 2019 12:25:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfLaRZL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2019 12:25:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so27385788lfm.5
        for <linux-ide@vger.kernel.org>; Tue, 31 Dec 2019 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfsW3RUqmm/72dG11g9WAVGCUYY87NQrPwAvjG+FAtQ=;
        b=XpsqTVOBlVSZBnmN/YNvyt2AnhiG8XFh3zasQySOFZgn2QK8mLXa5cQaP1lSLaAzMi
         t8f6fhwvARcymcAanndNLA00kee16kM22/ZEpG4J8kD2MOzMCvZiRTNXuRQV2UrfFz3r
         MHITETyi3Sjtp3Ah/3N1xjoHK4lJ95260E8DoDSuObK+fcsu5PNSn37dMBRl2qXiGjw2
         6hPVCPeaH6Vt4udGvBt6YGI3eYoLZ06UEOJ8Xhndt8aFPxBbrAQFCmKH0lnuicaGe3vT
         KFnFCtywlONYSenB93XFdE51/NwUjBvAlh/K2OokkRZicPVz//zQaNpsgtsqnKLlk1kS
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfsW3RUqmm/72dG11g9WAVGCUYY87NQrPwAvjG+FAtQ=;
        b=DdxkP6vBMavBU/rX/AyOayzV7rMRYFC/eWdnluMdU37tPt7fdEdHY9d3g1yuVOi/pY
         xvSa7ABSA40v2smvAA+nAW3aLveSH8msMXsUk9p5Im0x22IhSKo7kIUZvwzTpRGYDmC7
         /qfM0SSlMf1YEGhup63l/4UuJWmgtoI0yteHnksEH1g9ssC93QP3ff6blGzjhZsFlcVF
         yq/kSKAgzW0qn+liHs66EdQWa+rZfauvpmhcWX24egdZS3BJsxXlX1pYgdh9HgnYbF22
         GfOmgrtiLyZFRyHGICxscLKQYNVs+7NrKwBKhLo2ZhkkHwNGVMR+jeevo9HbgumqHpYp
         WjMw==
X-Gm-Message-State: APjAAAUQ1RNRlKqZH6R091ymbh362720IokOKnbpdoQzhKjVbqEusVEe
        Gl52a9lC+MPyvuIr3hAB+2dB1w==
X-Google-Smtp-Source: APXvYqzI2BeV4Lak3m84HE1MJwkwyNnwfHdnCTF541buzJ56jhmNHVFPPY5c+sMBNMRRo7tuNSEIQQ==
X-Received: by 2002:ac2:51de:: with SMTP id u30mr41227104lfm.69.1577813109720;
        Tue, 31 Dec 2019 09:25:09 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id z11sm16991572ljc.97.2019.12.31.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 09:25:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        device@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: Convert Faraday FTIDE010 to DT schema
Date:   Tue, 31 Dec 2019 18:24:58 +0100
Message-Id: <20191231172458.25984-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191231172458.25984-1-linus.walleij@linaro.org>
References: <20191231172458.25984-1-linus.walleij@linaro.org>
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
index 000000000000..65be218382e4
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
+    pata-controller@63000000 {
+      compatible = "cortina,gemini-pata", "faraday,ftide010";
+      reg = <0x63000000 0x100>;
+      interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&gcc GEMINI_CLK_GATE_IDE>;
+      clock-names = "PCLK";
+      sata = <&sata>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      drive@0 {
+        reg = <0>;
+      };
+      drive@1 {
+        reg = <1>;
+      };
+    };
+
+...
-- 
2.21.0

