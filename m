Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B47FC6379F
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F8C206E5
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qSSVc4kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgKWURi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:17:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18763 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbgKWURV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:17:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d20002>; Mon, 23 Nov 2020 12:17:22 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:21 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:20 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] dt-bindings: ata: tegra: Convert binding documentation to YAML
Date:   Mon, 23 Nov 2020 12:17:22 -0800
Message-ID: <1606162645-22326-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162642; bh=wlJFnUwU5HKWWHpUe0MiGg5G/qDVWBP57wxnM35kaw8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=qSSVc4kYKYDkTWQpF/UI/hfTO7OwRMVz80zW1uHjHYXk6Xy/MArRY5PBeJIMylD/6
         sM7CvuaD9y2Gy/ZP9OK6W/CtXwslP2/hsEzJzoySYXusRkVBf85hVIWHJsW98zQVMV
         sWtLlarcB6vUrlqTaxS0kkD4xVcJIhUVXIXGr/kAJkVvevYsBvIqFwIu99+nCEWucf
         osXIKBG4mPlds12bK9ziF+NxNsPsvbkO2IHKHK3oR4T5uL8NtoM9J7JqyiuVQpdbWj
         cPqsFRRhCDtc1NLQ0t1cE9AasiVGKRPvzpVNRItit0IPTR3A13fWWsiIlbfaTbcvHc
         TGIyWoMwi5DoQ==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch converts text based dt-binding document to YAML based
dt-binding document.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 138 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
 2 files changed, 138 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
new file mode 100644
index 0000000..3c15aea
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra AHCI SATA Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra124-ahci
+      - nvidia,tegra132-ahci
+      - nvidia,tegra210-ahci
+
+  reg:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: AHCI registers
+      - description: SATA configuration and IPFS registers
+      - description: SATA AUX registers
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sata
+      - const: sata-oob
+
+  clocks:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: sata
+      - const: sata-cold
+      - const: sata-oob
+
+  resets:
+    maxItems: 3
+
+  phy-names:
+    items:
+      - const: sata-0
+
+  phys:
+    maxItems: 1
+
+  hvdd-supply:
+    description: SATA HVDD regulator supply.
+
+  vddio-supply:
+    description: SATA VDDIO regulator supply.
+
+  avdd-supply:
+    description: SATA AVDD regulator supply.
+
+  target-5v-supply:
+    description: SATA 5V power regulator supply.
+
+  target-12v-supply:
+    description: SATA 12V power regulator supply.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-ahci
+              - nvidia,tegra132-ahci
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reset-names:
+          minItems: 3
+        resets:
+          minItems: 3
+      required:
+        - phys
+        - phy-names
+        - hvdd-supply
+        - vddio-supply
+        - avdd-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-ahci
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reset-names:
+          minItems: 3
+        resets:
+          minItems: 3
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/reset/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@70020000 {
+            compatible = "nvidia,tegra210-ahci";
+            reg = <0x70027000 0x00002000>, /* AHCI */
+                  <0x70020000 0x00007000>, /* SATA */
+                  <0x70001100 0x00010000>; /* SATA AUX */
+            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&tegra_car TEGRA210_CLK_SATA>,
+                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
+            clock-names = "sata", "sata-oob";
+            resets = <&tegra_car 124>,
+                     <&tegra_car 129>,
+                     <&tegra_car 123>;
+            reset-names = "sata", "sata-cold", "sata-oob";
+    };
diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
deleted file mode 100644
index 12ab2f7..0000000
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Tegra SoC SATA AHCI controller
-
-Required properties :
-- compatible : Must be one of:
-  - Tegra124 : "nvidia,tegra124-ahci"
-  - Tegra132 : "nvidia,tegra132-ahci", "nvidia,tegra124-ahci"
-  - Tegra210 : "nvidia,tegra210-ahci"
-- reg : Should contain 2 entries:
-  - AHCI register set (SATA BAR5)
-  - SATA register set
-- interrupts : Defines the interrupt used by SATA
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - sata
-  - sata-oob
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - sata
-  - sata-oob
-  - sata-cold
-- phys : Must contain an entry for each entry in phy-names.
-  See ../phy/phy-bindings.txt for details.
-- phy-names : Must include the following entries:
-  - For Tegra124 and Tegra132:
-    - sata-phy : XUSB PADCTL SATA PHY
-- For Tegra124 and Tegra132:
-  - hvdd-supply : Defines the SATA HVDD regulator
-  - vddio-supply : Defines the SATA VDDIO regulator
-  - avdd-supply : Defines the SATA AVDD regulator
-  - target-5v-supply : Defines the SATA 5V power regulator
-  - target-12v-supply : Defines the SATA 12V power regulator
-
-Optional properties:
-- reg :
-  - AUX register set
-- clock-names :
-  - cml1 :
-    cml1 clock should be defined here if the PHY driver
-    doesn't manage them. If it does, they should not be.
-- phy-names :
-  - For T210:
-    - sata-phy
-- 
2.7.4

