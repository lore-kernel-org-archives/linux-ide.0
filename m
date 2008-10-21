From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/22] sata_mv: remove unnecessary initialization
Date: Tue, 21 Oct 2008 18:17:41 +0900
Message-ID: <1224580680-13698-4-git-send-email-tj@kernel.org>
References: <1224580680-13698-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45975 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbYJUJUU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 05:20:20 -0400
In-Reply-To: <1224580680-13698-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

sata_mv initializes unused ioports fields including bmdma_addr to
NULL.  As later changes will conditionalize BMDMA, this makes sata_mv
unnecessarily dependent on BMDMA.  Remove the unnecessary
initialization.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_mv.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 2b24ae5..92f3ad8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2861,9 +2861,6 @@ static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 	/* special case: control/altstatus doesn't have ATA_REG_ address */
 	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST_OFS;
 
-	/* unused: */
-	port->cmd_addr = port->bmdma_addr = port->scr_addr = NULL;
-
 	/* Clear any currently outstanding port interrupt conditions */
 	serr_ofs = mv_scr_offset(SCR_ERROR);
 	writelfl(readl(port_mmio + serr_ofs), port_mmio + serr_ofs);
-- 
1.5.4.5

