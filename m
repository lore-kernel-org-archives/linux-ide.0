Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C7C35253
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67292087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBDQ4N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgBDQ4L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B0FCB1D3;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/46] libata: tracepoints for bus-master DMA
Date:   Tue,  4 Feb 2020 17:55:25 +0100
Message-Id: <20200204165547.115220-25-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for bus-master DMA and taskfile related functions.
That allows us to drop the relevant DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sff.c      | 41 +++++++++---------
 include/trace/events/libata.h | 97 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f1799291b4a6..a5e6be6955ae 100644
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
@@ -413,12 +413,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
 		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
 		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
 	}
 
 	if (is_addr) {
@@ -427,18 +421,10 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->lbal, ioaddr->lbal_addr);
 		iowrite8(tf->lbam, ioaddr->lbam_addr);
 		iowrite8(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
 	}
 
-	if (tf->flags & ATA_TFLAG_DEVICE) {
+	if (tf->flags & ATA_TFLAG_DEVICE)
 		iowrite8(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
 
 	ata_wait_idle(ap);
 }
@@ -498,8 +484,6 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
  */
 void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
@@ -509,6 +493,7 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
  *	ata_tf_to_host - issue ATA taskfile to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
+ *	@tag: tag of the associated command
  *
  *	Issues ATA taskfile register set to ATA host controller,
  *	with proper synchronization with interrupt handler and
@@ -518,9 +503,12 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
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
 
@@ -753,6 +741,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_start(qc);
 		break;
 #endif /* CONFIG_ATA_BMDMA */
@@ -1361,7 +1350,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
@@ -1373,7 +1362,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
@@ -1403,7 +1392,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2737,8 +2726,11 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
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
@@ -2746,7 +2738,9 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2794,6 +2788,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			return ata_sff_idle_irq(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 		bmdma_stopped = true;
 
@@ -2873,6 +2868,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 			thaw = true;
 		}
 
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 
 		/* if we're gonna thaw, make sure IRQ is clear */
@@ -2906,6 +2902,7 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
 
 	if (ata_is_dma(qc->tf.protocol)) {
 		spin_lock_irqsave(ap->lock, flags);
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 		spin_unlock_irqrestore(ap->lock, flags);
 	}
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index e9fb4d44eeac..476acf823928 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -291,6 +291,103 @@ DEFINE_EVENT(ata_qc_complete_template, ata_qc_complete_done,
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
+		__field( unsigned char,	proto )
+		__field( unsigned long,	flags )
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
+		__field( unsigned char,	proto )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+		__entry->tag		= tag;
+		__entry->proto		= tf->protocol;
+		__entry->cmd		= tf->command;
+	),
+
+	TP_printk("ata_port=%u cmd=%s%s tag=%d",
+		  __entry->ata_port,
+		  show_protocol_name(__entry->proto),
+		  show_opcode_name(__entry->cmd),
+		  __entry->tag)
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

