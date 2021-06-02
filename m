Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE81C4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063B5613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhFBKUJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhFBKTl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4CC061574
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3427818wmk.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NvljD9Coe3ImbVweUQhRVx0U62sw+qymnCXTI2Y/Fw=;
        b=Gc9btDcQSoeuLckJ3t8QvsF8N1XiFgL8Yc10DL7jwSYW5cVBidCVJWCiUbQE4cpQTe
         ABCaHy0bP7v8JrcR3tPLIWbA49QaqUN/UgeznpNE+or3KHcYsZDM8HK43mlpbFUMxuwd
         My623Iu3a4ApnfO9kDC8b7hvQhJjq3/1mvMT8jYAqR2rWNoqSe//YMUsP0/UZ6itFFKD
         Biro4D72WU95DpCGE+5osKehNHqaiqYSQE2XY3bsdSJiLI+49OwRQtJ8UKl0mFt8SKYv
         vjjYQCKvnfbGLqhULN13U6B/D7GVCrYG46OtlYXtQSD3ap/YIY1O7yuXaMnDHzsy1LWo
         LU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NvljD9Coe3ImbVweUQhRVx0U62sw+qymnCXTI2Y/Fw=;
        b=dQBVUB+qQZY7bVoIDQ6SBLGW7/7TjacNRUXp1ReujY3VdEvLE9Cp0nZJxYs3oIqtxt
         hag3+Exm0Q8joqQxZ2z26phedFtW+AXqTE6pKWWi+HGRl4/zdPZk6TC3xBbGrNY/vYN5
         UPCVexhncXEnTXEK88QLrEMQMo72RRsmTNvDRNiTf7PhVHx//sETHqmCUn7nNJrB8uJf
         wjFui7Xbid24DXueYkBoV7/JerK/P077ByfFMhz6EIqJt4QFFg2PCB7jzT0hhoNjd5Z5
         nkn6PCtCHTvdetP4XPeyukL4GaCIfxUKHAAloKDBGAiqzN6/PNtTMX3b6PVPKAE3ymjI
         +LAA==
X-Gm-Message-State: AOAM533wATYJkoEDbfs0YwWX4rSav0NIzwKa0vM1KJOkmoCGEHcexntD
        nNl56ur3lRdFQ/Nfu5QP2+sRsw==
X-Google-Smtp-Source: ABdhPJwwcyUY7GSV9q5R5pikjcfL0GaGuqMxRtnHnBtiSkEpFd7Ggbu7+oBDJJL1GrZVcThFLxXdHg==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr20132118wmb.8.1622629066278;
        Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 13/21] ide: siimage: Fix some incorrectly documented functions/params
Date:   Wed,  2 Jun 2021 11:17:14 +0100
Message-Id: <20210602101722.2276638-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/siimage.c:115: warning: Function parameter or member 'drive' not described in 'siimage_seldev'
 drivers/ide/siimage.c:115: warning: Excess function parameter 'hwif' description in 'siimage_seldev'
 drivers/ide/siimage.c:196: warning: expecting prototype for sil_udma_filter(). Prototype was for sil_pata_udma_filter() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/siimage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index c190dc6dfb50a..64fa6b253a824 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -103,7 +103,7 @@ static unsigned long siimage_selreg(ide_hwif_t *hwif, int r)
 
 /**
  *	siimage_seldev		-	return register base
- *	@hwif: interface
+ *	@drive: interface
  *	@r: config offset
  *
  *	Turn a config register offset into the right address in either
@@ -183,7 +183,7 @@ static void sil_iowrite32(struct pci_dev *dev, u32 val, unsigned long addr)
 }
 
 /**
- *	sil_udma_filter		-	compute UDMA mask
+ *	sil_pata_udma_filter		-	compute UDMA mask
  *	@drive: IDE device
  *
  *	Compute the available UDMA speeds for the device on the interface.
-- 
2.31.1

