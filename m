Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CDC4708F
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E206127A
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhE1JG5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhE1JGu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DEC061574
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m18so1726403wmq.0
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt1whjAB7B3KIqzNP8mB42+ojJZ8NO2eFQdyrF9/Hro=;
        b=V9Y8lSuMGMU3yqi01V/eDdLodPlG8RMYQHdQ/A3sATPU5XX24HQUwRpK7je3P0+yoR
         5BWByiLoRvY1dR6gkHKq82ZCY5A77LgxJRtu+nbANhCEkOlqIisclPj4sot0mrLNvRbI
         rh8vbGcRhYGSL442S/OKcDaC/poOcmdfwJWF5lsEiuI5ZyT+LMiAXA7rhJYNe9wf3HTX
         nAFLvMQ3+4psdoUNcEAmYm85yO4rVZBd3k/JmAZGM0fEopn50DG5PQ90sBalhL6TFT9U
         pXvBtK8XDpGGsiaudS+SSm4tXqe9MuwFGoGoD4mL36I2vDIlGSphVx1WboFN3MyoZPFl
         z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt1whjAB7B3KIqzNP8mB42+ojJZ8NO2eFQdyrF9/Hro=;
        b=HJMg8ekv1oJzvyRGLntZhfSOzxTJw5MZ5HBDYODid3K215YazpQdPU2jQi1QbEkKPr
         PbCFy/5v63524gBwP8K3j+FPpp5tkAGYIwgLix1uJNb5HD0hNgP3lS9gfPvdbhD0Fo0O
         iYjhi0AbxjTiukKHgNEbuA5ONTYyvpG763qboTcWA+rR1cIQxgG1fwF+Rt3/K0kVyAaE
         SUbCN6/FJrZEW9iCNcvSHDKBQy2MRjDNRB0kWFOA8JBbJiMLKc1BKcX4bV7ECxLoOmNu
         ukjTgb28m4hwFnQcnQ1XZofDmW3nrmUpVD1Z33+nWpRG4+fOilva3fNHlm8+HhKnhooY
         AgDg==
X-Gm-Message-State: AOAM531ov9heVkoHlLq1iVnsj2cecTEqtbY9bE6oa9G6ucT138QzThEk
        1S2lI1NGE9JuSj4+gYDzUG0TLA==
X-Google-Smtp-Source: ABdhPJz3EjGlpVSj2qf61StupfyMAlGqyKg+Maiz1smjHPwzTwf++AsVvBsw5JuEvP31tqKHaqYPwQ==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr1111078wmg.144.1622192713662;
        Fri, 28 May 2021 02:05:13 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/11] ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
Date:   Fri, 28 May 2021 10:05:00 +0100
Message-Id: <20210528090502.1799866-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sc1200.c:197:18: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_sc1200.c:197:18: note: (near initialization for ‘sc1200_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sc1200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 3b8c111140bdb..f28daf62a37df 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -193,8 +193,9 @@ static int sc1200_qc_defer(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sc1200_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary	= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations sc1200_port_ops = {
-- 
2.31.1

