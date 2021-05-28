Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8CC4708E
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40B96124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhE1JGs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbhE1JGp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B49DC06138A
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g17so2478698wrs.13
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=baxUJEs65n3xyZIblZq95NtbRVPvoaWnTBTr98e1a+Q=;
        b=Du15IUenyMTbo9/N8v6OxPcGKX6b5dxlbC12JobH5Gu8kyU0q3L+gg+YrhDXuP60Xx
         8bxHY6ePO6u7651R0c4Sj8CWMrI9w+nHj09eNcfxsG7AKIqr+TeAgfQc5YIrYyofe3op
         4TOZ52jJPeshmzZ9UMiOBBU6BP8q4WedrMmpeum5Y+LntkfepNyiOyEN4w4dU+5F9iWI
         s2MpqNLkr+mmnmF3V86K+g0/pzfOLeDPsFy8rhmvwdCeJMrfLrCD5w+8d8HoeBHfLAwM
         2MGwxpLagGSVy2kOx2glWfmJRGnlLSjRnriN6UaIYMvzHS1bAB17SJBlfPmyqPjZo4tu
         rDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=baxUJEs65n3xyZIblZq95NtbRVPvoaWnTBTr98e1a+Q=;
        b=NygOt8LdnzSqSQ5mAaY/Q+j7Ead84mEd4odddjSAwxhGjZNrHlj016xholSsVc7fVX
         P6vtdgIuuU3oTbu4m4JbJ0d7NjjTKwualNfFHFiImoqJ+tgCsA9/91UOhfX3jEFYTY/N
         wKDz0MhBWrNQug4y8J5fGrCsC8T5AGUWSwDUJX2pNdj+zAsTWHDgH9d9pRmk2+gZponp
         vCVRc8wtpd/5+KL48YOaYe61MLrQ7621VuUDPkHuuDmILt77u/PBYwfU1pJx2NWuGgV+
         OZASMBeVNgo+J2g7tL10sKPCB6yfaiseAjfE7RhIBy3t9+65g+O1uA/Jqq2ovQ8YxW5B
         tLGA==
X-Gm-Message-State: AOAM530qh7gZCyS1NQRrU6RKArLeT45nYUAE+L/UiL72/YU3eyUC4/JU
        smaZf/puWMhFPGv6r7NqoaEhRouVGpCi2Q==
X-Google-Smtp-Source: ABdhPJxydn3DGIetK8bKWaP5UYjhHLw5AYEwpil4WtbAULkPgKmCLhJV4vp+vSv7/v9heKVobgDu+g==
X-Received: by 2002:adf:a108:: with SMTP id o8mr6255604wro.290.1622192707653;
        Fri, 28 May 2021 02:05:07 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 03/11] ata: sata_sil24: Do not over-write initialise fields in 'sil24_sht'
Date:   Fri, 28 May 2021 10:04:54 +0100
Message-Id: <20210528090502.1799866-4-lee.jones@linaro.org>
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

 In file included from drivers/ata/sata_sil24.c:14:
 drivers/ata/sata_sil24.c:378:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_sil24.c:378:16: note: (near initialization for ‘sil24_sht.can_queue’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_sil24.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 560070d4f1d09..06a1e27c4f84a 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -374,11 +374,14 @@ static struct pci_driver sil24_pci_driver = {
 };
 
 static struct scsi_host_template sil24_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= SIL24_MAX_CMDS,
 	.sg_tablesize		= SIL24_MAX_SGE,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_FIFO,
+	.sdev_attrs		= ata_ncq_sdev_attrs,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.slave_configure	= ata_scsi_slave_config
 };
 
 static struct ata_port_operations sil24_ops = {
-- 
2.31.1

