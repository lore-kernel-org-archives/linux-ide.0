Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3287C433E9
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB9164E1E
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhA1SHd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhA1SEd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFDC061354
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so6355159wrx.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz1ysPXY6dIT/8FVs8doLP4WQeUP6R82FsIHTFVdMfY=;
        b=PCshDChF2psB5lznsc62jLqInBWsbrTH3AsmsS8j2tnSnEfifferJeJSlH4zGWQzsU
         iC4RcRAUfGIvKi/vPDfg9w/x7etN9PzJkIi5f8VvJb7BPg47PRIDFpdylo4VvZ7Efd95
         HfabLRFDScWwg8o7flnyeAymFkEGMwFNrtvna1xFnI3y2Vzwa+RXPJuyjZlbOV6JWJmJ
         S3Au8Yxi1BJYHRunWw8lVec29AtpSKx/7UNsnmRMjW0D4RjcVyEfpKJVcb+2QZESr1rF
         pSKAx2L2ObvxqaSlLGnZNsNXo1Mjp93Wq9aROO75mDXn3HH4Djc7Z9lbIQOiToyuGk/K
         ICww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz1ysPXY6dIT/8FVs8doLP4WQeUP6R82FsIHTFVdMfY=;
        b=aP7XhW0hjZV05Lc7YFpA4Pyp9hXV/A1F3C+qMDx8Gk2sE6om/zTJvNv7y87f8Onuf4
         uhTjF6ZFSz+gbkAiz9jXo2cil+tThlNBtQyBHS20JYnbPs5b7w8L1Jiv4AHLx4mlEIRy
         UIRXprJAX39pakiyKztERorhHOjYC6dCvagsIlAcqQ1jv78N+7Z4VB8wUAxPgrh7Hxwc
         7kpJLY4NI9gaOkiOYk0XhHVwPKlREh0NdvwyC0iDL1ppZ+t5apSfUw3TBaBp9xkXDYFP
         5ZafN6gV1v87P0Yc/OFEMD606wHKAFAcgSoUYnPpE5NZYJW17ccNJa0sXTlIW9CKaTZi
         pmVA==
X-Gm-Message-State: AOAM531JCneGMG7jupCKWcbrJQp3uKoRbT8z+wJMmThP5OKb52OPMhiV
        GwTeeu2tYrAfEq4lKWDkEgWrmQ==
X-Google-Smtp-Source: ABdhPJwjPI5OWXbhQTA/ivFPtXo+b03sqvS4hAl+8fbvpeLCkCYcA4RrTpzKqjyfPmdSuPmatlQZ2g==
X-Received: by 2002:adf:e807:: with SMTP id o7mr331333wrm.308.1611856970720;
        Thu, 28 Jan 2021 10:02:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 06/20] ata: ahci_mtk: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:25 +0000
Message-Id: <20210128180239.548512-7-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci_mtk.c:18:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c7c26a0ef7632..79c59550c23a0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
-- 
2.25.1

