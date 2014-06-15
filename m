From: Joe Perches <joe@perches.com>
Subject: [PATCH -next 03/26] ata: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:32 -0700
Message-ID: <2be5da39b914e5f9d845c0f789267e80c188d5b5.1402863905.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ata/sata_fsl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 616a6d2..07bc7e4 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -734,13 +734,12 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	if (!pp)
 		return -ENOMEM;
 
-	mem = dma_alloc_coherent(dev, SATA_FSL_PORT_PRIV_DMA_SZ, &mem_dma,
-				 GFP_KERNEL);
+	mem = dma_zalloc_coherent(dev, SATA_FSL_PORT_PRIV_DMA_SZ, &mem_dma,
+				  GFP_KERNEL);
 	if (!mem) {
 		kfree(pp);
 		return -ENOMEM;
 	}
-	memset(mem, 0, SATA_FSL_PORT_PRIV_DMA_SZ);
 
 	pp->cmdslot = mem;
 	pp->cmdslot_paddr = mem_dma;
-- 
1.8.1.2.459.gbcd45b4.dirty
