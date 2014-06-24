From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 1/8] dt-bindings: ata: create bindings for imx sata
 controller
Date: Tue, 24 Jun 2014 11:19:27 +0100
Message-ID: <E1WzNp1-0005dg-FQ@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:39996 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752957AbaFXKTf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 06:19:35 -0400
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

From: Shawn Guo <shawn.guo@freescale.com>
To: Tejun Heo <tj@kernel.org>,linux-ide@vger.kernel.org

The Freescale i.MX SATA controller mostly conforms to the AHCI
interface, but there are some special extensions at integration level
like clocks settings and hardware parameters.

Let's create a separate bindings doc for imx sata controller, so that
more imx specific properties can be added later without messing up the
generic ahci-platform bindings.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
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
@@ -22,10 +20,6 @@ Each SATA controller should have its own node.
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
1.8.3.1

