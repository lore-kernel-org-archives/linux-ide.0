From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V7 1/7] dt-bindings: ahci-tegra: add binding documentation
Date: Mon, 12 Feb 2018 22:56:40 +0530
Message-ID: <1518456406-21564-2-git-send-email-pchandru@nvidia.com>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This adds bindings documentation for the
AHCI controller on Tegra210

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v7:
* For Aux register set drop the Tegra210 since this register
  set also works on Tegra124
* rephrase the sentence for cml1 clock
* change the commit subject to include ahci-tegra
* drop pll_e since CCF handles it automatically as
  CML1 is a child clock of it.
v4:
* changed the commit message
* changed 'sata-cold' reset to mandatory for t210 and t124
* Removed the regulators for T210 since these regulators
  will be enabled in phy driver.
v3:
* Add AUX register.
v2:
* change cml1, pll_e and phy regulators as optional
  for T210.
---
 .../bindings/ata/nvidia,tegra124-ahci.txt          | 35 ++++++++++++++--------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
index 66c83c3e8915..0f4520a00716 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
@@ -1,20 +1,19 @@
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
@@ -24,9 +23,19 @@ Required properties :
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
+  - target-12v-supply : Defines the SATA 12V power regulator
+
+Optional properties:
+- clock-names :
+  - cml1 :
+    cml1 clock should be defined here if the PHY driver
+    doesn't manage them. If it does, they should not be.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
