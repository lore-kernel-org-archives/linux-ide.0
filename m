From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
Date: Mon,  4 Mar 2019 17:08:57 -0600
Message-ID: <20190304230858.13387-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

dma_async_tx_descriptor can contain a NULL variable and using
it in dmaengine_submit without checking can crash the process.
This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/ata/sata_dwc_460ex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6f142aa54f5f..44a0d7a1ef54 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 					SATA_DWC_DMACR_RXCHEN);
 
 		/* Enable AHB DMA transfer on the specified channel */
-		dmaengine_submit(desc);
-		dma_async_issue_pending(hsdevp->chan);
+		if (desc) {
+			dmaengine_submit(desc);
+			dma_async_issue_pending(hsdevp->chan);
+		}
 	}
 }
 
-- 
2.17.1
