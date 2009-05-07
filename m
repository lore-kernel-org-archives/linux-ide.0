From: Dave Liu <daveliu@freescale.com>
Subject: [PATCH] ata: Fix the command description of FSL SATA controller
Date: Thu,  7 May 2009 21:53:17 +0800
Message-ID: <1241704397-24043-1-git-send-email-daveliu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:51536 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762199AbZEGN6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 May 2009 09:58:12 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n47DvtCH017368
	for <linux-ide@vger.kernel.org>; Thu, 7 May 2009 06:58:06 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net [10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n47Dvrud026437
	for <linux-ide@vger.kernel.org>; Thu, 7 May 2009 08:57:54 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Dave Liu <daveliu@freescale.com>

The bit 11 of command description is reserved bit in Freescale
SATA controller, we should be set '1'.

Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 drivers/ata/sata_fsl.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index c2e90e1..f158bd7 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -205,6 +205,7 @@ struct cmdhdr_tbl_entry {
  * Description information bitdefs
  */
 enum {
+	CMD_DESC_RES = (1 << 11),
 	VENDOR_SPECIFIC_BIST = (1 << 10),
 	CMD_DESC_SNOOP_ENABLE = (1 << 9),
 	FPDMA_QUEUED_CMD = (1 << 8),
@@ -387,7 +388,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	void __iomem *hcr_base = host_priv->hcr_base;
 	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
 	struct command_desc *cd;
-	u32 desc_info = CMD_DESC_SNOOP_ENABLE;
+	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
 	u32 num_prde = 0;
 	u32 ttl_dwords = 0;
 	dma_addr_t cd_paddr;
@@ -840,7 +841,7 @@ issue_srst:
 
 	/* device reset/SRST is a control register update FIS, uses tag0 */
 	sata_fsl_setup_cmd_hdr_entry(pp, 0,
-				     SRST_CMD | CMD_DESC_SNOOP_ENABLE, 0, 0, 5);
+		SRST_CMD | CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE, 0, 0, 5);
 
 	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
 	ata_tf_to_fis(&tf, pmp, 0, cfis);
@@ -886,7 +887,8 @@ issue_srst:
 	 * using ATA signature D2H register FIS to the host controller.
 	 */
 
-	sata_fsl_setup_cmd_hdr_entry(pp, 0, CMD_DESC_SNOOP_ENABLE, 0, 0, 5);
+	sata_fsl_setup_cmd_hdr_entry(pp, 0, CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE,
+				      0, 0, 5);
 
 	tf.ctl &= ~ATA_SRST;	/* 2nd H2D Ctl. register FIS */
 	ata_tf_to_fis(&tf, pmp, 0, cfis);
-- 
1.5.4

