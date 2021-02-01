Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72153C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4056964EA2
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhBAPdf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhBAOl2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED5C0617AB
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j18so12853774wmi.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=XCEabafGuemjP1gHa/5Xw5MSj0MuP0PquR4NvFr1yb8kbn3KLr8XI51ghFUwxjmjtb
         EMCfX9DQ2UCxv1vxTyJHuDfrHPoONZ2KQblr2bZtBHkGBLDokAW8foKVYhpMotiuRXUC
         7ZqdxGZUINgl233YDbGXfPeXCqnvaW0smpv9zfiJlxemAW4xYidNk24MIdbEkMxKJEux
         RzwSsopK79UNjf/BwZkkvQfq/3BrqE7BM5ALD568moghnjCvDK92ydVS+aK8KCsZOkoJ
         muswkVkTtJZXJlZBobBcOASS68KtGdceyC1xoRV/GZkDor+g5XPsIRX5L0IvzEU8eQmL
         8Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=OStgAkFxMw43uUFzn3xhyzvSzn/qAtOUr1CpIC/LbGJicB/zD/eGRH1Pk9QjGYnmvR
         DVxYld/XaK3ONWIIie4Da7NYrfPQkQeUKqmnzwsPIX6pRt+r+urAhcruG4gdUwjApSbh
         04ud8gIYvqFeg+NeKlM7tHipmt1U5uOOfdIUAay9JcD/0+uq1uTO+NCYqa8eive7xKiI
         4Z031DKaU5254qRZJZeBnAJNWcuPq0DQUJJRT3ZUkAnCuBbNFl5ftveBQfs07u6GrXh1
         c8l1jmEAbdV3ooNJVJAHPOJingzLXSA9IY1s8OdrpTfD0juUBqvGV8X9nUByxF2WAFpG
         98yg==
X-Gm-Message-State: AOAM532oEev/jW5tT8tlYH5tfLfa65VggOP8+3ERs2bc+ihZ55GQMzpa
        EVFiN0HFF4kohcRO/UhNXLwQgA==
X-Google-Smtp-Source: ABdhPJx00o3B7KG5YWycXJnUp+FrSSgY1g5OgGjWmWV4YzRws8GYDs6sikt6/4gGY6Wdo6s34X5ILA==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr15820968wme.85.1612190391549;
        Mon, 01 Feb 2021 06:39:51 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 07/20] ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s 'mask' param
Date:   Mon,  1 Feb 2021 14:39:27 +0000
Message-Id: <20210201143940.2070919-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt366.c:200: warning: Function parameter or member 'mask' not described in 'hpt366_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt366.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2574d6fbb1ad3..06b7c4a9ec954 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -192,6 +192,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 /**
  *	hpt366_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: Current mask to manipulate and pass back
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
-- 
2.25.1

