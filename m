From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 5/8] ata: ahci_imx: add disable for spread-spectrum
Date: Tue, 24 Jun 2014 11:19:47 +0100
Message-ID: <E1WzNpL-0005dx-TT@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40016 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751713AbaFXKTu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 06:19:50 -0400
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>

Spread-spectrum doesn't work with Cubox-i hardware, so we have to
disable this feature.  Add a DT property so that platforms can
indicate that this feature should not be enabled.

Having it as a negative property keeps existing DT files working.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index c19019008132..2a4adc939f4c 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -372,6 +372,7 @@ struct reg_property {
 	const struct reg_value *values;
 	size_t num_values;
 	u32 def_value;
+	u32 set_value;
 };
 
 static const struct reg_value gpr13_tx_level[] = {
@@ -469,6 +470,10 @@ static const struct reg_property gpr13_props[] = {
 		.values = gpr13_rx_eq,
 		.num_values = ARRAY_SIZE(gpr13_rx_eq),
 		.def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
+	}, {
+		.name = "fsl,no-spread-spectrum",
+		.def_value = IMX6Q_GPR13_SATA_MPLL_SS_EN,
+		.set_value = 0,
 	},
 };
 
@@ -482,6 +487,14 @@ static u32 imx_ahci_parse_props(struct device *dev,
 	for (i = 0; i < num; i++, prop++) {
 		u32 of_val;
 
+		if (prop->num_values == 0) {
+			if (of_property_read_bool(np, prop->name))
+				reg_value |= prop->set_value;
+			else
+				reg_value |= prop->def_value;
+			continue;
+		}
+
 		if (of_property_read_u32(np, prop->name, &of_val)) {
 			dev_info(dev, "%s not specified, using %08x\n",
 				prop->name, prop->def_value);
@@ -553,7 +566,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
 				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
 				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
 				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
-				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
 				   reg_value;
 	}
 
-- 
1.8.3.1

