From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Sun,  7 Sep 2008 00:19:45 -1100
Message-ID: <12207863853449-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:52505 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbYIGLTu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 07:19:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, grundler@google.com, elendil@planet.nl, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com, Saeed Bishara <saeed@marvell.com>

Enabling blink mode makes the SATA active LED more human visible.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 13c1d2a..302e1f8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -208,6 +208,10 @@ enum {
 	DMA_IRQ			= (1 << 0),	/* shift by port # */
 	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
+	SOC_LED_CTRL_OFS	= 0x2c,
+	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
+	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex presence with */
+						/* the active LED */
 
 	/* Shadow block registers */
 	SHD_BLK_OFS		= 0x100,
@@ -2616,7 +2620,11 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
 				      void __iomem *mmio)
 {
-	return;
+	void __iomem *hc_mmio = mv_hc_base(mmio, 0);
+	u32 tmp = readl(hc_mmio + SOC_LED_CTRL_OFS);
+
+	/* enable blinking mode */
+	writel(tmp | SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
 }
 
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
-- 
1.5.2.5

