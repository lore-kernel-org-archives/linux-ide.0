Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7EC3F2EB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BA205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCCJjv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:47780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgCCJjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3404B22A;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/40] sata_nv: use generic tracepoints
Date:   Tue,  3 Mar 2020 10:37:55 +0100
Message-Id: <20200303093813.18523-23-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove logging messages covered by generic tracepoints and add
generic tracepoints for internal calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_nv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8639f66706a3..f7dd32679c8e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -31,6 +31,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
+#include <trace/events/libata.h>
 
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"3.5"
@@ -1428,8 +1429,6 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 
 	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
-
 	return 0;
 }
 
@@ -2007,19 +2006,17 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
 	if (qc == NULL)
 		return 0;
 
-	DPRINTK("Enter\n");
-
 	writel((1 << qc->hw_tag), pp->sactive_block);
 	pp->last_issue_tag = qc->hw_tag;
 	pp->dhfis_bits &= ~(1 << qc->hw_tag);
 	pp->dmafis_bits &= ~(1 << qc->hw_tag);
 	pp->qc_active |= (0x1 << qc->hw_tag);
 
+	trace_ata_tf_load(ap, &qc->tf);
 	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
+	trace_ata_exec_command(ap, &qc->tf, qc->hw_tag);
 	ap->ops->sff_exec_command(ap, &qc->tf);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
-
 	return 0;
 }
 
@@ -2031,8 +2028,6 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	if (qc->tf.protocol != ATA_PROT_NCQ)
 		return ata_bmdma_qc_issue(qc);
 
-	DPRINTK("Enter\n");
-
 	if (!pp->qc_active)
 		nv_swncq_issue_atacmd(ap, qc);
 	else
-- 
2.16.4

