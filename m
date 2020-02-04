Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EFC352A1
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F742087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgBDQ4K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:34822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgBDQ4J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07BFDB1A8;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/46] libata: add reset tracepoints
Date:   Tue,  4 Feb 2020 17:55:15 +0100
Message-Id: <20200204165547.115220-15-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

To follow the flow of control we should be using tracepoints, as
they will tie in with the actual I/O flow and deliver a better
overview about what it happening.
This patch adds tracepoints for hard and soft reset and adds
them in the libata-eh control flow.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c       | 16 +++++++-
 include/trace/events/libata.h | 88 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3bfd9da58473..253dcf903c1b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2787,12 +2787,19 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
 		/* mark that this EH session started with reset */
 		ehc->last_reset = jiffies;
-		if (reset == hardreset)
+		if (reset == hardreset) {
 			ehc->i.flags |= ATA_EHI_DID_HARDRESET;
-		else
+			trace_ata_link_hardreset_begin(link, classes, deadline);
+		} else {
 			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
+			trace_ata_link_softreset_begin(link, classes, deadline);
+		}
 
 		rc = ata_do_reset(link, reset, classes, deadline, true);
+		if (reset == hardreset)
+			trace_ata_link_hardreset_end(link, classes, rc);
+		else
+			trace_ata_link_softreset_end(link, classes, rc);
 		if (rc && rc != -EAGAIN) {
 			failed_link = link;
 			goto fail;
@@ -2806,8 +2813,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 				ata_link_info(slave, "hard resetting link\n");
 
 			ata_eh_about_to_do(slave, NULL, ATA_EH_RESET);
+			trace_ata_slave_hardreset_begin(slave, classes,
+							deadline);
 			tmp = ata_do_reset(slave, reset, classes, deadline,
 					   false);
+			trace_ata_slave_hardreset_end(slave, classes, tmp);
 			switch (tmp) {
 			case -EAGAIN:
 				rc = -EAGAIN;
@@ -2834,7 +2844,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			}
 
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
+			trace_ata_link_softreset_begin(link, classes, deadline);
 			rc = ata_do_reset(link, reset, classes, deadline, true);
+			trace_ata_link_softreset_end(link, classes, rc);
 			if (rc) {
 				failed_link = link;
 				goto fail;
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index ab69434e2329..e9fb4d44eeac 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -132,6 +132,22 @@
 		ata_protocol_name(ATAPI_PROT_PIO),	\
 		ata_protocol_name(ATAPI_PROT_DMA))
 
+#define ata_class_name(class)	{ class, #class }
+#define show_class_name(val)				\
+	__print_symbolic(val,				\
+		ata_class_name(ATA_DEV_UNKNOWN),	\
+		ata_class_name(ATA_DEV_ATA),		\
+		ata_class_name(ATA_DEV_ATA_UNSUP),	\
+		ata_class_name(ATA_DEV_ATAPI),		\
+		ata_class_name(ATA_DEV_ATAPI_UNSUP),	\
+		ata_class_name(ATA_DEV_PMP),		\
+		ata_class_name(ATA_DEV_PMP_UNSUP),	\
+		ata_class_name(ATA_DEV_SEMB),		\
+		ata_class_name(ATA_DEV_SEMB_UNSUP),	\
+		ata_class_name(ATA_DEV_ZAC),		\
+		ata_class_name(ATA_DEV_ZAC_UNSUP),	\
+		ata_class_name(ATA_DEV_NONE))
+
 const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
 #define __parse_status(s) libata_trace_parse_status(p, s)
 
@@ -329,6 +345,78 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
 		  __parse_eh_err_mask(__entry->eh_err_mask))
 );
 
+DECLARE_EVENT_CLASS(ata_link_reset_begin_template,
+
+	TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+
+	TP_ARGS(link, class, deadline),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__array( unsigned int,	class, 2)
+		__field( unsigned long,	deadline)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= link->ap->print_id;
+		memcpy(__entry->class, class, 2);
+		__entry->deadline	= deadline;
+	),
+
+	TP_printk("ata_port=%u deadline=%lu classes=[%s,%s]",
+		  __entry->ata_port, __entry->deadline,
+		  show_class_name(__entry->class[0]),
+		  show_class_name(__entry->class[1]))
+);
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_link_hardreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_slave_hardreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_link_softreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DECLARE_EVENT_CLASS(ata_link_reset_end_template,
+
+	TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+
+	TP_ARGS(link, class, rc),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__array( unsigned int,	class, 2)
+		__field( int,		rc)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= link->ap->print_id;
+		memcpy(__entry->class, class, 2);
+		__entry->rc		= rc;
+	),
+
+	TP_printk("ata_port=%u rc=%d class=[%s,%s]",
+		  __entry->ata_port, __entry->rc,
+		  show_class_name(__entry->class[0]),
+		  show_class_name(__entry->class[1]))
+);
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_hardreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_slave_hardreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.16.4

