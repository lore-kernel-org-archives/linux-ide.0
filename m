From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/23] sata_inic162x: kill PORT_PRD_ADDR initialization
Date: Mon, 10 May 2010 21:41:31 +0200
Message-ID: <1273520507-32459-8-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44950 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0EJTmZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:25 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

sata_inic162x doesn't use PRD anymore.  No need to initialize it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_inic162x.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 0ac6cdd..d3e1bab 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -668,8 +668,7 @@ static void init_port(struct ata_port *ap)
 	memset(pp->pkt, 0, sizeof(struct inic_pkt));
 	memset(pp->cpb_tbl, 0, IDMA_CPB_TBL_SIZE);
 
-	/* setup PRD and CPB lookup table addresses */
-	writel(ap->prd_dma, port_base + PORT_PRD_ADDR);
+	/* setup CPB lookup table addresses */
 	writel(pp->cpb_tbl_dma, port_base + PORT_CPB_CPBLAR);
 }
 
-- 
1.6.4.2

