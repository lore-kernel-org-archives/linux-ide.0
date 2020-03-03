Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770FC3F2E4
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188F214DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgCCJjt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgCCJjr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBD66B21B;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 21/40] sata_dwc_460ex: use generic tracepoints
Date:   Tue,  3 Mar 2020 10:37:54 +0100
Message-Id: <20200303093813.18523-22-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add generic tracepoints and drop the now obsolete logging statements.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_dwc_460ex.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index ef07d4a03627..a29cd81b7811 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -34,6 +34,7 @@
 #include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
+#include <trace/events/libata.h>
 
 #include "libata.h"
 
@@ -311,21 +312,6 @@ static const char *get_dma_dir_descript(int dma_dir)
 	}
 }
 
-static void sata_dwc_tf_dump(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	dev_vdbg(ap->dev,
-		"taskfile cmd: 0x%02x protocol: %s flags: 0x%lx device: %x\n",
-		tf->command, get_prot_descript(tf->protocol), tf->flags,
-		tf->device);
-	dev_vdbg(ap->dev,
-		"feature: 0x%02x nsect: 0x%x lbal: 0x%x lbam: 0x%x lbah: 0x%x\n",
-		tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
-	dev_vdbg(ap->dev,
-		"hob_feature: 0x%02x hob_nsect: 0x%x hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
-		tf->hob_feature, tf->hob_nsect, tf->hob_lbal, tf->hob_lbam,
-		tf->hob_lbah);
-}
-
 static void dma_dwc_xfer_done(void *hsdev_instance)
 {
 	unsigned long flags;
@@ -548,6 +534,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		 * active tag.  It is the tag that matches the command about to
 		 * be completed.
 		 */
+		trace_ata_bmdma_start(ap, &qc->tf, tag);
 		qc->ap->link.active_tag = tag;
 		sata_dwc_bmdma_start_by_tag(qc, tag);
 
@@ -1021,12 +1008,6 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		start_dma = 0;
 	}
 
-	dev_dbg(ap->dev,
-		"%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s start_dma? %x\n",
-		__func__, qc, tag, qc->tf.command,
-		get_dma_dir_descript(qc->dma_dir), start_dma);
-	sata_dwc_tf_dump(ap, &qc->tf);
-
 	if (start_dma) {
 		sata_dwc_scr_read(&ap->link, SCR_ERROR, &reg);
 		if (reg & SATA_DWC_SERROR_ERR_BITS) {
@@ -1064,16 +1045,6 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
-#ifdef DEBUG_NCQ
-	if (qc->hw_tag > 0 || ap->link.sactive > 1)
-		dev_info(ap->dev,
-			 "%s ap id=%d cmd(0x%02x)=%s qc tag=%d prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
-			 __func__, ap->print_id, qc->tf.command,
-			 ata_get_cmd_descript(qc->tf.command),
-			 qc->hw_tag, get_prot_descript(qc->tf.protocol),
-			 ap->link.active_tag, ap->link.sactive);
-#endif
-
 	if (!ata_is_ncq(qc->tf.protocol))
 		tag = 0;
 
@@ -1090,11 +1061,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 		sactive |= (0x00000001 << tag);
 		sata_dwc_scr_write(&ap->link, SCR_ACTIVE, sactive);
 
-		dev_dbg(qc->ap->dev,
-			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
-			__func__, tag, qc->ap->link.sactive, sactive);
-
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);
+		trace_ata_exec_command(qp, &qc->tf, tag);
 		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
 					     SATA_DWC_CMD_ISSUED_PEND);
 	} else {
-- 
2.16.4

