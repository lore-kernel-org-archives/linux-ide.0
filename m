From: <Yuantian.Tang@freescale.com>
Subject: [PATCH 2/2] ahci: qoriq: Update the default Rx watermark value
Date: Wed, 16 Dec 2015 13:43:50 +0800
Message-ID: <1450244630-10065-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1450244630-10065-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0147.outbound.protection.outlook.com ([207.46.100.147]:29280
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752951AbbLPFv3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Dec 2015 00:51:29 -0500
In-Reply-To: <1450244630-10065-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

The PTC[RXWM] sets the watermark value for Rx FIFO. The default
value 0x20 might be insufficient for some hard drives. If the
watermark value is too small, a single-cycle overflow may occur
and is reported as a CRC or internal error in the PxSERR register.
Updated the value to 0x29 according to the validation test.
All LS platforms are affected.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/ata/ahci_qoriq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 4d613f8..256d911 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -38,7 +38,7 @@
 #define AHCI_PORT_PHY_3_CFG	0x0e081004
 #define AHCI_PORT_PHY_4_CFG	0x00480811
 #define AHCI_PORT_PHY_5_CFG	0x192c96a4
-#define AHCI_PORT_TRANS_CFG	0x08000025
+#define AHCI_PORT_TRANS_CFG	0x08000029
 #define LS1043A_PORT_PHY2	0x28184d1f
 #define LS1043A_PORT_PHY3	0x0e081509
 
@@ -169,6 +169,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		break;
 	}
 
-- 
2.1.0.27.g96db324

