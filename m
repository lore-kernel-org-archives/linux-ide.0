From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 1/3] sata_mv: increase PIO IORDY timeout
Date: Tue, 23 Jun 2009 18:43:56 +0300
Message-ID: <1245771838-1332-1-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:6206 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754301AbZFWPn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 11:43:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, liml@rtr.ca
Cc: saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>

The old value (0xbc) in cycles of the IORDY timeout is suitable for
devices with core clock of 166 MHz, but some SoC controllers have
faster core clocks. The new value will make the IORDY timeout large
enough also for all SoC devices.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 23714ae..644436e 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3368,7 +3368,7 @@ static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
 	ZERO(0x024);		/* respq outp */
 	ZERO(0x020);		/* respq inp */
 	ZERO(0x02c);		/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+	writel(0x800, port_mmio + EDMA_IORDY_TMOUT);
 }
 
 #undef ZERO
-- 
1.6.0.4

