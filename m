Return-Path: <SRS0=EzgR=BD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC07C43465
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jul 2020 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8CA20658
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jul 2020 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE7384ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGXRRb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:17:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58885 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726892AbgGXRR3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jul 2020 13:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595611048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9NFv6U8TiufRPobb9Z4kCNESgyDTe0Yy+Q1ZLw1C2A=;
        b=VE7384ieaczJ2VwG64SlICWdnr03SRr4+s0qKaUevWBwLZD0cMHb4KKW/N0mAMyb4ZjOa/
        zRt78/R+5E0+//83aDVH5R6aFQFWwzEG+1gqWIImp0Z2ewhYUzYjfpbNCrlr+PnLLZZLUS
        muFOKkPkBbmhqGNxwOmKsVKtxUYF0x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Tvo4irP0O5SymP84XMfCiw-1; Fri, 24 Jul 2020 13:17:24 -0400
X-MC-Unique: Tvo4irP0O5SymP84XMfCiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B6928017FB;
        Fri, 24 Jul 2020 17:17:23 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72D7F74F64;
        Fri, 24 Jul 2020 17:17:22 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Subject: [v4 09/11] Add durable_name_printk_ratelimited
Date:   Fri, 24 Jul 2020 12:17:04 -0500
Message-Id: <20200724171706.1550403-10-tasleson@redhat.com>
In-Reply-To: <20200724171706.1550403-1-tasleson@redhat.com>
References: <20200724171706.1550403-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Create a rate limited macro for durable_name_printk so that
we can use this for printk_ratelimited usage in the block
layers and add the durable name key/value to the log
message.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 include/linux/dev_printk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 502cf9fd7fe7..931977f5c85e 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -37,6 +37,15 @@ __printf(3, 4) __cold
 void durable_name_printk(const char *level, const struct device *dev,
 			const char *fmt, ...);
 
+#define durable_name_printk_ratelimited(level, dev, fmt, ...)		\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+					DEFAULT_RATELIMIT_INTERVAL,	\
+					DEFAULT_RATELIMIT_BURST);	\
+	if (__ratelimit(&_rs))						\
+		durable_name_printk(level, dev, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 __printf(2, 3) __cold
 void _dev_emerg(const struct device *dev, const char *fmt, ...);
 __printf(2, 3) __cold
-- 
2.26.2

