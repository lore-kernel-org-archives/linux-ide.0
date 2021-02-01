Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46848C433E9
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2156B64E56
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBAOlS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhBAOlH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:07 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C05C061788
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a16so46701wmm.0
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=mapxxoizbqOdhL11CoWUraeZYOx5+PqR/p8mC5NxGcTDTQIuJkhsHdh1bXNCU9ADcZ
         j6YoODnzj2h3IFBHK/69d2IHLnPUZ2sF8zeVuWpjPwk8Y7LG0n7Km76U7zGNajBCrv1T
         m+SOn6WpVqUEDSpxdczlSX4Z6PThPVcue3a408x+5HNODq+4GBIt777xGiPS4YE0Z8QH
         +LrupyqH78BeEk1f1u2M9E8Wmt5u/us7gG6VawZa3ef/wYULl/Gwf/Q2I7HacgqCXnkm
         Oa+0Win/kSyStHptPyUH49e8bYY/4/LfJ9z5Nct7qfvSY42tZznM6I1xpb+YA1gggypV
         lA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=IicyW4iEGIzghvijFmmPR/OVxXsaG6i4XX3UUAecXWb5nMd+eLlf8eeAgPBL3hYn33
         58JCa7q+2jMiDmEfkbgKKWUaBscH5/yah5QueT0zDfJiStK1RP/ATgU4rujJh77JYBRU
         lJQM1Rp8LSflPT/Av9evnDWpJSJnUN03q1EGMNL8zsXKo26cgrByYSddIvrVv2tMWz5C
         BjXnH+idYx/RZ2+ItwIVFQLQWJy8Xzpmk94tVxmSU+2vmXpfR32/dedD4+gDaAqdWHqb
         lYArfTw1EpsI1LM3S5Vqn7y8Uix/vICmod6pAHlGEqRJB2ns1ZhgzrRjmetT7CJm04sl
         UMsg==
X-Gm-Message-State: AOAM533/zGW+5BKEm+WXBmSNOSRLrxx/ifvV3VZGudT2bWdJ0q9O1+re
        9sVFPVIg1BnqfNUeQbuCgC9geg==
X-Google-Smtp-Source: ABdhPJwSS3qcNCTIijeUJvFc07Hg1M5sq5oqgoWJwehXRFxKDf9xzf9DLuwxxWGKtYcpCq9CaQIcAg==
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr10071229wmq.140.1612190387319;
        Mon, 01 Feb 2021 06:39:47 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <teheo@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 03/20] ata: libata-pmp: Fix misspelling of 'val'
Date:   Mon,  1 Feb 2021 14:39:23 +0000
Message-Id: <20210201143940.2070919-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-pmp.c:76: warning: Function parameter or member 'val' not described in 'sata_pmp_write'
 drivers/ata/libata-pmp.c:76: warning: Excess function parameter 'r_val' description in 'sata_pmp_write'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 79f2aeeb482ab..ba7be3f386171 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -62,7 +62,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
  *	sata_pmp_write - write PMP register
  *	@link: link to write PMP register for
  *	@reg: register to write
- *	@r_val: value to write
+ *	@val: value to write
  *
  *	Write PMP register.
  *
-- 
2.25.1

