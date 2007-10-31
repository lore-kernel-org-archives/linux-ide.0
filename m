From: Li Yang <leoli@freescale.com>
Subject: [PATCH 09/12] ata/sata_fsl: cleanup style problem
Date: Wed, 31 Oct 2007 19:28:01 +0800
Message-ID: <1193830084-22298-9-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
 <1193830084-22298-7-git-send-email-leoli@freescale.com>
 <1193830084-22298-8-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56773 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbXJaLR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:57 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHs25004891
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:54 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHL005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:53 -0500 (CDT)
In-Reply-To: <1193830084-22298-8-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 03629b6..5892472 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -269,7 +269,7 @@ struct sata_fsl_host_priv {
 };
 
 static inline unsigned int sata_fsl_tag(unsigned int tag,
-					void __iomem * hcr_base)
+					void __iomem *hcr_base)
 {
 	/* We let libATA core do actual (queue) tag allocation */
 
@@ -308,7 +308,7 @@ static void sata_fsl_setup_cmd_hdr_entry(struct sata_fsl_port_priv *pp,
 	pp->cmdslot[tag].prde_fis_len =
 	    cpu_to_le32((num_prde << 16) | (fis_len << 2));
 	pp->cmdslot[tag].ttl = cpu_to_le32(data_xfer_len & ~0x03);
-	pp->cmdslot[tag].desc_info = cpu_to_le32((desc_info | (tag & 0x1F)));
+	pp->cmdslot[tag].desc_info = cpu_to_le32(desc_info | (tag & 0x1F));
 
 	VPRINTK("cda=0x%x, prde_fis_len=0x%x, ttl=0x%x, di=0x%x\n",
 		pp->cmdslot[tag].cda,
@@ -318,7 +318,7 @@ static void sata_fsl_setup_cmd_hdr_entry(struct sata_fsl_port_priv *pp,
 }
 
 static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
-				     u32 * ttl, dma_addr_t cmd_desc_paddr)
+				     u32 *ttl, dma_addr_t cmd_desc_paddr)
 {
 	struct scatterlist *sg;
 	unsigned int num_prde = 0;
@@ -406,7 +406,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	cd = (struct command_desc *)pp->cmdentry + tag;
 	cd_paddr = pp->cmdentry_paddr + tag * SATA_FSL_CMD_DESC_SIZE;
 
-	ata_tf_to_fis(&qc->tf, 0, 1, (u8 *) & cd->cfis);
+	ata_tf_to_fis(&qc->tf, 0, 1, (u8 *) &cd->cfis);
 
 	VPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x\n",
 		cd->cfis[0], cd->cfis[1], cd->cfis[2]);
@@ -837,7 +837,7 @@ try_offline_again:
 	DPRINTK("Sending SRST/device reset\n");
 
 	ata_tf_init(link->device, &tf);
-	cfis = (u8 *) & pp->cmdentry->cfis;
+	cfis = (u8 *) &pp->cmdentry->cfis;
 
 	/* device reset/SRST is a control register update FIS, uses tag0 */
 	sata_fsl_setup_cmd_hdr_entry(pp, 0,
@@ -963,7 +963,7 @@ skip_srst_do_ncq_error_handling:
 
 	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
 
-      check_device_signature:
+check_device_signature:
 
 	DPRINTK("SATA FSL : Now checking device signature\n");
 
-- 
1.5.3.2.104.g41ef

