Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6AC56202
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB81222248
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 19:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cJLRCgXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKMTg6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 14:36:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12184 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgKMTg5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 14:36:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faee05c0002>; Fri, 13 Nov 2020 11:37:00 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 19:36:56 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 13 Nov 2020 19:36:56 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
Date:   Fri, 13 Nov 2020 11:36:56 -0800
Message-ID: <1605296218-2510-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605296220; bh=DTqbNDNTrEH7FGaS+/LxLe9YlzvrV0TZBW4Le4P1oLQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=cJLRCgXzIOgI0dEfpO3P+wumUF+rW8t8P5MVhtlC4i2igQQSqs3zB5C18o+z5F9b3
         y2iZg9nSAooqFcMBTpiOkKszjhrSMq4mquRMmhCJg8UH9MRbAMa+n0ZiXt295PXZpE
         xLYzu7PU02Yw7OHOKFDQR7Q6ekQlBH39zCHydLij6QfBOJNueJPItBU7HvFPOKnpQz
         ak82GJItuKs2fqO6BsKcJny1qTIrkm0NWkJGyaTRtmp2N+hlXO3KNiCBvut2xVWgfF
         H8lTDeEL9+vbt1io1Y6i44UDJ504/sRiMH2G7tAe4QnxYS1cI/uGCffVyu3Bgnh8UJ
         y3joIjzFz0i0g==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds dt-bindings documentation for Tegra186 AHCI
controller.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
index dbbe460..f5f7326 100644
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

