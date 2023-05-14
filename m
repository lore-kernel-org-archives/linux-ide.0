Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC9C7EE22
	for <linux-ide@archiver.kernel.org>; Sun, 14 May 2023 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjENW0S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 May 2023 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENW0S (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 May 2023 18:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790C10EF;
        Sun, 14 May 2023 15:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9249C60A69;
        Sun, 14 May 2023 22:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64084C433EF;
        Sun, 14 May 2023 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684103175;
        bh=qZPBY2YELueAw7NlsCPdq55MgAj+fENSLQw5RDolD10=;
        h=From:To:Cc:Subject:Date:From;
        b=Ahgd9lcp5n6zhgBsVCJXQ19zUhFYwQU1hRw9h6GwbX9da6rYpKbi5vWzaoprUE8C2
         F4vZVROCYXZVl2HU2EU5H2zK2OWAUr9ul5YHJ+FGcaBtT3nrb+csEbFkSTrXHPGsLx
         irNPMGNfY/ygWyGB4yf3HU77DFVGXGlEiiyQGw08w1IjfvVtMy2Rw1KJXZhhJ+OQkM
         QgG3X8vjHIkgsLejCeHWTJGbP1ebvWK8BoGQhOPheJmbXcSI9a4nn4s6tgTRSiB+9K
         sRfLE354WMXqzidOLnOOoB5F/P8Qa4oyhrclMz4ZLd1bKj1yQCdDQhmt0ZXASRoeT8
         Y5lga/AsGIcJw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH] dt-bindings: Change documentation contact email
Date:   Mon, 15 May 2023 07:26:14 +0900
Message-Id: <20230514222614.115299-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change my email address to dlemoal@kernel.org.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-common.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml    | 2 +-
 Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml          | 2 +-
 Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml    | 2 +-
 Documentation/devicetree/bindings/riscv/canaan.yaml             | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index 7fdf40954a4c..38770c4c85fd 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -8,7 +8,7 @@ title: Common Properties for Serial ATA AHCI controllers
 
 maintainers:
   - Hans de Goede <hdegoede@redhat.com>
-  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description:
   This document defines device tree properties for a common AHCI SATA
diff --git a/Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml
index 998e5cce652f..380cb6d80025 100644
--- a/Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Canaan Kendryte K210 Clock
 
 maintainers:
-  - Damien Le Moal <damien.lemoal@wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description: |
   Canaan Kendryte K210 SoC clocks driver bindings. The clock
diff --git a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
index 8459d3642205..3b3beab9db3f 100644
--- a/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Canaan Kendryte K210 System Controller
 
 maintainers:
-  - Damien Le Moal <damien.lemoal@wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description:
   Canaan Inc. Kendryte K210 SoC system controller which provides a
diff --git a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
index 7f4f36a58e56..739a08f00467 100644
--- a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Canaan Kendryte K210 FPIOA
 
 maintainers:
-  - Damien Le Moal <damien.lemoal@wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description:
   The Canaan Kendryte K210 SoC Fully Programmable IO Array (FPIOA)
diff --git a/Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml b/Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
index ee8a2dcf5dfa..0c0135964b91 100644
--- a/Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
+++ b/Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Canaan Kendryte K210 Reset Controller
 
 maintainers:
-  - Damien Le Moal <damien.lemoal@wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description: |
   Canaan Kendryte K210 reset controller driver which supports the SoC
diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index f8f3f286bd55..41fd11f70a49 100644
--- a/Documentation/devicetree/bindings/riscv/canaan.yaml
+++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Canaan SoC-based boards
 
 maintainers:
-  - Damien Le Moal <damien.lemoal@wdc.com>
+  - Damien Le Moal <dlemoal@kernel.org>
 
 description:
   Canaan Kendryte K210 SoC-based boards
-- 
2.40.1

