Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC7C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D045D613BA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhFBKUX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhFBKTo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460BAC06134C
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so1699032wrz.8
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hghg5eiTw+XcFBcIuWtxfTHWZai/nFkGzTUoTFHy7tQ=;
        b=YZ50AN5U3jBUZLeLdk7DDuN3K2pMrIbrP2OHxpOHagH6mjsZMPmeQDsP5T2ltLpkqK
         jyb6gYRUE+7u9ExtFV15pSYX8tbD+1umFd/Hg8eP1mBac1Ltzedrfm/6gfD7OfHR+3nb
         gqyVpZM/tGwNkGDcOy3t0u9hAA6B3vnFnlsPNhUm9a69uhYauQp+PF7rqCIQ8hpjSrKx
         WaVNka9st+UOsX1NAM9B4S5QJ8FwsNarQeBSPFpAkWM/9LQIHjZ4cuQGKT1p/98hdI5S
         ZuOT0MskdJg1ZF8ErA3UzdDJNUxMAqIHvZB+vJ8whbQocROtF5g2WW8MiIijMITA9Qmp
         3Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hghg5eiTw+XcFBcIuWtxfTHWZai/nFkGzTUoTFHy7tQ=;
        b=MJyRfY2LTG+s96CU/kslS6nMw03TBpztv9htopY13x/we4W0dZ9TOJLrlouAHg544A
         VcB0zTI6zkuFXFcbIF4X+YNYBRBcj0ZSaUs4Hf6dH3rTPlrGHXu20cEC3GQuw8GFn0O3
         bqtSdw4UIHqs5aks+DBBlMj3tXwGonkM+qKnV2Pys5utj5kS4X2p7WF/1ECB5loxIgHE
         LvTmzdlR5WtMZe1mGm96xb1QnBjx1QA+6TbvzTjn4ZpOMSHq7770U4bj29Wqbk1L4SD2
         wc0e9jWpkWZm/Sr4SB+A0u8eKVDxhqVO1i2CAwwWJCN0+w8ODefeoH4a+BOH+J3vyOQk
         quCA==
X-Gm-Message-State: AOAM5310YZYiPmhWsQ/xLQmQ/LCjfrYMWFJp2xdKfuDuraw2w6mBtqHl
        dD8QumkP/naMrL8jQVESzU0YYQ==
X-Google-Smtp-Source: ABdhPJwNaESo8dgf3KZKl5D5IQxpN86T+b+Vg1TYMkBROXmXd/GZTTNXjRq21dG0p1Brd60StOt6NA==
X-Received: by 2002:adf:a489:: with SMTP id g9mr20930775wrb.103.1622629070953;
        Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 18/21] ide: ide-io: Document ide_intr()'s param 'irq'
Date:   Wed,  2 Jun 2021 11:17:19 +0100
Message-Id: <20210602101722.2276638-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-io.c:775: warning: Function parameter or member 'irq' not described in 'ide_intr'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index bd3e78985bcc7..129d036645f85 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -750,6 +750,7 @@ static void unexpected_intr(int irq, ide_hwif_t *hwif)
 
 /**
  *	ide_intr	-	default IDE interrupt handler
+ *	@irq: IRQ number
  *	@dev_id: hwif
  *
  *	This is the default IRQ handler for the IDE layer. You should
-- 
2.31.1

