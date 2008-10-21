From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/22] sata_inic162x: kill PORT_PRD_ADDR initialization
Date: Tue, 21 Oct 2008 18:17:45 +0900
Message-ID: <1224580680-13698-8-git-send-email-tj@kernel.org>
References: <1224580680-13698-1-git-send-email-tj@kernel.org>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1224580680-13698-1-git-send-email-tj@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

sata_inic162x doesn't use PRD anymore.  No need to initialize it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_inic162x.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 9dd7559..e87349d 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -667,8 +667,7 @@ static void init_port(struct ata_port *ap)
 	memset(pp->pkt, 0, sizeof(struct inic_pkt));
 	memset(pp->cpb_tbl, 0, IDMA_CPB_TBL_SIZE);
 
-	/* setup PRD and CPB lookup table addresses */
-	writel(ap->prd_dma, port_base + PORT_PRD_ADDR);
+	/* setup CPB lookup table addresses */
 	writel(pp->cpb_tbl_dma, port_base + PORT_CPB_CPBLAR);
 }
 
-- 
1.5.4.5

