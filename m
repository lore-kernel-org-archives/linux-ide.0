Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5864EC3524D
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA220674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBDQ4J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDQ4J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00228B16D;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/46] sata_nv: move DPRINTK to ata debugging
Date:   Tue,  4 Feb 2020 17:55:12 +0100
Message-Id: <20200204165547.115220-12-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Replace all DPRINTK calls with the ata_XXX_dbg functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_nv.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8639f66706a3..0cbddad7cd12 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1394,7 +1394,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 	void __iomem *mmio = pp->ctl_block;
 	int curr_ncq = (qc->tf.protocol == ATA_PROT_NCQ);
 
-	VPRINTK("ENTER\n");
+	ata_dev_dbg(qc->dev, "ENTER\n");
 
 	/* We can't handle result taskfile with NCQ commands, since
 	   retrieving the taskfile switches us out of ADMA mode and would abort
@@ -1428,7 +1428,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 
 	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
+	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);
 
 	return 0;
 }
@@ -2007,7 +2007,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
 	if (qc == NULL)
 		return 0;
 
-	DPRINTK("Enter\n");
+	ata_port_dbg(ap, "Enter\n");
 
 	writel((1 << qc->hw_tag), pp->sactive_block);
 	pp->last_issue_tag = qc->hw_tag;
@@ -2018,7 +2018,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
 	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
 	ap->ops->sff_exec_command(ap, &qc->tf);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
+	ata_port_dbg(ap, "Issued tag %u\n", qc->hw_tag);
 
 	return 0;
 }
@@ -2031,7 +2031,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	if (qc->tf.protocol != ATA_PROT_NCQ)
 		return ata_bmdma_qc_issue(qc);
 
-	DPRINTK("Enter\n");
+	ata_port_dbg(ap, "Enter\n");
 
 	if (!pp->qc_active)
 		nv_swncq_issue_atacmd(ap, qc);
@@ -2099,7 +2099,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
 
 	if (!ap->qc_active) {
-		DPRINTK("over\n");
+		ata_port_dbg(ap, "over\n");
 		nv_swncq_pp_reinit(ap);
 		return 0;
 	}
@@ -2114,10 +2114,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 		 */
 		lack_dhfis = 1;
 
-	DPRINTK("id 0x%x QC: qc_active 0x%x,"
+	ata_port_dbg(ap, "QC: qc_active 0x%llx,"
 		"SWNCQ:qc_active 0x%X defer_bits %X "
 		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
-		ap->print_id, ap->qc_active, pp->qc_active,
+		ap->qc_active, pp->qc_active,
 		pp->defer_queue.defer_bits, pp->dhfis_bits,
 		pp->dmafis_bits, pp->last_issue_tag);
 
@@ -2159,7 +2159,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
 	__ata_bmdma_stop(ap);
 	tag = nv_swncq_tag(ap);
 
-	DPRINTK("dma setup tag 0x%x\n", tag);
+	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);
 	qc = ata_qc_from_tag(ap, tag);
 
 	if (unlikely(!qc))
@@ -2227,9 +2227,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 
 	if (fis & NV_SWNCQ_IRQ_SDBFIS) {
 		pp->ncq_flags |= ncq_saw_sdb;
-		DPRINTK("id 0x%x SWNCQ: qc_active 0x%X "
+		ata_port_dbg(ap, "SWNCQ: qc_active 0x%X "
 			"dhfis 0x%X dmafis 0x%X sactive 0x%X\n",
-			ap->print_id, pp->qc_active, pp->dhfis_bits,
+			pp->qc_active, pp->dhfis_bits,
 			pp->dmafis_bits, readl(pp->sactive_block));
 		if (nv_swncq_sdbfis(ap) < 0)
 			goto irq_error;
@@ -2255,7 +2255,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 				goto irq_exit;
 
 			if (pp->defer_queue.defer_bits) {
-				DPRINTK("send next command\n");
+				ata_port_dbg(ap, "send next command\n");
 				qc = nv_swncq_qc_from_dq(ap);
 				nv_swncq_issue_atacmd(ap, qc);
 			}
-- 
2.16.4

