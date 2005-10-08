From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24] add support for 3131 and 3531
Date: Sat, 8 Oct 2005 12:15:23 +0900
Message-ID: <20051008031523.GB13957@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:9686 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751064AbVJHDPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 23:15:30 -0400
Received: by zproxy.gmail.com with SMTP id 13so450883nzn
        for <linux-ide@vger.kernel.org>; Fri, 07 Oct 2005 20:15:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, efalk@google.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff & Edward.

 This patch adds support for sil_3131 and sil_3531.  Both are
identical to 3124 except that they have only one port.  Bits 30 and 31
of ata_port_info->host_flags is used to encode available port numbers.
Version number is bumped to 0.22.

 Edward Falk supplied all the necessary information and preliminary
patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -41,7 +41,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.21"	/* Silicon Image's preview driver was 0.10 */
+#define DRV_VERSION	"0.22"	/* Silicon Image's preview driver was 0.10 */
 
 /*
  * Port request block (PRB) 32 bytes
@@ -196,6 +196,7 @@ enum {
 	/* board id */
 	BID_SIL3124		= 0,
 	BID_SIL3132		= 1,
+	BID_SIL3131		= 2,
 
 	IRQ_STAT_4PORTS		= 0xf,
 };
@@ -242,6 +243,8 @@ static int sil24_init_one(struct pci_dev
 static struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
 	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
+	{ 0x1095, 0x3131, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
+	{ 0x1095, 0x3531, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
 	{ } /* terminate list */
 };
 
@@ -300,13 +303,20 @@ static struct ata_port_operations sil24_
 	.host_stop		= sil24_host_stop,
 };
 
+/*
+ * Use bits 30-31 of host_flags to encode available port numbers.
+ * Current maxium is 4.
+ */
+#define SIL24_NPORTS2FLAG(nports)	((((unsigned)(nports) - 1) & 0x3) << 30)
+#define SIL24_FLAG2NPORTS(flag)		((((flag) >> 30) & 0x3) + 1)
+
 static struct ata_port_info sil24_port_info[] = {
 	/* sil_3124 */
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(4),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -317,7 +327,18 @@ static struct ata_port_info sil24_port_i
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_DMA,
+				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(2),
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil24_ops,
+	},
+	/* sil_3131/sil_3531 */
+	{
+		.sht		= &sil24_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_DMA | SIL24_NPORTS2FLAG(1),
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -665,6 +686,7 @@ static int sil24_init_one(struct pci_dev
 {
 	static int printed_version = 0;
 	unsigned int board_id = (unsigned int)ent->driver_data;
+	struct ata_port_info *pinfo = &sil24_port_info[board_id];
 	struct ata_probe_ent *probe_ent = NULL;
 	struct sil24_host_priv *hpriv = NULL;
 	void *host_base = NULL, *port_base = NULL;
@@ -705,12 +727,12 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	probe_ent->sht		= sil24_port_info[board_id].sht;
-	probe_ent->host_flags	= sil24_port_info[board_id].host_flags;
-	probe_ent->pio_mask	= sil24_port_info[board_id].pio_mask;
-	probe_ent->udma_mask	= sil24_port_info[board_id].udma_mask;
-	probe_ent->port_ops	= sil24_port_info[board_id].port_ops;
-	probe_ent->n_ports	= (board_id == BID_SIL3124) ? 4 : 2;
+	probe_ent->sht		= pinfo->sht;
+	probe_ent->host_flags	= pinfo->host_flags;
+	probe_ent->pio_mask	= pinfo->pio_mask;
+	probe_ent->udma_mask	= pinfo->udma_mask;
+	probe_ent->port_ops	= pinfo->port_ops;
+	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
