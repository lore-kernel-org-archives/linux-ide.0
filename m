From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 1/2] sata_mv: use hpriv->base instead of the host->iomap
Date: Wed, 13 Feb 2008 10:09:09 -1100
Message-ID: <12029369502995-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:39079 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752274AbYBMS4i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 13:56:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, nico@cam.org, byron.bbradley@gmail.com, Saeed Bishara <saeed@marvell.com>

this fixes crash bug as the iomap table is not valid for integrated controllers.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 04b5717..9c9a5b0 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -870,7 +870,7 @@ static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		int hard_port = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
-				ap->host->iomap[MV_PRIMARY_BAR], hard_port);
+					mv_host_base(ap->host), hard_port);
 		u32 hc_irq_cause, ipending;
 
 		/* clear EDMA event indicators, if any */
-- 
1.5.2.5

