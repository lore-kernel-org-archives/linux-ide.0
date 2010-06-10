From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] sata_sil24: Use memory barriers before issuing commands
Date: Thu, 10 Jun 2010 15:57:06 +0100
Message-ID: <20100610145706.15588.4562.stgit@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37458 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759377Ab0FJPMK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2010 11:12:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Colin Tuckley <colin.tuckley@arm.com>

The data in the cmd_block buffers may reach the main memory after the
writel() to the device ports. This patch introduces two calls to wmb()
to ensure the relative ordering.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Colin Tuckley <colin.tuckley@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_sil24.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e925051..6392fdb 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -622,6 +622,7 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	irq_enabled = readl(port + PORT_IRQ_ENABLE_SET);
 	writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR, port + PORT_IRQ_ENABLE_CLR);
 
+	wmb();
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
 	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
 
@@ -895,6 +896,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
 	activate = port + PORT_CMD_ACTIVATE + tag * 8;
 
+	wmb();
 	writel((u32)paddr, activate);
 	writel((u64)paddr >> 32, activate + 4);
 

