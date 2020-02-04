Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CDDC388EB
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B312087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgBDQ4P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbgBDQ4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25DC7B1C7;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/46] pata_octeon_cf: add bmdma tracepoints and drop DPRINTK()
Date:   Tue,  4 Feb 2020 17:55:27 +0100
Message-Id: <20200204165547.115220-27-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add missing bmdma tracepoints and drop the now pointless
DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index f5cd89173028..9527216e59b9 100644
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
 
@@ -517,17 +517,14 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
 	u16 blob;
 
 	if (tf->flags & ATA_TFLAG_DEVICE) {
-		VPRINTK("device 0x%X\n", tf->device);
 		blob = tf->device;
 	} else {
 		blob = 0;
 	}
 
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 	blob |= (tf->command << 8);
 	__raw_writew(blob, base + 6);
 
-
 	ata_wait_idle(ap);
 }
 
@@ -541,12 +538,10 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
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
@@ -798,8 +793,11 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf, qc->tag);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(qp, &qc->tf, qc->tag);
 		octeon_cf_dma_setup(qc);	    /* set up dma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		octeon_cf_dma_start(qc);	    /* initiate dma */
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-- 
2.16.4

