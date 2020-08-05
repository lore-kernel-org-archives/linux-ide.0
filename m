Return-Path: <SRS0=yqN4=BP=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D741BC433E0
	for <linux-ide@archiver.kernel.org>; Wed,  5 Aug 2020 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACADC206B6
	for <linux-ide@archiver.kernel.org>; Wed,  5 Aug 2020 07:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHEHU2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:20:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59538 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEHU1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 5 Aug 2020 03:20:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57F512003A1;
        Wed,  5 Aug 2020 09:20:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A6A1201418;
        Wed,  5 Aug 2020 09:20:20 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 03B5F40309;
        Wed,  5 Aug 2020 09:20:14 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: ata: Convert i.MX sata to json-schema
Date:   Wed,  5 Aug 2020 15:15:46 +0800
Message-Id: <1596611746-29155-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the i.MX sata binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/ata/imx-sata.txt | 37 ----------
 .../devicetree/bindings/ata/imx-sata.yaml          | 81 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-sata.txt
 create mode 100644 Documentation/devicetree/bindings/ata/imx-sata.yaml

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.txt b/Documentation/devicetree/bindings/ata/imx-sata.txt
deleted file mode 100644
index 781f887..0000000
--- a/Documentation/devicetree/bindings/ata/imx-sata.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Freescale i.MX AHCI SATA Controller
-
-The Freescale i.MX SATA controller mostly conforms to the AHCI interface
-with some special extensions at integration level.
-
-Required properties:
-- compatible : should be one of the following:
-   - "fsl,imx53-ahci" for i.MX53 SATA controller
-   - "fsl,imx6q-ahci" for i.MX6Q SATA controller
-   - "fsl,imx6qp-ahci" for i.MX6QP SATA controller
-- interrupts : interrupt mapping for SATA IRQ
-- reg : registers mapping
-- clocks : list of clock specifiers, must contain an entry for each
-  required entry in clock-names
-- clock-names : should include "sata", "sata_ref" and "ahb" entries
-
-Optional properties:
-- fsl,transmit-level-mV : transmit voltage level, in millivolts.
-- fsl,transmit-boost-mdB : transmit boost level, in milli-decibels
-- fsl,transmit-atten-16ths : transmit attenuation, in 16ths
-- fsl,receive-eq-mdB : receive equalisation, in milli-decibels
-  Please refer to the technical documentation or the driver source code
-  for the list of legal values for these options.
-- fsl,no-spread-spectrum : disable spread-spectrum clocking on the SATA
-  link.
-
-Examples:
-
-sata@2200000 {
-	compatible = "fsl,imx6q-ahci";
-	reg = <0x02200000 0x4000>;
-	interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX6QDL_CLK_SATA>,
-		 <&clks IMX6QDL_CLK_SATA_REF_100M>,
-		 <&clks IMX6QDL_CLK_AHB>;
-	clock-names = "sata", "sata_ref", "ahb";
-};
diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
new file mode 100644
index 0000000..cd94937
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/imx-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX AHCI SATA Controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The Freescale i.MX SATA controller mostly conforms to the AHCI interface
+  with some special extensions at integration level.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx53-ahci
+      - fsl,imx6q-ahci
+      - fsl,imx6qp-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: sata clock
+      - description: sata reference clock
+      - description: ahb clock
+
+  clock-names:
+    items:
+      - const: sata
+      - const: sata_ref
+      - const: ahb
+
+  fsl,transmit-level-mV:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: transmit voltage level, in millivolts.
+
+  fsl,transmit-boost-mdB:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: transmit boost level, in milli-decibels.
+
+  fsl,transmit-atten-16ths:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: transmit attenuation, in 16ths.
+
+  fsl,receive-eq-mdB:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: receive equalisation, in milli-decibels.
+
+  fsl,no-spread-spectrum:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: if present, disable spread-spectrum clocking on the SATA link.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@2200000 {
+        compatible = "fsl,imx6q-ahci";
+        reg = <0x02200000 0x4000>;
+        interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_SATA>,
+                 <&clks IMX6QDL_CLK_SATA_REF_100M>,
+                 <&clks IMX6QDL_CLK_AHB>;
+        clock-names = "sata", "sata_ref", "ahb";
+    };
-- 
2.7.4

