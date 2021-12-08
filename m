Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACAC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhLHQgk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F776218DF;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baUKbtNSh74UfEuMhSpprbaOG1vy2Zq+NPM/0/gP6i4=;
        b=CoVzV/huv/CSa/a9Ue6iARkTu74uNuFRo3gFyKCwFMGcHb/llwiHK2W+eAOFL1XW7fLfUc
        4MQM795Th/Gl2VbFhrIcv1qZyE/Lmgg3llyQWe1JDQ4FUj29wq3AQB/wYf261Rq+aqwDBg
        IHYWnqEEXMePRfjNSywyYPdK+i0Lek8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baUKbtNSh74UfEuMhSpprbaOG1vy2Zq+NPM/0/gP6i4=;
        b=s03TU63k7gqkDJcdkRoPzmyh0jLHwoKnArbOO9lCFELJeOm/ZIFctIIQJ+oPE16JLpHeMn
        MYYr4d2FamwZxkDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 32D69A3BA1;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 276AE5191F77; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 13/73] sata_dwc_460ex: use generic tracepoints
Date:   Wed,  8 Dec 2021 17:31:55 +0100
Message-Id: <20211208163255.114660-14-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add generic tracepoints and drop the now obsolete logging statements.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_dwc_460ex.c | 53 +++---------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index f5ef5ce5f758..6cdce9d00ed7 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -34,6 +34,7 @@
 #include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
+#include <trace/events/libata.h>
 
 #include "libata.h"
 
@@ -297,35 +298,6 @@ static const char *get_prot_descript(u8 protocol)
 	}
 }
 
-static const char *get_dma_dir_descript(int dma_dir)
-{
-	switch ((enum dma_data_direction)dma_dir) {
-	case DMA_BIDIRECTIONAL:
-		return "bidirectional";
-	case DMA_TO_DEVICE:
-		return "to device";
-	case DMA_FROM_DEVICE:
-		return "from device";
-	default:
-		return "none";
-	}
-}
-
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
@@ -553,6 +525,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		 * active tag.  It is the tag that matches the command about to
 		 * be completed.
 		 */
+		trace_ata_bmdma_start(ap, &qc->tf, tag);
 		qc->ap->link.active_tag = tag;
 		sata_dwc_bmdma_start_by_tag(qc, tag);
 
@@ -1031,12 +1004,6 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
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
@@ -1074,16 +1041,6 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
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
 
@@ -1100,11 +1057,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 		sactive |= (0x00000001 << tag);
 		sata_dwc_scr_write(&ap->link, SCR_ACTIVE, sactive);
 
-		dev_dbg(qc->ap->dev,
-			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
-			__func__, tag, qc->ap->link.sactive, sactive);
-
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);
+		trace_ata_exec_command(ap, &qc->tf, tag);
 		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
 					     SATA_DWC_CMD_ISSUED_PEND);
 	} else {
-- 
2.29.2

