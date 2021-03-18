Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390CFC4161F
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F73064E2E
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCRIwT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCRIwF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D7C06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so4605034wrn.4
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyiarI8XI+wr4cdrUP10jrX5TiM2u+Q08u5Edv+SeZQ=;
        b=UFMJn5wdi36JaAz2Mtjh0Yn3v4pMvV51lK4rgktPR83seHiknusOzEY081nZ0utH9E
         XsBjfmNGLBWwL3IwX/rHlehaL5IOMB2hwQ93D6exxnriB3HyIzgE/6VqvH6oizTh6sIa
         3zJ0kloQGxi/vSZOQejyRMLGFC+hURMKXakf5Dt96K3XV+uhioLxhl6QZXadfVAPX4p1
         /AlXszKtCNVLnxxMgOWXc7FPboidwGsAsm/8HIGZ2si/gIL55PqndogUsMPaKFiH3Tcs
         87tSbTDNEz6f7vxk1Iq+05iVhdNmxWoIBxRAWK5T6riqKsGZgshzwgBsU83NAyR4rO9f
         TzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyiarI8XI+wr4cdrUP10jrX5TiM2u+Q08u5Edv+SeZQ=;
        b=ku2CSo52c8bJXe+5rUeeVQBqSdOmcyuFLHLaNZ58y9nrLUTSew9rBWpN1J7bxFjeUW
         15a0LBSfE+Z6ePuAr0jpRsNh2Br+Q51BqFyfwvNU+O/NU80f9b9cWGgbfyDNsQdFlVFy
         FdIA5QzaDQQHpeBdMoSoyIbc1Bd/YWsLQK26Sv8CeGiSdQ7LuopWdDUpEqEv1wUxYFwE
         9BrLGfaSzU1q/iTXfc/NCyKMO/reXfQMNe7mZODVQ4GPEyqjmSCaBHnmMYoeAYoGHEYa
         5vlwrKRM4zQ1O11xfz7moQvWz2hIJKAaEw2rtBJndrysPEuNUET9dmqGVVxOe8RTPebl
         w8+w==
X-Gm-Message-State: AOAM5331kmNbjZfCh9ZZkkKAgh058DWkR8LHUW+KkAk6n+ZvF0dNKz9a
        m5WBi+jtEEYCUNXazMHyurhe5g==
X-Google-Smtp-Source: ABdhPJyxfLSduApCEQu/3N3aXkvQ4WqyvhVfStfESZlS6GN8wfK8Blsp+2pYr2Wqw5RKEWPWEdVMVg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr8292296wrx.417.1616057523266;
        Thu, 18 Mar 2021 01:52:03 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 12/15] ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
Date:   Thu, 18 Mar 2021 08:51:47 +0000
Message-Id: <20210318085150.3131936-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_cs5530.c:283: warning: Function parameter or member 'pdev' not described in 'cs5530_init_one'
 drivers/ata/pata_cs5530.c:283: warning: Excess function parameter 'dev' description in 'cs5530_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index ad75d02b6dacf..a1b4aaccaa50a 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -271,7 +271,7 @@ static int cs5530_init_chip(void)
 
 /**
  *	cs5530_init_one		-	Initialise a CS5530
- *	@dev: PCI device
+ *	@pdev: PCI device
  *	@id: Entry in match table
  *
  *	Install a driver for the newly found CS5530 companion chip. Most of
-- 
2.27.0

