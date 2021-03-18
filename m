Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168ECC432C3
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D912464F2A
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhCRIwR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCRIwB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEAFC06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so4608146wra.2
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSIM2KKFr13N10pkFzbCvVsAAb9CD2J/MyFkt7g9szU=;
        b=CA700hUJYglYphG7hWhs+QWaHdDggOUb4ENo9IZTXiOYWDmEKwmIZ6iaZ7orORhxJc
         ApqyUHWhUmdY9go/HZ3dUEgcSMgUFFcd138H/EbLKjPzmBrWXuag6JF+49iiCdDZ49me
         fYi5r3tooDhkTFYTEeMSAwJ223ReivQzTuKtB/Jharx2Rq1EE54u/rPq1CrllGe7KV+e
         Ha1qBqsB34mHiH+wcPAfGSCb395h0mW3I4qrLpALGELxE8rz1hCOolaXSX25Fqa9ETgb
         6a8SUNpDVZhcrCORzCH6ailvSHY+lMXFOQIRuWVSWNlq1R1gSQXjIUuF9wyINGos/A+6
         RPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSIM2KKFr13N10pkFzbCvVsAAb9CD2J/MyFkt7g9szU=;
        b=RzvUsKb4qQnQuyT9KeW7lEib3KR5JsF6l5mdykTYq4mZqNsmUSJrw5B8ovm6j/Qwjv
         Fj4t22rhKouHrBxEH0M5muYyVR18HIWjF3xQgxFyADE8D8OUHZnbOVuSKIHxZkrKAORa
         xj6rlCuntoOJBZw7te1WvGe2dZgYpGaq8X1llp5A0HOPAmGlLzFZJtGKr9elStAAxkx6
         f1rTXE1o9zdwL9SpBrnGJdCmDQAOdOLgR+8IAxlAlcGqjPrBNqB5iRM5KsB5U8oV0aTH
         0VU1hBCCzHblq89xgxWR/c7E+xYXVaWFwuni3zxHwMu0nFieeQwgqyQa3KakGYyvnL1H
         MzzA==
X-Gm-Message-State: AOAM531zi/ruf2439oNMAx2xVI7wPdbunB5g1NwFcndu4iMDBOe89dSI
        D2ipQhE2dxkwxDoDMSL9secOMg==
X-Google-Smtp-Source: ABdhPJzEPYgbRNUAwcuzE78GENH1iH412dXX0gAwXiEmKzjEbfvmuU6qm40gguyTgpxrotpWTqRWUw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr8375626wre.386.1616057519679;
        Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 08/15] ata: pata_sl82c105: Fix potential doc-rot
Date:   Thu, 18 Mar 2021 08:51:43 +0000
Message-Id: <20210318085150.3131936-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sl82c105.c:191: warning: expecting prototype for sl82c105_bmdma_end(). Prototype was for sl82c105_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sl82c105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index ac7ddd87f188d..8487470e2e01e 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -173,7 +173,7 @@ static void sl82c105_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	sl82c105_bmdma_end		-	DMA engine stop
+ *	sl82c105_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Reset the DMA engine each use as recommended by the errata
-- 
2.27.0

