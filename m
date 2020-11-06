Return-Path: <SRS0=A6T3=EM=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BDC4742C
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 02:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B692072E
	for <linux-ide@archiver.kernel.org>; Fri,  6 Nov 2020 02:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OJbUVBI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFCQJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:16:09 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9186 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgKFCQJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2020 21:16:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4b1ec0002>; Thu, 05 Nov 2020 18:16:12 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 02:16:08 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 02:16:08 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/4] dt-bindings: ata: tegra: Convert binding documentation to YAML
Date:   Thu, 5 Nov 2020 18:16:05 -0800
Message-ID: <1604628968-1501-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
References: <1604628968-1501-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604628972; bh=Y0gfu4oFjOlbeIFVzhHvOaFOiOI+h4jTM3OnjcXID+g=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=OJbUVBI6ru0uW/GTGP9lA3C9FGNxOEzMtEsq04I8jCBk//pXCGlPk5cQvGwVE4IlF
         jIYJ+hezTvW6Ra6z749Fqdc+kyOye9hyfrO5Je4P7s9YJsdha+h7i7k/hZ6WguBtzS
         UZIQMO1ROYx94MvMxMRppWlidfCY7zFApe/8qsXQOOP5YpxtgXppCfYCzSqrZCFPrt
         6d8+GCmu8LLMHWYwBGlBpOSwRBpSf0zVxl7znGNcBim0G0Ty9jFaIoVcXJPdkhFe/A
         rBgGHSGQI+IBQ+TE9voyLcSBmTCT2VwC+6WLwZ041ztB9OwJxeCBG/8ll14C3slnd2
         Io/q6ifAL1Vhg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch converts text based dt-binding document to YAML based
dt-binding document.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 152 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
 2 files changed, 152 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
new file mode 100644
index 0000000..ac20f6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -0,0 +1,152 @@
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
+    maxItems: 2
+    items:
+      - const: sata
+      - const: sata-oob
+
+  clocks:
+    maxItems: 2
+    description:
+      Must contain an entry for each entry in clock-names.
+      See ../clocks/clock-bindings.txt for details.
+
+  reset-names:
+    maxItems: 3
+
+  resets:
+    maxItems: 3
+    description:
+      Must contain an entry for each entry in reset-names.
+      See ../reset/reset.txt for details.
+
+  phy-names:
+    items:
+      - const: sata-0
+
+  phys:
+    maxItems: 1
+    description:
+      Must contain an entry for each entry in phy-names.
+      See ../phy/phy-bindings.txt for details.
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
+          items:
+            - const: sata
+            - const: sata-oob
+            - const: sata-cold
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
+          items:
+            - const: sata
+            - const: sata-oob
+            - const: sata-cold
+        resets:
+          minItems: 3
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/reset/tegra210-car.h>
+
+    sata@70020000 {
+            compatible = "nvidia,tegra210-ahci";
+            reg = <0x0 0x70027000 0x0 0x00002000>, /* AHCI */
+                  <0x0 0x70020000 0x0 0x00007000>, /* SATA */
+                  <0x0 0x70001100 0x0 0x00010000>; /* SATA AUX */
+            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&tegra_car TEGRA210_CLK_SATA>,
+                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
+            clock-names = "sata", "sata-oob";
+            resets = <&tegra_car 124>,
+                     <&tegra_car 123>,
+                     <&tegra_car 129>;
+            reset-names = "sata", "sata-oob", "sata-cold";
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

