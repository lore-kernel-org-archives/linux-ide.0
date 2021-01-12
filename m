Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7424C433E0
	for <linux-ide@archiver.kernel.org>; Tue, 12 Jan 2021 02:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD7C22CAD
	for <linux-ide@archiver.kernel.org>; Tue, 12 Jan 2021 02:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbhALChO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhALChN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2021 21:37:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C9C061575;
        Mon, 11 Jan 2021 18:36:33 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c12so467547pfo.10;
        Mon, 11 Jan 2021 18:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h9fhRdWWspSQu4n1BaWZHaKW8EOn6n3KPYXE2frKUsY=;
        b=B6MEma4QRnEyxIqcDcQ/fq9MWe4X7FMEEyEd57XgMUB1IGYZuqv6Njp61A2+TxiS8D
         IpMQ4ZWoYh2JeSW3turtd1OActP9xnkcYfQ5HM6SObfy9V4cuXdKtQFVYw8i+CdKM3o3
         2OJT+cczIBpxl1vU6pT2SAy6aIhGuDdk2JZ3EXje7zE1N58wm838MGG05cuZbSIbXvUO
         RMdW8SVbukaM4ptZYZuQqoxIfC2LY22Ur80gH0q5ayhHs1wgBtkwb3HY3WcG4vYRPgum
         ZPSY8U88TzTzunaQI+LsRr+KiRE9QnRMXjHu7qNTl2CmXhikx6Jl/vu5/FAr6LtuXfWN
         r1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h9fhRdWWspSQu4n1BaWZHaKW8EOn6n3KPYXE2frKUsY=;
        b=B/wWaAmjxM/+lTY4fyScjPjWwAVvvMiv29HmyutksofT7gfHzs0Lecs1u2y2eOKnVj
         AqKWn4LSgoTOUE5/Oxdr6Bjp9s8HXsUjM/QzcYDLXfqxREvFj5UQaQITuxKoyO6Q6hR+
         46ZMmHqV7rePaTpq+fK2+o9wsc58zIVOh4HDo+OAahSMjuItPzxdlEdQf9v4qrGfRHXm
         GNAJX1xgEaXzaXPTYX/xQdTkWm1Z/3Yo6Ct2oQMFmURmsF98f5zvWbeFC2iOOzDhV4OT
         Mpe+jfZLtBo3CJre2rX3kNjUgZqB1dx0AkuBeiz/Ohjgqjk1bglqmv2WwBQ7mr0IRBmf
         rYjQ==
X-Gm-Message-State: AOAM532g1HYRWucofZnt9sSiK/wPBU+gmEt6tfEntBIcqEBJ4EYtzzBP
        FMfUMi91gERcTun4ggj2jlU=
X-Google-Smtp-Source: ABdhPJywMqN5uAGoZJXkW+OrN3nOwHLqagIeMFp3RatFDMLPd+d7XvNzoIX/zE2wxPFyFSVGrmTyFw==
X-Received: by 2002:a63:d551:: with SMTP id v17mr2465636pgi.18.1610418992436;
        Mon, 11 Jan 2021 18:36:32 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p22sm1268370pgk.21.2021.01.11.18.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 18:36:31 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] ata: remove redundant error print in rb532_pata_driver_probe
Date:   Mon, 11 Jan 2021 18:36:19 -0800
Message-Id: <20210112023619.5713-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Coccinelle reports a redundant error print in rb532_pata_driver_probe.
As 'platform_get_irq' already prints the error message, error print
here is redundant and can be removed.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 drivers/ata/pata_rb532_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 479c4b29b856..dcde84f571c4 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
-- 
2.17.1

