Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD778C43381
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B290F64E23
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhA1SQp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhA1SGc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:06:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6AC0611C1
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a1so6360051wrq.6
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnaBivPDyIR6gMAHAoH39HuDWPvuUIfAphuD3A1F0ZE=;
        b=GmTt6uepAz3Dn8NZmdm/BpZmoDDL7JOogKQSj/2DdscZhtv74SQ3r/PuDlDeSForKM
         o5+rbKyl5ATV6x06CbajjAu6abcqUq8sObBpfUXgwKD0GdKkoDwniAUcuFY2a0FwAAYu
         +Qa/Na6KUrTg9/jQlzFcZZHJdIRb1NImmmQTvvy4YdSjlu+lqINGVXOodnVNaPh74vkA
         AP7antxMT6B0JYzbuXNgSrb07xCThkY03NIQZ3aS9mvKs8mQacXQCIm9chMlc0BHDWot
         Yl4K3CbN5hKt54wYnGPI3eKRLPdl70gICFBfr34rg4I2NgmbT8mdl1H8PZl/DV6+75aI
         HMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnaBivPDyIR6gMAHAoH39HuDWPvuUIfAphuD3A1F0ZE=;
        b=m9U4mYuuzxSpRA0XZjfIFL/OWYdGWAujd2ztZTi1DvMmATjCefi8EnKzbOhco553Bs
         oP5vGLMgtJjCCedYPLC2l/RI6JIiWCnaz0ndY8GfyQglpaj5OSekU5D7ylrlkY5cddIg
         oVmhatgcWh2bvUQ5v5NNIc+Ufyi2/b5w8AUXVfK7V6+bZ8zBm4EiHRdZl+rQdGG21wsb
         L7/dvIvD0mttHzm8JzVSBa7ue/J3dXxy8Kj8A8ujXCjuYikVo7juIxQ2B3cClvP5DhXc
         4HO/DUoUu0wDwsncilH4okRsyLQQ0l/JptwOVs1ueQt8wxv8QG5cg7XGRMkOobDjEHzX
         oDeg==
X-Gm-Message-State: AOAM532E2vwV/Fci3DF0wcZlp9Ntwph5DyBoliiLFuJ091cn+d7GZejB
        c5Ab0au8nxhcHcaZq9oI3M4EaQ==
X-Google-Smtp-Source: ABdhPJyQoFfgxJ9wREOuyYhhU7/FmotdW8dZeHkvFg/1RJHmXWvNuU2KrLPJd6Ia32VJzLOcpRkxQg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr233167wrw.379.1611856980901;
        Thu, 28 Jan 2021 10:03:00 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 15/20] ata: sata_highbank: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:34 +0000
Message-Id: <20210128180239.548512-16-lee.jones@linaro.org>
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

 In file included from drivers/ata/sata_highbank.c:25:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_highbank_platform_sht.can_queue’)
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_highbank_platform_sht.sdev_attrs’)
 drivers/ata/sata_highbank.c:442:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d46703777cdd4..cf851f5a4e7fd 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,6 +5,7 @@ CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
+CFLAGS_sata_highbank.o		= $(call cc-disable-warning, override-init)
 CFLAGS_sata_sil24.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
-- 
2.25.1

