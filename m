Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173FCC433E0
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D347E64DD6
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhA1SPC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhA1SHV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:07:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2003C061A2A
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c12so6334146wrc.7
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLTjdVY72aKyqSF59N/uJRYV12gUSHg1TskoZb+zwxc=;
        b=XxpSF2uP2v0W9RW2VCJqhChGAX6WSCAXs6w4ijZe6v+12yrVxLzHWT1Ec/Q+f/FtXI
         9HqklksJde6eMBy/0MI4UQM5rIzajbYvZgaXfZv1WnfdVhfWIadYljnqt0OGCCgOgex4
         kYi6InAkGU0oFT0kDeOzCT+T/eYaBP8f/ATqDzUoD2dJ8ZBTmZsjNw28UDwA2i30psU7
         QjTanU5sTVW7sPPBj6jpc+3Ct+XEYM6sH+DrHzWoXx2ysWqds68bJPs1xsvqbBsqszxJ
         ctswyt4WdjEGjUELBK2BBMQNfdqOv/aNhV7mWh0K0JpxUZbLVLQBV/OJPzqMr4dnsFdl
         kXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLTjdVY72aKyqSF59N/uJRYV12gUSHg1TskoZb+zwxc=;
        b=RYbdgY29y4vwDOX5dKZd+pd+Vu4l8IvV4Hd0BUAht78smr3gF9ARo3yBBSmLztOpBj
         YILnX5ylQSXxUMQM3cLDkN0nWuQWJZ3KgRyJtV+cHNcNSVRWRwn2ZeKP4WKIqHb7fJc/
         Xc8S/ip63x4IVdv6p2+jH2VQ1pksbHmdP3pOyrPY81x8jyjUYAFFKrcjl6s07SBeJ3Yh
         9GDBZ+4OIKt+wofoIwUk+S/aerSa2I6QN4kchMSmNdT9tcHXcLEoIzf0vKuC7cx0m40U
         6dIn9HVeZI85dm6T4Qvve60e53+nEXH0jFB4jMu1x6aczVDlrGRvG3lSL8L4Tf+3hpJi
         yBHQ==
X-Gm-Message-State: AOAM5325a9dOyQ953YoU8i6i+UADcL1Syn01AQt2qyIPa6rulVJZH02U
        qB+cp2pqfa0RvtqIHp3t9xx48A==
X-Google-Smtp-Source: ABdhPJyWSuYrKMWdaIv71fSya9X1MGXlIYeadHHN2MFhUwF+tSJksHr5Ryna9O09obzzpWv9VnBglg==
X-Received: by 2002:a5d:6044:: with SMTP id j4mr247434wrt.287.1611856986700;
        Thu, 28 Jan 2021 10:03:06 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 20/20] ata: ahci: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:39 +0000
Message-Id: <20210128180239.548512-21-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci.c:35:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_sht.can_queue’)
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_sht.sdev_attrs’)
 drivers/ata/ahci.c:104:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index a6755a524efa0..4580a0306bf3d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_acard-ahci.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci.o			= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_brcm.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
-- 
2.25.1

