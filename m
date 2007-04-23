From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ali: More work
Date: Mon, 23 Apr 2007 11:53:29 +0100
Message-ID: <20070423115329.4c27fc70@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53843 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161356AbXDWKuA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 06:50:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Still don't know why some people see problems with ATAPI devices
specifically but here are some more small fixes done while searching for
the root problem (some of these fixes are overconservative but that can
be fixed *after* the thing works fully)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc6-mm1/drivers/ata/pata_ali.c linux-2.6.21-rc6-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.21-rc6-mm1/drivers/ata/pata_ali.c	2007-04-12 14:15:03.000000000 +0100
+++ linux-2.6.21-rc6-mm1/drivers/ata/pata_ali.c	2007-04-23 11:34:40.423648592 +0100
@@ -346,6 +346,16 @@
 	return 0;
 }
 
+static int ali_check_atapi_dma_20(struct ata_queued_cmd *qc)
+{
+	if (qc->dma_dir == DMA_TO_DEVICE)
+		return -1;
+	/* Don't do DMA except for whole blocks */
+	if (qc->nbytes & 511)
+		return -1;
+	return 0;
+}
+
 static struct scsi_host_template ali_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -389,7 +399,6 @@
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.check_atapi_dma= ali_check_atapi_dma,
 
 	.data_xfer	= ata_data_xfer,
 
@@ -432,7 +441,7 @@
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.check_atapi_dma= ali_check_atapi_dma,
+	.check_atapi_dma= ali_check_atapi_dma_20,
 
 	.data_xfer	= ata_data_xfer,
 
@@ -629,22 +638,22 @@
 		.udma_mask = 0x1f,
 		.port_ops = &ali_c2_port_ops
 	};
-	/* Revision 0xC3 is UDMA100 */
+	/* Revision 0xC3 is UDMA66 for now */
 	static struct ata_port_info info_c3 = {
 		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
-		.udma_mask = 0x3f,
+		.udma_mask = 0x1f,
 		.port_ops = &ali_c2_port_ops
 	};
-	/* Revision 0xC4 is UDMA133 */
+	/* Revision 0xC4 is UDMA100 */
 	static struct ata_port_info info_c4 = {
 		.sht = &ali_sht,
 		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_PIO_LBA48,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
-		.udma_mask = 0x7f,
+		.udma_mask = 0x3f,
 		.port_ops = &ali_c2_port_ops
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
