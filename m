Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A16C433E0
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC49164E17
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhA1SJM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhA1SHI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:07:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07491C061A28
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so6362546wrz.0
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=imMgoFtlkjloJ+OspitfwQCei1PhD4tUkQ8n4W661tybxoH12p9ephNZH/jRUaqGRl
         5G77kRHPX4TI9pHwjL2AK3CWnD9htKFzwuEftp/q1nAjFIrQDdAoo1D9J69T+s806X6+
         rOI44p2L0yKdO5cgFX9JW0YorcXDy56kJBh6vwDmW1KBzWIIxqYAeGwSLNmvjW9FFfOH
         3o2LBirukSDHYozGAycnTpuREqSe50YP3RZNsxMH1kKywBJf2Kq3FlKRZRIg3a41+aY2
         jO75FNUh9Jf1ztHPdyxcQBXXeEQZSxOAdu68p0LUMQEf9Qvn8RXUEff3lY/ngv4F1pcQ
         YluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=TPHNCe01zL3lqYjkTApIhGkXgc9vztYJCMGmpIskcDskUr2Y+fMLDUsbQbpd+8Quoc
         lhFfkpw8rDJUhBRIaEzoD/S1W6vJZiDaqko2dm45LkTixlZbw2vB0zDqqZ6LOQktBbho
         CXmc59CZxY1Mog6Dap4zjAu4PtlPMpUnVq3lL/2qybekLgIILzPcL44VvFXW//UM+35f
         /dMz1QKd5dbEiCFjiylZZI72yTisLIQWDqaAiGdxaRjUxyQQvK7ernACC0LKZeexZ1tl
         4kiSnjMQglivgrUOmeuHJBxKoYNFhY1tMmvdu2lQORPainSeNYdCUjnq5jax/k0el8uI
         labw==
X-Gm-Message-State: AOAM5329T/RmsBTDa/t5x4CeGcrCr9Kz0VwvXRi6OLX6I2R+gcfF9FfI
        eJK47tXIOv9p6/+EnJzvPM+eAQ==
X-Google-Smtp-Source: ABdhPJyVgNtveW+MCIr6+u0POnj/CePkkyGFEb/lmovqSafnYMRpj3kHzr30TDzgukgfeEjN28RSGg==
X-Received: by 2002:a5d:524a:: with SMTP id k10mr307969wrc.394.1611856985730;
        Thu, 28 Jan 2021 10:03:05 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 19/20] ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
Date:   Thu, 28 Jan 2021 18:02:38 +0000
Message-Id: <20210128180239.548512-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_ali.c:119: warning: Function parameter or member 'mask' not described in 'ali_20_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: and cc <htejun@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index e18aa02f89530..557ecf4661022 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -109,7 +109,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 /**
  *	ali_20_filter		-	filter for earlier ALI DMA
  *	@adev: ATA device
- *	@adev: attached device
+ *	@mask: received mask to manipulate and pass back
  *
  *	Ensure that we do not do DMA on CD devices. We may be able to
  *	fix that later on. Also ensure we do not do UDMA on WDC drives
-- 
2.25.1

