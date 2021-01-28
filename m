Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C082C4332B
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DF164E23
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhA1SQo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhA1SGC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:06:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE67C061226
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u14so5296274wmq.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gT2cxZw+MQ4seB7v8/9B4WCOA4wG3O/G2z6VtzkvCxE=;
        b=Gt5dMryvvJiG5ucbCvgM4VjHdED5lacseCJlduFYa9/RYb8Bm1pjJ4JzVsgtIkE84H
         599RG1ThbTLLHDxyXnlh3p3x86BIL5+7WKkaExWDEF1fP9nqoTeaUIEPsyEjJYyEyRHZ
         4A23gg+N2xnAK5nIX94CM6M4BUgTLujxp62Aj1tcJafnWQAGy5nQWDeYhURbX/VPxGLY
         g7D6Lq4P1iQw7ivC8Mdoz7dgjXpAOlsGJcdfvtDwJV+HvSBNGJ14Q85YOXpW+m6o0Bzf
         m8/9azLHkPwSK4T4CX5vzzUevFGd3SYfX8scgbLostDbjpidxT9jZQ0dNLuY5Av9YnzO
         sT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT2cxZw+MQ4seB7v8/9B4WCOA4wG3O/G2z6VtzkvCxE=;
        b=BktyLO7dZ4Fdvz6IiyjOy3QTJp1843mieYklgbS9sEh4THGsS+74pB6tknfdyQw5+H
         P/bXhsmkNlNQi4iiEeTpzYqCI/SvCQ8SRej503lnXEyiWruHFFgH3/Zu0P38HCJEp5om
         33acm7JR8Y1l/BeCElLQQ6a8S+4euqdEBfPyaxGhT7a7xE5eQKoHhzvnAhamaxb/H2mp
         MdTBJdd3pl25H79aVzaBZXHFQf5sOw27+jMiaDPZIR5rNVzqM+RWvn59mn/dVxAlvx0o
         uTBzb78US+tc/JJtWShjcEcasgIbLbM0df9Fq8wTr+sdBj/ey0/mj/rLYtI2SgCTcHUo
         /xKA==
X-Gm-Message-State: AOAM532CTnJMK6yaeHeBapPxM8/SCwAYC5JgCup0lyDphgLd2OXyXALO
        XRFaO5vocjPEIjmraQEEqXqxRw==
X-Google-Smtp-Source: ABdhPJwVi4H8wPonjuSrecsMlYCH9jt2QZgzS6XQr3HaYK95r2i3Rcv1jRARG6htvkqqNF6A2B32yw==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr405984wmb.99.1611856979878;
        Thu, 28 Jan 2021 10:02:59 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 14/20] ata: sata_sil24: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:33 +0000
Message-Id: <20210128180239.548512-15-lee.jones@linaro.org>
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

 In file included from drivers/ata/sata_sil24.c:14:
 drivers/ata/sata_sil24.c:381:22: note: in expansion of macro ‘BLK_TAG_ALLOC_FIFO’
 drivers/ata/sata_sil24.c:381:22: note: in expansion of macro ‘BLK_TAG_ALLOC_FIFO’
 drivers/ata/libata-pmp.c:76: warning: Function parameter or member 'val' not described in 'sata_pmp_write'
 drivers/ata/libata-pmp.c:76: warning: Excess function parameter 'r_val' description in 'sata_pmp_write'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c7460c6b94c1d..d46703777cdd4 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,6 +5,7 @@ CFLAGS_ahci_ceva.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_mtk.o		= $(call cc-disable-warning, override-init)
 CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
+CFLAGS_sata_sil24.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
 
-- 
2.25.1

