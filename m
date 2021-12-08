Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE37AC4321E
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhLHQgl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48DEE1FE0C;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXYRQ+8Yy448PM8DJFkQ+urRqLeuECSozTgi8xmktL0=;
        b=DxRq5KsdUvDffXIivlR/IYHIXTtgNtPPlxeWtQytFD4xBogIbXFfl94LyrHpmnpVP0/wb3
        YBhkmjYSlU+JyRX0XlbuLOcVNy8yL1MHGgHxbfuch9/y2EddtTt6r4hKTCZfqtDUPmB9Vt
        hPOyPHgTAEpHkz1fnRYvKCQylBhfnDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXYRQ+8Yy448PM8DJFkQ+urRqLeuECSozTgi8xmktL0=;
        b=c4kva/pBGP/tzNh2PWWiv19qB3ZM5U+oIVyA6HoiNt6Ss3FKXSmwXZpiXi3odTRfIrSsNY
        ++D+eF/mCToxIKAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 459D4A3BA5;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 41D0E5191F81; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 18/73] libata: add tracepoints for ATA error handling
Date:   Wed,  8 Dec 2021 17:32:00 +0100
Message-Id: <20211208163255.114660-19-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for ATA error handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c       | 10 ++++--
 include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 043a1c846f2c..2a25be588e14 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -940,7 +940,7 @@ void ata_std_sched_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
-	DPRINTK("port EH scheduled\n");
+	trace_ata_std_sched_eh(ap);
 }
 EXPORT_SYMBOL_GPL(ata_std_sched_eh);
 
@@ -1070,7 +1070,7 @@ static void __ata_port_freeze(struct ata_port *ap)
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->print_id);
+	trace_ata_port_freeze(ap);
 }
 
 /**
@@ -1147,7 +1147,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->print_id);
+	trace_ata_port_thaw(ap);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
@@ -1287,6 +1287,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	ata_eh_clear_action(link, dev, ehi, action);
@@ -1317,6 +1319,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
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
2.29.2

