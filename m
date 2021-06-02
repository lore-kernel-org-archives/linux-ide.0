Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F4C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB30613DD
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFBKTp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhFBKTb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14656C061343
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so2891408wmq.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oC9NQ9021w3IDCN0kWXfKOwdq7JNsN8GscpJCnjZMl0=;
        b=BDdcauGSENaWJe4pI5Cw+RyVU5FDkuoCPZZKUFubXyxrEkSCeDLqDHmAUA5z3U4f+H
         OIzPOicIlZJWR85BSWLhd0fZ2gRIXU+5m5ynwTbq8hWfnr5A6ktHKk89dwAK7i6LVPRg
         RyE6McgSDUbH6tl++hb2Pc7C+680MUsAN96wtPkyyV5pCR6i1/vPrL7oIEyADhZ8U5f4
         gcLtWnOGVTJyPlOWIlRs+wcmTWJKoEIU1SbsvIxNaG91sLnNJ7A6OuTDstAU3c48MdB/
         K+/8U0RAYoXig3eLMzdar254k7SNQgfs2CR1/OZxYWkcXhr41A1ELhvlTJ6rMxDL7aNw
         IS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oC9NQ9021w3IDCN0kWXfKOwdq7JNsN8GscpJCnjZMl0=;
        b=CpkoniqWiMe3ZQ4qJnDwTEUa7wophQSpWOvuVXYB4FdB66U0gUKDRgZwETWim/Fs6Z
         xkWqdA5ySmn0zaO85eu/NQnTrgySkUHBeKt1i8nRVzwhwPNch2kfed4rZxi1l8gBu1zr
         EPbC2wK2aed8tsxX1nJvB0/L+Hc6MglKrqdwac/ycxQ7cLqmLftH9ozuYWNhIQ1JIw8x
         gRvrDTh3JD29cVDDFRGNb0bBgF30OudfF8Q4cpjJ8Rqi0sw4mQRaaFkoLgiDwLAUxwNA
         cgM1J9vyatQvyfPISgdg7KFtZaK6CKKxlJhFvhAm+/08ehJE8tYmokJmU2GFkIz24lRW
         fgOA==
X-Gm-Message-State: AOAM5300Xo7ahbLPr0x7ch2E3GedY6OSgrRzRewjF/PAUaDKO3m5bmFp
        1wD96J2h+Wdzq3NBeC09G8+HEw==
X-Google-Smtp-Source: ABdhPJx1x9r9KkQCQH6nl+ygj9NZHxQrtQjuKCanG6OV0JmKyCjUUsZ7gxOsPVhew+giHhRAOrd+oQ==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr30486017wmq.145.1622629061739;
        Wed, 02 Jun 2021 03:17:41 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        Adrian Sun <a.sun@sun.com>, Duncan Laurie <void@sun.com>,
        Tim Hockin <thockin@sun.com>, Mike Waychison <crlf@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        or <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 08/21] ide: hpt366: Provide some missing descriptions for 'f_{low,high}'
Date:   Wed,  2 Jun 2021 11:17:09 +0100
Message-Id: <20210602101722.2276638-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/hpt366.c:849: warning: Function parameter or member 'f_low' not described in 'hpt37x_calibrate_dpll'
 drivers/ide/hpt366.c:849: warning: Function parameter or member 'f_high' not described in 'hpt37x_calibrate_dpll'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Adrian Sun <a.sun@sun.com>
Cc: Duncan Laurie <void@sun.com>
Cc: Tim Hockin <thockin@sun.com>
Cc: Mike Waychison <crlf@sun.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: or <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/hpt366.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index b3d44de777cbd..69c7c2abf3e51 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -841,6 +841,8 @@ static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
 /**
  *	hpt37x_calibrate_dpll	-	calibrate the DPLL
  *	@dev: PCI device
+ *	@f_low: DPLL low value
+ *	@f_high: DPLL high value
  *
  *	Perform a calibration cycle on the DPLL.
  *	Returns 1 if this succeeds
-- 
2.31.1

