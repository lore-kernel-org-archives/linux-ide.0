Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690EC3524F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1620674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgBDQ4O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbgBDQ4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 138C1B1BD;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/46] ahci: drop DPRINTK() calls in reset
Date:   Tue,  4 Feb 2020 17:55:16 +0100
Message-Id: <20200204165547.115220-16-hare@suse.de>
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
 drivers/ata/ahci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4f628e33f52e..56066cb4506f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -683,8 +683,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
@@ -692,8 +690,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	hpriv->start_engine(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
-
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
 	 */
@@ -773,8 +769,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc, i;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
@@ -812,7 +806,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 
-- 
2.16.4

