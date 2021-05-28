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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28599C4708C
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2026124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhE1JG5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhE1JGv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2AC061760
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m18so1726445wmq.0
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKY7Nwt97Wel376ZxrfOUdfc8QT+39QiKI00VWQO/14=;
        b=cETsOJWQgQVIPEsVJjUzNFQmUWMmPee1hcTqqOuWmu7/ai4R8HMTiT1EfvHP9eHWcK
         11FcyFFb/ryknvG1Www6P18bTeFhkrUONNRDhX125P2ruK4but07UxTh0UZ+mlrduB93
         ezosoNKqtQRvO0rUlmOQi6uOC17M1fwY9Fz2pnuHAF9w7FrKB2ZNNAH+mA9+VNsbUn7K
         ScFI2FhpyYl7JuL8fDBP769JDbbcg6p/w3sZnlIKnRvbBxFV3SHLVMRQtkJ6VqY6eJsg
         xnpZkgQP1Bh/svbdbjSDHq5/YJPTeCjzTrgoQ023Cjb5WoIpv8VY3kNarBFxdd9mbWLI
         DBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKY7Nwt97Wel376ZxrfOUdfc8QT+39QiKI00VWQO/14=;
        b=Cx4TAuMaLgqhH3IWeXDMCjrFinpSwvdLZaFtwKvvyoT3GlHziJquoqjaj28TeHXFUq
         fJJz3pj8aFjBgKP4Y43bnGn72FYHtVQTHC/ZnyN6B13nysi1GJIIxjwD73KZjlY7Hutw
         aIAhiQzTL9vBPqLmUIeh9SfyVWGvSLmAGnoCTsulQovwrHEVAzuPNPKtdeje7lkxebe4
         77fSxzgEXmhwZBP4wOouNQvt8WIovSrgp+Jxlw0+UA3a4i+Bg33JfOG38DWwiPQ4ZEVc
         WDYQzL8DcT3G1cIkSvBWD5aAroez0lCGcxEZsTPy7UsBaqxVh/eqJhJwieYUg3YrTZBz
         c8Wg==
X-Gm-Message-State: AOAM532Mkwfd8ns1ImRuKo2NuwnGCrqA/YlGIytmiHJYXqyoEYvd0NnF
        plAnIw3W/6iZ1Zo0zj0JxNX0tg==
X-Google-Smtp-Source: ABdhPJxUQmT2mCaxsuzt0DkPUWwZBKAAH94RsxoIBGrhQGVgAqC6MnQeY6WnCJam1ZDPv+wuQfDinw==
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr7404576wmf.75.1622192714749;
        Fri, 28 May 2021 02:05:14 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 10/11] ata: pata_serverworks: Avoid overwriting initialised field in 'serverworks_osb4_sht
Date:   Fri, 28 May 2021 10:05:01 +0100
Message-Id: <20210528090502.1799866-11-lee.jones@linaro.org>
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

 drivers/ata/pata_serverworks.c:257:18: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_serverworks.c:257:18: note: (near initialization for ‘serverworks_osb4_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_serverworks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 7511e11eef4d6..b602e303fb54c 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -253,8 +253,9 @@ static void serverworks_set_dmamode(struct ata_port *ap, struct ata_device *adev
 }
 
 static struct scsi_host_template serverworks_osb4_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary	= ATA_DMA_BOUNDARY,
 };
 
 static struct scsi_host_template serverworks_csb_sht = {
-- 
2.31.1

