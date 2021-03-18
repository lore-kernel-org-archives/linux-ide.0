Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D76C4321A
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F7464E2E
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCRIwQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhCRIwA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E8FC061762
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z2so4598795wrl.5
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBw5nJooq34YS/jxcj30RML2GTr2FUzleakjhCquzqA=;
        b=y6Bd33NPTlbrNrDNk5ltgxDfqEu0YSGOTuMoUR/1UIjYmrZYLJlAWNrU1Kji+onJFN
         JZlNNLamvo6yZuyOIOxIIHkCxXNVENB12TaV8AtSTH04T3LeDaNwngt+LtB8VbfnbFWd
         RgPClcK0v0wmyVHRHHnp26/0tuLBlpjb0p2At/D1FK0Q7bvn7U+s7ccmnxX9xmnXGlRq
         54CsgzbbI60bJVuc2od8/tCuFyEchLxML+jJYCoMeQ8ghmgo0JDRUYPYdOK81luLQdAA
         lAlyub2xO6vdYol6boQGUEj2MmSPFGiyosjp+QdjBaKkQeMmUuVdt3aYiIfv8y0uE3Fy
         pTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBw5nJooq34YS/jxcj30RML2GTr2FUzleakjhCquzqA=;
        b=JFSIynnsaKstlNzBgyx/WzXG3Co5S0lPwolfb1s2dYyh3QTDdnybQBYm0KJOC0Bb6j
         oR96IhKyhWjm8ucmqfUImYQhHJ7TY5xMhOVorl1qw6Ysh9NXO+oKzKjw319+kjWEz0mU
         BssLRwKMCVEQf8YFszUvFig3t6vI4S1BE0t1rMKzDyEpZ65fGJabBWZzHNJlO6qn6qVq
         sub64YnB6zodxVmm49wOQBp4aw9QjISGA91iMuCTauih3mgp3XOu+SEq1UxpucaHAJ2M
         wgTYkzHnHn4esUpU3fbMQweHHPVB31vy0uZ5yOdr0414HDJvDssoRBInQ/gG3AcMW9jQ
         1qCw==
X-Gm-Message-State: AOAM5318lvf8VNSbwOWc2f1FwPqKHk9BUQuEfkYyv+fTevFKiG5v/L1d
        EOhScc6QAr113SCU1UoVF9fBrA==
X-Google-Smtp-Source: ABdhPJwLSz3XO+Lumh3wZ6Y75pm80hiRCK36mLGAazKBoInU/8OojCpv+2FWnoiz3qOtUJTUp+nQNw==
X-Received: by 2002:a5d:526b:: with SMTP id l11mr8299694wrc.385.1616057518854;
        Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Hat Inc <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 07/15] ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
Date:   Thu, 18 Mar 2021 08:51:42 +0000
Message-Id: <20210318085150.3131936-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_piccolo.c:87: warning: expecting prototype for ata_tosh_init(). Prototype was for ata_tosh_init_one() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Hat Inc <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_piccolo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_piccolo.c b/drivers/ata/pata_piccolo.c
index 35cb0e2632379..389b63b13c706 100644
--- a/drivers/ata/pata_piccolo.c
+++ b/drivers/ata/pata_piccolo.c
@@ -74,7 +74,7 @@ static struct ata_port_operations tosh_port_ops = {
 };
 
 /**
- *	ata_tosh_init		-	attach generic IDE
+ *	ata_tosh_init_one		-	attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
  *
-- 
2.27.0

