From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ata: sata_rcar: add gen[123] fallback compatibility strings
Date: Tue,  8 Mar 2016 10:30:42 +0900
Message-ID: <1457400642-19377-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39846 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbcCHBbA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Mar 2016 20:31:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility string for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7779 is older
than r8a7778 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on libata/for-next
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 15 ++++++++++++---
 drivers/ata/sata_rcar.c                             | 12 ++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 0764f9ab63dc..b44048176938 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -1,14 +1,23 @@
 * Renesas R-Car SATA
 
 Required properties:
-- compatible		: should contain one of the following:
+- compatible		: should contain one or more of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
-			    ("renesas,rcar-sata" is deprecated)
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
 			  - "renesas,sata-r8a7791" for R-Car M2-W
 			  - "renesas,sata-r8a7793" for R-Car M2-N
 			  - "renesas,sata-r8a7795" for R-Car H3
+			  - "renesas,rcar-gen1-sata" for a generic R-Car Gen1 compatible device
+			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2 compatible device
+			  - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 compatible device
+			  - "renesas,rcar-sata" is deprecated
+
+			  When compatible with the generic version, nodes
+			  must list the SoC-specific version corresponding
+			  to the platform first followed by the generic
+			  version.
+
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
 - clocks		: must contain a reference to the functional clock.
@@ -16,7 +25,7 @@ Required properties:
 Example:
 
 sata0: sata@ee300000 {
-	compatible = "renesas,sata-r8a7791";
+	compatible = "renesas,sata-r8a7791", "renesas,rcar-gen2-sata";
 	reg = <0 0xee300000 0 0x2000>;
 	interrupt-parent = <&gic>;
 	interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index f72d601e300a..09d4ba3f0bc4 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -858,6 +858,18 @@ static struct of_device_id sata_rcar_match[] = {
 		.compatible = "renesas,sata-r8a7795",
 		.data = (void *)RCAR_GEN2_SATA
 	},
+	{
+		.compatible = "renesas,rcar-gen1-sata",
+		.data = (void *)RCAR_GEN1_SATA
+	},
+	{
+		.compatible = "renesas,rcar-gen2-sata",
+		.data = (void *)RCAR_GEN2_SATA
+	},
+	{
+		.compatible = "renesas,rcar-gen3-sata",
+		.data = (void *)RCAR_GEN2_SATA
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
-- 
2.1.4

