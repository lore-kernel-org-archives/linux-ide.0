From: <Yuantian.Tang@freescale.com>
Subject: [PATCH] ahci: qoriq: Adjust the default register values on ls1021a
Date: Wed, 16 Dec 2015 14:00:35 +0800
Message-ID: <1450245635-8383-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0112.outbound.protection.outlook.com ([157.56.111.112]:20132
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754623AbbLPGWP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Dec 2015 01:22:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Updated the registers' values to enhance SATA performance and
reliability on ls1021a soc.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/ata/ahci_qoriq.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 256d911..7bdee9b 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -34,16 +34,20 @@
 
 /* port register default value */
 #define AHCI_PORT_PHY_1_CFG	0xa003fffe
-#define AHCI_PORT_PHY_2_CFG	0x28183411
-#define AHCI_PORT_PHY_3_CFG	0x0e081004
-#define AHCI_PORT_PHY_4_CFG	0x00480811
-#define AHCI_PORT_PHY_5_CFG	0x192c96a4
 #define AHCI_PORT_TRANS_CFG	0x08000029
-#define LS1043A_PORT_PHY2	0x28184d1f
-#define LS1043A_PORT_PHY3	0x0e081509
+
+/* for ls1021a */
+#define LS1021A_PORT_PHY2	0x28183414
+#define LS1021A_PORT_PHY3	0x0e080e06
+#define LS1021A_PORT_PHY4	0x064a080b
+#define LS1021A_PORT_PHY5	0x2aa86470
 
 #define SATA_ECC_DISABLE	0x00020000
 
+/* for ls1043a */
+#define LS1043A_PORT_PHY2	0x28184d1f
+#define LS1043A_PORT_PHY3	0x0e081509
+
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
 	AHCI_LS1043A,
@@ -153,10 +157,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1021A:
 		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY_2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY_3_CFG, reg_base + PORT_PHY3);
-		writel(AHCI_PORT_PHY_4_CFG, reg_base + PORT_PHY4);
-		writel(AHCI_PORT_PHY_5_CFG, reg_base + PORT_PHY5);
+		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
+		writel(LS1021A_PORT_PHY3, reg_base + PORT_PHY3);
+		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
+		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		break;
 
-- 
2.1.0.27.g96db324

