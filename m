From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V3 2/3] dt-bindings: tegra: Add tegra210 AHCI
Date: Fri, 12 May 2017 15:04:09 +0530
Message-ID: <1494581650-11115-3-git-send-email-pchandru@nvidia.com>
References: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2472 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755209AbdELJfY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 May 2017 05:35:24 -0400
In-Reply-To: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org
Cc: tegra@vger.kernel.org, linux-ide@vger.kernel.org, ldewangan@nvidia.com, preetham260@gmail.com, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
v3:
* Add AUX register.
v2:
* change cml1, pll_e and phy regulators as optional
  for T210.
---
 .../bindings/ata/nvidia,tegra124-ahci.txt          | 45 +++++++++++++++-------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
index 66c83c3..dc62dba 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
@@ -1,32 +1,49 @@
-Tegra124 SoC SATA AHCI controller
+Tegra SoC SATA AHCI controller
 
 Required properties :
-- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwise,
-  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip>
-  is tegra132.
-- reg : Should contain 2 entries:
+- compatible : Must be one of:
+  - Tegra124 : "nvidia,tegra124-ahci"
+  - Tegra210 : "nvidia,tegra210-ahci"
+- reg : Should contain 3 entries:
   - AHCI register set (SATA BAR5)
   - SATA register set
+  - AUX register set
 - interrupts : Defines the interrupt used by SATA
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entries:
   - sata
   - sata-oob
-  - cml1
-  - pll_e
 - resets : Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - sata
   - sata-oob
-  - sata-cold
+  - For T124: sata-cold
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
+
+Optional properties:
+- clock-names :
+  - cml1 :
+    cml1 clock is required by phy so it is optional to define
+    here as phy driver will be enabling this clock.
+  - pll_e :
+    pll_e is the parent of cml1 clock so it is optional to define
+    here as phy driver will be enabling this clock.
+- For T210:
+  - l0-hvddio-sata-supply : Defines the SATA HVDDIO regulator
+  - l0-dvddio-sata-supply : Defines the SATA DVDDIO regulator
+  - hvdd-pex-pll-e-supply : Defines the PEX PLL_E regulator
+  - dvdd-sata-pll-supply  : Defines the SATA PLL regulator
+  - hvdd-sata-supply      : Defines the SATA HVDD regulator
-- 
2.1.4

