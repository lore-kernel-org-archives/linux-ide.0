Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E05C77B71
	for <linux-ide@archiver.kernel.org>; Thu, 13 Apr 2023 18:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDMSXy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMSXx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2023 14:23:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BD59FF;
        Thu, 13 Apr 2023 11:23:52 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57910660321D;
        Thu, 13 Apr 2023 19:23:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681410231;
        bh=KE/Qh2dz/391cip/CPeIBTyPxaiySIGR7XU//jF9HQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLL+poNly6f3IBlk3AcHxjpOJ8gIQE2cGE4I6Xg1ZFICMpx1DyZUTlpHA+IUtO4hJ
         kCZbWdMjfXNjAgcx/JbDOatnmGbyWSZXPW5qG54p7HUJHRqE4deVIBld/FouDB2Ki0
         M0uO0E06O/+8f+ROutsz3y42AeShpdj/HORVnBWjn/5K9k91zRQ/TC//tvP8w11COD
         HKG7PivvGp93lzC9lqw6xk+mIOIX7gaIG1/yBJQ3XVUWflmgBdxsASaN2clW4zfaq3
         sxyPYMDcFM80u21UXU2UzLqLucuLRXRoCz2siDHI/1q5EvtMuOCp9dd4xROp6dRgGK
         68pN6ewd0rHMA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8CA424807EF; Thu, 13 Apr 2023 20:23:48 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 2/5] dt-bindings: ata: ahci: add RK3588 AHCI controller
Date:   Thu, 13 Apr 2023 20:23:42 +0200
Message-Id: <20230413182345.92557-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413182345.92557-1-sebastian.reichel@collabora.com>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Just like RK3568, the RK3588 has a DWC based AHCI controller.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
FWIW IDK what exactly the ASIC clock is. The TRM does not provide any
details unfortunately. It is required for functional SATA, though.
---
 .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml       | 6 ++++--
 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml    | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
index c1457910520b..0df8f49431eb 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
@@ -31,11 +31,11 @@ properties:
       PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
       clock, etc.
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
     items:
       oneOf:
         - description: Application APB/AHB/AXI BIU clock
@@ -50,6 +50,8 @@ properties:
           const: rxoob
         - description: SATA Ports reference clock
           const: ref
+        - description: Rockchip ASIC clock
+          const: asic
 
   resets:
     description:
diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
index 5afa4b57ce20..c6a0d6c8b62c 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -23,9 +23,11 @@ properties:
         const: snps,dwc-ahci
       - description: SPEAr1340 AHCI SATA device
         const: snps,spear-ahci
-      - description: Rockhip RK3568 AHCI controller
+      - description: Rockhip AHCI controller
         items:
-          - const: rockchip,rk3568-dwc-ahci
+          - enum:
+              - rockchip,rk3568-dwc-ahci
+              - rockchip,rk3588-dwc-ahci
           - const: snps,dwc-ahci
 
 patternProperties:
-- 
2.39.2

