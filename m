Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EAC47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8F613BA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFBKUJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhFBKTj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5760C06134A
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso1349554wmj.2
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jQZgJxLSK97kuij2epKKmjGvDzAp1XS69EVQaGkB+E=;
        b=bI/Id/J3vE+NpunaijQxocoJVdgJYwNjSXzd39GknOcYqzeVoEtr5PF9IRtaZSL1GF
         KIDxwvDXXDXDGjhAAJqKZnd0S/6Zs/ARBaH5p8v9W3AgWLB9SRg0wmT/rmrvo1AS6FWG
         JwM1Nnft7kWRMZ07XcPks8lcCKy98Gf1n2WIvp0nmtzXoU91fxGGs+YukkyDm7Ci96FX
         9HZRlUIeLKL1YG96yaoW9CxhWwF2Xqn9cc9GWa9bwKenw/wNMArfrpZ6rUzJKQlVKYPE
         7R2U9f+yvvnzSXpkXdtL3nZxg8Dy0mUsO9WMyTXA6VMjju/7xu7I3kbxWFB9puESmZwW
         gMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jQZgJxLSK97kuij2epKKmjGvDzAp1XS69EVQaGkB+E=;
        b=YB2NL+0+u0XZZgoereKqSUbgOIZ4boWNioU9sTel1RGVFa50qphlQFl/Kaj8vyZahg
         0jiqMQGicDdylw6ukJemy+hdpTdWVQM2R4XWAEJwUacK4gnRLNzMPwjcSRljX7Qj+Vas
         PT5S882+AtWwHVIbUjIgCwieBBuSltwAsoSUlC9yjaE68BOlZwyUxnEkFy+6qmyQaaeq
         p5sNijEugGZyPGrHeFZETIt6nXzwJnLwTN3lXP9SQlXiuGrLiDLuFeYxtCC2F0Zw4lUT
         +H+9RfQCAzwXukbeG2aB9RJSz+HJlqPggfhsR6XwQ58s658jA/pwguj3k297j/v62wPu
         PH/w==
X-Gm-Message-State: AOAM533IrSZ749W8vYxPxg05X8hV3qD7sMlUlY8ymuTr0VsHq2A3VIxn
        mwpc3WcCbHaE7a9tGkCczaIx2USxmByiKw==
X-Google-Smtp-Source: ABdhPJzWreFQP4zXN2JQs++LA7F3tdEPIobN3r9eUGUZA2C1/ySjJZUxwndWSVJdLTuVNfCsWNlMlA==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr18527827wmi.176.1622629065245;
        Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 12/21] ide: it821x: Fix a couple of incorrectly documented functions
Date:   Wed,  2 Jun 2021 11:17:13 +0100
Message-Id: <20210602101722.2276638-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/it821x.c:362: warning: expecting prototype for it821x_dma_read(). Prototype was for it821x_dma_start() instead
 drivers/ide/it821x.c:384: warning: expecting prototype for it821x_dma_write(). Prototype was for it821x_dma_end() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/it821x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index aad746007330c..e7c965c3703e5 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -346,7 +346,7 @@ static void it821x_tune_udma(ide_drive_t *drive, u8 mode_wanted)
 }
 
 /**
- *	it821x_dma_read	-	DMA hook
+ *	it821x_dma_start	-	DMA hook
  *	@drive: drive for DMA
  *
  *	The IT821x has a single timing register for MWDMA and for PIO
@@ -372,7 +372,7 @@ static void it821x_dma_start(ide_drive_t *drive)
 }
 
 /**
- *	it821x_dma_write	-	DMA hook
+ *	it821x_dma_end	-	DMA hook
  *	@drive: drive for DMA stop
  *
  *	The IT821x has a single timing register for MWDMA and for PIO
-- 
2.31.1

