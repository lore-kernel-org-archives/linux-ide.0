From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/6] ata: i.MX PATA: use void __iomem * for regs
Date: Thu,  4 Apr 2013 11:25:06 +0200
Message-ID: <1365067509-10186-4-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38442 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050Ab3DDJZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Apr 2013 05:25:27 -0400
In-Reply-To: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

regs is returned from ioremap, so add a __iomem. Also, make it
void * instead of u8 *.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/pata_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index f243496..adbb01d 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -37,7 +37,7 @@
 struct pata_imx_priv {
 	struct clk *clk;
 	/* timings/interrupt/control regs */
-	u8 *host_regs;
+	void __iomem *host_regs;
 	u32 ata_ctl;
 };
 
-- 
1.8.2.rc2

