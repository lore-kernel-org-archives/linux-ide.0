From: Li Yang <leoli@freescale.com>
Subject: [PATCH 04/12] ata/sata_fsl: Kill ata_sg_is_last()
Date: Wed, 31 Oct 2007 19:27:56 +0800
Message-ID: <1193830084-22298-4-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56725 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093AbXJaLRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:48 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHkWi004848
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHB005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:45 -0500 (CDT)
In-Reply-To: <1193830084-22298-3-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index f8d8614..9e99cc8 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -355,7 +355,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 					"s/g len unaligned : 0x%x\n", sg_len);
 
 		if ((num_prde == (SATA_FSL_MAX_PRD_DIRECT - 1)) &&
-		    !ata_sg_is_last(sg, qc)) {
+		    (qc->n_iter + 1 != qc->n_elem)) {
 			VPRINTK("setting indirect prde\n");
 			prd_ptr_to_indirect_ext = prd;
 			prd->dba = cpu_to_le32(indirect_ext_segment_paddr);
-- 
1.5.3.2.104.g41ef

