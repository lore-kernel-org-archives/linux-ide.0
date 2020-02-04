Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C15C35253
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776232087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBDQ4U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgBDQ4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7026BB1ED;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 39/46] libata: add tracepoints for ATA error handling
Date:   Tue,  4 Feb 2020 17:55:40 +0100
Message-Id: <20200204165547.115220-40-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for ATA error handling, and remove the related
DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c       | 22 +++++-----------
 drivers/ata/libata-pmp.c      |  8 ------
 include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef3576eb5874..f37dad5f9c17 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -526,8 +526,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	unsigned long flags;
 	LIST_HEAD(eh_work_q);
 
-	DPRINTK("ENTER\n");
-
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -541,7 +539,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	/* finish or retry handled scmd's and clean up */
 	WARN_ON(!list_empty(&eh_work_q));
 
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -933,7 +930,7 @@ void ata_std_sched_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
-	DPRINTK("port EH scheduled\n");
+	trace_ata_std_sched_eh(ap);
 }
 EXPORT_SYMBOL_GPL(ata_std_sched_eh);
 
@@ -1060,7 +1057,7 @@ static void __ata_port_freeze(struct ata_port *ap)
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->print_id);
+	trace_ata_port_freeze(ap);
 }
 
 /**
@@ -1208,7 +1205,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->print_id);
+	trace_ata_port_thaw(ap);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
@@ -1347,6 +1344,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	ata_eh_clear_action(link, dev, ehi, action);
@@ -1377,6 +1376,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
+	trace_ata_eh_done(link, dev ? dev->devno : 0, action);
+
 	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
@@ -2119,8 +2120,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	u32 serror;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
 		return;
 
@@ -2227,7 +2226,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	}
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -3126,8 +3124,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	unsigned long flags;
 	int rc = 0;
 
-	DPRINTK("ENTER\n");
-
 	/* For PATA drive side cable detection to work, IDENTIFY must
 	 * be done backwards such that PDIAG- is released by the slave
 	 * device before the master device is identified.
@@ -3241,7 +3237,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
  err:
 	*r_failed_dev = dev;
-	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 
@@ -3755,8 +3750,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	int rc, nr_fails;
 	unsigned long flags, deadline;
 
-	DPRINTK("ENTER\n");
-
 	/* prep for recovery */
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
@@ -3964,7 +3957,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (rc && r_failed_link)
 		*r_failed_link = link;
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3ff14071617c..438caf3a7d8c 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -652,8 +652,6 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
 	u32 *gscr = (void *)ap->sector_buf;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	ata_eh_about_to_do(link, NULL, ATA_EH_REVALIDATE);
 
 	if (!ata_dev_enabled(dev)) {
@@ -686,12 +684,10 @@ static int sata_pmp_revalidate(struct ata_device *dev, unsigned int new_class)
 
 	ata_eh_done(link, NULL, ATA_EH_REVALIDATE);
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
 	ata_dev_err(dev, "PMP revalidation failed (errno=%d)\n", rc);
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
@@ -759,8 +755,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	int detach = 0, rc = 0;
 	int reval_failed = 0;
 
-	DPRINTK("ENTER\n");
-
 	if (dev->flags & ATA_DFLAG_DETACH) {
 		detach = 1;
 		goto fail;
@@ -827,7 +821,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	/* okay, PMP resurrected */
 	ehc->i.flags = 0;
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
@@ -837,7 +830,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	else
 		ata_dev_disable(dev);
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 40027d8424f8..c882c8f9b405 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -454,6 +454,37 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
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
@@ -534,6 +565,35 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
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

