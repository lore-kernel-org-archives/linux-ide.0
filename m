Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA79CC433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882A264E1F
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhA1SHs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhA1SFJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:05:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143BAC061222
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s7so3347925wru.5
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=Nurqslu0d9ZwZ10IWWGqE6G9xt1JePKcmpIrRynNCMdLIAc+57LzYLJKEL7PvrBXjw
         6bGtME1fvy03oT7Jllc0teJLFoQrunhkSoJfyUIWryc3t0vG0CnlN7sFstoC6Ko9HM4x
         /UzgUlxzWm9yrbEHJB8EcxTBGS/m98p7ZpId/OcKIhvBHeFPZ2tm4clYfnYWLSBw/DKE
         yRmbLqUkhOlJ/BmotlqnwRtmPduKAJHrfOcNs2DsYl9yz5s3FNzw71H1HvDIznGpfL+b
         vy4ulT08Wj2ss/C1JDa2ZnxFTJ3DiZ3PZhrdAPB0YttCZ83ZbVSp6dbRcqb0GldlIUq6
         J5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=HQ0SZr4CdsbWQCN0VM9jT5lEBRvOsL4YXxoNtmFO9P/L2yezV1SaehF9JpifD+jppy
         KHNWP5Gc6JYuo9/a6qL1MHa6VS11sXkOrf5zjlHdCZMdR3tbIWjQyJW2ORaUWWrpybuN
         ajY8CZZ+wcq8QNfVpYvn+mYjMvp+l3q4k5iCZMoOWwz6uWFQND7sfP7YXSRufnEP2Oq8
         /kag3ZAoy89yrrBo7IKS/jA7I29iLTSXLCn2Q2DkkmYMys66NerHKuArVkFA9SALyPtH
         cabz/W2TNg89WYR/4p2xw8blsH4Rjj79JZL0BpUDmc4evzlUFwPHGtQpj0L9k8YGIfuh
         bBPA==
X-Gm-Message-State: AOAM5333vrB18SCkUOogvVak98rQ/CkIYG8Of/1N0HAw+y5z5zUcYq1c
        txx1PmaLM9Fgw93LsOJ3XXVD9g==
X-Google-Smtp-Source: ABdhPJxrEupt53VzeI+7GcG+/MAFplgDc5K42e8phIxQ6WxAavhFiIMN6vtlA3P8N4zstFeBVpogiw==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr323827wrt.312.1611856977884;
        Thu, 28 Jan 2021 10:02:57 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 12/20] ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s 'mask' param
Date:   Thu, 28 Jan 2021 18:02:31 +0000
Message-Id: <20210128180239.548512-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt366.c:200: warning: Function parameter or member 'mask' not described in 'hpt366_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt366.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2574d6fbb1ad3..06b7c4a9ec954 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -192,6 +192,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 /**
  *	hpt366_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: Current mask to manipulate and pass back
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
-- 
2.25.1

