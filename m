Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB602C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F3764E1F
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhA1SHT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhA1SEQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57660C061788
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so6361827wrz.0
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=e15ABOPKKSkb+A+yzXSg3oWGdKhKBFvuayIyU7x7O9IWe6tZK6N/gu6rO7l0S2hugw
         rwwIHwJ+rxrWgPhnhQeolBYxEnt17NAVO9s7PgeV09/HenT2OnZv3lhmasdL5EmvEnOG
         8AWeWwvoe9hDkviDX8GnXzVvDJg+ZlNKIJTgh6vQxOuNFbBz1uQbpO40tXYywJ32IE7I
         6pulN78q2w+jAykFNHWVSpBNxSEHSww+8xk/8mcP/m2s7LdowUovoFxZNN4cypJPoXZ3
         VBTT2omEbJYEthiAKgD9wgjuc8JBgzOXBBAPT2DAv2m3AzPztYwwoevO3ccAmrjpqQeF
         iZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=rBhy1hDepJc+fpYXqCbanBB1pbJoQxlKjnA+OGL5CE+nZ3mwwCwEEs2XYSdj58ju0l
         ZwMyGygz/uZuNyFdeKl4Q3ehgg3X6NKtbYYxTH1hbNi7Hz719hthZ4wL+t6rETzA2Uje
         hyntovPhXixHOoDwY3tnIMv391G0zfw7SkwQ+kjDkk3JQnTjZP4Oyajv8aE1n85nZ0BO
         ESA6KxfDOFTJsmFePWkpOfrqh5WYPmL6bRJ/YNriFODD+zwvepRgR4WRfya/lDp5ZQtg
         xko8FVc72a61zCgS4DlBaCWDRAprQ/gPOIAcKpFEZGVe/1pFThswkfb9AkPEVEJgKlQl
         2WGA==
X-Gm-Message-State: AOAM532rw/8y5RDf+6fPUFLINqLCRfYNPUeRb7SDzulBsAbeHJlLnIOa
        mKNuKbq4O/L3N80vMjKZSTpNww==
X-Google-Smtp-Source: ABdhPJzWIx/SFzMc8lRIlMQ0pH/4OykRg1Xgf+E2QnrCoAgIO+1y6+Izb7pmAkfbT9U/ZC2paA+aww==
X-Received: by 2002:adf:9523:: with SMTP id 32mr244948wrs.361.1611856972100;
        Thu, 28 Jan 2021 10:02:52 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 07/20] ata: pata_ali: Repair some misnamed kernel-doc issues
Date:   Thu, 28 Jan 2021 18:02:26 +0000
Message-Id: <20210128180239.548512-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_ali.c:119: warning: Function parameter or member 'mask' not described in 'ali_20_filter'
 drivers/ata/pata_ali.c:119: warning: Excess function parameter 'ap' description in 'ali_20_filter'
 drivers/ata/pata_ali.c:322: warning: Function parameter or member 'qc' not described in 'ali_check_atapi_dma'
 drivers/ata/pata_ali.c:322: warning: Excess function parameter 'adev' description in 'ali_check_atapi_dma'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: and cc <htejun@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_ali.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 0b122f903b8a8..e18aa02f89530 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -108,7 +108,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 
 /**
  *	ali_20_filter		-	filter for earlier ALI DMA
- *	@ap: ALi ATA port
+ *	@adev: ATA device
  *	@adev: attached device
  *
  *	Ensure that we do not do DMA on CD devices. We may be able to
@@ -313,7 +313,7 @@ static void ali_lock_sectors(struct ata_device *adev)
 
 /**
  *	ali_check_atapi_dma	-	DMA check for most ALi controllers
- *	@adev: Device
+ *	@qc: Command to complete
  *
  *	Called to decide whether commands should be sent by DMA or PIO
  */
-- 
2.25.1

