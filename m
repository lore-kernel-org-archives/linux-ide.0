Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187BBC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhLHQgl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B1DE1FE0D;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjswPDBCnBWmaxh4x2DX3gkFKSqIUOpnhQqfrvWGcY4=;
        b=SVc9lgiIYIqmPe4I8r5MYt/TNQAsk52GADdwsefHjt6M5VxzsrH+Q58hLkTYDdRybEWpPC
        YuMlCRCZeRiolDqvlqJxd3Xf1zsZT7HHnSVuCgJa+8XARXh8ZJRlBNQU9IQWInA/i+79gp
        7f0i8DOcze+56fSCs/AcgQoCCGhhWxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjswPDBCnBWmaxh4x2DX3gkFKSqIUOpnhQqfrvWGcY4=;
        b=NqV7J2AbhOvRECz8BgB1+/3wTdn39qauCtNasDjDRRl7lYSfmZPf5kt7Q1bOqLaOZOPMs/
        bBAZXUo2eu/+09CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3AE7DA3BA3;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 36A525191F7D; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 16/73] libata-sff: add tracepoints for ata_sff_flush_pio_task()
Date:   Wed,  8 Dec 2021 17:31:58 +0100
Message-Id: <20211208163255.114660-17-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replace DPRINTK calls with tracepoints.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sff.c      |  5 +----
 include/trace/events/libata.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5d6ea1c9ce29..58304dc401ac 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1249,7 +1249,7 @@ EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
 
 void ata_sff_flush_pio_task(struct ata_port *ap)
 {
-	DPRINTK("ENTER\n");
+	trace_ata_sff_flush_pio_task(ap);
 
 	cancel_delayed_work_sync(&ap->sff_pio_task);
 
@@ -1266,9 +1266,6 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	spin_unlock_irq(ap->lock);
 
 	ap->sff_pio_task_link = NULL;
-
-	if (ata_msg_ctl(ap))
-		ata_port_dbg(ap, "%s: EXIT\n", __func__);
 }
 
 static void ata_sff_pio_task(struct work_struct *work)
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 135b1df472e5..06bc6756f1dc 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -621,6 +621,31 @@ DEFINE_EVENT(ata_transfer_data_template, atapi_send_cdb,
 	     TP_PROTO(struct ata_queued_cmd *qc, unsigned int offset, unsigned int count),
 	     TP_ARGS(qc, offset, count));
 
+DECLARE_EVENT_CLASS(ata_sff_template,
+
+	TP_PROTO(struct ata_port *ap),
+
+	TP_ARGS(ap),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__field( unsigned char,	hsm_state )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= ap->print_id;
+		__entry->hsm_state	= ap->hsm_task_state;
+	),
+
+	TP_printk("ata_port=%u task_state=%s",
+		  __entry->ata_port,
+		  show_sff_hsm_state_name(__entry->hsm_state))
+);
+
+DEFINE_EVENT(ata_sff_template, ata_sff_flush_pio_task,
+	     TP_PROTO(struct ata_port *ap),
+	     TP_ARGS(ap));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.29.2

