Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FAC47092
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F2E613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhFBKUw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhFBKUD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:20:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5AC061351
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z17so1708550wrq.7
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffhlhORa9MD76Qfgf3sMwz4+X77WIAnMaM3VUopGK6E=;
        b=E4V+Pbwmmui80575wZa/0HhSIL4NfmUAqtTHl/YRjmu6QInCPP/KB5KEEriGSKXHYu
         s5Hse/hhPpcrhWx0SLnX+Sh+/3HROvL2RP8P06SdD79B5eiv/xEgE4Ponkno2YUEPta1
         Duz2MBcgS4T6dmyyC9S0FnOe3cStkUhW0rHGCVDE2Mbw7c7CAdgps0CHZRPE6wTfe+9c
         QqeMES6A5NarvrSp3SsYlt8oPbdmsYZmxulLxnrEWfeYBrnMz7muy4XYqeR83G1pt8Ox
         5+HdsMR+MDvaVQsVHj4m+MoopxDr57VOByrt96OZU3xjrdimwZ+mJcMkk5VnjSzXcJ7w
         JYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffhlhORa9MD76Qfgf3sMwz4+X77WIAnMaM3VUopGK6E=;
        b=dWYpKZFolVGkJ0L4ieO1fk2rlc8LAnWGt3CaMJl136I4CIJnSNYB2aEl/Q4WMgdpxW
         UHGlalAk0NNsabqpCd2G94W4bgCcBUzpYbWIaUN4RSYsQpIQo0NBVQzn0bLxByBd1VC1
         ZYccrafRU/5Yp+U9vIsUunRN9m57SsbCDeIM7WNDJ6hmhxSfJIUVhBTwXORfKXwFQOFR
         vPwaVg59vwQvcDm1po46MUkGhCBCTkC9bZSc0Ljpd8lTWKc4Ou8tSUAA0nkXzLqlnz1x
         bWz+374S2VsTW5nO5ZWnqlCRVXlso4hogkvkeWjmVy9GEcphArtJZ/hX/8IjRob7zKzH
         koyg==
X-Gm-Message-State: AOAM5336FC2iJ6+z3qYcDpkoDuUHn6AwUVd3ztIBYOsfkB/wkUdI7wO+
        1NWWdUpGZHs9PwjbrwTVxRbYcw==
X-Google-Smtp-Source: ABdhPJxxspuwt2Ws7/m8yQcpkZD3Kik31bJdkaR9gIDi5maHoFcQtmHfbDYEw48CsQ+js9D8owBZbQ==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr31460242wrf.130.1622629071932;
        Wed, 02 Jun 2021 03:17:51 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 19/21] ide: piix: Fix incorrectly documented param 'hwif'
Date:   Wed,  2 Jun 2021 11:17:20 +0100
Message-Id: <20210602101722.2276638-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/piix.c:69: warning: Function parameter or member 'hwif' not described in 'piix_set_pio_mode'
 drivers/ide/piix.c:69: warning: Excess function parameter 'port' description in 'piix_set_pio_mode'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index ede42d2a5b0b1..6a22c281ea90a 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -59,7 +59,7 @@ static int no_piix_dma;
 
 /**
  *	piix_set_pio_mode	-	set host controller for PIO mode
- *	@port: port
+ *	@hwif: IDE interface
  *	@drive: drive
  *
  *	Set the interface PIO mode based upon the settings done by AMI BIOS.
-- 
2.31.1

