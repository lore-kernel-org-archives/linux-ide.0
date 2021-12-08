Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A8C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhLHQgj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B833218D5;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5m2RTcBzquxx9L3BrYLtK/lKrcZKdkaeSFATWoaE+vY=;
        b=kGwciJm7Y6+XX7q+l+taPJmRj+knQp4b3q/UGbznMnmbjPUe/Wqh5zGd5RDQFCaMJ6bm0G
        unbfZE96/m3PcjJ3cfMRfht1cl6iNepuKueBl/RvhL6yENyyquSWxDgN6KuoNT3JsH2i8W
        k0hTErg72l85lkcnwR3pSXwGQgsb9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5m2RTcBzquxx9L3BrYLtK/lKrcZKdkaeSFATWoaE+vY=;
        b=jB5+BXT4ADMzvkODP4DIPuRVpo3ODIkDO7dGd2YqY7b9e5ruRsk19L0rtdPURFtWGJSPeg
        DQqDCwnvnKMB53Dw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2D732A3B9B;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 03B615191F6B; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/73] libata: add reset tracepoints
Date:   Wed,  8 Dec 2021 17:31:49 +0100
Message-Id: <20211208163255.114660-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

To follow the flow of control we should be using tracepoints, as
they will tie in with the actual I/O flow and deliver a better
overview about what it happening.
This patch adds tracepoints for hard reset, soft reset, and postreset
and adds them in the libata-eh control flow.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c       | 21 ++++++--
 include/trace/events/libata.h | 96 +++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1d4a6f1e88cd..043a1c846f2c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2596,12 +2596,19 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
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
@@ -2615,8 +2622,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
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
@@ -2644,7 +2654,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			}
 
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
+			trace_ata_link_softreset_begin(link, classes, deadline);
 			rc = ata_do_reset(link, reset, classes, deadline, true);
+			trace_ata_link_softreset_end(link, classes, rc);
 			if (rc) {
 				failed_link = link;
 				goto fail;
@@ -2698,8 +2710,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
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
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index ab69434e2329..ec2a350d1aca 100644
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
 
@@ -329,6 +345,86 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
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
+		__array( unsigned int,	class, 2 )
+		__field( unsigned long,	deadline )
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
+		__array( unsigned int,	class, 2 )
+		__field( int,		rc	)
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
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.29.2

