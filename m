Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C00C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A6E64E17
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhA1SHW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhA1SEQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDCC061356
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so6355273wrx.4
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=LCSL/fcwhlSrm7/lPGXpRlMQ0n2aJQsdeAOcuIr7kBIZyWGO4wpdPQ3TUqEgqrxZA0
         UMkH9ME6yeqoYFSIQnabalTsyaacEnMVFhkVr1ipyzQsoI+JO5RNSw3V93yhVo6vn33h
         G2OhqiZzDjzJVgIWhHhm0szCYXY4TBHp7P/G9LVdxZ/c0FZSEJjFEUyFSLNNtJiIEC6O
         5B7SIsdJhLuG8JwhcDL1QYWQgXLcN+GMDFNV1TKFXEmFd4E+UzHQdmWrzTXDBkgnYvDJ
         BZSKMH3/TfZg3sdClckaTszuFVK11UbU+Yber7oT1ea+wdx0+EcSrCutdlkh60sA2OWF
         bHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=SyolQ4WGPVP/AEzYPEzDhuNu5Nq976rcDdiq0OeuCnJJbdQOFfqvz4DygjUDT/AkmH
         E5ctx6LYPODcKBLK/5rItc1nZTLJ93NIxKryE4H/o8e84IqG06ImIvD/Dxxh/Slu/UIu
         e0l7inCXlpy/aV98+EmN/z+5SHxVgD7ZtSjMhwXKbwiqb/ijXJ0XmJpT8bKx0HIZ4vK2
         SUuTUEQwitbzoyK72Xo1SefAds8mwQmqwd9YM+Vv/xwN9XXgWxuSbnyJw8StqKGj0hDt
         8bESCEqlR+21jXRt3FBPiecczWlIaN2UkEG4FYdSXVcgmq/S5lzMlOFv7Hbu7xjYceTg
         +VHQ==
X-Gm-Message-State: AOAM533PKwWieCUUxyiPj7CEv+yuZWMzVEUZ4SjI7++nh+0N0svW+0pa
        P3mhxuNz5XSMokHsCpv8c0mZjw==
X-Google-Smtp-Source: ABdhPJwlRmBQ0XlMBMJkoz0Jvfl43UE6ncweVPFdcFHqoMnwtYyXiwnmj5wsqPFr3KRph9ft58miLw==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr359995wru.106.1611856973290;
        Thu, 28 Jan 2021 10:02:53 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        linux-ide@vger.kernel.org
Subject: [PATCH 08/20] ata: pata_artop: Fix a function name and parameter description
Date:   Thu, 28 Jan 2021 18:02:27 +0000
Message-Id: <20210128180239.548512-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_artop.c:278: warning: expecting prototype for artop_6210_qc_defer(). Prototype was for artop6210_qc_defer() instead
 drivers/ata/pata_artop.c:359: warning: Function parameter or member 'id' not described in 'artop_init_one'
 drivers/ata/pata_artop.c:359: warning: Excess function parameter 'ent' description in 'artop_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6bd2228bb6ffa..02e4fd5e3b934 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -344,7 +344,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 /**
  *	artop_init_one - Register ARTOP ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in artop_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

