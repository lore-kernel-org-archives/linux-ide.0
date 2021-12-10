Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEDCC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhLJHdC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4B0D1F3A3;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EWO2sZKQRBuUGZs3wQOfffsdcZ3MGfg1N2IL4nIK5E=;
        b=gKoHQkM77IImlxd8pBIgaWdDtgIIUfKS2ZHTjPLiHVSnHuI0uZnc45MjWfT52L8D0OyfzO
        QZnUNE/+9+6kq8Ibrn4xZMrbcTgkuLWWzkbkXj1xPs5jou93tRN+DSQuf/dwA4ksnw9jT3
        JmLlsWfgESWX06U/NMVBzMomlUOB4h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EWO2sZKQRBuUGZs3wQOfffsdcZ3MGfg1N2IL4nIK5E=;
        b=M8UII6AFkqRPAQkFJC/WAx2E6/PLMnEiHc86vo0TgaYRM5M1mtwODvqFu0BDd2ewn5kDAg
        6CM+fqzbYiuoVoAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 977C2A3B9F;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 766EB519202F; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/68] libata: add qc_prep tracepoint
Date:   Fri, 10 Dec 2021 08:28:04 +0100
Message-Id: <20211210072905.15666-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the existing ata_qc_issue() tracepoint into a template,
and add tracepoints for ata_qc_prep() and ata_qc_issue() based
on that template.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c     |  1 +
 include/trace/events/libata.h | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 33d65a2a39c7..80af26ea04b8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4885,6 +4885,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		return;
 	}
 
+	trace_ata_qc_prep(qc);
 	qc->err_mask |= ap->ops->qc_prep(qc);
 	if (unlikely(qc->err_mask))
 		goto err;
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index ec2a350d1aca..2394fc2b2831 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -164,7 +164,7 @@ const char *libata_trace_parse_subcmd(struct trace_seq *, unsigned char,
 				      unsigned char, unsigned char);
 #define __parse_subcmd(c,f,h) libata_trace_parse_subcmd(p, c, f, h)
 
-TRACE_EVENT(ata_qc_issue,
+DECLARE_EVENT_CLASS(ata_qc_issue_template,
 
 	TP_PROTO(struct ata_queued_cmd *qc),
 
@@ -223,6 +223,14 @@ TRACE_EVENT(ata_qc_issue,
 		  __entry->dev)
 );
 
+DEFINE_EVENT(ata_qc_issue_template, ata_qc_prep,
+	     TP_PROTO(struct ata_queued_cmd *qc),
+	     TP_ARGS(qc));
+
+DEFINE_EVENT(ata_qc_issue_template, ata_qc_issue,
+	     TP_PROTO(struct ata_queued_cmd *qc),
+	     TP_ARGS(qc));
+
 DECLARE_EVENT_CLASS(ata_qc_complete_template,
 
 	TP_PROTO(struct ata_queued_cmd *qc),
-- 
2.29.2

