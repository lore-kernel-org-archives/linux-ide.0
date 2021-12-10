Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A7CC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhLJHcy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:32:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhLJHcx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9FCF01F3A0;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoBEZAO6YHCzYp2DmsoCHBWi0YJ7FhQkSByFiYyafr8=;
        b=IWrcKGs1N+pSo4HNfejZJnAxchBOw+pYkj1JBHKUJHH2wzVYus4xHjUZU2iY/zMtATm1o4
        ASwuh5V0pTpabRAqCfL0UwyhNGryl906TqrTOChux1j2p5KoLa2lMYKJvykXW+0zexKAbu
        usEEUl+MTQlS+724xA2oa6Eu1HI/B+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoBEZAO6YHCzYp2DmsoCHBWi0YJ7FhQkSByFiYyafr8=;
        b=Dq35gmkwrDJK22flxkTlYmFhoid9yMmNfOTjx2vIWFQSF/BwNW2EfHjiI7xZyY4+4dGXqF
        Obz0Fnyk8Vj1rOAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 98CEDA3BA0;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 854D85192037; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/68] libata: add tracepoints for ATA error handling
Date:   Fri, 10 Dec 2021 08:28:08 +0100
Message-Id: <20211210072905.15666-12-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoints for ATA error handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c       | 26 ++++-----------
 drivers/ata/libata-pmp.c      |  8 -----
 drivers/ata/libata-sata.c     |  3 --
 include/trace/events/libata.h | 60 +++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 043a1c846f2c..69f51616d8bd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -533,8 +533,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	unsigned long flags;
 	LIST_HEAD(eh_work_q);
 
-	DPRINTK("ENTER\n");
-
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -548,7 +546,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 	/* finish or retry handled scmd's and clean up */
 	WARN_ON(!list_empty(&eh_work_q));
 
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -940,7 +937,7 @@ void ata_std_sched_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
-	DPRINTK("port EH scheduled\n");
+	trace_ata_std_sched_eh(ap);
 }
 EXPORT_SYMBOL_GPL(ata_std_sched_eh);
 
@@ -1070,7 +1067,7 @@ static void __ata_port_freeze(struct ata_port *ap)
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
-	DPRINTK("ata%u port frozen\n", ap->print_id);
+	trace_ata_port_freeze(ap);
 }
 
 /**
@@ -1147,7 +1144,7 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	DPRINTK("ata%u port thawed\n", ap->print_id);
+	trace_ata_port_thaw(ap);
 }
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
@@ -1287,6 +1284,8 @@ void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned long flags;
 
+	trace_ata_eh_about_to_do(link, dev ? dev->devno : 0, action);
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	ata_eh_clear_action(link, dev, ehi, action);
@@ -1317,6 +1316,8 @@ void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 
+	trace_ata_eh_done(link, dev ? dev->devno : 0, action);
+
 	ata_eh_clear_action(link, dev, &ehc->i, action);
 }
 
@@ -1421,8 +1422,6 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
 		return;
 	}
 
-	DPRINTK("ATA request sense\n");
-
 	ata_tf_init(dev, &tf);
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
@@ -1463,8 +1462,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 
-	DPRINTK("ATAPI request sense\n");
-
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
 	/* initialize sense_buf with the error register,
@@ -1928,8 +1925,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	u32 serror;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (ehc->i.flags & ATA_EHI_NO_AUTOPSY)
 		return;
 
@@ -2036,7 +2031,6 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.action |= ata_eh_speed_down(dev, eflags, all_err_mask);
 		trace_ata_eh_link_autopsy(dev, ehc->i.action, all_err_mask);
 	}
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -2936,8 +2930,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	unsigned long flags;
 	int rc = 0;
 
-	DPRINTK("ENTER\n");
-
 	/* For PATA drive side cable detection to work, IDENTIFY must
 	 * be done backwards such that PDIAG- is released by the slave
 	 * device before the master device is identified.
@@ -3051,7 +3043,6 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 
  err:
 	*r_failed_dev = dev;
-	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 
@@ -3566,8 +3557,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	int rc, nr_fails;
 	unsigned long flags, deadline;
 
-	DPRINTK("ENTER\n");
-
 	/* prep for recovery */
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
@@ -3775,7 +3764,6 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	if (rc && r_failed_link)
 		*r_failed_link = link;
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba7be3f38617..e2e9cbd405fa 100644
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
 		rc = -ENODEV;
@@ -828,7 +822,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	/* okay, PMP resurrected */
 	ehc->i.flags = 0;
 
-	DPRINTK("EXIT, rc=0\n");
 	return 0;
 
  fail:
@@ -838,7 +831,6 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 	else
 		ata_dev_disable(dev);
 
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 4e88597aa9df..7b72c68bc9f7 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -533,8 +533,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (online)
 		*online = false;
 
@@ -610,7 +608,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			*online = false;
 		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
 	}
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index fcb8fde39614..d4e631aa976f 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -490,6 +490,37 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
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
@@ -570,6 +601,35 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
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

