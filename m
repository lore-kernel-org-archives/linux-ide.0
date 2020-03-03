Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C8C3F2E7
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1828214DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgCCJjt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgCCJjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17343B240;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 28/40] libata-eh: remove DPRINTK() calls for request sense
Date:   Tue,  3 Mar 2020 10:38:01 +0100
Message-Id: <20200303093813.18523-29-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The information will printed during ata_qc_issue() anyway, so
this messages can be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f37dad5f9c17..388f8ed46eab 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1538,8 +1538,6 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
 		return;
 	}
 
-	DPRINTK("ATA request sense\n");
-
 	ata_tf_init(dev, &tf);
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
@@ -1580,8 +1578,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 
-	DPRINTK("ATAPI request sense\n");
-
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
 	/* initialize sense_buf with the error register,
-- 
2.16.4

