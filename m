Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B0C3F2E9
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299D3205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgCCJj4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgCCJjt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04CD5B22D;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/40] libata: add tracepoints for ATA error handling
Date:   Tue,  3 Mar 2020 10:37:59 +0100
Message-Id: <20200303093813.18523-27-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for ATA error handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c       | 10 +++++---
 include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef3576eb5874..a068b5370aac 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -933,7 +933,7 @@ void ata_std_sched_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
-	DPRINTK("port EH scheduled\n");
+	trace_ata_std_sched_eh(ap);
 }
 EXPORT_SYMBOL_GPL(ata_std_sched_eh);
 
@@ -1060,7 +1060,7 @@ static void __ata_port_freeze(struct ata_port *ap)
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->print_id);
+	trace_ata_port_freeze(ap);
 }
 
 /**
@@ -1208,7 +1208,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->print_id);
+	trace_ata_port_thaw(ap);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
@@ -1347,6 +1347,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	ata_eh_clear_action(link, dev, ehi, action);
@@ -1377,6 +1379,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
+	trace_ata_eh_done(link, dev ? dev->devno : 0, action);
+
 	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 06bc6756f1dc..7d48e804b889 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -457,6 +457,37 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
 		  __parse_eh_err_mask(__entry->eh_err_mask))
 );
 
+DECLARE_EVENT_CLASS(ata_eh_action_template,
+
+	TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
+
+	TP_ARGS(link, devno, eh_action),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	eh_action )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= link->ap->print_id;
+		__entry->ata_dev	= link->pmp + devno;
+		__entry->eh_action	= eh_action;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u eh_action=%s",
+		  __entry->ata_port, __entry->ata_dev,
+		  __parse_eh_action(__entry->eh_action))
+);
+
+DEFINE_EVENT(ata_eh_action_template, ata_eh_about_to_do,
+	     TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
+	     TP_ARGS(link, devno, eh_action));
+
+DEFINE_EVENT(ata_eh_action_template, ata_eh_done,
+	     TP_PROTO(struct ata_link *link, unsigned int devno, unsigned int eh_action),
+	     TP_ARGS(link, devno, eh_action));
+
 DECLARE_EVENT_CLASS(ata_link_reset_begin_template,
 
 	TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
@@ -537,6 +568,35 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
 	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
 	     TP_ARGS(link, class, rc));
 
+DECLARE_EVENT_CLASS(ata_port_eh_begin_template,
+
+	TP_PROTO(struct ata_port *ap),
+
+	TP_ARGS(ap),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+	),
+
+	TP_printk("ata_port=%u", __entry->ata_port)
+);
+
+DEFINE_EVENT(ata_port_eh_begin_template, ata_std_sched_eh,
+	     TP_PROTO(struct ata_port *ap),
+	     TP_ARGS(ap));
+
+DEFINE_EVENT(ata_port_eh_begin_template, ata_port_freeze,
+	     TP_PROTO(struct ata_port *ap),
+	     TP_ARGS(ap));
+
+DEFINE_EVENT(ata_port_eh_begin_template, ata_port_thaw,
+	     TP_PROTO(struct ata_port *ap),
+	     TP_ARGS(ap));
+
 DECLARE_EVENT_CLASS(ata_sff_hsm_template,
 
 	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
-- 
2.16.4

