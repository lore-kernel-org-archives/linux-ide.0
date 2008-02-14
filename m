From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 04/11] ata: fix sparse warnings in sata_mv.c
Date: Wed, 13 Feb 2008 21:14:14 -0800
Message-ID: <1202966055.2748.18.camel@brick>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:8412 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186AbYBNFOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:17 -0500
Received: by wx-out-0506.google.com with SMTP id h31so224555wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:17 -0800 (PST)
In-Reply-To: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

pp is never used again in this function, no need to declare a
new one.

drivers/ata/sata_mv.c:1545:24: warning: symbol 'pp' shadows an earlier one
drivers/ata/sata_mv.c:1501:22: originally declared here
drivers/ata/sata_mv.c:1553:24: warning: symbol 'pp' shadows an earlier one
drivers/ata/sata_mv.c:1501:22: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/sata_mv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 04b5717..2ecd44d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1542,7 +1542,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 		eh_freeze_mask = EDMA_EH_FREEZE_5;
 
 		if (edma_err_cause & EDMA_ERR_SELF_DIS_5) {
-			struct mv_port_priv *pp	= ap->private_data;
+			pp = ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
@@ -1550,7 +1550,7 @@ static void mv_err_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 		eh_freeze_mask = EDMA_EH_FREEZE;
 
 		if (edma_err_cause & EDMA_ERR_SELF_DIS) {
-			struct mv_port_priv *pp	= ap->private_data;
+			pp = ap->private_data;
 			pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
-- 
1.5.4.1.1278.gc75be


