Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A1C3F2D8
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB621775
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCCJjr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1120B221;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/40] libata-sff: add tracepoints for ata_sff_flush_pio_task()
Date:   Tue,  3 Mar 2020 10:37:57 +0100
Message-Id: <20200303093813.18523-25-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace DPRINTK calls with tracepoints.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sff.c      |  5 +----
 include/trace/events/libata.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f6a54b574b25..ffe633f13f55 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1234,7 +1234,7 @@ EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
 
 void ata_sff_flush_pio_task(struct ata_port *ap)
 {
-	DPRINTK("ENTER\n");
+	trace_ata_sff_flush_pio_task(ap);
 
 	cancel_delayed_work_sync(&ap->sff_pio_task);
 
@@ -1251,9 +1251,6 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	spin_unlock_irq(ap->lock);
 
 	ap->sff_pio_task_link = NULL;
-
-	if (ata_msg_ctl(ap))
-		ata_port_dbg(ap, "EXIT\n");
 }
 
 static void ata_sff_pio_task(struct work_struct *work)
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 135b1df472e5..06bc6756f1dc 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -621,6 +621,31 @@ DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
 	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
 	     TP_ARGS(qc, offset, count));
 
+DECLARE_EVENT_CLASS(ata_sff_template,
+
+	TP_PROTO(struct ata_port *ap),
+
+	TP_ARGS(ap),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned char,	hsm_state )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+		__entry->hsm_state	= ap->hsm_task_state;
+	),
+
+	TP_printk("ata_port=%u task_state=%s",
+		  __entry->ata_port,
+		  show_sff_hsm_state_name(__entry->hsm_state))
+);
+
+DEFINE_EVENT(ata_sff_template, ata_sff_flush_pio_task,
+	     TP_PROTO(struct ata_port *ap),
+	     TP_ARGS(ap));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.16.4

