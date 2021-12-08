Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B0C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhLHQge (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhLHQgc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 37F7C1FD2A;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guUwfX68vopVfGyGXTrFZ3Egm+67WKjTH7HIGlKhF3M=;
        b=xIbrCfjYi1N0ISnMfAFatB1mePEu8v+BRDlyhcCr5JPDwSRyTHNx7X3xPchCVW+vrOhnNw
        W8ruFr5fFQriEEwx1Zeznpw1W9olyzBiKqd0VE8SBhXftS2Kpd8aEDRcX5ia4N+tV5XUQp
        guDhIR+mA6hE/WgZJinmrTnN7zg7ydU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guUwfX68vopVfGyGXTrFZ3Egm+67WKjTH7HIGlKhF3M=;
        b=6s+yTOtJ3vwV7KizpaHvUl6E7F0RLFAPvjqFwPE+BY9kW1rAJktL+UK6fTZDz3fOC0B2pO
        PsUvUbL9ylcSBgDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2E71EA3B9C;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 109455191F6F; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/73] libata: tracepoints for bus-master DMA
Date:   Wed,  8 Dec 2021 17:31:51 +0100
Message-Id: <20211208163255.114660-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for bus-master DMA and taskfile related functions.
That allows us to drop the relevant DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c     |   5 ++
 drivers/ata/libata-sff.c      |  23 ++++++--
 include/trace/events/libata.h | 100 ++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 02cd8fe1acab..ef5ae37bfac0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6614,3 +6614,8 @@ void ata_print_version(const struct device *dev, const char *version)
 	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
 }
 EXPORT_SYMBOL(ata_print_version);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_setup);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ata_bmdma_start);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4cc7c0606e06..60ac93a0bafb 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 #include <linux/libata.h>
 #include <linux/highmem.h>
-
+#include <trace/events/libata.h>
 #include "libata.h"
 
 static struct workqueue_struct *ata_sff_wq;
@@ -505,6 +505,7 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
  *	ata_tf_to_host - issue ATA taskfile to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
+ *	@tag: tag of the associated command
  *
  *	Issues ATA taskfile register set to ATA host controller,
  *	with proper synchronization with interrupt handler and
@@ -514,9 +515,12 @@ EXPORT_SYMBOL_GPL(ata_sff_exec_command);
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
 
@@ -768,6 +772,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_start(qc);
 		break;
 #endif /* CONFIG_ATA_BMDMA */
@@ -1376,7 +1381,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
@@ -1388,7 +1393,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
@@ -1418,7 +1423,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
-		ata_tf_to_host(ap, &qc->tf);
+		ata_tf_to_host(ap, &qc->tf, qc->tag);
 
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2745,8 +2750,11 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
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
@@ -2754,7 +2762,9 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 	case ATAPI_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->hsm_task_state = HSM_ST_FIRST;
 
@@ -2802,6 +2812,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 			return ata_sff_idle_irq(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 		bmdma_stopped = true;
 
@@ -2881,6 +2892,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 			thaw = true;
 		}
 
+		trace_ata_bmdma_stop(ap, &qc->tf, qc->tag);
 		ap->ops->bmdma_stop(qc);
 
 		/* if we're gonna thaw, make sure IRQ is clear */
@@ -2914,6 +2926,7 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
 
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
2.29.2

