From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/23] sata_mv: remove unnecessary initialization
Date: Mon, 10 May 2010 21:41:27 +0200
Message-ID: <1273520507-32459-4-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44927 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab0EJTmM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:12 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
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
index 71cc0d4..bd48646 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3656,9 +3656,6 @@ static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 	/* special case: control/altstatus doesn't have ATA_REG_ address */
 	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST;
 
-	/* unused: */
-	port->cmd_addr = port->bmdma_addr = port->scr_addr = NULL;
-
 	/* Clear any currently outstanding port interrupt conditions */
 	serr = port_mmio + mv_scr_offset(SCR_ERROR);
 	writelfl(readl(serr), serr);
-- 
1.6.4.2

