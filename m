Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F07C47087
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CF561222
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhE1JHB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhE1JG4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE9C061761
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so2489891wrj.11
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYwNHNrhbfh9CANgoPYUUc0JeKX9lP8oPhSc5WFJNEQ=;
        b=ZX38wE3i7apU5/duc7GW+BMobL+9wKiANk42JZTaCXJrhPeef2VoTcBCpAO37TEazY
         SU7icxq1P/BracR22EQYxyo47osE2Sps3QSY/1XxKZraPTimTkEc8RpWVJJS/ZFr2drw
         FjImleBL9XAJ/J402JNy9e2kBL6ZpYjLH56PH9xr89wsceD+wW98Fpe32yhpghexRGJz
         2wB9Vw3Xvu1jskZZtBRTgnEGVckIFuN/gBKgMuw6nB11i+RuyIWepbS4jNkRT96rOn/2
         FMbxwinxH65FcjBMcVx+s9XnS0UBXDLtcPWIJiPPyiJAyMcmnN3FwQ4yet3zGSlhw18b
         QBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYwNHNrhbfh9CANgoPYUUc0JeKX9lP8oPhSc5WFJNEQ=;
        b=nUK2ptuk/gKRRkh4Dc6yD5LOYzH5FOd1A2JiBH0s6eefSz+capJEP95qvHKh/jIM71
         FIBc5uSl1/iMj1bOgmGVHnG3xqzc8kD7gMpXIJN4490k5BYghyosxFemxh0vqz2rKnrr
         lU2kpG1w40Xjd68kSKtJUScGul5KSA/AQdZl1geLVCPnszsF0XGuIr9hQmX0VIZDqYmm
         p65MdR4mS+I8rg1/O5BIs5NxyTXmzhoFdYh/I8nzk28lMPa/V4Rnod80Y+35KE76xDdf
         zyKsDoPuZ5mbR4n23PjiPVq1L4xQ1v5yI3T41CEmb1C6mPrGbR5gC0xkBPW/gpaTqXw3
         Deiw==
X-Gm-Message-State: AOAM533yph+lCYetu5v6e/SVCpgCPlNJeAYIGNCJjbMEK6sjSFPt3FNs
        U3tFIcTRstTW2LRwuo2Rx5OVe4VoXTtEHQ==
X-Google-Smtp-Source: ABdhPJxrDRvCtE+DWyEoqHgvQj097Jghqqs+XsQt5bmzubXXdYwa7DpNX15McFcRRHL7TMga/x2aTA==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr7483627wrt.365.1622192715897;
        Fri, 28 May 2021 02:05:15 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        benh@kernel.crashing.org, linux-ide@vger.kernel.org
Subject: [PATCH 11/11] ata: pata_macio: Avoid overwriting initialised field in 'pata_macio_sht'
Date:   Fri, 28 May 2021 10:05:02 +0100
Message-Id: <20210528090502.1799866-12-lee.jones@linaro.org>
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

 drivers/ata/pata_macio.c:925:21: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_macio.c:925:21: note: (near initialization for ‘pata_macio_sht.slave_configure’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_macio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e47a28271f5bb..be0ca8d5b3452 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -914,7 +914,7 @@ static int pata_macio_do_resume(struct pata_macio_priv *priv)
 #endif /* CONFIG_PM_SLEEP */
 
 static struct scsi_host_template pata_macio_sht = {
-	ATA_BASE_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MAX_DCMDS,
 	/* We may not need that strict one */
 	.dma_boundary		= ATA_DMA_BOUNDARY,
@@ -923,6 +923,9 @@ static struct scsi_host_template pata_macio_sht = {
 	 */
 	.max_segment_size	= MAX_DBDMA_SEG,
 	.slave_configure	= pata_macio_slave_config,
+	.sdev_attrs		= ata_common_sdev_attrs,
+	.can_queue		= ATA_DEF_QUEUE,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
 
 static struct ata_port_operations pata_macio_ops = {
-- 
2.31.1

