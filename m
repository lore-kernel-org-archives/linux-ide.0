Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E8C433E0
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A10F64E23
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhA1SQq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhA1SGv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:06:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FEC06178B
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so6350179wrx.1
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlJPa4weJ+jes2vrsBZmFk9aHoMXb6b/UAhdjjLI1xw=;
        b=tIoUH1MMZgHPgcFm1H5xu5GhnyoOc6pk1LknTNWKf1oRwOVc068CLd4D+hvcZXd3Dt
         ZWekkNvjydaiLPrxtaSjQZWwB6pworR01AK+cB7oEEL5CfA9vfOx3l2cYwFWPEmGD5WX
         /XUfMWHAgo+JLnjCquaGOUWO0E3+vodO+gsmcFkAWrLPeF+8MEPEDMGH9yg5HEp9GXQ+
         pNWuR1mkrY1sscEUp1LswyjfN6lD84DZp0la7v5j7tIuyACn7j2ddg4MpbihmbuX7Zim
         RnZxc6rXRoC14A6KgxJbyA2TXVc2x8e+Gh2mNWBEWqhnzwEMJKWV+Iep3OU9jqog7yQb
         +2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlJPa4weJ+jes2vrsBZmFk9aHoMXb6b/UAhdjjLI1xw=;
        b=TpVvbhG/NKa57Bo9atFMmRap0LcUarkuSezcTlDLrw2Na/VhLoSM0McxnZLBwUSyIw
         DrDwJ0TuKqy5L/lee3Ez7bwY15QkT+mU4Ooy5OkXLocVVTsxIuRROubtQxq9qgy2e6Lk
         KTYsIGPurvwkAxwCCFyeFQEIjxI3qeOe4hQoIBmv9hHneMT3TtkoCy+VQ1nKxoJhr5vW
         ECLfExhACbId1Oq/F9ZoewCsdGRhASJlUHOw1s+AJnBSHNkaKlX0CJNdGw90I0lOHn+3
         QWJCiirXVF+w7w0/iZAkp2F2t5ec7+Ve1oHkT2KgjISOY/DGyhbFksP8BxcFganK2WuE
         kovw==
X-Gm-Message-State: AOAM53391H+P+Ya89purk/Ma1GlqP7gORma9UZSjrkHEw9lUyXX+dWld
        h9XB5Z89bmn72389zZkb+XBt5g==
X-Google-Smtp-Source: ABdhPJzCh/6Len5XnN+iFyPGMOmxw2mV+V4tO818WFPny0PyiE6vtR+TA1iztn7KqE0i9aOnTYVTwQ==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr357970wrl.100.1611856983215;
        Thu, 28 Jan 2021 10:03:03 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>,
        Suman Tripathi <stripathi@apm.com>, linux-ide@vger.kernel.org
Subject: [PATCH 17/20] ata: ahci_xgene: Fix incorrect naming of 'xgene_ahci_handle_broken_edge_irq()'s 'host' param
Date:   Thu, 28 Jan 2021 18:02:36 +0000
Message-Id: <20210128180239.548512-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/ahci_xgene.c:564: warning: Function parameter or member 'host' not described in 'xgene_ahci_handle_broken_edge_irq'
 drivers/ata/ahci_xgene.c:564: warning: Excess function parameter 'ata_host' description in 'xgene_ahci_handle_broken_edge_irq'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Loc Ho <lho@apm.com>
Cc: Tuan Phan <tphan@apm.com>
Cc: Suman Tripathi <stripathi@apm.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ahci_xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 16246c843365e..dffc432b9d54a 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -537,7 +537,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
 
 /**
  * xgene_ahci_handle_broken_edge_irq - Handle the broken irq.
- * @ata_host: Host that recieved the irq
+ * @host: Host that recieved the irq
  * @irq_masked: HOST_IRQ_STAT value
  *
  * For hardware with broken edge trigger latch
-- 
2.25.1

