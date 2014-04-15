From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Tue, 15 Apr 2014 10:41:42 +0800
Message-ID: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:6022 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbaDOCmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 22:42:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>

Comparing to enums, macros are more conventional to be used for
registers and bits definition.  Let's switch to macros.

While at it, the names of the registers and bit-fields are updated to
have proper namespace prefix and match the hardware reference manual.

No functional change is involved.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/ata/ahci_imx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 497c7ab..39629b4 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -28,11 +28,9 @@
 #include <linux/libata.h>
 #include "ahci.h"
 
-enum {
-	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
-	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
-	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
-};
+#define IMX_SATA_TIMER1MS			0x00e0
+#define IMX_SATA_P0PHYCR			0x0178
+#define  P0PHYCR_TEST_PDDQ			(1 << 20)
 
 enum ahci_imx_type {
 	AHCI_IMX53,
@@ -156,8 +154,8 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	 * without full reset once the pddq mode is enabled making it
 	 * impossible to use as part of libata LPM.
 	 */
-	reg_val = readl(mmio + PORT_PHY_CTL);
-	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
+	reg_val = readl(mmio + IMX_SATA_P0PHYCR);
+	writel(reg_val | P0PHYCR_TEST_PDDQ, mmio + IMX_SATA_P0PHYCR);
 	imx_sata_disable(hpriv);
 	imxpriv->no_device = true;
 }
@@ -248,7 +246,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 
 	/*
 	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
-	 * and IP vendor specific register HOST_TIMER1MS.
+	 * and IP vendor specific register IMX_SATA_TIMER1MS.
 	 * Configure CAP_SSS (support stagered spin up).
 	 * Implement the port0.
 	 * Get the ahb clock rate, and configure the TIMER1MS register.
@@ -265,7 +263,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	}
 
 	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, hpriv->mmio + HOST_TIMER1MS);
+	writel(reg_val, hpriv->mmio + IMX_SATA_TIMER1MS);
 
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info, 0, 0);
 	if (ret)
-- 
1.8.3.2


