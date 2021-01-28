Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB4C433E0
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3564E1C
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhA1SEt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhA1SDM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:03:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43CC0617A7
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:47 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u14so5031610wml.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azFmqObNrsq2Y9KjmcVwLZnWbMejrbRgZoxiCEhbXjM=;
        b=HNGSfsRPfXOsvjYZ7/0xtd7uCashfdor2Eo/qkjTDPQH12ec/MO+9jNMbB/dyUMQJF
         7g7ReSrcfoqkCpBh36rKtsCpmczMvqyXaqetvt0+xbGorohmXiyHF4TV6gSc/b823c4F
         Vj0PNNYViEBVsnqcbx1shl+9VrWnH6e0WqnUQIwB1IAe9c0ExAWS1DFrBTcxuUQA2YBx
         BEBQH0xDA2qAMIH9+d18aK01tAQU8lO0h3mmIOeJgtduRGovJYc824139kQtmg8YqrlQ
         lSYBB4/O0IG4u4n7m3Z0LgwauIq46AiQHti0NdSxXJXdIR/QdhDfdcDyU3XzbKRnKp9B
         qXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azFmqObNrsq2Y9KjmcVwLZnWbMejrbRgZoxiCEhbXjM=;
        b=uKqRZH3VUo60NYkAKdJCjaGjGwQ0ZzAs9vG2zasOsIWWYMAMLSC3njOWmnpfc1wqYT
         Zudpp90n5wCfWxDjo0Y1kurCEVk3opWF/DauVKOL2L3FvfFuJoWhvY9P8J7B3v0KATFT
         eSQob9qJSQPDBzajQ8GpWLRk5m6Cwxw5BJ2ghLfc9YsEJ5+Rxys7YnKHXGy6B7TkgFq4
         1ZL0AhHb31JNzyIaSh6GheF6sIlCiTo676iKdl8KxvfER6e4LY2xBLaAPRyBEFDM/INY
         vz/Jrn2TPGmauMO9BWQZlJn2pvf9GGNJpKVrQECn7LidfSv4C/8GfBNWrmDkgBx6/hQt
         FQvQ==
X-Gm-Message-State: AOAM533lvSYfEXkD1D3F9Iii+chFWhSrIQRNjzd+2m1Bun+6LLzqAqOs
        xyPnULB5TH+4VmdKIGvwaoCc6g==
X-Google-Smtp-Source: ABdhPJw9yt3wZkSFszLXr+EE6OLfe4qNPCK4cG+E8VjybhnGF87k5wzXMes6R+iUcVwPwSLVR6gq2Q==
X-Received: by 2002:a1c:ab57:: with SMTP id u84mr422142wme.115.1611856966567;
        Thu, 28 Jan 2021 10:02:46 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 03/20] ata: ahci_platform: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:22 +0000
Message-Id: <20210128180239.548512-4-lee.jones@linaro.org>
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

 In file included from drivers/ata/ahci_platform.c:21:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d24bf4d2b08d6..c7c26a0ef7632 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
 
-- 
2.25.1

