From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v3 1/2] ahci: imx: add namespace for register enums
Date: Sun, 4 May 2014 21:48:05 +0800
Message-ID: <1399211286-8624-2-git-send-email-shawn.guo@freescale.com>
References: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:37593
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752900AbaEDNsl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 May 2014 09:48:41 -0400
In-Reply-To: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>

Update register enums a little bit to add proper namespace prefix, and
have the names match i.MX reference manual.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/ata/ahci_imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 497c7ab..7767576 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -29,9 +29,11 @@
 #include "ahci.h"
 
 enum {
-	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
-	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
-	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
+	/* Timer 1-ms Register */
+	IMX_TIMER1MS				= 0x00e0,
+	/* Port0 PHY Control Register */
+	IMX_P0PHYCR				= 0x0178,
+	IMX_P0PHYCR_TEST_PDDQ			= 1 << 20,
 };
 
 enum ahci_imx_type {
@@ -156,8 +158,8 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	 * without full reset once the pddq mode is enabled making it
 	 * impossible to use as part of libata LPM.
 	 */
-	reg_val = readl(mmio + PORT_PHY_CTL);
-	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
+	reg_val = readl(mmio + IMX_P0PHYCR);
+	writel(reg_val | IMX_P0PHYCR_TEST_PDDQ, mmio + IMX_P0PHYCR);
 	imx_sata_disable(hpriv);
 	imxpriv->no_device = true;
 }
@@ -248,7 +250,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 
 	/*
 	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
-	 * and IP vendor specific register HOST_TIMER1MS.
+	 * and IP vendor specific register IMX_TIMER1MS.
 	 * Configure CAP_SSS (support stagered spin up).
 	 * Implement the port0.
 	 * Get the ahb clock rate, and configure the TIMER1MS register.
@@ -265,7 +267,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	}
 
 	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, hpriv->mmio + HOST_TIMER1MS);
+	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
 
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info, 0, 0);
 	if (ret)
-- 
1.8.3.2

