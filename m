Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA216C3F2CD
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87E214DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgCCJjp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgCCJjp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD964B1FA;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/40] libata: sanitize ATA_HORKAGE_DUMP_ID
Date:   Tue,  3 Mar 2020 10:37:44 +0100
Message-Id: <20200303093813.18523-12-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As ata_dev_dbg() is now using dynamic debugging ATA_HORKAGE_DUMP_ID
will now print out the raw IDENTIFY data without a header unless
explicitly enable via dyndebug.
So move the logging level up to INFO and have the header printed
always.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1987886140b6..40e327e49905 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1944,10 +1944,10 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	}
 
 	if (dev->horkage & ATA_HORKAGE_DUMP_ID) {
-		ata_dev_dbg(dev, "dumping IDENTIFY data, "
+		ata_dev_info(dev, "dumping IDENTIFY data, "
 			    "class=%d may_fallback=%d tried_spinup=%d\n",
 			    class, may_fallback, tried_spinup);
-		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET,
+		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
 			       16, 2, id, ATA_ID_WORDS * sizeof(*id), true);
 	}
 
-- 
2.16.4

