Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C4C3F2DF
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1E205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgCCJjs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA0E2B217;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 19/40] pata_octeon_cf: add bmdma tracepoints and drop DPRINTK() calls
Date:   Tue,  3 Mar 2020 10:37:52 +0100
Message-Id: <20200303093813.18523-20-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add missing bmdma tracepoints and drop the now pointless
DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_octeon_cf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 9b66552efbd2..62646dbc9d71 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -19,7 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <scsi/scsi_host.h>
-
+#include <trace/events/libata.h>
 #include <asm/byteorder.h>
 #include <asm/octeon/octeon.h>
 
@@ -535,12 +535,10 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
 	struct octeon_cf_port *cf_port;
 
 	cf_port = ap->private_data;
-	DPRINTK("ENTER\n");
 	/* issue r/w command */
 	qc->cursg = qc->sg;
 	cf_port->dma_finished = 0;
 	ap->ops->sff_exec_command(ap, &qc->tf);
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -792,8 +790,11 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		octeon_cf_dma_setup(qc);	    /* set up dma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		octeon_cf_dma_start(qc);	    /* initiate dma */
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-- 
2.16.4

