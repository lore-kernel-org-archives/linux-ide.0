From: Li Yang <leoli@freescale.com>
Subject: [PATCH 11/12] ata/sata_fsl: Remove sending LOG EXT command in sata_fsl_softreset()
Date: Wed, 31 Oct 2007 19:28:03 +0800
Message-ID: <1193830084-22298-11-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
 <1193830084-22298-7-git-send-email-leoli@freescale.com>
 <1193830084-22298-8-git-send-email-leoli@freescale.com>
 <1193830084-22298-9-git-send-email-leoli@freescale.com>
 <1193830084-22298-10-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:44112 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbXJaLSA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:18:00 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9VBHvrJ007374
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHP005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:57 -0500 (CDT)
In-Reply-To: <1193830084-22298-10-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: ashish kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>

From: ashish kalra <ashish.kalra@freescale.com>

Signed-off-by: ashish kalra <ashish.kalra@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |   70 ------------------------------------------------
 1 files changed, 0 insertions(+), 70 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e076e1f..c3b0360 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -730,10 +730,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	u8 *cfis;
 	u32 Serror;
 	int i = 0;
-	struct ata_queued_cmd qc;
-	u8 *buf;
-	dma_addr_t dma_address;
-	struct scatterlist *sg;
 	unsigned long start_jiffies;
 
 	DPRINTK("in xx_softreset\n");
@@ -833,9 +829,6 @@ try_offline_again:
 	 * reached here, we can send a command to the target device
 	 */
 
-	if (link->sactive)
-		goto skip_srst_do_ncq_error_handling;
-
 	DPRINTK("Sending SRST/device reset\n");
 
 	ata_tf_init(link->device, &tf);
@@ -903,69 +896,6 @@ try_offline_again:
 	 * command bit of the CCreg
 	 */
 	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
-	goto check_device_signature;
-
-skip_srst_do_ncq_error_handling:
-
-	VPRINTK("Sending read log ext(10h) command\n");
-
-	memset(&qc, 0, sizeof(struct ata_queued_cmd));
-	ata_tf_init(link->device, &tf);
-
-	tf.command = ATA_CMD_READ_LOG_EXT;
-	tf.lbal = ATA_LOG_SATA_NCQ;
-	tf.nsect = 1;
-	tf.hob_nsect = 0;
-	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_LBA48 | ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_PIO;
-
-	qc.tag = ATA_TAG_INTERNAL;
-	qc.scsicmd = NULL;
-	qc.ap = ap;
-	qc.dev = link->device;
-
-	qc.tf = tf;
-	qc.flags |= ATA_QCFLAG_RESULT_TF;
-	qc.dma_dir = DMA_FROM_DEVICE;
-
-	buf = ap->sector_buf;
-	ata_sg_init_one(&qc, buf, 1 * ATA_SECT_SIZE);
-
-	/*
-	 * Need to DMA-map the memory buffer associated with the command
-	 */
-
-	sg = qc.__sg;
-	dma_address = dma_map_single(ap->dev, qc.buf_virt,
-				     sg->length, DMA_FROM_DEVICE);
-
-	sg_dma_address(sg) = dma_address;
-	sg_dma_len(sg) = sg->length;
-
-	VPRINTK("EH, addr = 0x%x, len = 0x%x\n", dma_address, sg->length);
-
-	sata_fsl_qc_prep(&qc);
-	sata_fsl_qc_issue(&qc);
-
-	temp = ata_wait_register(CQ + hcr_base, 0x1, 0x1, 1, 5000);
-	if (temp & 0x1) {
-		VPRINTK("READ_LOG_EXT_10H issue failed\n");
-
-		VPRINTK("READ_LOG@5000,CQ=0x%x,CA=0x%x,CC=0x%x\n",
-			ioread32(CQ + hcr_base),
-			ioread32(CA + hcr_base), ioread32(CC + hcr_base));
-
-		sata_fsl_scr_read(ap, SCR_ERROR, &Serror);
-
-		VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
-		VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
-		VPRINTK("Serror = 0x%x\n", Serror);
-		goto err;
-	}
-
-	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
-
-check_device_signature:
 
 	DPRINTK("SATA FSL : Now checking device signature\n");
 
-- 
1.5.3.2.104.g41ef

