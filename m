Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52BC47087
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FE961222
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhE1JGv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhE1JGs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD7C061763
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f17so268407wmf.2
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q31aHu4d2EyGCNum2ZU2yD6ze38ZUxKCEqsQOMZ06Lw=;
        b=iHU4SmZtE0qceEDUVqwq0nooHVzMWLGqymHGWYwomhTQJQR+Wh9lEwitqZaNDTujXb
         YL+eLd3W0ZNq90heaVygzxuMYhQ6ksvqadoN75LjUvZWdHtaR+ZLlbhoz1aE/It5SYWE
         XnvSsgn+mqTByNkFXZEzNNiGo4wjaWGYrkCgI0XQlyX+yYQCexn6CvTXyt3w6HdSeFD1
         cBtAAst4erMizizLtAPP2GJZyadGgzfVEQaluAjV4l1zffplaMFZPKJmsNC49ACOoi5y
         tpev3tSwpxVBb/ErkeotHdN3dsjj3fkCNWPzCRudvWsotXrg4Jgwg7VA+tPpvf3cuHQv
         zqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q31aHu4d2EyGCNum2ZU2yD6ze38ZUxKCEqsQOMZ06Lw=;
        b=OOiK9+YKFsIPhtTFilkAKXqTl4A2B2B6VK8du3ElOjUuHLIbNweNACq5IYzIbPtROT
         eQWxv7fP07pkO+CLNf7FAq0Nau7nR0ZA1T/ChC9t7mabJQDwg8z5+vIo3LDxd+igJkuE
         8X4B/HxPZKXzequv02JXyLilicHERV4aM7BsUq9LTPi3mGLlZlVXPcUtuLnUe3tjLeOq
         8o6Rh568QWCLwdCRGVDWUZ5y4+1yMJ1D77GfHIB2Z1fX6pLxjbS0vkB9ava/09feIep2
         wHxYBZXE7DxFdewu/2MwCemI2qDWSHMRAND8aRGQjHgR/VXBH2IdpW9xOT70RJXtRb1L
         9iYg==
X-Gm-Message-State: AOAM532fmLZ0Zy9r0KvVhNiAOLqklLhlT+OzbZ1IKZz1dscQlN8YGzeL
        10/eq6qaIQuVqPxNhCSMdMKqEQ==
X-Google-Smtp-Source: ABdhPJztjboOyPvoUhgaD1zdQe8HIPehEzyszSEHX6rN62P1I/Uqy+OvhLlZnpuYvbpKVFAHI4ZfoA==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr7622742wmj.155.1622192710912;
        Fri, 28 May 2021 02:05:10 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ATI Inc <hyu@ati.com>, linux-ide@vger.kernel.org
Subject: [PATCH 06/11] ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
Date:   Fri, 28 May 2021 10:04:57 +0100
Message-Id: <20210528090502.1799866-7-lee.jones@linaro.org>
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

 drivers/ata/pata_atiixp.c:256:19: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_atiixp.c:256:19: note: (near initialization for ‘atiixp_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: ATI Inc <hyu@ati.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_atiixp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index d671d33ef2874..c3a65ccd4b799 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -252,8 +252,9 @@ static void atiixp_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template atiixp_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations atiixp_port_ops = {
-- 
2.31.1

