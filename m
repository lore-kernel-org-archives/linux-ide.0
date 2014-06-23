From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/5] ata: ahci_imx: warn when disabling ahci link
Date: Mon, 23 Jun 2014 12:59:08 +0100
Message-ID: <E1Wz2tw-0000eE-Ml@rmk-PC.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:38924 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752408AbaFWL7Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 07:59:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

When the AHCI link is disabled, it can't be re-enabled except by
resetting the entire SoC.  Rather than doing this silently print
some kernel messages to inform the user, along with how to avoid
this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3a901520c62b..4eba1c5279ec 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -324,6 +324,10 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	writel(reg_val | IMX_P0PHYCR_TEST_PDDQ, mmio + IMX_P0PHYCR);
 	imx_sata_disable(hpriv);
 	imxpriv->no_device = true;
+
+	dev_info(ap->dev, "no device found, disabling link.\n");
+	dev_info(ap->dev, "pass " MODULE_PARAM_PREFIX
+		 ".hotplug=1 to enable hotplug\n");
 }
 
 static int ahci_imx_softreset(struct ata_link *link, unsigned int *class,
-- 
1.8.3.1

