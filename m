Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36008C3F2D7
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7FF205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgCCJjr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgCCJjr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D37CCB20F;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/40] libata: tracepoints for bus-master DMA
Date:   Tue,  3 Mar 2020 10:37:50 +0100
Message-Id: <20200303093813.18523-18-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for bus-master DMA and taskfile related functions.
That allows us to drop the relevant DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c     |   5 +++
 drivers/ata/libata-sff.c      |  23 +++++++---
 include/trace/events/libata.h | 100 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 329cc587eeab..695974d0c634 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7383,3 +7383,8 @@ EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
 EXPORT_SYMBOL_GPL(ata_host_get);
 EXPORT_SYMBOL_GPL(ata_host_put);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_setup);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_start);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 25c10f3eef83..e2d1504f7562 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/libata.h>
 #include <linux/highmem.h>
-
+#include <trace/events/libata.h>
 #include "libata.h"
 
 static struct workqueue_struct *ata_sff_wq;
@@ -509,6 +509,7 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
  *	ata_tf_to_host - issue ATA taskfile to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
+ *	@tag: tag of the associated command
  *
  *	Issues ATA taskfile register set to ATA host controller,
  *	with proper synchronization with interrupt handler and
@@ -518,9 +519,12 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
  *	spin_lock_irqsave(host lock)
  */
 static inline void ata_tf_to_host(struct ata_port *ap,
-				  const struct ata_taskfile *tf)
+				  const struct ata_taskfile *tf,
+				  unsigned int tag)
 {
+	trace_ata_tf_load(ap, tf);
 	ap->ops->sff_tf_load(ap, tf);
+	trace_ata_exec_command(ap, tf, tag);
 	ap->ops->sff_exec_command(ap, tf);
 }
 
@@ -753,6 +757,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_start(qc);
 		break;
 #endif /* CONFIG_ATA_BMDMA */
@@ -1361,7 +1366,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
@@ -1373,7 +1378,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
@@ -1403,7 +1408,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2735,8 +2740,11 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
@@ -2744,7 +2752,9 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2792,6 +2802,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			return ata_sff_idle_irq(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 		bmdma_stopped = true;
 
@@ -2871,6 +2882,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 			thaw = true;
 		}
 
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 
 		/* if we're gonna thaw, make sure IRQ is clear */
@@ -2904,6 +2916,7 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
 
 	if (ata_is_dma(qc->tf.protocol)) {
 		spin_lock_irqsave(ap->lock, flags);
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 		spin_unlock_irqrestore(ap->lock, flags);
 	}
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index ec2a350d1aca..6a0a9b7a42ec 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -291,6 +291,106 @@ DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_done,
 	     TP_PROTO(struct ata_queued_cmd *qc),
 	     TP_ARGS(qc));
 
+TRACE_EVENT(ata_tf_load,
+
+	TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf),
+
+	TP_ARGS(ap, tf),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned char,	cmd	)
+		__field( unsigned char,	dev	)
+		__field( unsigned char,	lbal	)
+		__field( unsigned char,	lbam	)
+		__field( unsigned char,	lbah	)
+		__field( unsigned char,	nsect	)
+		__field( unsigned char,	feature	)
+		__field( unsigned char,	hob_lbal )
+		__field( unsigned char,	hob_lbam )
+		__field( unsigned char,	hob_lbah )
+		__field( unsigned char,	hob_nsect )
+		__field( unsigned char,	hob_feature )
+		__field( unsigned char,	proto	)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+		__entry->proto		= tf->protocol;
+		__entry->cmd		= tf->command;
+		__entry->dev		= tf->device;
+		__entry->lbal		= tf->lbal;
+		__entry->lbam		= tf->lbam;
+		__entry->lbah		= tf->lbah;
+		__entry->hob_lbal	= tf->hob_lbal;
+		__entry->hob_lbam	= tf->hob_lbam;
+		__entry->hob_lbah	= tf->hob_lbah;
+		__entry->feature	= tf->feature;
+		__entry->hob_feature	= tf->hob_feature;
+		__entry->nsect		= tf->nsect;
+		__entry->hob_nsect	= tf->hob_nsect;
+	),
+
+	TP_printk("ata_port=%u proto=%s cmd=%s%s " \
+		  " tf=(%02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x)",
+		  __entry->ata_port,
+		  show_protocol_name(__entry->proto),
+		  show_opcode_name(__entry->cmd),
+		  __parse_subcmd(__entry->cmd, __entry->feature, __entry->hob_nsect),
+		  __entry->cmd, __entry->feature, __entry->nsect,
+		  __entry->lbal, __entry->lbam, __entry->lbah,
+		  __entry->hob_feature, __entry->hob_nsect,
+		  __entry->hob_lbal, __entry->hob_lbam, __entry->hob_lbah,
+		  __entry->dev)
+);
+
+DECLARE_EVENT_CLASS(ata_exec_command_template,
+
+	TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
+
+	TP_ARGS(ap, tf, tag),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned int,	tag	)
+		__field( unsigned char,	cmd	)
+		__field( unsigned char,	feature	)
+		__field( unsigned char,	hob_nsect )
+		__field( unsigned char,	proto	)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+		__entry->tag		= tag;
+		__entry->proto		= tf->protocol;
+		__entry->cmd		= tf->command;
+		__entry->feature	= tf->feature;
+		__entry->hob_nsect	= tf->hob_nsect;
+	),
+
+	TP_printk("ata_port=%u tag=%d proto=%s cmd=%s%s",
+		  __entry->ata_port, __entry->tag,
+		  show_protocol_name(__entry->proto),
+		  show_opcode_name(__entry->cmd),
+		  __parse_subcmd(__entry->cmd, __entry->feature, __entry->hob_nsect))
+);
+
+DEFINE_EVENT(ata_exec_command_template, ata_exec_command,
+	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
+	     TP_ARGS(ap, tf, tag));
+
+DEFINE_EVENT(ata_exec_command_template, ata_bmdma_setup,
+	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
+	     TP_ARGS(ap, tf, tag));
+
+DEFINE_EVENT(ata_exec_command_template, ata_bmdma_start,
+	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
+	     TP_ARGS(ap, tf, tag));
+
+DEFINE_EVENT(ata_exec_command_template, ata_bmdma_stop,
+	     TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),
+	     TP_ARGS(ap, tf, tag));
+
 TRACE_EVENT(ata_eh_link_autopsy,
 
 	TP_PROTO(struct ata_device *dev, unsigned int eh_action, unsigned int eh_err_mask),
-- 
2.16.4

