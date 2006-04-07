From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] sata_sil24: consolidate host flags into SIL24_COMMON_FLAGS
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978131314-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:62430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932378AbWDGIRC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:02 -0400
Received: by wproxy.gmail.com with SMTP id 58so295241wri
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:02 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

All sil24 controllers share the same host flags except for NPORTS.
Consolidate them into SIL24_COMMON_FLAGS.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

18f37254b289b3c8215e83f313e0dc53756f6c1d
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 4434cf2..dd4db40 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -218,6 +218,10 @@ enum {
 	BID_SIL3132		= 1,
 	BID_SIL3131		= 2,
 
+	/* host flags */
+	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+
 	IRQ_STAT_4PORTS		= 0xf,
 };
 
@@ -345,9 +349,7 @@ static struct ata_port_info sil24_port_i
 	/* sil_3124 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  SIL24_NPORTS2FLAG(4),
+		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -356,9 +358,7 @@ static struct ata_port_info sil24_port_i
 	/* sil_3132 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  SIL24_NPORTS2FLAG(2),
+		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -367,9 +367,7 @@ static struct ata_port_info sil24_port_i
 	/* sil_3131/sil_3531 */
 	{
 		.sht		= &sil24_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  SIL24_NPORTS2FLAG(1),
+		.host_flags	= SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
-- 
1.2.4


