From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 1/6] sata_mv: increase PIO IORDY timeout
Date: Sun,  6 Dec 2009 18:26:17 +0200
Message-ID: <1260116782-31714-1-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50704 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbZLFQ0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

The old value (0xbc) in cycles of the IORDY timeout is suitable for
devices with core clock of 166 MHz, but some SoC controllers have
faster core clocks. The new value will make the IORDY timeout large
enough also for all SoC devices.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 6f5093b..312c3e0 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3393,7 +3393,7 @@ static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
 	ZERO(0x024);		/* respq outp */
 	ZERO(0x020);		/* respq inp */
 	ZERO(0x02c);		/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+	writel(0x800, port_mmio + EDMA_IORDY_TMOUT);
 }
 
 #undef ZERO
-- 
1.6.0.4

