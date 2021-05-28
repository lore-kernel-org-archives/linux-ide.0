Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1008C4708C
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B738861222
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhE1JGx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhE1JGs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1CC0613ED
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r13so1204739wmq.1
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqNtuLDYrKvRNBVp3VSAfSB/yMTpSme5doamFgIXxy8=;
        b=pCHP+eJ93Zsu6Jmihy8fbe9klOotG1nugf7P6lL8GCE9XxOxZmDm+bE1SJVZUmmiH7
         HE7hjzyIqIo6oROqHxoLcBFhjv5+qjweXEHcDPqa3sALw4F2BhqG1kVAVvAQhbkK3aHl
         BITJRLKIZnlxy1a59hQKgiXd30jonzTIVQQmWVFKoaoJuUm2kvxNfCE0yDFTjXieB2Kz
         t+SfOt6Dw74PdI8mAobwKz+qntsal97GxggeGF7S6Oc7dxb4Sms0OBvXFMXIqtzFH7ES
         0MHB+JHnzj+iCFTO6287BoQqmcgVvVRr1PaTqykXw4HC4fHIrI+9Ux7xpimwh4PkbMlm
         2uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqNtuLDYrKvRNBVp3VSAfSB/yMTpSme5doamFgIXxy8=;
        b=Kfd07pt0uqEIfc0IAjXQg63Go0vhTgOGV6HgQTzDHxyOpbjhIb4oPrdMaHaoEOgA1h
         DMdTNqNfjWtYhTjkKRwtOVMfyzD3TCAZJpsQ4fPkbCJ70qfwCTn7KAaTBmX0ypCIZ6Gk
         ax1gAsII1PjpL8d9KndUG1r24Be1SoGX7m1zKpMreTOW24oSYfRuBMATD6aw5vTVI7Kg
         ykk4Kpm2c+jSbnn/uQIQlp8JJ9qGWdAjaEEYzh/FcGH4V3QitZRSPgUHCZQIESUovKv5
         kaRNVrSTxJ2t/TIJK0PBPsZO91cAkjUSwh+6UKSqgZr+7wnKIihSsgyziyg8novy6tVl
         L1LQ==
X-Gm-Message-State: AOAM531j8V+U6YxwAMD9Q6mJSbNdOf+brGf/A8LWakYtwGpb/jyOCQ49
        1FNjOb1iyif3GyXoBiPmKjr9Hw==
X-Google-Smtp-Source: ABdhPJyFYyV65K75HWrpKoxF/h0k2JdSJZa3XOT1Hbbj2zyfEfXqWZncoCe6ZmvK+oqSz6Auq+lTaw==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr12657564wme.16.1622192711854;
        Fri, 28 May 2021 02:05:11 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 07/11] ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
Date:   Fri, 28 May 2021 10:04:58 +0100
Message-Id: <20210528090502.1799866-8-lee.jones@linaro.org>
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

 drivers/ata/pata_cs5520.c:99:19: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_cs5520.c:99:19: note: (near initialization for ‘cs5520_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5520.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index d09d432d3c442..247c147026243 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -95,8 +95,9 @@ static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5520_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations cs5520_port_ops = {
-- 
2.31.1

