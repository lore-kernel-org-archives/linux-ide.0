From: <yuantian.tang@nxp.com>
Subject: [PATCH 1/2] ahci: qoriq: adjust sata parameter
Date: Tue, 9 Aug 2016 09:51:21 +0800
Message-ID: <1470707482-13421-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:59568
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752365AbcHIDfl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2016 23:35:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

The default values for Port Phy2Cfg register and
Port Phy3Cfg register are better, no need to overwrite them.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 7bdee9b..ed357a1 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -44,10 +44,6 @@
 
 #define SATA_ECC_DISABLE	0x00020000
 
-/* for ls1043a */
-#define LS1043A_PORT_PHY2	0x28184d1f
-#define LS1043A_PORT_PHY3	0x0e081509
-
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
 	AHCI_LS1043A,
@@ -166,8 +162,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	case AHCI_LS1043A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(LS1043A_PORT_PHY2, reg_base + PORT_PHY2);
-		writel(LS1043A_PORT_PHY3, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		break;
 
-- 
2.1.0.27.g96db324

