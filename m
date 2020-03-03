Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92AC3F2DE
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FD7205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgCCJjs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D970DB215;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 20/40] pata_arasan_cf: use generic tracepoints
Date:   Tue,  3 Mar 2020 10:37:53 +0100
Message-Id: <20200303093813.18523-21-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For completeness add generic tracepoints for bus-master DMA.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_arasan_cf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index e9cf31f38450..f066c47f8d6e 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -39,6 +39,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <trace/events/libata.h>
 
 #define DRIVER_NAME	"arasan_cf"
 #define TIMEOUT		msecs_to_jiffies(3000)
@@ -703,9 +704,11 @@ static unsigned int arasan_cf_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);
 		acdev->dma_status = 0;
 		acdev->qc = qc;
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag)
 		arasan_cf_dma_start(acdev);
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-- 
2.16.4

