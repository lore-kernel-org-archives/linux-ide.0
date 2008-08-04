From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] sata_mv: add the Gen IIE flag to the SoC devices.
Date: Mon,  4 Aug 2008 00:52:55 -1100
Message-ID: <12178507751128-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:33388 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYHDMDE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 08:03:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: liml@rtr.ca, linux-ide@vger.kernel.org, jeff@garzik.org
Cc: buytenh@marvell.com, Saeed Bishara <saeed@marvell.com>

The SoC sata port is based on the 7042/6042 devices (Gen IIE). This patch
will fix various issues when working with PMP and/or NCQ.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ad169ff..f483067 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3036,7 +3036,8 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 		break;
 	case chip_soc:
 		hpriv->ops = &mv_soc_ops;
-		hp_flags |= MV_HP_FLAG_SOC | MV_HP_ERRATA_60X1C0;
+		hp_flags |= MV_HP_FLAG_SOC | MV_HP_GEN_IIE |
+			MV_HP_ERRATA_60X1C0;
 		break;
 
 	default:
-- 
1.5.2.5

