From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] sata_rcar: Document deprecated "renesas,rcar-sata"
Date: Mon, 10 Nov 2014 19:42:30 +0100
Message-ID: <1415644950-2983-2-git-send-email-geert+renesas@glider.be>
References: <1415644950-2983-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:49256 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbaKJSmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2014 13:42:23 -0500
In-Reply-To: <1415644950-2983-1-git-send-email-geert+renesas@glider.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA PHY support")
deprecated "renesas,rcar-sata" in favor of "renesas,sata-r8a7779", but
the deprecated value was never documented in the binding documentation,
while it is still in active use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Acked-by,
  - Rebased on top of libata/for-next
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index f09c1ee260ba1d10..2493a5a316551de8 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible		: should contain one of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
+			    ("renesas,rcar-sata" is deprecated)
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
 			  - "renesas,sata-r8a7791" for R-Car M2-W
-- 
1.9.1

