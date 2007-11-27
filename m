From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] [libata] sata_mv: fix compilation error when enabling DEBUG
Date: Tue, 27 Nov 2007 17:42:33 +0200
Message-ID: <11961781532837-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:31251 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755058AbXK0Pj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 10:39:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Saeed Bishara <saeed.bishara@gmail.com>, Saeed Bishara <saeed@marvell.com>

From: Saeed Bishara <saeed.bishara@gmail.com>

use sstatus instead status.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index a43f64d..97c3e11 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2170,7 +2170,7 @@ static void mv_phy_reset(struct ata_port *ap, unsigned int *class,
 		mv_scr_read(ap, SCR_ERROR, &serror);
 		mv_scr_read(ap, SCR_CONTROL, &scontrol);
 		DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
-			"SCtrl 0x%08x\n", status, serror, scontrol);
+			"SCtrl 0x%08x\n", sstatus, serror, scontrol);
 	}
 #endif
 
-- 
1.5.0.6

