From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 2/3] sata_rcar: correct 'sata_rcar_sht'
Date: Tue, 28 May 2013 02:45:08 +0400
Message-ID: <201305280245.09149.sergei.shtylyov@cogentembedded.com>
References: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Using ATA_BMDMA_SHT() to intialize 'sata_rcar_sht' was suboptimal as the R-Car
descriptor table transfer counter is 28 bits wide (bit 1 to bit 28), so that the
'dma_boundary' field of 0xFFFF is just too small, as well as the 'sg_tablesize'
field of 128.  Use ATA_BASE_SHT() to initialize 'sata_rcar_sht' instead and give
proper values to the 'dma_boundary' and 'sg_tablesize' fields explicitly. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/ata/sata_rcar.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -121,6 +121,8 @@
 /* Descriptor table word 0 bit (when DTA32M = 1) */
 #define SATA_RCAR_DTEND			BIT(0)
 
+#define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
+
 struct sata_rcar_priv {
 	void __iomem *base;
 	struct clk *clk;
@@ -575,7 +577,14 @@ static u8 sata_rcar_bmdma_status(struct 
 }
 
 static struct scsi_host_template sata_rcar_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
+	/*
+	 * This controller allows transfer chunks up to 512MB which cross 64KB
+	 * boundaries, therefore the DMA limits are more relaxed than standard
+	 * ATA SFF.
+	 */
+	.sg_tablesize		= ATA_MAX_PRD,
+	.dma_boundary		= SATA_RCAR_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations sata_rcar_port_ops = {

