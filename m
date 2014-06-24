From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH] dt-bindings: ata: create bindings for imx sata controller
Date: Tue, 24 Jun 2014 15:44:37 +0800
Message-ID: <1403595877-5921-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:32007
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751326AbaFXHox (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2014 03:44:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@freescale.com>

The Freescale i.MX SATA controller mostly conforms to the AHCI
interface, but there are some special extensions at integration level
like clocks settings and hardware parameters.

Let's create a separate bindings doc for imx sata controller, so that
more imx specific properties can be added later without messing up the
generic ahci-platform bindings.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  6 -----
 Documentation/devicetree/bindings/ata/imx-sata.txt | 26 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/imx-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c96d8dcf98fd..549ceb8cb93b 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -6,8 +6,6 @@ Each SATA controller should have its own node.
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
-  - "fsl,imx53-ahci"
-  - "fsl,imx6q-ahci"
   - "hisilicon,hisi-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
@@ -22,10 +20,6 @@ Optional properties:
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
 
-"fsl,imx53-ahci", "fsl,imx6q-ahci" required properties:
-- clocks            : must contain the sata, sata_ref and ahb clocks
-- clock-names       : must contain "ahb" for the ahb clock
-
 Examples:
         sata@ffe08000 {
 		compatible = "snps,spear-ahci";
diff --git a/Documentation/devicetree/bindings/ata/imx-sata.txt b/Documentation/devicetree/bindings/ata/imx-sata.txt
new file mode 100644
index 000000000000..aeb99dd986b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/imx-sata.txt
@@ -0,0 +1,26 @@
+* Freescale i.MX AHCI SATA Controller
+
+The Freescale i.MX SATA controller mostly conforms to the AHCI interface
+with some special extensions at integration level.
+
+Required properties:
+- compatible : should be one of the following:
+   - "fsl,imx53-ahci" for i.MX53 SATA controller
+   - "fsl,imx6q-ahci" for i.MX6Q SATA controller
+- interrupts : interrupt mapping for SATA IRQ
+- reg : registers mapping
+- clocks : list of clock specifiers, must contain an entry for each
+  required entry in clock-names
+- clock-names : should include "sata", "sata_ref" and "ahb" entries
+
+Examples:
+
+sata@02200000 {
+	compatible = "fsl,imx6q-ahci";
+	reg = <0x02200000 0x4000>;
+	interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX6QDL_CLK_SATA>,
+		 <&clks IMX6QDL_CLK_SATA_REF_100M>,
+		 <&clks IMX6QDL_CLK_AHB>;
+	clock-names = "sata", "sata_ref", "ahb";
+};
-- 
1.8.3.2

