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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042DC64E75
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6370520715
	for <linux-ide@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SA4t3Q7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgKWURX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:17:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2130 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733206AbgKWURW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2020 15:17:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc18d80001>; Mon, 23 Nov 2020 12:17:28 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:17:22 +0000
Received: from skomatineni-linux.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Nov 2020 20:17:21 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
Date:   Mon, 23 Nov 2020 12:17:23 -0800
Message-ID: <1606162645-22326-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
References: <1606162645-22326-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606162648; bh=HuoDnHcnGhEevhf1Zh/7gdjVQApYfl/WHCoySUA+VnE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=SA4t3Q7JCHtrQp4YzKIBDBPjjJyWdGfYwF0yD+B6co/GZ7KAqALhkl3EiYHlYdQEB
         EPxMNZvbuZtMdUEGD9whFDtljTJaIv9A6qWDR9onlSorSmiPKoY9YTcE9k1nmAfE+i
         a3IbOiM4T3j70CHkK0bk82GVRUPVj0PcMmExTui/4d0PZYnjQ/OmCx6vNKEcwCXBdm
         Qh5JynvFhCxb8kP245gnRjflO7pJcnW7JRzwg/OI10++LL5ouav4S9d2N6T95E2uZj
         dsfdeyc/f+zJ2xCy4YbzzJVqomv7QeGOU4oMtMGbTwalvqXkLp7QfFtFh78jMHupZ3
         O4qUUePh20V0w==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds dt-bindings documentation for Tegra186 AHCI
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
index 3c15aea..a75e9a8 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -16,6 +16,7 @@ properties:
       - nvidia,tegra124-ahci
       - nvidia,tegra132-ahci
       - nvidia,tegra210-ahci
+      - nvidia,tegra186-ahci
 
   reg:
     minItems: 2
@@ -37,14 +38,31 @@ properties:
     maxItems: 2
 
   reset-names:
+    minItems: 2
     items:
       - const: sata
       - const: sata-cold
       - const: sata-oob
 
   resets:
+    minItems: 2
     maxItems: 3
 
+  iommus:
+    maxItems: 1
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  interconnects:
+    maxItems: 2
+
+  power-domains:
+    items:
+      - description: SAX power-domain
+
   phy-names:
     items:
       - const: sata-0
@@ -114,6 +132,26 @@ allOf:
         resets:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-ahci
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reset-names:
+          maxItems: 2
+        resets:
+          maxItems: 2
+      required:
+        - iommus
+        - interconnect-names
+        - interconnects
+        - power-domains
+
 additionalProperties: true
 
 examples:
-- 
2.7.4

