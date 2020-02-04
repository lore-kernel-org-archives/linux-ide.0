Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A0EC352A3
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B73920674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgBDQ4P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgBDQ4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DC0FB1BA;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/46] pata_octeon_cf: drop DPRINTK() calls in reset
Date:   Tue,  4 Feb 2020 17:55:18 +0100
Message-Id: <20200204165547.115220-18-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Reset is now logged with tracepoints, so the DPRINTK() calls can
be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index d3d851b014a3..f5cd89173028 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -440,7 +440,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
 	int rc;
 	u8 err;
 
-	DPRINTK("about to softreset\n");
 	__raw_writew(ap->ctl, base + 0xe);
 	udelay(20);
 	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
@@ -455,7 +454,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
 
 	/* determine by signature whether we have ATA or ATAPI devices */
 	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
 
-- 
2.16.4

