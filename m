Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C441C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C1464E21
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhA1SIq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhA1SGc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:06:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811FC0611C3
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a1so6360127wrq.6
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Kb16WgSiv4QCUnRh1QxmaZs22WYIlooIF+TJGzI06k=;
        b=uY4tumtm8YxOImI9ocT2XoW8jBaWMaHHZiFSt4FEuXv9bdzGN9Xj+osrJCQGerKD/P
         sSgI2L4hb4qjMt7aVvkNRMKuZ6rj0dJ7y396CeWuYr+K5hDfG0ixH0Mwj/jWYlHVTDDO
         ZUAiIdWz/0iGZCKsHCQSS9R4hek/lPkeCB40HrUQRcjNokwQKG7GwmrVAvVR8eDczZY0
         LO5KJDXrrVmjxg+x/mySwzjkG8UG/5mvat7AgllpymQ6UA2+ssRaQdKkCoCFvnNseHJ0
         3ZT37UgpKQ+OBZllJcKKbHglPTxM3GSUNQYr92qAEjJ4y/Jk3R+/h3imz9I/qP1n3zZr
         qXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Kb16WgSiv4QCUnRh1QxmaZs22WYIlooIF+TJGzI06k=;
        b=N0zNyfGbvd/podW5gbOc9N+VQZlZZM1maQhEnZ3f5bFBK1zcW2BD90hlxQKdjMH6EE
         8s2NY5qVTRSaRbMT1Vu0IW8jCQ2tPP/8SiMu5hW5McY1+5hOjFWIV8ZEnHgJ6V1YqPaE
         JbMHYlcAN/X/bbgidUiuFgkDu4xM5h1VVreXteQPUaJnkRTok82/f1ZznfG0OGR1h5/D
         Vd8iW/rJHA1Oc4uzprPGQxfY8Gh/4YkokW0l6Ilzn0lokuJ+Anq9ov+A1a+M1qN4dZKI
         7JbEEKtBLn384OE5Yn2/UXN8gBS0uqQQgeBQMOqGpkTJSqT7SgBsK+VE7ZmSFLWAKXgz
         rIJw==
X-Gm-Message-State: AOAM533LEWMc1OZ2tU81dYVJorZ2s5nCN9XmlPqVEy9BynXZPQehIML+
        SQbKutMh8UuMzu9lVNilXRIC5A==
X-Google-Smtp-Source: ABdhPJy0q7zmSeCorDLSuCQkUi+uvpRw9C9SmnsugADQK5tQ2YEsviEZpL2JQSzXWWVaz05j2FO+8w==
X-Received: by 2002:adf:dc88:: with SMTP id r8mr238462wrj.401.1611856982219;
        Thu, 28 Jan 2021 10:03:02 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 16/20] ata: ahci_brcm: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:35 +0000
Message-Id: <20210128180239.548512-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/ahci_brcm.c:22:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_brcm.c:414:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index cf851f5a4e7fd..a6755a524efa0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_brcm.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

