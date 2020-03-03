Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E18BC3F2E5
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B5205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgCCJju (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbgCCJjt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29A2AB248;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 34/40] sata_nv: move DPRINTK to ata debugging
Date:   Tue,  3 Mar 2020 10:38:07 +0100
Message-Id: <20200303093813.18523-35-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace all DPRINTK calls with the ata_XXX_dbg functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_nv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f7dd32679c8e..0bdf18625d95 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2094,7 +2094,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
 
 	if (!ap->qc_active) {
-		DPRINTK("over\n");
+		ata_port_dbg(ap, "over\n");
 		nv_swncq_pp_reinit(ap);
 		return 0;
 	}
@@ -2109,10 +2109,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
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
 
@@ -2154,7 +2154,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
 	__ata_bmdma_stop(ap);
 	tag = nv_swncq_tag(ap);
 
-	DPRINTK("dma setup tag 0x%x\n", tag);
+	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);
 	qc = ata_qc_from_tag(ap, tag);
 
 	if (unlikely(!qc))
@@ -2222,9 +2222,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 
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
@@ -2250,7 +2250,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 				goto irq_exit;
 
 			if (pp->defer_queue.defer_bits) {
-				DPRINTK("send next command\n");
+				ata_port_dbg(ap, "send next command\n");
 				qc = nv_swncq_qc_from_dq(ap);
 				nv_swncq_issue_atacmd(ap, qc);
 			}
-- 
2.16.4

