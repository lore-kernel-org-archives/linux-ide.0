Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE08C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74F264E1C
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhA1SF1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhA1SDe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:03:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625FC0613ED
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id z16so2726614wml.2
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8dNJasVRLn/usmEjlw+r/WiHjA7itNZyTC4iBox9OE=;
        b=BEIFtbiLYui7i5/dK8Bzf4Sp/HnMwiI8qwC5Eq9mDJR/PlW8Oy5ZcdR6cFBRg0RWvu
         m1xMJBXcVw/0tMl152QNrNboilxrvP6WwFx/F0VP/X7Poxu411PsronDlfbmmxF9qOGc
         6UgK3Q+hxvizl/QnZaeG//DtubPyDt2lcGEtZv+c9dyULOWOcgKByNKv0RW1IGLAOpk0
         LsqGLPD9jZ6pJff9mag9GVsnq+RGxzLWJRvc+BoLGIjNPdwYkUEEXJKGI7fMxmej5xGi
         44+QIR72AT/K4VT/Znpc4+B8nUdgqbQQixMLcygHrVdmdRPo0ROAjQv2VxJs+l9huj2r
         cYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8dNJasVRLn/usmEjlw+r/WiHjA7itNZyTC4iBox9OE=;
        b=gZQf6fsjCu8+1SOSmiO/j+l1TngNDp9+GKzJoHWsj3lrbT1mpSa+RcuRE8xoo7lVxI
         ehlpPeZygoELycqZKIEE8DwZHerEUhDSJKxGiyrKygjvbwvn70LK8I+SrSWyCflOevm+
         zk+MVgIyvtFBB2NDDgWcDlCNhRorxUy6QhwSMzYGcHSglNqECScTI81m/CPKjQNrl+UD
         C3+fhtnnXTVdZTj1lvbdcC4nsqnZ/Y27rEs82EFfsDemWM7uO3C0lPAMmkPzMaO8diKA
         fwR2rmvmuyjQ5FPuluJKA4O1uBgwHx/6hS9JRLCrNKB0pTTFl8tnNmNLpJ30rHpJL+cC
         KVxg==
X-Gm-Message-State: AOAM53378UVMNgc9VGxlHdn39ebbqAOQKrvU5PTSKYQmWhYb0lSqdNAx
        xL1FXJNPHu7upIzc8Xss4jTf3g==
X-Google-Smtp-Source: ABdhPJyUftLDpHNUfD3jbKYPjUbXco7613rE8AOb0mliJLVNCNsrJ8XZcvKWXWqnwRH+I1hsLPUN0A==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr477664wmj.48.1611856963384;
        Thu, 28 Jan 2021 10:02:43 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 01/20] ata: ahci_dm816: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:20 +0000
Message-Id: <20210128180239.548512-2-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci_dm816.c:16:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_dm816_platform_sht.can_queue’)
 drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_dm816_platform_sht.sdev_attrs’)
 drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b8aebfb14e825..d24bf4d2b08d6 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
+
 obj-$(CONFIG_ATA)		+= libata.o
 
 # non-SFF interface
-- 
2.25.1

