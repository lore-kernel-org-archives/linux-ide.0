From: <Yuantian.Tang@freescale.com>
Subject: [PATCH 1/2] ahci: qoriq: Adjust the default register values on ls1043a
Date: Wed, 16 Dec 2015 13:43:49 +0800
Message-ID: <1450244630-10065-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0117.outbound.protection.outlook.com ([157.56.110.117]:61696
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751091AbbLPFvY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Dec 2015 00:51:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Updated the registers' values to enhance SATA performance and
reliability.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/ata/ahci_qoriq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index d0f9de9..4d613f8 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -39,6 +39,8 @@
 #define AHCI_PORT_PHY_4_CFG	0x00480811
 #define AHCI_PORT_PHY_5_CFG	0x192c96a4
 #define AHCI_PORT_TRANS_CFG	0x08000025
+#define LS1043A_PORT_PHY2	0x28184d1f
+#define LS1043A_PORT_PHY3	0x0e081509
 
 #define SATA_ECC_DISABLE	0x00020000
 
@@ -159,6 +161,12 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1043A:
+		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(LS1043A_PORT_PHY2, reg_base + PORT_PHY2);
+		writel(LS1043A_PORT_PHY3, reg_base + PORT_PHY3);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		break;
+
 	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		break;
-- 
2.1.0.27.g96db324

