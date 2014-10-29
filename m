From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] sata_rcar: Add clocks to sata_rcar bindings
Date: Wed, 29 Oct 2014 14:58:49 +0100
Message-ID: <1414591131-21771-2-git-send-email-geert+renesas@glider.be>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:46389 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbaJ2N6p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2014 09:58:45 -0400
In-Reply-To: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

Now that the clocks are available in the R-Car Gen2 DT,
add clocks property description to the sata_rcar bindings.
The clocks have been tested on r8a7791 so we use that
as an example of the R-Car SATA node.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
[geert: Reworded clocks property]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 1e6111333fa88f86..12d9de915ebd6cbf 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -7,12 +7,14 @@ Required properties:
 			  - "renesas,sata-r8a7791" for R-Car M2
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
+- clocks		: must contain a reference to the functional clock.
 
 Example:
 
-sata: sata@fc600000 {
-	compatible = "renesas,sata-r8a7779";
-	reg = <0xfc600000 0x2000>;
+sata0: sata@ee300000 {
+	compatible = "renesas,sata-r8a7791";
+	reg = <0 0xee300000 0 0x2000>;
 	interrupt-parent = <&gic>;
-	interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
 };
-- 
1.9.1

