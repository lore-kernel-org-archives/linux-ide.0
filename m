From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 1/5] Documentation: dt-bindings: reformat and order list of ahci-platform compatibles
Date: Tue, 15 Apr 2014 17:00:02 +0200
Message-ID: <1397574006-5868-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41246 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbaDOPAK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 11:00:10 -0400
In-Reply-To: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The ahci-platform.txt Device Tree binding documentation is gaining a
growing number of compatible strings, and it will gain one more with
the addition of the Marvell Armada 380 AHCI support. It is therefore
time to reformat this list into a proper bullet list, and more
importantly order it alphabetically;

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 48b285f..5598862 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -4,10 +4,14 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible        : compatible list, one of "snps,spear-ahci",
-                      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
-                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
-                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
+- compatible        : compatible string, one of:
+  - "allwinner,sun4i-a10-ahci"
+  - "fsl,imx53-ahci"
+  - "fsl,imx6q-ahci"
+  - "ibm,476gtr-ahci"
+  - "snps,dwc-ahci"
+  - "snps,exynos5440-ahci"
+  - "snps,spear-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
-- 
1.9.2

