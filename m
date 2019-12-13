Return-Path: <SRS0=ypzH=2D=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B558FC43603
	for <linux-ide@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB7214D8
	for <linux-ide@archiver.kernel.org>; Fri, 13 Dec 2019 07:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="M5Z0fhzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xZ+B6sOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLMHto (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:49:44 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51043 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbfLMHtn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Dec 2019 02:49:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1125822784;
        Fri, 13 Dec 2019 02:49:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 02:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=mJFqAJ0C3QCpWN2iUjPkDmdFvn
        znhTzLbrbNUZFsDHk=; b=M5Z0fhzEup+SlJRpXx8Nk9814SOijbwUlJwPFXr3Fp
        UXqpw5TDvfj53uwfP5k001Y0KKkIp3sJ3cYzvL4uM/IXYvnLSwLktwJEs56LQr5u
        ONz83jKed3LKu4T/4s7I4BXg7MigZxMWmdCxPEZ+Nf0MDMxJLgncD+u4Oc53/3iU
        43jlJXMsQKMt8OY0AbZ9vrAmgzwBpvrLT1UG05t48wWpJq5dq4iqiCkeIH4teVsG
        yZnXhDz4Agl3XjSZzV/kO0lhfCFXb27UMBkO4bliuoBRhBgcxunN4EBCBmzUJQx5
        WuFaqBkVj22GilvqhuhbKm580KicthIsSZY0/U6EJ4og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mJFqAJ0C3QCpWN2iU
        jPkDmdFvnznhTzLbrbNUZFsDHk=; b=xZ+B6sOQYtZxyvToFKhUpaFvzQkiGu4k2
        D6M/OzzLo3y3zN0FMj6bGuZj5J9eK5Ul5pUQKbQa07XVXIchfOXMGf8jq02dmhUE
        X47btzYL4GBhsJRPzSamTYnNNnVvz8CAqAqqYLgvsQM5oShXYymZ7HW424A8+ASD
        RYWHPvkQVbZQ05gRqaT9d6OVUcjaBgGuXB2GFuDOreCUtX9HTX+oKh6VMNTd9sDI
        RA9qk6iDz+KRVjbkzlrJsYBxeml0XQuZ6Fx0RxjhnpBYwfbWij7ocHPyT2pNx4cE
        uFSZI+O37mrXTdNpQ26er2HxIFBzDr4SfYRsQKkliH/jR1YefStww==
X-ME-Sender: <xms:lkLzXZU9KDrpochxgUwvzHVDtY2_D3LFfhBduW93rjRu1WIZMAFpZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogevohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgi
    himhgvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdr
    ohhrghenucfkphepledtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:lkLzXQf9_gBrxN17AcTL8Ma1jJ5ZOsSrHDAgNj-2FlZd56KBp_9UfQ>
    <xmx:lkLzXduYbHuMJZUUQmKSo__iuMRC7xP9IKO5qpN5P1WKJzsRQZp-Yw>
    <xmx:lkLzXX8BF3j5y60ZmFiHgjESVUxrzH8OnQFfXiKt4SfeI7M1-RC9pw>
    <xmx:l0LzXdSX-vkhze1OcB_TTFVL9e23hD77BV-zKs4PVlnD6LXN07sjXQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B783880069;
        Fri, 13 Dec 2019 02:49:41 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        axboe@kernel.dk, linux-ide@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] dt-bindings: ata: Convert Allwinner AHCI controller to a schema
Date:   Fri, 13 Dec 2019 08:49:38 +0100
Message-Id: <20191213074938.27285-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Allwinner SoCs have a AHCI controllers that is supported in Linux, with
a matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../devicetree/bindings/ata/ahci-platform.txt | 12 ----
 .../ata/allwinner,sun4i-a10-ahci.yaml         | 47 +++++++++++++
 .../ata/allwinner,sun8i-r40-ahci.yaml         | 67 +++++++++++++++++++
 3 files changed, 114 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 55c6fab1b373..77091a277642 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -9,8 +9,6 @@ PHYs.
 
 Required properties:
 - compatible        : compatible string, one of:
-  - "allwinner,sun4i-a10-ahci"
-  - "allwinner,sun8i-r40-ahci"
   - "brcm,iproc-ahci"
   - "hisilicon,hisi-ahci"
   - "cavium,octeon-7130-ahci"
@@ -45,8 +43,6 @@ Required properties when using sub-nodes:
 - #address-cells    : number of cells to encode an address
 - #size-cells       : number of cells representing the size of an address
 
-For allwinner,sun8i-r40-ahci, the reset property must be present.
-
 Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
@@ -60,14 +56,6 @@ Examples:
 		interrupts = <115>;
         };
 
-	ahci: sata@1c18000 {
-		compatible = "allwinner,sun4i-a10-ahci";
-		reg = <0x01c18000 0x1000>;
-		interrupts = <56>;
-		clocks = <&pll6 0>, <&ahb_gates 25>;
-		target-supply = <&reg_ahci_5v>;
-	};
-
 With sub-nodes:
 	sata@f7e90000 {
 		compatible = "marvell,berlin2q-achi", "generic-ahci";
diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
new file mode 100644
index 000000000000..cb530b46beff
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/allwinner,sun4i-a10-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 AHCI SATA Controller bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  compatible:
+    const: allwinner,sun4i-a10-ahci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHCI Bus Clock
+      - description: AHCI Module Clock
+
+  interrupts:
+    maxItems: 1
+
+  target-supply:
+    description: Regulator for SATA target power
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ahci: sata@1c18000 {
+        compatible = "allwinner,sun4i-a10-ahci";
+        reg = <0x01c18000 0x1000>;
+        interrupts = <56>;
+        clocks = <&pll6 0>, <&ahb_gates 25>;
+        target-supply = <&reg_ahci_5v>;
+    };
diff --git a/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.yaml b/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.yaml
new file mode 100644
index 000000000000..e74d609be3cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/allwinner,sun8i-r40-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner R40 AHCI SATA Controller bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  compatible:
+    const: allwinner,sun8i-r40-ahci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHCI Bus Clock
+      - description: AHCI Module Clock
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    description: AHCI Reset Line
+
+  reset-names:
+    const: ahci
+
+  ahci-supply:
+    description: Regulator for the AHCI controller
+
+  phy-supply:
+    description: Regulator for the SATA PHY power
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun8i-r40-ccu.h>
+    #include <dt-bindings/reset/sun8i-r40-ccu.h>
+
+    ahci: sata@1c18000 {
+        compatible = "allwinner,sun8i-r40-ahci";
+        reg = <0x01c18000 0x1000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+        resets = <&ccu RST_BUS_SATA>;
+        reset-names = "ahci";
+        ahci-supply = <&reg_dldo4>;
+        phy-supply = <&reg_eldo3>;
+    };
+
+...
-- 
2.23.0

