Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16658C3B185
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37382087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBDQ4Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:34808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgBDQ4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27199B1CC;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/46] libata-core: drop DPRINTK() calls in reset
Date:   Tue,  4 Feb 2020 17:55:23 +0100
Message-Id: <20200204165547.115220-23-hare@suse.de>
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
 drivers/ata/libata-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8a18047f9bcb..297aa8172d4e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4070,8 +4070,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (online)
 		*online = false;
 
@@ -4147,7 +4145,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			*online = false;
 		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
 	}
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
@@ -4193,16 +4190,12 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
 	u32 serror;
 
-	DPRINTK("ENTER\n");
-
 	/* reset complete, clear SError */
 	if (!sata_scr_read(link, SCR_ERROR, &serror))
 		sata_scr_write(link, SCR_ERROR, serror);
 
 	/* print link status */
 	sata_print_link_status(link);
-
-	DPRINTK("EXIT\n");
 }
 
 /**
-- 
2.16.4

