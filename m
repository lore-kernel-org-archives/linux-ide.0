Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E3C433E6
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C98E64E98
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBAOlT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhBAOlJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A3C06178C
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p15so16785121wrq.8
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=ra/HweOfs/gsoL7RyLujE631F/5dEYvUbwH3AyoP0y+0qLVXdfz9LBEfiacR6k0Uiv
         /hmLUtwrpWpF8pMBw/JnZJFgp3UrAG8o0tGYTfvesq3H+057BEMzHQDVk0Wr3l9jmSFC
         sQzdhrMyVmMfr3Ez5VoTReuvdHasOXOM/18O+D1LAzBmAXSRs8eO/N7sUd611slNq5SP
         N9HIlQNxRDHpL2M8WPcGlCx9Ea2ECGM94xa9XIVHyGxgO8jfqnoiQoX/e8iMriwr5voJ
         YLqbsL1SCCeUlEumVhEdHwbDxaC0y4iw28JMpVgAKglMmGIvkmJeRCLSmLOsfFoIJXCN
         AG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=ITkjkMolJyTE4Lt07gfvZc99bCXjsTbTAoeeuhgMQtg9qnm6+Y0zZiGfu3tQDfQzY+
         vdNpHnEHhTrlGIy6cBg2p3X09Y/XJkrpLv479PjtgHrdw50T7BMgqBmJBHV+XZm5+jB4
         dv/BC0jIRO/jKo5l+hqX5+FYUFHBSyq7sawnxoxm5132lADezh5yawNxl8qTX1CYI+WC
         ihg/u27yV9p9zN9iUH4c9uNFTNo+bbYOvI8+IPrWsgItQC3kAh68YQTiCbKrnyLRdnaz
         yL4qQjik3PY5g6YXdR8XKbHxAtgFexwNuKRDr4vykSRrZE6ulosGErU5cPTxVyfxaY/6
         +sMQ==
X-Gm-Message-State: AOAM532r2sg7i4M67C61TkbmgXG6t8fvqO/sLPOypnhF3VcJLJJKpdtJ
        XWrUxL3LE2bTMMbR6KVoWs+ugQ==
X-Google-Smtp-Source: ABdhPJw4cRTTRwXoePbizxuey8YfKHu06X58Br5OOurPNGDHnCrrdn6vczKshahRCQ+oD4IRxt4AXg==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr6890968wrx.328.1612190388422;
        Mon, 01 Feb 2021 06:39:48 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 04/20] ata: pata_ali: Repair some misnamed kernel-doc issues
Date:   Mon,  1 Feb 2021 14:39:24 +0000
Message-Id: <20210201143940.2070919-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
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

