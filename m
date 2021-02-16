Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85978C433E0
	for <linux-ide@archiver.kernel.org>; Tue, 16 Feb 2021 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C90864DE0
	for <linux-ide@archiver.kernel.org>; Tue, 16 Feb 2021 11:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBPLNU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBPLNM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2021 06:13:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF010C061574
        for <linux-ide@vger.kernel.org>; Tue, 16 Feb 2021 03:12:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l17so8809642wmq.2
        for <linux-ide@vger.kernel.org>; Tue, 16 Feb 2021 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UmpLeEW/6ZV1TTbJC46Fwto+nRUnbgy7ySkBxdls2uA=;
        b=Z992/rRp0GR2lFYyXXvIvGyUHpsuG8RDygcjpyBflouDsBbLbxd+mx3KjuZNZo7Pae
         PkjVKCKfOrQC5W8SoAmrL3UEE1Ya7bNcZO1UZFmwXUIW1msIXCxT+XORNOdMj7x0a6r1
         rnQbAm21n7MEIySlY+JMJuUg5MvD2QIlePM03jEDyTO8pWwlaZTKo8As+u645C5bSxF9
         EnTnL+u30y1dgcL/nxPTH6Irnb4JRWwrFXZFEP1XxUEzERLKJ4vS8J7Vn3UhionVXdlC
         uVe4kZm0efB3/O+kksDh5XsglwAl2FKpdBho6QMnPny7R9hHsDTduoYtjfFcwdZyF1qb
         lMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UmpLeEW/6ZV1TTbJC46Fwto+nRUnbgy7ySkBxdls2uA=;
        b=rk+PWT4/sY/YjUo7zhBi+hfTmTO7ypxJnGqZkgOGKuQWfEwnhwQCiow9YibVds67eR
         ouLH/u3uxjHONICbv8KBuAjbR4NkM7S3dTpcZJy4xZIkpmm9c1XlmJdZgWaxnOYM5V4a
         65vuu/7p/BZuAWAFOrg6hwNft9Q3txWhnbGxtRdxqDszgstOv6wyEoq7YQuYrCePMYFO
         f+T5FhnuMbJbyeFIg25RHly49MSkYC0pU+BAJsxRNILlP5mae0Qdckxkp25+w+qcDRdz
         yFnv6rSKjk3T8rbDF/AUnSVdFszMMTHwiVulxbIuWCwDCa84hgmoZgTX8530mFd9cQzx
         +wbQ==
X-Gm-Message-State: AOAM533g1vN/Yi1FrKI/I7K7jvaNirCSBvoUZwfPkT/8wufPfHTEH/c0
        WeegtcDTaSjHO5ZpvVpt/56drpXMJzlrFw==
X-Google-Smtp-Source: ABdhPJw5rj9x89Mh1bxHseIBdGshCakEa6t9WIeRTU5dEE0PZPRwByyRGQkoKjVVLfBbzFOX6m1KUw==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr2875973wmg.108.1613473950191;
        Tue, 16 Feb 2021 03:12:30 -0800 (PST)
Received: from ?IPv6:2003:ea:8f39:5b00:ac39:e452:593c:61b5? (p200300ea8f395b00ac39e452593c61b5.dip0.t-ipconnect.de. [2003:ea:8f39:5b00:ac39:e452:593c:61b5])
        by smtp.googlemail.com with ESMTPSA id r7sm2963059wmh.38.2021.02.16.03.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:12:29 -0800 (PST)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ahci: use BUILD_BUG_ON for constants comparison
Message-ID: <64ed387c-fdef-279c-dace-7c26ffd3cdb6@gmail.com>
Date:   Tue, 16 Feb 2021 12:12:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Both are constant enum values, therefore we can check at
compile time.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 00ba8e5a1..e953425e1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1673,7 +1673,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	VPRINTK("ENTER\n");
 
-	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+	BUILD_BUG_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
-- 
2.30.1

