Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57CC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhLHQgp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 656E01FE11;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGwy0BryW1yc2ABtpMd9zDJusTzVFZB2qCM0tVo+Fr4=;
        b=kimVvruWtfIQRax6AVc6Pxloau4QArbiInz2W/zVuZ/eAOYfrlsEfW+uTRWZ2x4oqfu+aG
        c9aPA6nAzaueUMIxKxIuR+ktvemxVMtGLchurALqKZ+4P7Wh/Q+AikRnBrx7kFexaNRKjK
        HGpXTBRVGyNsxhUSi/gbzf39/ys2HVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGwy0BryW1yc2ABtpMd9zDJusTzVFZB2qCM0tVo+Fr4=;
        b=JzAIkDlmS9cNR8aHQxuTCLGeJVTWQ9QMNVQWNlkAABo/WeYlg/GZDTxiNPzRf9Y9vTjGxA
        HQbIr7mGngr4Y6CA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5C41AA3BA9;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 58F5D5191F89; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/73] libata: add qc_prep tracepoint
Date:   Wed,  8 Dec 2021 17:32:04 +0100
Message-Id: <20211208163255.114660-23-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add tracepoint for ata_qc_prep().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c     |  1 +
 include/trace/events/libata.h | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index de5f4bf1c90c..a538840c652a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4931,6 +4931,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		return;
 	}
 
+	trace_ata_qc_prep(qc);
 	qc->err_mask |= ap->ops->qc_prep(qc);
 	if (unlikely(qc->err_mask))
 		goto err;
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index 7d48e804b889..360f99980b44 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -176,7 +176,7 @@ const char *libata_trace_parse_subcmd(struct trace_seq *, unsigned char,
 				      unsigned char, unsigned char);
 #define __parse_subcmd(c,f,h) libata_trace_parse_subcmd(p, c, f, h)
 
-TRACE_EVENT(ata_qc_issue,
+DECLARE_EVENT_CLASS(ata_qc_issue_template,
 
 	TP_PROTO(struct ata_queued_cmd *qc),
 
@@ -235,6 +235,14 @@ TRACE_EVENT(ata_qc_issue,
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

