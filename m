From: Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] sata_dwc_460ex: fix burst transaction length
Date: Thu,  7 Apr 2016 00:44:55 +0200
Message-ID: <1459982695-32394-1-git-send-email-chunkeey@googlemail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Christian Lamparter <chunkeey@googlemail.com>, tj@kernel.org, mans@mansr.com, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

According to DesignWare DW_ahb_dmac Databook page 159,
both SRC_MSIZE and DEST_MSIZE values "are not related to
AHB bus mater HBURST bus".

The hardware uses these values as a unit of TR_WIDTHs.
As both TR_WIDTHs are hardcoded to 4 Bytes, the MSIZEs
should be 16, so the burst transaction length will be:
64 Bytes.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/ata/sata_dwc_460ex.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2fc1516..52f0614 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -58,7 +58,8 @@
 #define NO_IRQ		0
 #endif
 
-#define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length*/
+#define AHB_DMA_BRST_DFLT	64
+#define BRST_TRANS_LEN_DFLT	16
 
 enum {
 	SATA_DWC_MAX_PORTS = 1,
@@ -381,8 +382,8 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	}
 
 	sconf.direction = qc->dma_dir;
-	sconf.src_maxburst = AHB_DMA_BRST_DFLT;
-	sconf.dst_maxburst = AHB_DMA_BRST_DFLT;
+	sconf.src_maxburst = BRST_TRANS_LEN_DFLT;
+	sconf.dst_maxburst = BRST_TRANS_LEN_DFLT;
 	sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-- 
2.8.0.rc3
