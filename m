Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6AC3B18A
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809E120674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBDQ4W (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:34808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgBDQ4O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38983B1D8;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 30/46] libata-core: add postreset tracepoints
Date:   Tue,  4 Feb 2020 17:55:31 +0100
Message-Id: <20200204165547.115220-31-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Add additional tracepoints for postreset and remove
the DPRINTK() call.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c       | 5 ++++-
 drivers/ata/libata-sff.c      | 4 +---
 include/trace/events/libata.h | 8 ++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 253dcf903c1b..ef3576eb5874 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2900,8 +2900,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 */
 	if (postreset) {
 		postreset(link, classes);
-		if (slave)
+		trace_ata_link_postreset(link, classes, rc);
+		if (slave) {
 			postreset(slave, classes);
+			trace_ata_slave_postreset(slave, classes, rc);
+		}
 	}
 
 	/*
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 228f801ef611..ffe633f13f55 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2052,10 +2052,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 		ap->ops->sff_dev_select(ap, 0);
 
 	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE)
 		return;
-	}
 
 	/* set up device control */
 	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 446f56cb3f01..40027d8424f8 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -526,6 +526,14 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
 	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
 	     TP_ARGS(link, class, rc));
 
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
 DECLARE_EVENT_CLASS(ata_sff_hsm_template,
 
 	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
-- 
2.16.4

