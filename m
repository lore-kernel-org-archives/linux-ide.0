From: Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 3/3] ahci: qoriq: add ls1028a platforms support
Date: Mon, 11 Mar 2019 15:20:14 +0800
Message-ID: <20190311072014.36565-3-peng.ma@nxp.com>
References: <20190311072014.36565-1-peng.ma@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, andy.tang@nxp.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

Ls1028a is a new introduced soc which supports ATA3.0

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
depends on:
	- http://patchwork.ozlabs.org/patch/1045218/

 drivers/ata/ahci_qoriq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 08dbb86..ea1175f 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -53,6 +53,7 @@
 
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
+	AHCI_LS1028A,
 	AHCI_LS1043A,
 	AHCI_LS2080A,
 	AHCI_LS1046A,
@@ -72,6 +73,7 @@ struct ahci_qoriq_priv {
 
 static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
+	{ .compatible = "fsl,ls1028a-ahci", .data = (void *)AHCI_LS1028A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
@@ -223,6 +225,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
+	case AHCI_LS1028A:
 	case AHCI_LS1088A:
 	case AHCI_LX2160A:
 		if (!(qpriv->ecc_addr || ecc_initialized))
-- 
1.7.1
