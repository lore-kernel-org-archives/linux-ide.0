Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58982C47092
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DDB613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhFBKUM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhFBKTm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778FBC06175F
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g204so903984wmf.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htzTcpdW4AR6FOO02fF09uyWR4q4i8TTi3eEflccMFY=;
        b=zjGeF5HCKjXczIh0I1gv61WfZERqc2GBLPFhv816eSDsCbZ0p/YEmcJh0u//noMPzc
         A5jPOJAxXZUMc0uRxRZwleiKNOWQ2+WuY0t3cZXkkQHvoIYco+zApOZM4bBhC6nUpWtw
         4Ovy4k07pWbZ9cYUQaTSUAfhVVatV7S/pRCS7XDVt/cAALLq/Slovj8XTZ7gZZp88v1n
         fesO8+qq7XNt6PEx9/Yz3n+nTw9tIDftj29lJSSKQB5OwY7x8IYxYEH8YKkr9MzzQne7
         Yp/Ut5PClr/daFiaBUpNwxhdcS6CZY8+RkufdL9drv2u32hst4GaQPnfd6m9CCT1QYn3
         gKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htzTcpdW4AR6FOO02fF09uyWR4q4i8TTi3eEflccMFY=;
        b=uNw8+YaTn5ab3pnAG9NPkD/HUSwAwRybL59TSlmpBgS0dVYwOiZLXHGbTfsiEJxRPQ
         nCX4aI4C6V+WOxDFh4TS9c0bXjdL+VlQ7DizVAIfH9XwX7gQpsnxvhMBebFz696b7WYL
         cAlLA/PbopGB5XGQdCI5338vrKRrYt16cO/2p/yPxMj2Fn9ilrjK90fAw+b4pbGRtadY
         UgZ9JXxaq97CblaUQ3CbUvLitJmWjdmh5yV1ap0Y4+enzXRLA35t5aD49Bbdch9iYXiP
         YA7SNA15ZAuiuEXWYG9KPGuLmnV/se2C1BxWBeMnhJU7FUkNUWVPWqUZV+sLaNDZEd7L
         ODWQ==
X-Gm-Message-State: AOAM531DDCLDGpC2l2AN5gODv2CYZ2zEazrLrcnmE7BNJI6yWsExVRy4
        v+Ns4S2pmnp3WEpCkYlkIKCfHkfSbqE26w==
X-Google-Smtp-Source: ABdhPJywrchhxFcUzDLyRI0gTv8NdS60hjXxQddFSDjmZ8WQbwt6LZhVB7Hc6j6/1S1MD5vEwK84aA==
X-Received: by 2002:a1c:1f4a:: with SMTP id f71mr4470189wmf.146.1622629067150;
        Wed, 02 Jun 2021 03:17:47 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 14/21] ide: via82cxxx: Fix misdocumentation of via_set_speed()'s 'hwif' param
Date:   Wed,  2 Jun 2021 11:17:15 +0100
Message-Id: <20210602101722.2276638-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/via82cxxx.c:122: warning: Function parameter or member 'hwif' not described in 'via_set_speed'
 drivers/ide/via82cxxx.c:122: warning: Excess function parameter 'dev' description in 'via_set_speed'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/via82cxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 166feaeed6e38..9beb25cfa5436 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -111,7 +111,7 @@ struct via82cxxx_dev
 
 /**
  *	via_set_speed			-	write timing registers
- *	@dev: PCI device
+ *	@hwif: IDE interface
  *	@dn: device
  *	@timing: IDE timing data to use
  *
-- 
2.31.1

