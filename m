From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH  1/2] dt-bindings: ata: ahci_tegra: Add tegra210 AHCI support
Date: Wed, 19 Oct 2016 23:45:55 +0530
Message-ID: <1476900956-23719-2-git-send-email-pchandru@nvidia.com>
References: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:49077 "EHLO
        hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S944546AbcJSSRC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 14:17:02 -0400
In-Reply-To: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, swarren@wwwdotorg.org, thierry.reding@gmail.com, preetham260@gmail.com
Cc: ldewangan@nvidia.com, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
 .../bindings/ata/nvidia,tegra124-ahci.txt          | 48 ++++++++++++++++------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
index 66c83c3..446214f 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
@@ -1,9 +1,9 @@
-Tegra124 SoC SATA AHCI controller
+Tegra SoC SATA AHCI controller
 
 Required properties :
-- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwise,
-  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip>
-  is tegra132.
+- compatible : Must be one of:
+  - Tegra124 : "nvidia,tegra124-ahci"
+  - Tegra210 : "nvidia,tegra210-ahci"
 - reg : Should contain 2 entries:
   - AHCI register set (SATA BAR5)
   - SATA register set
@@ -13,8 +13,6 @@ Required properties :
 - clock-names : Must include the following entries:
   - sata
   - sata-oob
-  - cml1
-  - pll_e
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
@@ -24,9 +22,35 @@ Required properties :
 - phys : Must contain an entry for each entry in phy-names.
   See ../phy/phy-bindings.txt for details.
 - phy-names : Must include the following entries:
-  - sata-phy : XUSB PADCTL SATA PHY
-- hvdd-supply : Defines the SATA HVDD regulator
-- vddio-supply : Defines the SATA VDDIO regulator
-- avdd-supply : Defines the SATA AVDD regulator
-- target-5v-supply : Defines the SATA 5V power regulator
-- target-12v-supply : Defines the SATA 12V power regulator
+  - For T124:
+    - sata-phy : XUSB PADCTL SATA PHY
+  - For T210:
+    - sata-0
+- For T124:
+  - hvdd-supply : Defines the SATA HVDD regulator
+  - vddio-supply : Defines the SATA VDDIO regulator
+  - avdd-supply : Defines the SATA AVDD regulator
+  - target-5v-supply : Defines the SATA 5V power regulator
+- For T210:
+  - l0-hvddio-sata-supply : Defines the SATA HVDDIO regulator
+  - l0-dvddio-sata-supply : Defines the SATA DVDDIO regulator
+  - hvdd-pex-pll-e-supply : Defines the PEX PLL_E regulator
+  - dvdd-sata-pll-supply  : Defines the SATA PLL regulator
+  - hvdd-sata-supply      : Defines the SATA HVDD regulator
+- nvidia,disable-features : Must include the following entries:
+  - devslp
+  - dipm
+
+Optional properties:
+- clock-names :
+  - cml1 :
+    cml1 clock is required by phy so it is optional to define
+    here as phy driver will be enabling this clock.
+  - pll_e :
+    pll_e is the parent of cml1 clock so it is optional to define
+    here as phy driver will be enabling this clock.
+- nvidia,disable-features :
+  - hipm
+  - ncq
+  - partial
+  - slumber
-- 
2.1.4

