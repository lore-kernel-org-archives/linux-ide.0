Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE24C352A4
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5402087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBDQ4O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgBDQ4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 137FEB1BB;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/46] libahci: drop DPRINTK() calls in reset
Date:   Tue,  4 Feb 2020 17:55:19 +0100
Message-Id: <20200204165547.115220-19-hare@suse.de>
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
 drivers/ata/libahci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c1bc973ecc16..1c6d98fab3a3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1391,8 +1391,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	bool fbs_disabled = false;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap);
 	if (rc && rc != -EOPNOTSUPP)
@@ -1452,7 +1450,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (fbs_disabled)
 		ahci_enable_fbs(ap);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  fail:
@@ -1474,8 +1471,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 {
 	int pmp = sata_srst_pmp(link);
 
-	DPRINTK("ENTER\n");
-
 	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
 EXPORT_SYMBOL_GPL(ahci_do_softreset);
@@ -1505,8 +1500,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	u32 irq_sts;
 
-	DPRINTK("ENTER\n");
-
 	rc = ahci_do_softreset(link, class, pmp, deadline,
 			       ahci_bad_pmp_check_ready);
 
@@ -1540,8 +1533,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_taskfile tf;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
@@ -1557,7 +1548,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	if (*online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_do_hardreset);
-- 
2.16.4

