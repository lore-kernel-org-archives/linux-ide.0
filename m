Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C11C35247
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863F20674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBDQ4N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgBDQ4M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C56DB1D5;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 25/46] libata-sff: add tracepoints for HSM state machine
Date:   Tue,  4 Feb 2020 17:55:26 +0100
Message-Id: <20200204165547.115220-26-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for the HSM state machine and remove DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/ata/libata-sff.c      | 12 +++---
 drivers/ata/libata-trace.c    | 29 +++++++++++++
 include/trace/events/libata.h | 95 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index a5e6be6955ae..6b961eadc201 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -660,7 +660,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
 
 	/* do the actual data transfer */
 	buf = kmap_atomic(page);
@@ -723,7 +723,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
 static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
+	trace_atapi_send_cdb(qc, 0, qc->dev->cdb_len);
 	WARN_ON_ONCE(qc->dev->cdb_len < 12);
 
 	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
@@ -794,7 +794,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	trace_atapi_pio_transfer_data(qc, offset, count);
 
 	/* do the actual data transfer */
 	buf = kmap_atomic(page);
@@ -976,8 +976,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 	WARN_ON_ONCE(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
+	trace_ata_sff_hsm_state(qc, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -1178,8 +1177,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		}
 
 		/* no more data to transfer */
-		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
-			ap->print_id, qc->dev->devno, status);
+		trace_ata_sff_hsm_command_complete(qc, status);
 
 		WARN_ON_ONCE(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
 
diff --git a/drivers/ata/libata-trace.c b/drivers/ata/libata-trace.c
index 08e001303a82..5a9fba18411b 100644
--- a/drivers/ata/libata-trace.c
+++ b/drivers/ata/libata-trace.c
@@ -137,6 +137,35 @@ libata_trace_parse_qc_flags(struct trace_seq *p, unsigned int qc_flags)
 	return ret;
 }
 
+const char *
+libata_trace_parse_tf_flags(struct trace_seq *p, unsigned int tf_flags)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "%x", tf_flags);
+	if (tf_flags) {
+		trace_seq_printf(p, "{ ");
+		if (tf_flags & ATA_TFLAG_LBA48)
+			trace_seq_printf(p, "LBA48 ");
+		if (tf_flags & ATA_TFLAG_ISADDR)
+			trace_seq_printf(p, "ISADDR ");
+		if (tf_flags & ATA_TFLAG_DEVICE)
+			trace_seq_printf(p, "DEV ");
+		if (tf_flags & ATA_TFLAG_WRITE)
+			trace_seq_printf(p, "WRITE ");
+		if (tf_flags & ATA_TFLAG_LBA)
+			trace_seq_printf(p, "LBA ");
+		if (tf_flags & ATA_TFLAG_FUA)
+			trace_seq_printf(p, "FUA ");
+		if (tf_flags & ATA_TFLAG_POLLING)
+			trace_seq_printf(p, "POLL ");
+		trace_seq_putc(p, '}');
+	}
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 const char *
 libata_trace_parse_subcmd(struct trace_seq *p, unsigned char cmd,
 			  unsigned char feature, unsigned char hob_nsect)
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 476acf823928..acfc5d739b17 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -148,6 +148,15 @@
 		ata_class_name(ATA_DEV_ZAC_UNSUP),	\
 		ata_class_name(ATA_DEV_NONE))
 
+#define ata_sff_hsm_state_name(state)	{ state, #state }
+#define show_sff_hsm_state_name(val)				\
+    __print_symbolic(val,				\
+		ata_sff_hsm_state_name(HSM_ST_IDLE),	\
+		ata_sff_hsm_state_name(HSM_ST_FIRST),	\
+		ata_sff_hsm_state_name(HSM_ST),		\
+		ata_sff_hsm_state_name(HSM_ST_LAST),	\
+		ata_sff_hsm_state_name(HSM_ST_ERR))
+
 const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
 #define __parse_status(s) libata_trace_parse_status(p, s)
 
@@ -160,6 +169,9 @@ const char *libata_trace_parse_eh_err_mask(struct trace_seq *, unsigned int);
 const char *libata_trace_parse_qc_flags(struct trace_seq *, unsigned int);
 #define __parse_qc_flags(f) libata_trace_parse_qc_flags(p, f)
 
+const char *libata_trace_parse_tf_flags(struct trace_seq *, unsigned int);
+#define __parse_tf_flags(f) libata_trace_parse_tf_flags(p, f)
+
 const char *libata_trace_parse_subcmd(struct trace_seq *, unsigned char,
 				      unsigned char, unsigned char);
 #define __parse_subcmd(c,f,h) libata_trace_parse_subcmd(p, c, f, h)
@@ -514,6 +526,89 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
 	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
 	     TP_ARGS(link, class, rc));
 
+DECLARE_EVENT_CLASS(ata_sff_hsm_template,
+
+	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
+
+	TP_ARGS(qc, status),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	tag	)
+		__field( unsigned int,	qc_flags )
+		__field( unsigned int,	protocol )
+		__field( unsigned int,	hsm_state )
+		__field( unsigned char,	dev_state )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= qc->ap->print_id;
+		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
+		__entry->tag		= qc->tag;
+		__entry->qc_flags	= qc->flags;
+		__entry->protocol	= qc->tf.protocol;
+		__entry->hsm_state	= qc->ap->hsm_task_state;
+		__entry->dev_state	= status;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u tag=%d protocol=%d flags=%s task_state=%s dev_stat=0x%X",
+		  __entry->ata_port, __entry->ata_dev, __entry->tag,
+		  __entry->protocol,__parse_qc_flags(__entry->qc_flags),
+		  show_sff_hsm_state_name(__entry->hsm_state),
+		  __entry->dev_state)
+);
+
+DEFINE_EVENT(ata_sff_hsm_template, ata_sff_hsm_state,
+	TP_PROTO(struct ata_queued_cmd *qc, unsigned char state),
+	TP_ARGS(qc, state));
+
+DEFINE_EVENT(ata_sff_hsm_template, ata_sff_hsm_command_complete,
+	TP_PROTO(struct ata_queued_cmd *qc, unsigned char state),
+	TP_ARGS(qc, state));
+
+DECLARE_EVENT_CLASS(ata_transfer_data_template,
+
+	TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
+
+	TP_ARGS(qc, offset, count),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	ata_dev	)
+		__field( unsigned int,	tag	)
+		__field( unsigned int,	flags	)
+		__field( unsigned int,	offset	)
+		__field( unsigned int,	bytes	)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= qc->ap->print_id;
+		__entry->ata_dev	= qc->dev->link->pmp + qc->dev->devno;
+		__entry->tag		= qc->tag;
+		__entry->flags		= qc->tf.flags;
+		__entry->offset		= offset;
+		__entry->bytes		= count;
+	),
+
+	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s offset=%u bytes=%u",
+		  __entry->ata_port, __entry->ata_dev, __entry->tag,
+		  __parse_tf_flags(__entry->flags),
+		  __entry->offset, __entry->bytes)
+);
+
+DEFINE_EVENT(ata_transfer_data_template, ata_sff_pio_transfer_data,
+	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
+	     TP_ARGS(qc, offset, count));
+
+DEFINE_EVENT(ata_transfer_data_template, atapi_pio_transfer_data,
+	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
+	     TP_ARGS(qc, offset, count));
+
+DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
+	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
+	     TP_ARGS(qc, offset, count));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.16.4

