Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379CC433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D564E17
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhA1SHi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhA1SEp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A2C06121E
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so6350563wry.2
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/DwODThT9yC2p7TIC8q4FOkFeXMx+9HaJ4TFjAbkcM=;
        b=IcehFqxg+qhB/Bt2N/xmvTOQuNtPxLWBYFNOY1uPVKFq6t37B8P6+QnybvCbJfIA0g
         mHUNP7ASctifTUszQvOB+5y7G0oU/eSaeZKeAreNjtBPSzoijZeIitNytsMQ793/pOOS
         l0T0sWha6HXVk5kMRVejg7Z2bHFXa46jLIbiy0rTXPg0nPwTFrRrRDbSIq+2zXlWGmbL
         RWXJHlbHhMfR9Hucr89j3YzuE8r2piliwu92LDTV0LHIpbg1c6KOAlenjcx8HChqLW79
         S5JiOCzAh1OIDpQPJ/npZfS0jnteGMOhfBJ0KpNOtHj5xvkgxYTlExW+zELNTPJ/vYAg
         tS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/DwODThT9yC2p7TIC8q4FOkFeXMx+9HaJ4TFjAbkcM=;
        b=iVDeCcosrdj5qt8+54pnSQUWs1DYUT5URrzy6jtPDDHf9K1Huo/5PzSCVWI97mvO01
         gn39+FMY1ORbOTTxx/0H7jpa+Kx7/OhVdHRewhYrA12aLOwtniAIQEOCORLXOYN9pAfq
         q3rMVlST8kXjB4Sqeb/bH8xqBVkzwupAq+9hkWKzA3opRPDLCljS0OzS5rDyD3Bv7vmT
         U0OnbToJbYpbDIHP/78eq3nuU28ct7XTzSGtzAHUrWgJO8TEdWI7T9XOPjw4dPyawUex
         KyTz2BL02++UqMw7zmG+WUpg6+SsepDWxaixtmUL9/XQmMQhcQQcbuyKuObQJlHqF3wn
         SWlw==
X-Gm-Message-State: AOAM533QTjvGP6QBz7HPj6rUPSNC929iItZdkZXf/oKgO/uiVQecbZR6
        EU5BLnQ3tSfZKaP3BGV+fZK4Yg==
X-Google-Smtp-Source: ABdhPJxVOhutxcNoDQUOFr31hXwp4y4YTk/hM1DXXDnAs/FBnB2x/NCn3+pnA2qCqgH/1pK5aeCmXg==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr244663wre.279.1611856975325;
        Thu, 28 Jan 2021 10:02:55 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 10/20] ata: ahci_ceva: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:29 +0000
Message-Id: <20210128180239.548512-11-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci_ceva.c:15:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_ceva.c:187:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/sata_sil24.c:378:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_sil24.c:378:16: note: (near initialization for ‘sil24_sht.can_queue’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 4542f101042ac..c7460c6b94c1d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

