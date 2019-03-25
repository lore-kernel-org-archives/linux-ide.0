From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH v2] ata: dwc_460ex: Avoid potential NULL pointer dereference
Date: Mon, 25 Mar 2019 17:54:53 -0500
Message-ID: <20190325225453.14276-1-pakki001@umn.edu>
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
v1: Return error in case of failure to desc variable to avoid hang up.
---
 drivers/ata/sata_dwc_460ex.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6f142aa54f5f..63d922c624a4 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -185,7 +185,7 @@ enum {
 /*
  * Prototypes
  */
-static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
+static int sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 				u32 check_status);
 static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
@@ -512,7 +512,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	u8 status, tag;
-	int handled, num_processed, port = 0;
+	int handled, num_processed, ret, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
 	hsdev->sactive_issued = 0;
@@ -553,10 +553,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		 * be completed.
 		 */
 		qc->ap->link.active_tag = tag;
-		sata_dwc_bmdma_start_by_tag(qc, tag);
-
-		handled = 1;
-		goto DONE;
+		ret = sata_dwc_bmdma_start_by_tag(qc, tag);
+		if (!ret) {
+			handled = 1;
+			goto DONE;
+		}
 	}
 	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
 	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
@@ -1008,7 +1009,7 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
 	sata_dwc_bmdma_setup_by_tag(qc, tag);
 }
 
-static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
+static int sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 {
 	int start_dma;
 	u32 reg;
@@ -1018,6 +1019,9 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 	struct dma_async_tx_descriptor *desc = hsdevp->desc[tag];
 	int dir = qc->dma_dir;
 
+	if (!desc)
+		return -ENOMEM;
+
 	if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_NOT) {
 		start_dma = 1;
 		if (dir == DMA_TO_DEVICE)
@@ -1055,9 +1059,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		dmaengine_submit(desc);
 		dma_async_issue_pending(hsdevp->chan);
 	}
+	return 0;
 }
 
-static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
+static int sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 {
 	u8 tag = qc->hw_tag;
 
@@ -1068,7 +1073,7 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 		tag = 0;
 	}
 	dev_dbg(qc->ap->dev, "%s\n", __func__);
-	sata_dwc_bmdma_start_by_tag(qc, tag);
+	return sata_dwc_bmdma_start_by_tag(qc, tag);
 }
 
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
-- 
2.17.1
